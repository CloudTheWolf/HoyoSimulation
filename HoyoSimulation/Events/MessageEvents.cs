using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using DSharpPlus;
using DSharpPlus.EventArgs;
using HoyoSimulation.Lib;

namespace HoyoSimulation.Events
{
    internal class MessageEvents
    {
        private static DatabaseRequests _dr = new DatabaseRequests(Main.Logger);
        internal static async Task OnMessageCreated(DiscordClient client, MessageCreateEventArgs args)
        {

            if (args.Author.IsBot) return;


            var rewards = new List<int>
            {
                5,
                10,
                50,
                100,
                160,
                300,
                600,
                1600
            };

            var rand = new Random();           
            _dr.IssueReward(args.Author.Id, rewards[rand.Next(0, 7)]);
            

        }
    }
}
