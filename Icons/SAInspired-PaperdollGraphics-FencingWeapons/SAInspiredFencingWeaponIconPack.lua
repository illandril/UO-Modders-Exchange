SAInspiredPaperdollFencingWeaponIconPack = {}

SAInspiredPaperdollFencingWeaponIconPack.prefix = "SAInspiredPaperdollFencingWeaponIconPack_"
SAInspiredPaperdollFencingWeaponIconPack.textures = { "assassinspike", "dagger", "doublebladedstaff", "elvenspellblade", "kama", "kryss", "lajatang", "leafblade", "pike", "sai", "shortspear", "spear", "tekagi", "warcleaver", "warfork" }

function SAInspiredPaperdollFencingWeaponIconPack.Initialize()
    for i,v in ipairs( SAInspiredPaperdollFencingWeaponIconPack.textures ) do
        IconLoader.AddIconData( SAInspiredPaperdollFencingWeaponIconPack.prefix..v )
    end
end
