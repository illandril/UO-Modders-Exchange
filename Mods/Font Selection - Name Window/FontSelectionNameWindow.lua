FontSelectionNameWindow = {}

FontSelectionNameWindow.FontSettingName = "NameWindowFont"

function FontSelectionNameWindow.Initialize()
    CustomSettingsWindow.AddFontSetting( "Fonts", "NameWindowFont", FontSelectionNameWindow.FontSettingName, nil )

    FontSelectionNameWindow.UpdateNameOriginal = OverheadText.UpdateName
    OverheadText.UpdateName = FontSelectionNameWindow.UpdateNameNew
    FontSelectionNameWindow.ShowNameOriginal = OverheadText.ShowName
    OverheadText.ShowName = FontSelectionNameWindow.ShowNameNew

    CustomSettings.RegisterUpdateSettingsListener( FontSelectionNameWindow.UpdateSettings )
    FontSelectionNameWindow.UpdateSettings()
end


function FontSelectionNameWindow.UpdateSettings()
    FontSelectionNameWindow.Font = CustomSettings.LoadStringValue( {settingName=FontSelectionNameWindow.FontSettingName } )
end

function FontSelectionNameWindow.ShowNameNew( mobileId )
    FontSelectionNameWindow.ShowNameOriginal( mobileId )
    FontSelectionNameWindow.SetNameWindowFont( mobileId )
end

function FontSelectionNameWindow.UpdateNameNew( mobileId )
    FontSelectionNameWindow.UpdateNameOriginal( mobileId )
    FontSelectionNameWindow.SetNameWindowFont( mobileId )
end

function FontSelectionNameWindow.SetNameWindowFont( mobileId )
    if FontSelectionNameWindow.Font ~= nil then
        local windowName = "OverheadTextWindow_"..mobileId
        if DoesWindowNameExist( windowName ) then
            local labelName = windowName.."Name"
            LabelSetFont( labelName, FontSelectionNameWindow.Font, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING )
        end
    end
end
