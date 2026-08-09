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
    internal class BannerTypeProvider : IChoiceProvider
    {
        private static readonly IEnumerable<DiscordApplicationCommandOptionChoice> BannerTypes =
        [
            new("Character Banner", "character"),
            new("Weapon Banner", "weapon")
        ];

        public ValueTask<IEnumerable<DiscordApplicationCommandOptionChoice>> ProvideAsync(
            CommandParameter parameter) => ValueTask.FromResult(BannerTypes);
    }
    internal class ZenlessBannerTypeProvider : IChoiceProvider
    {
        private static readonly IEnumerable<DiscordApplicationCommandOptionChoice> BannerTypes =
        [
            new("Agent Banner", "character"),
            new("W-Engine Banner", "weapon")
        ];

        public ValueTask<IEnumerable<DiscordApplicationCommandOptionChoice>> ProvideAsync(
            CommandParameter parameter) => ValueTask.FromResult(BannerTypes);
    }
}
