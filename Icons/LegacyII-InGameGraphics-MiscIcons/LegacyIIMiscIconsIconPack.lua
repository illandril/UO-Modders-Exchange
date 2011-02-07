LegacyIIMiscIconsIconPack = {}

LegacyIIMiscIconsIconPack.prefix = "LegacyIIMiscIconsIconPack_"
LegacyIIMiscIconsIconPack.textures = { 
"arlo",
"antnest1",
"antnest2",
"antnest3",
"antnest4",
"antnest5",
"trashbarrel",
"recallhome"
}

function LegacyIIMiscIconsIconPack.Initialize()
    for i,v in ipairs( LegacyIIMiscIconsIconPack.textures ) do
        IconLoader.AddIconData( LegacyIIMiscIconsIconPack.prefix..v )
    end
end
