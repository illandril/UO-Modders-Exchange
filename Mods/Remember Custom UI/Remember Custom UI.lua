RememberCustomUI = {}
RememberCustomUI.CurrentUI = nil
RememberCustomUI.CurrentRememberedUI = nil
RememberCustomUI.OldSettingName = "StoredCustomUI"
RememberCustomUI.RememberedSettingName = "RememberedCustomUI"
RememberCustomUI.SwitchedSettingName = "SwitchedCustomUI"

function RememberCustomUI.Initialize()
    RememberCustomUI.CurrentUI = SystemData.Settings.Interface.customUiName
    
    local storedUI = CustomSettings.LoadStringValue( { settingName=RememberCustomUI.OldSettingName } )
    if storedUI ~= nil then
        CustomSettings.SaveStringValue( { settingName=RememberCustomUI.RememberedSettingName, settingValue=storedUI } )
        CustomSettings.SaveStringValue( { settingName=RememberCustomUI.OldSettingName, settingValue=nil } )
        CustomSettings.SaveStringValue( { settingName=RememberCustomUI.SwitchedSettingName, settingValue=storedUI } )
        Debug.PrintToChat( L"**RememberCustomUI** Your old stored UI has been migrated to the new RememberCustomUI setting." )
    end
    local rememberedUI = CustomSettings.LoadStringValue( { settingName=RememberCustomUI.RememberedSettingName } )
    RememberCustomUI.CurrentRememberedUI = rememberedUI
    local switchedUI = CustomSettings.LoadStringValue( { settingName=RememberCustomUI.SwitchedSettingName } )
    if switchedUI ~= nil then
        if switchedUI ~= RememberCustomUI.CurrentUI then
            CustomSettings.SaveStringValue( { settingName=RememberCustomUI.SwitchedSettingName, settingValue=nil } )
            Debug.PrintToChat( L"**RememberCustomUI** A previous attempt to change your stored UI to "..StringToWString( switchedUI ) ..L" failed. The switched UI did not have an up-to-date Remember Custom UI Mod." )
            if rememberedUI ~= nil then
                Debug.PrintToChat( L"**RememberCustomUI** The old stored UI ("..StringToWString( rememberedUI )..L") has been retained as your current stored UI." )
            end
            Debug.PrintToChat( L"**RememberCustomUI** Open the settings window and press OK or Apply to store the current UI for this character." )
            Debug.PrintToChat( L"**RememberCustomUI** Change the custom UI selection first to use a different UI (note: that UI must include this mod to work properly)." )
        else
            CustomSettings.SaveStringValue( { settingName=RememberCustomUI.RememberedSettingName, settingValue=switchedUI } )
            CustomSettings.SaveStringValue( { settingName=RememberCustomUI.SwitchedSettingName, settingValue=nil } )
            Debug.PrintToChat( L"**RememberCustomUI** Your stored UI is now '"..StringToWString( switchedUI )..L"'" )
        end
    else
        if rememberedUI == nil then
            Debug.PrintToChat( L"**RememberCustomUI** No Custom UIs seem to be remembered for this character." )
            Debug.PrintToChat( L"**RememberCustomUI** Open the settings window and press OK or Apply to store the current UI for this character." )
            Debug.PrintToChat( L"**RememberCustomUI** Change the custom UI selection first to use a different UI (note: that UI must include this mod to work properly)." )
        elseif rememberedUI ~= RememberCustomUI.CurrentUI then
            local match = false
            for i,v in ipairs( SystemData.CustomUIList ) do
                if v == rememberedUI then
                    match = true
                    break
                end
            end
            if match then
                Debug.PrintToChat( L"**RememberCustomUI** Your stored UI ("..StringToWString( rememberedUI )..L") is being loaded..." )
                SystemData.Settings.Interface.customUiName = rememberedUI
                needsReload = UserSettingsChanged()
                if ( needsReload == true ) then
                    InterfaceCore.ReloadUI()
                end
            else
                Debug.PrintToChat( L"**RememberCustomUI** Your stored UI ("..StringToWString( rememberedUI )..L") was not loaded as it no longer seems to exist." )
                Debug.PrintToChat( L"**RememberCustomUI** Quit now and restore the UI files if this was a mistake." )
                Debug.PrintToChat( L"**RememberCustomUI** Open the settings window and press OK or Apply to store the current UI for this character." )
                Debug.PrintToChat( L"**RememberCustomUI** Change the custom UI selection first to use a different UI (note: that UI must include this mod to work properly)." )
            end
        end
    end
    
    CustomSettings.RegisterUpdateSettingsListener( RememberCustomUI.UpdateSettings )
end

function RememberCustomUI.UpdateSettings()
    if RememberCustomUI.CurrentRememberedUI ~= SystemData.Settings.Interface.customUiName then
        RememberCustomUI.CurrentRememberedUI = SystemData.Settings.Interface.customUiName
        if RememberCustomUI.CurrentRememberedUI == RememberCustomUI.CurrentUI then
            CustomSettings.SaveStringValue( { settingName=RememberCustomUI.RememberedSettingName, settingValue=RememberCustomUI.CurrentRememberedUI } )
            Debug.PrintToChat( L"**RememberCustomUI** Your Custom UI choice has been saved!" )
        else
            Debug.PrintToChat( L"**RememberCustomUI** Attempting to remember your new UI ("..StringToWString( SystemData.Settings.Interface.customUiName )..L")" )
            CustomSettings.SaveStringValue( { settingName=RememberCustomUI.SwitchedSettingName, settingValue=SystemData.Settings.Interface.customUiName } )
        end
    end
end
