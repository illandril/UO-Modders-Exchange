SAInspiredTextNumbersIconPack = {}

SAInspiredTextNumbersIconPack.prefix = "SAInspiredTextNumbersIconPack_"

function SAInspiredTextNumbersIconPack.Initialize()
    for i=0,9 do
        IconLoader.AddIconData( SAInspiredTextNumbersIconPack.prefix..i )
    end
end
