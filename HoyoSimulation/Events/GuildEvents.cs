using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DSharpPlus;
using DSharpPlus.EventArgs;
using Microsoft.Extensions.Logging;

namespace HoyoSimulation.Events
{
    internal class GuildEvents
    {
        internal static async Task OnDownloadCompleted(DiscordClient client, GuildDownloadCompletedEventArgs args)
        {
            args.Guilds.ToList().ForEach(async guild =>
            {
                Main.Logger.LogInformation($"In Guild {guild.Value.Name}");
            });            
            
        }
    }
}
