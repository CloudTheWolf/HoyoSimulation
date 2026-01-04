using System.ComponentModel;
using DSharpPlus.Entities;
using Newtonsoft.Json.Linq;
using Microsoft.Extensions.Logging;
using HoyoSimulation.Lib;
using DSharpPlus.Commands;
using DSharpPlus.Commands.ContextChecks;
using DSharpPlus.Commands.Processors.SlashCommands.ArgumentModifiers;
using HoyoSimulation.Actions.Providers;
using HoyoSimulation.Events;
using Newtonsoft.Json;
using ImageMagick;
using Serilog;
using ImageMagick.Drawing;

namespace HoyoSimulation.Actions
{
    
    [Command("genshin"),Description("Genshin Impact Commands"), RequirePermissions(botPermissions: DiscordPermissions.None, userPermissions: DiscordPermissions.UseApplicationCommands)]
    internal class Genshin
    {
        private static DatabaseRequests _dr = new DatabaseRequests();

        public Genshin() {
            _dr = new DatabaseRequests();
        }

        [Command(name: "wish"),Description("Pull from a Banner"),RequirePermissions(botPermissions: DiscordPermissions.None, userPermissions: DiscordPermissions.UseApplicationCommands)]
        public async Task Warp(CommandContext ctx, [Parameter("banner"), Description("Which Banner will you use?"),SlashChoiceProvider<BannerTypeProvider>] string warp_banner = "character", [Parameter("amount"),Description("How Many Pulls will you do"),SlashChoiceProvider<PullSizeProvider>] int numberOfPulls = 1)
        {
            bool updateStats = true;
            if (!Directory.Exists("./temp"))
            {
                Directory.CreateDirectory("./temp");
            }

            var max_warps = numberOfPulls;
            _ = ctx.DeferResponseAsync();
            if (warp_banner.ToLower() != "character" && warp_banner != "weapon"  && (max_warps > 1 || max_warps < 10))
            {
                var errorEmbed = new DiscordEmbedBuilder
                {
                    Title = "Invalid Pull Type",
                    Color = DiscordColor.Red,
                    Description = $"Either Banner or Pull Type is not valid, Banner can only be `character` or `weapon`, Type can be between 1 and 10 "
                }.WithAuthor("Pom-Pom", iconUrl: "https://static.wikia.nocookie.net/gensin-impact/images/4/40/Heated_Battle_Mode_Paimon.png/revision/latest/scale-to-width-down/50");
                await ctx.EditResponseAsync(new DiscordWebhookBuilder().AddEmbed(errorEmbed.Build()));
                return;
            }

            var cost = 160 * max_warps;
            var player = _dr.GetPlayerData(ctx.Member.Id);

            if (player.stellar_gems < cost)
            {
                var errorEmbed = new DiscordEmbedBuilder
                {
                    Title = $"Not Enough Jems",
                    Color = DiscordColor.Red,
                    Description = $"You can't afford a {max_warps}-pull"
                }.WithAuthor("Pom-Pom", iconUrl: "https://static.wikia.nocookie.net/gensin-impact/images/4/40/Heated_Battle_Mode_Paimon.png/revision/latest/scale-to-width-down/50");
                await ctx.EditResponseAsync(new DiscordWebhookBuilder().AddEmbed(errorEmbed.Build()));
                return;
            }


            int warps = 0;
            var items = new List<JToken>();
            int three_star_count = 0;
            int four_start_count = 0;
            int five_star_count = 0;
            int six_star_count = 0;
            var total_warps = player.warps_since_five_star;
            var event_warps = (warp_banner == "weapon" ? player.warps_since_event_weapon : player.warps_since_event_character);
            while (warps != max_warps)
            {
                var item = DoWarp(true, (warp_banner.ToLower() == "character") , three_star_count == 9,total_warps,event_warps);
                switch (item["rank"].ToString())
                {
                    case "6":
                        { 
                        ++six_star_count;
                        ++total_warps;
                        ++event_warps;
                        break;
                        }
                    case "5":
                    {
                        ++five_star_count;
                        if (int.Parse(item["event_boosted"].ToString()) == 1) event_warps = 0;
                        total_warps = 0;
                        break;
                    }
                    case "4":
                    {
                        ++four_start_count;
                        ++total_warps;
                        ++event_warps;
                        if (updateStats)
                        {
                            _ = GuildEvents.SetStatus(ctx.Client); // We should find a better way to do this, but it's not like they'll have a 4-star all the time
                            updateStats = false;
                        }

                        break;
                    }
                    default:
                        ++three_star_count;
                        ++total_warps;
                        ++event_warps;
                        break;
                }
                items.Add(item);
                warps++;
            }

            var banner_img = await Image.MakeWarpBanner(items,"genshin");

            var rand = new Random();
            var banner_path = $"./temp/{ctx.Member.Id}_{rand.Next(5458, 15458)}.png";
            banner_img.Write(banner_path);

            var banner = new FileStream(banner_path, FileMode.Open, FileAccess.Read);

            DiscordColor color;
            if (six_star_count > 0)
            {
                color = DiscordColor.Orange;
            }
            else if (five_star_count > 0)
            {
                color = DiscordColor.Gold;
            }
            else if (four_start_count > 0)
            {
                color = DiscordColor.Purple;
            }
            else
            {
                color = DiscordColor.Cyan;
            }

            var embed = new DiscordEmbedBuilder
            {
                Title = "The Astral Express Has Arrived",
                Color = color
            }.WithAuthor("Pom-Pom", iconUrl: "https://static.wikia.nocookie.net/gensin-impact/images/4/40/Heated_Battle_Mode_Paimon.png/revision/latest/scale-to-width-down/50"); ;
            JArray dbRecord = new JArray();
            foreach (var item in items)
            {
                var stars = "";
                switch (item["rank"].ToString())
                {
                    case "6":
                        stars = "✪✪✪✪✪✪";
                        break;
                    case "5":
                        stars = "✪✪✪✪✪";
                        break;
                    case "4":
                        stars = "✪✪✪✪";
                        break;
                    default:
                        stars = "✪✪✪";
                        break;
                }
                var suffix = "";
                embed.AddField("Item", $"[{stars}]{item["name"]}{suffix}", true);
                dbRecord.Add(new JObject
                {
                    { "item", item["id"].ToObject<int>() },
                    { "player", ctx.Member.Id},
                    { "name_suffix",suffix }

                });
            }

            var items_json = JsonConvert.SerializeObject(dbRecord);
            _dr.AddToInventory(ctx.Member.Id, cost, items_json);
            _dr.UpdatePlayerWarps(ctx.Member.Id, total_warps, event_warps, warp_banner);
            await ctx.EditResponseAsync(new DiscordWebhookBuilder().AddFile(banner).AddEmbed(embed.Build()));

            banner.Dispose();
            File.Delete(banner_path);


        }

        /// <summary>
        /// Perform a warp!
        /// </summary>
        /// <param name="is_event"></param>
        /// <param name="is_character"></param>
        /// <param name="no_three_star"></param>
        /// <returns></returns>
        private static JToken   DoWarp(bool is_event, bool is_character, bool no_three_star, int warps_since_five_star ,int warps_since_event_item)
        {            
            var random = new Random();
            var randomNumber = random.Next(0, no_three_star ? Options.FourStarMax : 1000);
            JToken item;

            if (randomNumber <= Options.FiveStarMax || warps_since_five_star >= 100 || warps_since_event_item >= 200)
            {
                item = _dr.GetItemFromDatabase(5, is_character ? "character" : "weapon", warps_since_event_item == 200,"genshin");                
            }
            else if (randomNumber <= Options.FourStarMax)
            {
                item = _dr.GetItemFromDatabase(4, is_character ? "character" : "weapon",game: "genshin");
            }
            else
            {
                item = _dr.GetItemFromDatabase(3, is_character ? "character" : "weapon", game: "genshin");
            }
            return item;
        }   
    }
}
