using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HoyoSimulation.Models
{
    internal class PlayerModel
    {
        public ulong id {  get; set; }
        public int stellar_gems { get; set; }
        public DateTime last_reward { get; set; }
        public int warps_since_five_star {  get; set; }
        public int warps_since_event_character { get; set; }
        public int warps_since_event_weapon { get; set; }

    }
}
