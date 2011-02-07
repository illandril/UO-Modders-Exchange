LegacyIIInGameSuperSlayerIconPack = {}

LegacyIIInGameSuperSlayerIconPack.prefix = "LegacyIIInGameSuperSlayerIconPack_"
LegacyIIInGameSuperSlayerIconPack.textures = { "arachnid", "demon", "elemental", "fey", "repond", "reptile", "undead" }

function LegacyIIInGameSuperSlayerIconPack.Initialize()
    for i,v in ipairs( LegacyIIInGameSuperSlayerIconPack.textures ) do
        IconLoader.AddIconData( LegacyIIInGameSuperSlayerIconPack.prefix..v )
    end
end
