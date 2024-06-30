using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HoyoSimulation
{
    internal class Options
    {
        /// <summary>
        /// MySql Host
        /// </summary>
        public static string MySqlHost { get; set; }
        /// <summary>
        /// MySql Port
        /// </summary>
        public static int MySqlPort { get; set; }
        /// <summary>
        /// MySql Password
        /// </summary>
        public static string MySqlUsername { get; set; }
        /// <summary>
        /// MySql Username
        /// </summary>
        public static string MySqlPassword { get; set; }
        /// <summary>
        /// MySql Database Name
        /// </summary>
        public static string MySqlDatabase { get; set; }
        /// <summary>
        /// Base image for warps
        /// </summary>
        public static string WarpBackground { get; set; }
        /// <summary>
        /// Rate for 5-Star drops
        /// </summary>
        public static int FiveStarMax {  get; set; }
        /// <summary>
        /// Rate for 4-Star Drops
        /// </summary>
        public static int FourStarMax { get; set; }

    }
}
