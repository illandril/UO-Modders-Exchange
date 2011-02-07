LegacyIIInGameSuperSlayer2IconPack = {}

LegacyIIInGameSuperSlayer2IconPack.prefix = "LegacyIIInGameSuperSlayer2IconPack_"
LegacyIIInGameSuperSlayer2IconPack.textures = { "arachnid", "demon", "elemental", "fey", "repond", "reptile", "undead" }

function LegacyIIInGameSuperSlayer2IconPack.Initialize()
    for i,v in ipairs( LegacyIIInGameSuperSlayer2IconPack.textures ) do
        IconLoader.AddIconData( LegacyIIInGameSuperSlayer2IconPack.prefix..v )
    end
end
