using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CloudTheWolf.DSharpPlus.Scaffolding.Data;
using CloudTheWolf.DSharpPlus.Scaffolding.Logging;
using HoyoSimulation.Models;
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

        internal JToken GetItemFromDatabase(int rank, string type, bool must_be_event_item = false)
        {
            var type_request = rank != 5 ? "" : $"(type = '{type}' or type = 'special') AND";
            if(must_be_event_item)
            {
                type_request = $"(type = '{type}' AND event_boosted = 1) AND";
            }
            var result = _sda.Request($"select * from items where {type_request} pack != 0 and `rank` = {rank} order by RAND() LIMIT 1;", DbLogger);
            return JArray.Parse(result)[0];
        }

        internal PlayerModel GetPlayerData(ulong player)
        {
            var result = _sda.Request($"SELECT * FROM `players` WHERE id = {player}",DbLogger);
            var json = JArray.Parse(result);
            if (json == null || json.Count == 0) return null;
            return new PlayerModel()
            {
                id = ulong.Parse(json[0]["id"].ToString()),
                stellar_gems = int.Parse(json[0]["stellar_gems"].ToString()),
                last_reward = DateTime.Parse(json[0]["last_reward"].ToString()),
                warps_since_five_star = int.Parse(json[0]["warps_since_five_star"].ToString()),
                warps_since_event_character = int.Parse(json[0]["warps_since_event_character"].ToString()),
                warps_since_event_weapon = int.Parse(json[0]["warps_since_event_weapon"].ToString()),
            };            
            
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

        internal void UpdatePlayerWarps(ulong id, int total_warps, int event_warps, string warp_banner)
        {
            var event_field = $"warps_since_event_{warp_banner.ToLower()}";
            _sda.Request($"UPDATE `players` SET `warps_since_five_star` = '{total_warps}', `{event_field}` = '{event_warps}' WHERE (`id` = '{id}');",DbLogger);
        }
    }
}
