LegacyIIInGameThrowingWeaponIconPack = {}

LegacyIIInGameThrowingWeaponIconPack.prefix = "LegacyIIInGameThrowingWeaponIconPack_"
LegacyIIInGameThrowingWeaponIconPack.textures = {
"boomerang",
"cyclone",
"soulglaive"
}
function LegacyIIInGameThrowingWeaponIconPack.Initialize()
    for i,v in ipairs( LegacyIIInGameThrowingWeaponIconPack.textures ) do
        IconLoader.AddIconData( LegacyIIInGameThrowingWeaponIconPack.prefix..v )
    end
end
