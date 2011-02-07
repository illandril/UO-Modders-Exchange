FontSelectionOverheadChat = {}

FontSelectionOverheadChat.FontSettingName = "OverheadChatFont"

function FontSelectionOverheadChat.Initialize()
    CustomSettingsWindow.AddFontSetting( "Fonts", "OverheadChatFont", FontSelectionOverheadChat.FontSettingName, nil )

    FontSelectionOverheadChat.UpdateStatusOriginal = OverheadText.ShowOverheadText
    OverheadText.ShowOverheadText = FontSelectionOverheadChat.UpdateStatusNew

    CustomSettings.RegisterUpdateSettingsListener( FontSelectionOverheadChat.UpdateSettings )
    FontSelectionOverheadChat.UpdateSettings()
end


function FontSelectionOverheadChat.UpdateSettings()
    FontSelectionOverheadChat.Font = CustomSettings.LoadStringValue( {settingName=FontSelectionOverheadChat.FontSettingName } )
end

function FontSelectionOverheadChat.UpdateStatusNew( mobileId )
    FontSelectionOverheadChat.UpdateStatusOriginal( mobileId )
    
    if FontSelectionOverheadChat.Font ~= nil then
        local windowName = "OverheadTextWindow_"..SystemData.TextSourceID.."Chat"
        for i=1,4 do
            local overheadChatWindow = windowName..i
            if DoesWindowNameExist( overheadChatWindow ) then
                LabelSetFont( overheadChatWindow, FontSelectionOverheadChat.Font, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING )
            end
        end
    end
end
