using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DSharpPlus.Commands.Processors.SlashCommands.ArgumentModifiers;
using DSharpPlus.Commands.Trees;
using DSharpPlus.Entities;

namespace HoyoSimulation.Actions.Providers
{
    internal class PullSizeProvider : IChoiceProvider
    {
        private static readonly IEnumerable<DiscordApplicationCommandOptionChoice> PullSizes =
        [
            new("1", 1),
            new("2", 2),
            new("3", 3),
            new("4", 4),
            new("5", 5),
            new("6", 6),
            new("7", 7),
            new("8", 8),
            new("9", 9),
            new("10", 10)
        ];

        public ValueTask<IEnumerable<DiscordApplicationCommandOptionChoice>> ProvideAsync(
            CommandParameter parameter) => ValueTask.FromResult(PullSizes);
    }
}
