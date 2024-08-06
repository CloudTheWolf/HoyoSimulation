using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DSharpPlus;
using DSharpPlus.EventArgs;

namespace HoyoSimulation.Events
{
    internal class HeartbeatEvents
    {
        public static Task UpdateStatusOnHeartBeat(DiscordClient sender, HeartbeatedEventArgs args)
        {
            if (Options.StatusCounter == 1)
            {
                GuildEvents.SetStatus(sender);
            }

            Options.StatusCounter = Options.StatusCounter == 15 ? 0 :  Options.StatusCounter + 1;
            return Task.CompletedTask;
        }
    }
}
