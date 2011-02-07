LegacyIIInGameInstrumentsIconPack = {}

LegacyIIInGameInstrumentsIconPack.prefix = "LegacyIIInGameInstrumentsIconPack_"
LegacyIIInGameInstrumentsIconPack.textures = {
"bambooflute", 
"drum", 
"lapharp", 
"lute", 
"snakecharmerflute", 
"standingharp", 
"tambourine", 
"tambourineribbon"
}

function LegacyIIInGameInstrumentsIconPack.Initialize()
    for i,v in ipairs( LegacyIIInGameInstrumentsIconPack.textures ) do
        IconLoader.AddIconData( LegacyIIInGameInstrumentsIconPack.prefix..v )
    end
end
