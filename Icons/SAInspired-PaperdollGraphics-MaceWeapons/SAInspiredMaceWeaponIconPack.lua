SAInspiredPaperdollMaceWeaponIconPack = {}

SAInspiredPaperdollMaceWeaponIconPack.prefix = "SAInspiredPaperdollMaceWeaponIconPack_"
SAInspiredPaperdollMaceWeaponIconPack.textures = { "blackstaff", "club", "diamondmace", "gnarledstaff", "hammerpick", "mace", "maul", "nunchaku", "quarterstaff", "scepter", "sheperdscrook", "smithhammer", "tetsubo", "waraxe", "warhammer", "wildstaff" }

function SAInspiredPaperdollMaceWeaponIconPack.Initialize()
    for i,v in ipairs( SAInspiredPaperdollMaceWeaponIconPack.textures ) do
        IconLoader.AddIconData( SAInspiredPaperdollMaceWeaponIconPack.prefix..v )
    end
end
