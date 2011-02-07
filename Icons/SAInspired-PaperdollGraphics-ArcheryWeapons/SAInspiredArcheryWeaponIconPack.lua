SAInspiredPaperdollArcheryWeaponIconPack = {}

SAInspiredPaperdollArcheryWeaponIconPack.prefix = "SAInspiredPaperdollArcheryWeaponIconPack_"
SAInspiredPaperdollArcheryWeaponIconPack.textures = { "bow", "compositebow", "crossbow", "heavycrossbow", "magicalshortbow", "repeatingcrossbow", "yumi" }

function SAInspiredPaperdollArcheryWeaponIconPack.Initialize()
    for i,v in ipairs( SAInspiredPaperdollArcheryWeaponIconPack.textures ) do
        IconLoader.AddIconData( SAInspiredPaperdollArcheryWeaponIconPack.prefix..v )
    end
end
