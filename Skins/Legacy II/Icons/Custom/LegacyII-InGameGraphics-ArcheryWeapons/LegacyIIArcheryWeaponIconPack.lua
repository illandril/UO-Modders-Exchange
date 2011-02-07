LegacyIIInGameArcheryWeaponIconPack = {}

LegacyIIInGameArcheryWeaponIconPack.prefix = "LegacyIIInGameArcheryWeaponIconPack_"
LegacyIIInGameArcheryWeaponIconPack.textures = { 
"bow",
"compositebow",
"crossbow",
"elvencomposite",
"heavycrossbow",
"magicalshortbow",
"repeatingcrossbow",
"yumi" }

function LegacyIIInGameArcheryWeaponIconPack.Initialize()
    for i,v in ipairs( LegacyIIInGameArcheryWeaponIconPack.textures ) do
        IconLoader.AddIconData( LegacyIIInGameArcheryWeaponIconPack.prefix..v )
    end
end
