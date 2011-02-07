DefaultInGameFencingWeaponIconPack = {}

DefaultInGameFencingWeaponIconPack.prefix = "DefaultInGameFencingWeaponIconPack_"
DefaultInGameFencingWeaponIconPack.textures = { "assassinspike", "dagger", "doublebladedstaff", "elvenspellblade", "kama", "kryss", "lajatang", "leafblade", "pike", "sai", "shortspear", "spear", "tekagi", "warcleaver", "warfork" }

function DefaultInGameFencingWeaponIconPack.Initialize()
    for i,v in ipairs( DefaultInGameFencingWeaponIconPack.textures ) do
        IconLoader.AddIconData( DefaultInGameFencingWeaponIconPack.prefix..v )
    end
end
