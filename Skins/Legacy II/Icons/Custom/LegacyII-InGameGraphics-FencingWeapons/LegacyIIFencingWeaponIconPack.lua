LegacyIIInGameFencingWeaponIconPack = {}

LegacyIIInGameFencingWeaponIconPack.prefix = "LegacyIIInGameFencingWeaponIconPack_"
LegacyIIInGameFencingWeaponIconPack.textures = {
"assassinspike",
"bloodblade",
"dagger",
"doublebladedstaff",
"dualpointedspear",
"elvenspellblade",
"gargishdagger",
"kama",
"kryss",
"lajatang",
"lance",
"leafblade",
"pike",
"pitchfork",
"sai",
"shortblade",
"shortspear",
"spear",
"tekagi",
"warcleaver",
"warfork"
}

function LegacyIIInGameFencingWeaponIconPack.Initialize()
    for i,v in ipairs( LegacyIIInGameFencingWeaponIconPack.textures ) do
        IconLoader.AddIconData( LegacyIIInGameFencingWeaponIconPack.prefix..v )
    end
end
