LegacyIIInGameMiscWeaponIconPack = {}

LegacyIIInGameMiscWeaponIconPack.prefix = "LegacyIIInGameMiscWeaponIconPack_"
LegacyIIInGameMiscWeaponIconPack.textures = {
"bola",
"fukiyaanddarts",
"shuriken",
"smokebomb"
}

function LegacyIIInGameMiscWeaponIconPack.Initialize()
    for i,v in ipairs( LegacyIIInGameMiscWeaponIconPack.textures ) do
        IconLoader.AddIconData( LegacyIIInGameMiscWeaponIconPack.prefix..v )
    end
end
