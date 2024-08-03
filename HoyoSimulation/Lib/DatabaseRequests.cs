using CloudTheWolf.DSharpPlus.Scaffolding.Data;
using Serilog;
using HoyoSimulation.Models;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace HoyoSimulation.Lib
{
    internal class DatabaseRequests
    {
        private readonly IDatabase _sda;

        public DatabaseRequests()
        {
            _sda = Objects.DatabaseObject.Database;
        }

        internal void AddToInventory(ulong player, int cost, string items_json)
        {
            _sda.Execute($"CALL UpdatePlayerInventory({player}, {cost}, '{items_json}');");
        }

        internal JToken GetItemFromDatabase(int rank, string type, bool must_be_event_item = false)
        {
            var type_request = rank != 5 ? "" : $"(type = '{type}' or type = 'special') AND";
            if(must_be_event_item)
            {
                type_request = $"(type = '{type}' AND event_boosted = 1) AND";
            }
            var result = _sda.Query($"select * from items where {type_request} pack != 0 and `rank` = {rank} order by RAND() LIMIT 1;");
            var item = JsonConvert.SerializeObject(result);
            return JArray.Parse(item)[0];
        }

        internal PlayerModel GetPlayerData(ulong memberId)
        {
            var result = _sda.Query($"SELECT * FROM `players` WHERE id = {memberId}");
            var playerDaya = result.First();
            var player = new PlayerModel()
            {
                id = ulong.Parse(playerDaya.id.ToString()),
                stellar_gems = int.Parse(playerDaya.stellar_gems.ToString()),
                last_reward = DateTime.Parse(playerDaya.last_reward.ToString()),
                warps_since_five_star = int.Parse(playerDaya.warps_since_five_star.ToString()),
                warps_since_event_character = int.Parse(playerDaya.warps_since_event_character.ToString()),
                warps_since_event_weapon = int.Parse(playerDaya.warps_since_event_weapon.ToString()),
            };

            return player;

        }

        internal IEnumerable<dynamic> GetPlayerItems(ulong memberId)
        {
            var result = _sda.Query($"CALL GetPlayerInventory({memberId});");
            return result;            
        }

        internal void IssueReward(ulong player, int reward)
        {
            _sda.Execute($"CALL UpdatePlayerGems({player}, {reward});");
        }

        internal void UpdatePlayerWarps(ulong id, int total_warps, int event_warps, string warp_banner)
        {
            var event_field = $"warps_since_event_{warp_banner.ToLower()}";
            _sda.Execute($"UPDATE `players` SET `warps_since_five_star` = '{total_warps}', `{event_field}` = '{event_warps}' WHERE (`id` = '{id}');");
        }
    }
}
