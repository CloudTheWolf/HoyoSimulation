using CloudTheWolf.DSharpPlus.Scaffolding.Logging;
using CloudTheWolf.DSharpPlus.Scaffolding.Shared.Interfaces;
using DSharpPlus;
using HoyoSimulation.Actions;
using HoyoSimulation.Events;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace HoyoSimulation
{
    public class Main : IPlugin
    {
        public string Name => "Hoyoverse Pull Simulator";

        public string Description => "A plugin to simulate pulls from Hoyoverse games";

        public int Version => 1;

        public static ILogger<Logger> Logger;

        public void InitPlugin(IBot bot, ILogger<Logger> logger, DiscordConfiguration discordConfiguration, IConfigurationRoot applicationConfig)
        {
            Logger = logger;
            LoadConfig(applicationConfig);
            RegisterCommands(bot);
            bot.Client.MessageCreated += MessageEvents.OnMessageCreated;
            Logger.LogInformation("Ready to warp");
            bot.Client.GuildDownloadCompleted += GuildEvents.OnDownloadCompleted;
        }

        private void LoadConfig(IConfigurationRoot applicationConfig)
        {
            Options.MySqlHost = applicationConfig.GetValue<string>("SQL:Host");
            Options.MySqlPort = applicationConfig.GetValue<int>("SQL:Port");
            Options.MySqlUsername = applicationConfig.GetValue<string>("SQL:Username");
            Options.MySqlPassword = applicationConfig.GetValue<string>("SQL:Password");
            Options.MySqlDatabase = applicationConfig.GetValue<string>("SQL:Database");
            Options.WarpBackground = applicationConfig.GetValue<string>("Warp:Background");
            Options.FiveStarMax = applicationConfig.GetValue<int>("Warp:FiveStarMax");
            Options.FourStarMax = applicationConfig.GetValue<int>("Warp:FourStarMax");
        }

        private void RegisterCommands(IBot bot)
        {
            bot.SlashCommandsExt.RegisterCommands<HonkaiStarRail>();
            Logger.LogInformation(Name + ": Registered {0}!", nameof(HonkaiStarRail));

            bot.SlashCommandsExt.RegisterCommands<Player>();
            Logger.LogInformation(Name + ": Registered {0}!", nameof(Player));
        }
    }
}
