FontSelectionDamageNumbers = {}

FontSelectionDamageNumbers.FontSettingName = "DamageNumbersFont"

function FontSelectionDamageNumbers.Initialize()
    CustomSettingsWindow.AddFontSetting( "Fonts", "DamageNumbersFont", FontSelectionDamageNumbers.FontSettingName, nil )

    FontSelectionDamageNumbers.InitOriginal = DamageWindow.Init
    DamageWindow.Init = FontSelectionDamageNumbers.InitNew

    CustomSettings.RegisterUpdateSettingsListener( FontSelectionDamageNumbers.UpdateSettings )
    FontSelectionDamageNumbers.UpdateSettings()
end


function FontSelectionDamageNumbers.UpdateSettings()
    FontSelectionDamageNumbers.Font = CustomSettings.LoadStringValue( {settingName=FontSelectionDamageNumbers.FontSettingName } )
end

function FontSelectionDamageNumbers.InitNew()
    FontSelectionDamageNumbers.InitOriginal( mobileId )
    if FontSelectionDamageNumbers.Font ~= nil then
        local numWindow = Damage.numWindow
        local windowName = "DamageWindow"..numWindow
        if DoesWindowNameExist( windowName ) then
            local labelName = windowName.."Text"
            LabelSetFont( labelName, FontSelectionDamageNumbers.Font, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING )
        end
    end
end
