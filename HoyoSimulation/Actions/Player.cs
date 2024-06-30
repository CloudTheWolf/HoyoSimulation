using DSharpPlus.SlashCommands;
using DSharpPlus.Entities;
using Newtonsoft.Json.Linq;
using Microsoft.Extensions.Logging;
using HoyoSimulation.Lib;
using System.Net;
using System.Drawing;
using System.Drawing.Imaging;

namespace HoyoSimulation.Actions
{
    [SlashCommandGroup(name: "player", "Player Commands", false)]
    internal class Player : ApplicationCommandModule
    {
        private static DatabaseRequests _dr = new DatabaseRequests(Main.Logger);

        public Player() {
            _dr = new DatabaseRequests(Main.Logger);
        }

        [SlashCommand(name:"inventory", description:"Check your Inventory",false)]
        public async Task CharacterWarp(InteractionContext ctx)
        {            
            ctx.DeferAsync(ephemeral: true);
            var bank = _dr.GetPlayerBank(ctx.Member.Id);

            var items = _dr.GetPlayerItems(ctx.Member.Id);

            var embed = new DiscordEmbedBuilder
            {
                Title = "Your Inventory"
            };
            embed.AddField("Bank", $"<:Item_Stellar_Jade:1256938540369969202> {bank}");

            var field_count = 1;
            var extra = 0;
            foreach(var item in items)
            {
                if(field_count == 21)
                {
                    ++extra;
                    continue;
                }
                embed.AddField($"{item["full_item_name"]}", $"x{item["item_count"]}", true);
                ++field_count;
            }

            if(extra > 0)
            {
                embed.AddField("And", $"{extra} more unique items!", true);
            }

            await ctx.EditResponseAsync(new DiscordWebhookBuilder().AddEmbed(embed.Build()));
        }

        
    }
}
