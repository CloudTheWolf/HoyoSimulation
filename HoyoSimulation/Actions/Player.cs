using DSharpPlus.Entities;
using Newtonsoft.Json.Linq;
using Microsoft.Extensions.Logging;
using HoyoSimulation.Lib;
using System.Net;
using System.Drawing;
using System.Drawing.Imaging;
using DSharpPlus.Commands.ContextChecks;
using DSharpPlus.Commands;
using System.ComponentModel;
using DSharpPlus.Commands.Processors.SlashCommands;

namespace HoyoSimulation.Actions
{
    internal class Player
    {
        private static DatabaseRequests _dr = new();

        public Player() {
            _dr = new DatabaseRequests();
        }

        [Command(name: "inventory"), Description("Check your Inventory"), RequirePermissions(botPermissions: DiscordPermissions.None, userPermissions: DiscordPermissions.UseApplicationCommands),SlashCommandTypes(DiscordApplicationCommandType.SlashCommand)]
        public async Task CharacterWarp(SlashCommandContext ctx)
        {            
            _ = ctx.DeferResponseAsync(true);
            
            var player = _dr.GetPlayerData(ctx.Member.Id);

            var items = _dr.GetPlayerItems(ctx.Member.Id);

            var embed = new DiscordEmbedBuilder
            {
                Title = $"Inventory For {ctx.Member.DisplayName} ({ctx.Member.Username})"
            };
            embed.AddField("Bank", $"<:Item_Stellar_Jade:1256938540369969202> {player.stellar_gems}");

            var field_count = 1;
            var extra = 0;
            foreach(var item in items)
            {
                if(field_count == 21)
                {
                    ++extra;
                    continue;
                }
                embed.AddField($"{item.full_item_name}", $"x{item.item_count}", true);
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
