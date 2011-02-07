LegacyIIInGameSwordWeaponIconPack = {}

LegacyIIInGameSwordWeaponIconPack.prefix = "LegacyIIInGameSwordWeaponIconPack_"
LegacyIIInGameSwordWeaponIconPack.textures = {"axe",
"bardiche",
"battleaxe",
"bladedstaff",
"bokuto",
"boneharvester",
"broadsword",
"cleaver",
"crescentblade",
"cutlass",
"daisho",
"doubleaxe",
"elvenmachete",
"executionersaxe",
"halberd",
"katana",
"largebattleaxe",
"longsword",
"nodachi",
"ornateaxe",
"radiantscimitar",
"runeblade",
"scimitar",
"scythe",
"twohandedaxe",
"vikingsword",
"wakizashi"}

function LegacyIIInGameSwordWeaponIconPack.Initialize()
    for i,v in ipairs( LegacyIIInGameSwordWeaponIconPack.textures ) do
        IconLoader.AddIconData( LegacyIIInGameSwordWeaponIconPack.prefix..v )
    end
end

















