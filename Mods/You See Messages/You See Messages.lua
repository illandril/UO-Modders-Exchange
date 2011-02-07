YouSeeMessages = {}

YouSeeMessages.YouSeeMessageSetting = "ShowYouSeeMessages"
YouSeeMessages.YouSeeMessageRepeatSetting = "ShowYouSeeMessagesRepeat"

function YouSeeMessages.Initialize()
    CustomSettingsWindow.AddBooleanSetting( "Journal", "ShowYouSeeMessages", YouSeeMessages.YouSeeMessageSetting, false )
    CustomSettingsWindow.AddBooleanSetting( "Journal", "ShowYouSeeMessagesRepeat", YouSeeMessages.YouSeeMessageRepeatSetting, false )

    YouSeeMessages.CreateNameOriginal = OverheadText.Initialize
    OverheadText.Initialize = YouSeeMessages.CreateNameNew
    YouSeeMessages.ShowNameOriginal = OverheadText.ShowName
    OverheadText.ShowName = YouSeeMessages.ShowNameNew
end

function YouSeeMessages.ShowNameNew(...)
    YouSeeMessages.ShowNameOriginal(unpack(arg))
    local mobileId = arg[0]
    if CustomSettings.LoadBooleanValue( { settingName=YouSeeMessages.YouSeeMessageRepeatSetting, defaultValue=false } ) then
        YouSeeMessages.OnShown( mobileId )
    end
end

function YouSeeMessages.CreateNameNew(...)
    YouSeeMessages.CreateNameOriginal(unpack(arg))
    YouSeeMessages.OnShown( SystemData.DynamicWindowId )
end

function YouSeeMessages.OnShown( mobileId )
    if CustomSettings.LoadBooleanValue( { settingName=YouSeeMessages.YouSeeMessageSetting, defaultValue=false } ) then
        local data = WindowData.MobileName[mobileId]
        if data ~= nil and data.MobName ~= nil and data.MobName ~= L"" then
            ChatWindow.Print( L"You see:"..data.MobName, SystemData.ChatLogFilters.SYSTEM )
        end
    end
end
