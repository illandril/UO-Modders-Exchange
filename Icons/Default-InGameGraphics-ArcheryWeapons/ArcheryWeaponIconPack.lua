DefaultInGameArcheryWeaponIconPack = {}

DefaultInGameArcheryWeaponIconPack.prefix = "DefaultInGameArcheryWeaponIconPack_"
DefaultInGameArcheryWeaponIconPack.textures = { "bow", "compositebow", "crossbow", "heavycrossbow", "magicalshortbow", "repeatingcrossbow", "yumi" }

function DefaultInGameArcheryWeaponIconPack.Initialize()
    for i,v in ipairs( DefaultInGameArcheryWeaponIconPack.textures ) do
        IconLoader.AddIconData( DefaultInGameArcheryWeaponIconPack.prefix..v )
    end
end
