DefaultTextNumbersIconPack = {}

DefaultTextNumbersIconPack.prefix = "DefaultTextNumbersIconPack_"

function DefaultTextNumbersIconPack.Initialize()
    for i=0,9 do
        IconLoader.AddIconData( DefaultTextNumbersIconPack.prefix..i )
    end
end
