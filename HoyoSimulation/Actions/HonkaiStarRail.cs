﻿using DSharpPlus.SlashCommands;
using DSharpPlus.Entities;
using Newtonsoft.Json.Linq;
using Microsoft.Extensions.Logging;
using HoyoSimulation.Lib;
using System.Net;
using System.Drawing;
using System.Drawing.Imaging;
using Newtonsoft.Json;
using ImageMagick;

namespace HoyoSimulation.Actions
{
    [SlashCommandGroup(name: "honkaistartail", "Honkai Star Rail Commands", false)]
    internal class HonkaiStarRail : ApplicationCommandModule
    {
        private static DatabaseRequests _dr = new DatabaseRequests(Main.Logger);

        public HonkaiStarRail() {
            _dr = new DatabaseRequests(Main.Logger);
        }

        [SlashCommand(name:"CharacterWarp", description:"Pull from the Character Event Banner",false)]
        public async Task CharacterWarp(InteractionContext ctx, [Option("type","Type of warp, (1 or 10)")] string warps_str = "1")
        {
            if (!Directory.Exists("./temp"))
            {
                Directory.CreateDirectory("./temp");
            }

            var max_warps = int.Parse(warps_str);
            ctx.DeferAsync();
            if (max_warps != 1 && max_warps != 10)
            {
                var errorEmbed = new DiscordEmbedBuilder
                {
                    Title = "Invalid Pull Type",
                    Color = DiscordColor.Red,
                    Description = $"Pull Type {max_warps} is not valid, please select 1 or 10"
                }.WithAuthor("Pom-Pom", iconUrl: "https://static.wikia.nocookie.net/houkai-star-rail/images/d/dc/NPC_Pom-Pom_Icon.png/revision/latest/scale-to-width-down/50");
                await ctx.EditResponseAsync(new DiscordWebhookBuilder().AddEmbed(errorEmbed.Build()));
                return;
            }

            var cost = 160 * max_warps;
            var player_bank = _dr.GetPlayerBank(ctx.Member.Id);
            if(player_bank < cost)
            {
                var errorEmbed = new DiscordEmbedBuilder
                {
                    Title = $"Not Enough Jades",
                    Color = DiscordColor.Red,
                    Description = $"You can't afford a {max_warps}-pull"
                }.WithAuthor("Pom-Pom", iconUrl: "https://static.wikia.nocookie.net/houkai-star-rail/images/d/dc/NPC_Pom-Pom_Icon.png/revision/latest/scale-to-width-down/50");
                await ctx.EditResponseAsync(new DiscordWebhookBuilder().AddEmbed(errorEmbed.Build()));                
                return;
            }


            int warps = 0;
            var items = new List<JToken>();
            int three_star_count = 0;
            int four_start_count = 0;
            int five_star_count = 0;
            while (warps != max_warps)
            {
                var item = DoWarp(true, true, three_star_count == 9);
                if (item["rank"].ToString() == "5")
                {
                    ++five_star_count;
                }
                else if (item["rank"].ToString() == "4")
                {
                    ++four_start_count;
                }
                else
                {
                    ++three_star_count;
                }
                items.Add(item);
                Main.Logger.LogInformation("");
                warps++;
            }            
            
            var banner_img = await MakeWarpBanner(items);

            var rand = new Random();
            var banner_path = $"./temp/{ctx.Member.Id}_{rand.Next(5458, 15458)}.png";
            banner_img.Write(banner_path);

            var banner = new FileStream(banner_path, FileMode.Open, FileAccess.Read);

            DiscordColor color;

            if (five_star_count > 0) {
                color = DiscordColor.Gold;
            }
            else if (four_start_count > 0) {
                color = DiscordColor.Purple;
            }
            else {
                color = DiscordColor.Cyan;
            }

            var embed = new DiscordEmbedBuilder
            {
                Title = "The Astral Express Has Arived",
                Color = color
            }.WithAuthor("Pom-Pom", iconUrl: "https://static.wikia.nocookie.net/houkai-star-rail/images/d/dc/NPC_Pom-Pom_Icon.png/revision/latest/scale-to-width-down/50"); ;
            JArray dbRecord = new JArray();
            foreach (var item in items)
            {
                var stars = "";
                switch (item["rank"].ToString())
                {
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
                embed.AddField("Item", $"[{stars}]{item["name"]}",true);
                dbRecord.Add(new JObject
                {
                    { "item", item["id"].ToObject<int>() },
                    { "player", ctx.Member.Id},
                    { "name_suffix","" }

                });
            }

            var items_json = JsonConvert.SerializeObject(dbRecord);
            _dr.AddToInventory(ctx.Member.Id,cost,items_json);
            await ctx.EditResponseAsync(new DiscordWebhookBuilder().AddFile(banner).AddEmbed(embed.Build()));

            banner.Dispose();
            File.Delete(banner_path);

            
        }

        private static JToken DoWarp(bool is_event, bool is_character, bool no_three_star)
        {            
            var random = new Random();
            var randomNumber = random.Next(0, no_three_star ? Options.FourStarMax : 1000);
            JToken item;

            if (randomNumber <= Options.FiveStarMax)
            {
                item = _dr.GetItemFromDatabase(5,"character");                
            }
            else if (randomNumber <= Options.FourStarMax)
            {
                item = _dr.GetItemFromDatabase(4, "character");
            }
            else
            {
                item = _dr.GetItemFromDatabase(3, "character");
            }
            return item;
        }
    

        private async Task<MagickImage> MakeWarpBanner(List<JToken> items)
        {
            string background = "https://cloudthewolf.com/warp_bg.png"; // Move to config later
            
            //207 x 277 max size
            (int x, int y)[] positions = new (int x, int y)[]
            {
                (407, 62),
                (631, 62),
                (856, 62),
                (1306, 62),
                (1081, 62),

                (407, 392),
                (631, 392),
                (856, 392),
                (1081, 392),
                (1306, 392)
            };
            // Download the main image
            var mainImage = await DownloadImageFromUrlAsync(background);
            int pos = 0;         

            foreach (var item in items)
            {

                var overlay = await DownloadImageFromUrlAsync(item["image"].ToString());

                overlay.Density = mainImage.Density;
                overlay = ResizeImage(overlay, 200, item["name"].ToString());
                mainImage.Composite(overlay,x: positions[pos].x, y: positions[pos].y, CompositeOperator.SrcOver);
                overlay.Dispose();
                ++pos;
            }

            return mainImage;
        }

        static async Task<MagickImage> DownloadImageFromUrlAsync(string url)
        {
            try
            {
                var client = new HttpClient();
                client.Timeout = TimeSpan.FromSeconds(30); // Set timeout as needed
                var response = await client.GetAsync(url);
                response.EnsureSuccessStatusCode();
                var stream = await response.Content.ReadAsStreamAsync();
                return new MagickImage(stream);
            }
            catch (Exception ex)
            {
                Main.Logger.LogError(ex.Message);
                throw;
            }
        }

        private static MagickImage ResizeImage(MagickImage image, int maxWidth, string name)
        {
            // Resize the image
            int newWidth = maxWidth;
            int newHeight = (int)(image.Height * ((float)maxWidth / image.Width));
            image.InterpolativeResize(newWidth, newHeight, PixelInterpolateMethod.Bilinear);

            // Split the text if necessary
            string text = name.Length > 15 ? name.Substring(0, 15) + "\n" + name.Substring(15) : name;

            // Create a text overlay image with a transparent background
            using (MagickImage TextOverlay = new MagickImage(MagickColors.Transparent, newWidth, newHeight + 100)) // Adjust height to accommodate text
            {
                // Calculate text placement coordinates
                int textX = newWidth / 2;
                int textY = newHeight + 40; // Adjust as needed for proper placement

                // Draw the text on the overlay
                new Drawables()
                  .FontPointSize(19)
                  .Font("Impact", FontStyleType.Italic, FontWeight.Bold, FontStretch.ExtraExpanded)
                  .StrokeColor(MagickColors.Black)
                  .StrokeWidth(1)
                  .FillColor(MagickColors.White)
                  .TextAlignment(TextAlignment.Center)
                  .Text(textX, textY, text)
                  .Draw(TextOverlay);

                // Create a final image to combine the resized image and the text overlay
                using (MagickImage finalImage = new MagickImage(MagickColors.Transparent, newWidth, newHeight + 100))
                {
                    finalImage.Composite(image, 0, 0, CompositeOperator.SrcOver);
                    finalImage.Composite(TextOverlay, 0, 0, CompositeOperator.SrcOver);                    
                    return (MagickImage)finalImage.Clone();
                }
            }
        }

        private static FileStream OpenFileStream(string path, FileMode mode, FileAccess access)
        {
            return new FileStream(path, mode, access);
        }
    }
}
