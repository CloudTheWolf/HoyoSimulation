using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DSharpPlus;
using DSharpPlus.Entities;
using DSharpPlus.EventArgs;
using HoyoSimulation.Lib;

namespace HoyoSimulation.Events
{
    internal class GuildEvents
    {
        internal static async Task OnDownloadCompleted(DiscordClient client, GuildDownloadCompletedEventArgs args)
        {
            foreach (var guild in args.Guilds)
            {
                PluginLogging.Logger.Information(
                    "Plugin {PluginName} is active in guild {GuildName}",
                    Options.LogPrefix,
                    guild.Value.Name);
                var databaseRequests = new DatabaseRequests();
                databaseRequests.ImportGuild(guild.Value.Id, guild.Value.Name);
            }

            await SetStatus(client).ConfigureAwait(false);
        }

        public static Task SetStatus(DiscordClient client)
        {
            var databaseRequests = new DatabaseRequests();
            var players = databaseRequests.GetPlayers();
            var guilds = databaseRequests.GetGuilds();
            return client.UpdateStatusAsync(
                new DiscordActivity(
                    $"with {players} Trailblazers in {guilds} Guilds",
                    DiscordActivityType.Playing));
        }
    }
}
