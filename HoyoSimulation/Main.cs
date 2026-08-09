using CloudTheWolf.DSharpPlus.Scaffolding.Data;
using CloudTheWolf.DSharpPlus.Scaffolding.Shared.Interfaces;
using DSharpPlus.Commands.Trees;
using HoyoSimulation.Actions;
using HoyoSimulation.Events;
using HoyoSimulation.Objects;
using Microsoft.Extensions.Configuration;
using Serilog;

namespace HoyoSimulation
{
    public class Main : IPlugin
    {
        private ILogger _logger;

        public string Name => "Hoyoverse Pull Simulator";

        public string Id => "cloudthewolf.hoyosimulation";

        public string Description => "A plugin to simulate pulls from Hoyoverse games";

        public int Version => 1;

        public System.Version PluginVersion => new(1, 0, 1);

        public Task InitializeAsync(
            PluginContext context,
            CancellationToken cancellationToken = default)
        {
            ArgumentNullException.ThrowIfNull(context);
            cancellationToken.ThrowIfCancellationRequested();

            _logger = context.Logger.ForContext<Main>();
            PluginLogging.Initialize(_logger);
            Options.LogPrefix = Name;

            LoadDatabase(context.Configuration);
            LoadConfig(context.Configuration);
            RegisterCommands(context.Bot);
            context.Bot.RegisterEventHandlers(Id, events => events
                .HandleMessageCreated(MessageEvents.OnMessageCreated)
                .HandleGuildDownloadCompleted(GuildEvents.OnDownloadCompleted));

            _logger.Information(
                "Plugin {PluginId} version {PluginVersion} initialized",
                Id,
                PluginVersion);
            return Task.CompletedTask;
        }

        public Task ShutdownAsync(CancellationToken cancellationToken = default)
        {
            _logger?.Information("Plugin {PluginId} is shutting down", Id);
            DatabaseObject.Database = null;
            PluginLogging.Reset();
            _logger = null;
            return Task.CompletedTask;
        }

        /// <summary>
        /// Create a Database Object using the details in the Application Config.
        /// </summary>
        private static void LoadDatabase(IConfigurationRoot applicationConfig)
        {
            DatabaseObject.Database = DatabaseFactory.CreateDatabase(applicationConfig);
        }

        /// <summary>
        /// Load the plugin configuration.
        /// </summary>
        private static void LoadConfig(IConfigurationRoot applicationConfig)
        {
            // TODO: Move these settings to the database and allow per-guild settings.
            Options.HsrWarpBackground = applicationConfig.GetValue<string>("Warp:Background");
            Options.GenshinWarpBackground = Options.HsrWarpBackground;
            Options.ZenlessWarpBackground = Options.HsrWarpBackground;
            Options.FiveStarMax = applicationConfig.GetValue<int>("Warp:FiveStarMax");
            Options.FourStarMax = applicationConfig.GetValue<int>("Warp:FourStarMax");
            Options.ProfileUrlBase = applicationConfig.GetValue<string>("Warp:ProfileUrl");
        }

        private void RegisterCommands(IBot bot)
        {
            RegisterCommand<HonkaiStarRail>(bot);
            RegisterCommand<Zenless>(bot);
            RegisterCommand<Genshin>(bot);
            RegisterCommand<Player>(bot);
        }

        private void RegisterCommand<TCommand>(IBot bot)
        {
            var command = CommandBuilder.From(typeof(TCommand));
            bot.RegisterCommand(command);
            _logger.Information(
                "Plugin {PluginId} registered command {CommandName}",
                Id,
                command.Name);
        }
    }
}
