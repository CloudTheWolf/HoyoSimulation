using CloudTheWolf.DSharpPlus.Scaffolding.Data;
using Serilog.Core;
using Serilog;
using CloudTheWolf.DSharpPlus.Scaffolding.Shared.Interfaces;
using DSharpPlus;
using HoyoSimulation.Actions;
using HoyoSimulation.Events;
using HoyoSimulation.Objects;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using ILogger = Serilog.ILogger;
using CloudTheWolf.DSharpPlus.Scaffolding.Logging;

namespace HoyoSimulation
{
    public class Main : IPlugin
    {
        public string Name => "Hoyoverse Pull Simulator";

        public string Description => "A plugin to simulate pulls from Hoyoverse games";

        public int Version => 1;

        

        public void InitPlugin(IBot bot, ILogger logger, DiscordConfiguration discordConfiguration, IConfigurationRoot applicationConfig)
        {
            Logger.Initialize();
            LoadDatabase(applicationConfig);
            LoadConfig(applicationConfig);
            RegisterCommands(bot);
            bot.Client.MessageCreated += MessageEvents.OnMessageCreated;
            Logger.Log.LogInformation("We're Ready");
            bot.Client.GuildDownloadCompleted += GuildEvents.OnDownloadCompleted;

            //TODO: Wait for Command Appending before moving to the new ClientBuilder Method 
            //bot.ClientBuilder.ConfigureEventHandlers(
            //    b => b.HandleMessageCreated(async (c, a) =>
            //        {
            //            await MessageEvents.OnMessageCreated(c, a);
            //        })
            //        .HandleGuildDownloadCompleted(async (c, e) =>
            //        {
            //            await GuildEvents.OnDownloadCompleted(c, e);
            //        })
            //);
        }

        /// <summary>
        /// Create a Database Object using the details in the Application Config
        /// </summary>
        /// <param name="applicationConfig"></param>
        private void LoadDatabase(IConfigurationRoot applicationConfig)
        {
            DatabaseObject.Database = DatabaseFactory.CreateDatabase(applicationConfig);
        }
        /// <summary>
        /// Load out Bot Config
        /// </summary>
        /// <param name="applicationConfig"></param>
        private void LoadConfig(IConfigurationRoot applicationConfig)
        {
            //TODO: Move these settings to the Database and allow for Per-Guild settings
            Options.WarpBackground = applicationConfig.GetValue<string>("Warp:Background");
            Options.FiveStarMax = applicationConfig.GetValue<int>("Warp:FiveStarMax");
            Options.FourStarMax = applicationConfig.GetValue<int>("Warp:FourStarMax");
        }

        private void RegisterCommands(IBot bot)
        {
            Logger.Log.LogInformation("{0}: Starting Command Registration!", Name);

            bot.Commands.AddCommands(typeof(HonkaiStarRail));
            Logger.Log.LogInformation("{0}: Registered {1} Commands!", Name, nameof(HonkaiStarRail));

            bot.Commands.AddCommands(typeof(Player));
            Logger.Log.LogInformation("{0}: Registered {1} Commands!", Name, nameof(Player));

        }
    }
}
