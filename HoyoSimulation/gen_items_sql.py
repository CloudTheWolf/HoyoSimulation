import time
import sys
import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin

####
# Genshin
###
GENSHIN_BASE = "https://genshin-impact.fandom.com"
GENSHIN_CHARACTER_LIST = f"{GENSHIN_BASE}/wiki/Character/List"
GENSHIN_WEAPON_LIST = f"{GENSHIN_BASE}/wiki/Weapon/List"

###
# ZZZ
###
ZZZ_BASE = "https://zenless-zone-zero.fandom.com"
ZZZ_AGENT_LIST = f"{ZZZ_BASE}/wiki/Agent/List"
ZZZ_WENGINE_LIST = f"{ZZZ_BASE}/wiki/W-Engine/List"


HEADERS = {
    'Cookie': 'Geo={%22region%22:%22LCE%22%2C%22city%22:%22leicester%22%2C%22country_name%22:%22united kingdom%22%2C%22country%22:%22GB%22%2C%22continent%22:%22EU%22}; exp_bucket=v7-70; exp_bucket_2=v5-61'
}

REQUEST_DELAY = 0.5  # safe for API usage

def normalize(text):
    return " ".join((text or "").split()).lower()

def sql_escape(value):
    if value is None:
        return "NULL"
    return "'" + str(value).replace("\\", "\\\\").replace("'", "\\'") + "'"

def normalize_filename(name):
    return (
        name
        .replace('"', '')
        .replace('[', '(')
        .replace(']', ')')
        .replace(' ', '_')
    )

def build_banner_filenames(name, item_type):
    safe = normalize_filename(name)
    match item_type:
        # Genshin
        case "character":
            return [f"Character_{safe}_Full_Wish.png"]
        case "weapon":
            return [f"Weapon_{safe}_Wish.png",f"Weapon_{safe}_Full_Icon.png",f"Weapon_{safe}_3D.png"]

        # Zenless Zone Zero
        case "agent":
            return [
                f"Mindscape_{safe}_Full.png"
            ]
        case "w-engine":
            return [
                f"W-Engine_{safe}.png"
            ]

        case _:
            raise ValueError(f"Unknown item_type: {item_type}")


def fetch_banner_image(name, item_type, base_url, session):
    filenames = build_banner_filenames(name, item_type)

    for filename in filenames:
        api_url = (
            f"{base_url}/api.php"
            "?action=query"
            "&format=json"
            "&prop=imageinfo"
            "&iiprop=url"
            f"&titles=File:{filename}"
        )
        try:
            resp = session.get(api_url, headers=HEADERS, timeout=20)
            resp.raise_for_status()
            data = resp.json()
        except Exception:
            continue

        pages = data.get("query", {}).get("pages", {})
        for page in pages.values():
            imageinfo = page.get("imageinfo")
            if imageinfo and isinstance(imageinfo, list):
                url = imageinfo[0].get("url")
                if url:
                    return url

    print(f"[WARN] No banner image found for {item_type} {name}", file=sys.stderr)
    print(f"Check {api_url}")    
    return None

def parse_rank_from_alt(alt_text):
    """
    Parse rank from an image alt string.
    Supports:
      - Numeric stars (e.g. '5 Stars')
      - ZZZ letter ranks (e.g. 'Agent Rank S', 'Item Rank A')
    """
    print(f"Parsing {alt_text}")
    if not alt_text:
        return None

    alt_text = alt_text.strip()

    # 1️⃣ Try numeric (Genshin-style)
    try:
        return int(alt_text[0])
    except (ValueError, IndexError):
        pass
    print("ZZZ Mode")
    # 2️⃣ Try letter rank (ZZZ-style)
    rank_map = {
        "B": 3,
        "A": 4,
        "S": 5,
    }

    last_char = alt_text[-1].upper()
    return rank_map.get(last_char)

def fetch_items(list_url, base_url, item_type, session):
    print (list_url)
    resp = session.get(list_url, headers=HEADERS, timeout=25)
    resp.raise_for_status()
    soup = BeautifulSoup(resp.text, "html.parser")

    seen = set()
    results = []

    for table in soup.find_all("table"):
        header_row = table.find("tr")
        if not header_row:
            continue

        headers = header_row.find_all("th", recursive=False)
        if not headers:
            continue

        header_map = {}
        for i, th in enumerate(headers):
            text = normalize(th.get_text())
            if text == "name":
                header_map["name"] = i
            elif text == "title":
                header_map["name"] = i
            elif text == "version":
                header_map["version"] = i
            elif (
                "quality" in text
                or "rarity" in text
                or text == "rank"
            ):
                header_map["quality"] = i

        if "name" not in header_map:
            continue

        name_idx = header_map["name"]
        version_idx = header_map.get("version")
        quality_idx = header_map.get("quality")

        for row in table.find_all("tr")[1:]:            
            cols = row.find_all("td", recursive=False)
            if len(cols) <= name_idx:
                continue

            name_cell = cols[name_idx]
            link = name_cell.find("a", href=True)
            if not link:
                continue

            name = link.get_text(strip=True)
            if not name or name in seen:
                continue

            version = cols[version_idx].get_text(strip=True) if version_idx is not None else None

            rank = None
            if quality_idx is not None:
                img = cols[quality_idx].find("img")
                if img and img.get("alt"):
                    try:
                        rank = parse_rank_from_alt(img.get("alt"))
                    except Exception:
                        pass

            print(f"[INFO] Resolving {item_type} banner: {name}")
            banner = fetch_banner_image(name, item_type, base_url, session)
            if banner:
                results.append({
                    "name": name,
                    "version": version,
                    "wish_image": banner,
                    "rank": rank,
                })

            seen.add(name)
            time.sleep(REQUEST_DELAY)

    return results

def to_sql(row, item_type,game_name):

    version_value = (
        row.get("version")
        if row.get("wish_image")
        else "0"
    )
        
    return (
        "INSERT INTO `HoyoSim`.`items`"
        "(`name`,`pack`,`image`,`game`,`canShiny`,`rank`,`event_only`,`event_boosted`,`type`)VALUES("
        f"{sql_escape(row['name'])},"
        f"{sql_escape(version_value) if version_value else sql_escape("1.0")},"
        f"{sql_escape(row['wish_image']) if row['wish_image'] else 'NULL'},"
        f"{sql_escape(game_name)},"
        f"{'1' if item_type == 'character' else '0'},"
        f"{row['rank'] if row['rank'] is not None else 'NULL'},"
        "0,0,"
        f"{sql_escape(item_type)});"
    )

if __name__ == "__main__":
    session = requests.Session()

    characters = fetch_items(GENSHIN_CHARACTER_LIST,GENSHIN_BASE,"character",session)
    weapons = fetch_items(GENSHIN_WEAPON_LIST,GENSHIN_BASE,"weapon",session)
    agents = fetch_items(ZZZ_AGENT_LIST,ZZZ_BASE,"agent",session)
    w_engines = fetch_items(ZZZ_WENGINE_LIST,ZZZ_BASE,"w-engine",session)

    output_file = "hoyosim_items.sql"

    with open(output_file, "w", encoding="utf-8") as f:
        # Header comment
        f.write("-- Auto-generated Genshin Impact items\n")
        f.write(f"-- Characters: {len(characters)}\n")
        f.write(f"-- Weapons: {len(weapons)}\n")
        f.write("-- Auto-generated ZZZ items\n")
        f.write(f"-- Characters: {len(agents)}\n")
        f.write(f"-- Weapons: {len(w_engines)}\n")
        f.write(f"-- Generated at: {time.strftime('%Y-%m-%d %H:%M:%S')}\n\n")

        # Characters
        for row in characters:
            sql = to_sql(row, "character","genshin")
            # print(sql)
            f.write(sql + "\n")

        # Weapons
        for row in weapons:
            sql = to_sql(row, "weapon","genshin")
            # print(sql)
            f.write(sql + "\n")

        # Agents
        for row in agents:
             sql = to_sql(row, "character","zzz")
            # print(sql)
             f.write(sql + "\n")

        # W-Engine
        for row in w_engines:
            sql = to_sql(row, "weapon","zzz")
            # print(sql)
            f.write(sql + "\n")

    print(f"\n-- SQL written to {output_file}")
