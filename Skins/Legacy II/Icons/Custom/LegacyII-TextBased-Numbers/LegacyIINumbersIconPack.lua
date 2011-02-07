LegacyIITextNumbersIconPack = {}

LegacyIITextNumbersIconPack.prefix = "LegacyIITextNumbersIconPack_"

function LegacyIITextNumbersIconPack.Initialize()
    for i=0,9 do
        IconLoader.AddIconData( LegacyIITextNumbersIconPack.prefix..i )
    end
end
