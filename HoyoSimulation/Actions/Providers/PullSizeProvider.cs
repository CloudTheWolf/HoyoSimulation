using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DSharpPlus.Commands.Processors.SlashCommands.ArgumentModifiers;
using DSharpPlus.Commands.Trees;

namespace HoyoSimulation.Actions.Providers
{
    internal class PullSizeProvider : IChoiceProvider
    {
        private static readonly IReadOnlyDictionary<string, object> Number = new Dictionary<string, object>
        {
            ["1"] = 1,
            ["2"] = 2,
            ["3"] = 3,
            ["4"] = 4,
            ["5"] = 5,
            ["6"] = 6,
            ["7"] = 7,
            ["8"] = 8,
            ["9"] = 9,
            ["10"] = 10,


        };

        public ValueTask<IReadOnlyDictionary<string, object>> ProvideAsync(CommandParameter parameter) => ValueTask.FromResult(Number);
    }
}
