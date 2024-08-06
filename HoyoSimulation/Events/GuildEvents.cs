using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DSharpPlus;
using DSharpPlus.Entities;
using DSharpPlus.EventArgs;
using HoyoSimulation.Lib;
using Microsoft.Extensions.Logging;

namespace HoyoSimulation.Events
{
    internal class GuildEvents
    {
        internal static async Task OnDownloadCompleted(DiscordClient client, GuildDownloadCompletedEventArgs args)
        {
            args.Guilds.ToList().ForEach(async guild =>
            {
                Logger.Log.LogInformation("[± {0}]In Guild {1}", Options.LogPrefix, guild.Value.Name);
                var _dr = new DatabaseRequests();
                _dr.ImportGuild(guild.Value.Id, guild.Value.Name);
            });            
            SetStatus(client);
        }

        public static async Task SetStatus(DiscordClient client)
        {
            var _dr = new DatabaseRequests();
            var players = _dr.GetPlayers();
            var guilds = _dr.GetGuilds();
            client.UpdateStatusAsync(new DiscordActivity($"with {players} Trailblazers in {guilds} Guilds", DiscordActivityType.Playing));
        }
    }
}
