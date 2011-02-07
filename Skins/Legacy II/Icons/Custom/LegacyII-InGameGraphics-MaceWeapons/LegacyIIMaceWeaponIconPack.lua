LegacyIIInGameMaceWeaponIconPack = {}

LegacyIIInGameMaceWeaponIconPack.prefix = "LegacyIIInGameMaceWeaponIconPack_"
LegacyIIInGameMaceWeaponIconPack.textures = {
"blackstaff",
"club",
"crook",
"diamondmace",
"discmace",
"glassstaff",
"gnarledstaff",
"hammerpick",
"mace",
"maul",
"nunchaku",
"quarterstaff",
"scepter",
"serpentstonestaff",
"sledgehammer",
"smithhammer",
"tessen",
"tetsubo",
"wand1",
"wand2",
"wand3",
"wand4",
"waraxe",
"warhammer",
"warmace",
"wildstaff"
}

function LegacyIIInGameMaceWeaponIconPack.Initialize()
    for i,v in ipairs( LegacyIIInGameMaceWeaponIconPack.textures ) do
        IconLoader.AddIconData( LegacyIIInGameMaceWeaponIconPack.prefix..v )
    end
end
