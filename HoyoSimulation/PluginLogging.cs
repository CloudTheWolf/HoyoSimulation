using Serilog;

namespace HoyoSimulation
{
    /// <summary>
    /// Makes the host-owned plugin logger available to static command and event handlers.
    /// The reference is cleared during shutdown so it cannot outlive the plugin lifecycle.
    /// </summary>
    internal static class PluginLogging
    {
        private static ILogger _logger;

        internal static ILogger Logger => _logger
            ?? throw new InvalidOperationException("The HoyoSimulation plugin has not been initialized.");

        internal static void Initialize(ILogger logger)
        {
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        internal static void Reset()
        {
            _logger = null;
        }
    }
}
