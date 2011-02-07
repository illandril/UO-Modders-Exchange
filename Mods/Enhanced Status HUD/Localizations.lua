CustomLocalization.AddLocalization( SystemData.Settings.Language.LANGUAGE_ENU, "ESH_Settings", L"E.Stat HUD" )
function AddESHLocalization( type )
    CustomLocalization.AddLocalization( SystemData.Settings.Language.LANGUAGE_ENU, "ESH_"..type.."Icon", StringToWString( type )..L" Icon" )
    CustomLocalization.AddLocalization( SystemData.Settings.Language.LANGUAGE_ENU, "ESH_"..type.."Scale", StringToWString( type )..L" Scale" )
    CustomLocalization.AddLocalization( SystemData.Settings.Language.LANGUAGE_ENU, "ESH_"..type.."FadeDown", StringToWString( type )..L" Icon Fades Down (Unchecked = Fades Up)" )
    CustomLocalization.AddLocalization( SystemData.Settings.Language.LANGUAGE_ENU, "ESH_"..type.."Mobile", StringToWString( type )..L" Is Movable" )
end
AddESHLocalization("Health")
AddESHLocalization("Mana")
AddESHLocalization("Stamina")

