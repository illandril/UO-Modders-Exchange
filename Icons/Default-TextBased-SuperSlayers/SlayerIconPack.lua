DefaultTextSlayerIconPack = {}

DefaultTextSlayerIconPack.prefix = "DefaultTextSlayerIconPack_"
DefaultTextSlayerIconPack.textures = { "arachnid", "demon", "elemental", "fey", "repond", "reptile", "undead" }

function DefaultTextSlayerIconPack.Initialize()
    for i,v in ipairs( DefaultTextSlayerIconPack.textures ) do
        IconLoader.AddIconData( DefaultTextSlayerIconPack.prefix..v )
    end
end
