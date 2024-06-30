using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CloudTheWolf.DSharpPlus.Scaffolding.Data;
using CloudTheWolf.DSharpPlus.Scaffolding.Logging;
using Microsoft.Extensions.Logging;
using MySqlConnector;
using Newtonsoft.Json.Linq;

namespace HoyoSimulation.Lib
{
    internal class DatabaseRequests
    {
        public static ILogger<Logger> DbLogger;
        private static MySqlDataAccess _sda = new();

        public DatabaseRequests(ILogger<Logger> logger)
        {
            DbLogger = logger;
            MySqlConnectionStringBuilder connStringBuilder = new MySqlConnectionStringBuilder
            {
                Server = Options.MySqlHost,
                Port = (uint)Options.MySqlPort,
                UserID = Options.MySqlUsername,
                Password = Options.MySqlPassword,
                Database = Options.MySqlDatabase
            };
            _sda.LoadConnectionString(connStringBuilder.ToString(), DbLogger);
        }

        internal void AddToInventory(ulong player, int cost, string items_json)
        {
            
            _sda.Request($"CALL UpdatePlayerInventory({player}, {cost}, '{items_json}');", DbLogger);
        }

        internal JToken GetItemFromDatabase(int rank, string type)
        {
            var type_request = rank != 5 ? "" : $"type = '{type}' and"; // Only filter on warp type for 5-stars 
            var result = _sda.Request($"select * from items where {type_request} pack != 0 and `rank` = {rank} order by RAND() LIMIT 1;", DbLogger);
            return JArray.Parse(result)[0];
        }

        internal int GetPlayerBank(ulong player)
        {
            var result = _sda.Request($"SELECT * FROM `players` WHERE id = {player}",DbLogger);
            var json = JArray.Parse(result);
            if (json == null || json.Count == 0) return 0;
            return json[0]["stellar_gems"].ToObject<int>();
        }

        internal JArray GetPlayerItems(ulong player)
        {
            var result = _sda.Request($"CALL GetPlayerInventory({player});", DbLogger);
            return JArray.Parse(result);            
        }

        internal void IssueReward(ulong player, int reward)
        {
            _sda.Request($"CALL UpdatePlayerGems({player}, {reward});",DbLogger);
        }
    }
}
