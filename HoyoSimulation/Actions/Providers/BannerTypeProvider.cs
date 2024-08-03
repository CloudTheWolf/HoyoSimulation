using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DSharpPlus.Commands.Processors.SlashCommands.ArgumentModifiers;
using DSharpPlus.Commands.Trees;

namespace HoyoSimulation.Actions.Providers
{
    internal class BannerTypeProvider : IChoiceProvider
    {
        private static readonly IReadOnlyDictionary<string, object> bannerType = new Dictionary<string, object>
        {
            ["Character Banner"] = "character",
            ["Weapon Banner"] = "weapon"

        };

        public ValueTask<IReadOnlyDictionary<string, object>> ProvideAsync(CommandParameter parameter) => ValueTask.FromResult(bannerType);
    }
}
