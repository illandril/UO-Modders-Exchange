DefaultInGameMaceWeaponIconPack = {}

DefaultInGameMaceWeaponIconPack.prefix = "DefaultInGameMaceWeaponIconPack_"
DefaultInGameMaceWeaponIconPack.textures = { "blackstaff", "club", "diamondmace", "gnarledstaff", "hammerpick", "mace", "maul", "nunchaku", "quarterstaff", "scepter", "sheperdscrook", "smithhammer", "tetsubo", "waraxe", "warhammer", "wildstaff" }

function DefaultInGameMaceWeaponIconPack.Initialize()
    for i,v in ipairs( DefaultInGameMaceWeaponIconPack.textures ) do
        IconLoader.AddIconData( DefaultInGameMaceWeaponIconPack.prefix..v )
    end
end
