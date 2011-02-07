OpenOnStartup = {}

OpenOnStartup.OpenPaperdoll = false
OpenOnStartup.OpenPaperdollCount = 10

OpenOnStartup.OpenInventory = false
OpenOnStartup.OpenInventoryCount = 15

OpenOnStartup.OpenAtlas = false
OpenOnStartup.OpenSkillTracker = false

OpenOnStartup.UpdateCycleCount = 0

function OpenOnStartup.Initialize()
    CustomSettingsWindow.AddBooleanSetting( "StartupSettings", "OpenPaperdollOnStartup", "OpenPaperdollOnStartup", false )
    CustomSettingsWindow.AddBooleanSetting( "StartupSettings", "OpenAtlasOnStartup", "OpenAtlasOnStartup", false )
    CustomSettingsWindow.AddBooleanSetting( "StartupSettings", "OpenInventoryOnStartup", "OpenInventoryOnStartup", false )
    CustomSettingsWindow.AddBooleanSetting( "StartupSettings", "OpenSkillTrackerOnStartup", "OpenSkillTrackerOnStartup", false )
    
    OpenOnStartup.OpenPaperdoll = CustomSettings.LoadBooleanValue( { settingName="OpenPaperdollOnStartup", defaultValue=false } )
    OpenOnStartup.OpenInventory = CustomSettings.LoadBooleanValue( { settingName="OpenInventoryOnStartup", defaultValue=false } )
    OpenOnStartup.OpenAtlas = CustomSettings.LoadBooleanValue( { settingName="OpenAtlasOnStartup", defaultValue=false } )
    OpenOnStartup.OpenSkillTracker = CustomSettings.LoadBooleanValue( { settingName="OpenSkillTrackerOnStartup", defaultValue=false } )
    
    if OpenOnStartup.OpenAtlas then
        MapWindow.ActivateMap()
    end
    
    if OpenOnStartup.OpenSkillTracker then
        if SkillsWindow.SkillsTrackerMode == 0 then
            SkillsWindow.SkillsTrackerMode = 1
            CreateWindow( "SkillsTrackerWindow", true )
        end
        SkillsWindow.UpdateSkillsTrackerToggleButtonText()
    end
end

function OpenOnStartup.Update()
    if OpenOnStartup.OpenPaperdoll or OpenOnStartup.OpenInventory then
        OpenOnStartup.UpdateCycleCount = OpenOnStartup.UpdateCycleCount + 1
        if OpenOnStartup.OpenPaperdoll and OpenOnStartup.UpdateCycleCount > OpenOnStartup.OpenPaperdollCount then
            OpenOnStartup.OpenPaperdoll = false
            MenuBarWindow.TogglePaperdollWindow()
        end
        if OpenOnStartup.OpenInventory and OpenOnStartup.UpdateCycleCount > OpenOnStartup.OpenInventoryCount then
            OpenOnStartup.OpenInventory = false
            local objectId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
            local windowName = "ContainerWindow_"..objectId
            SystemData.DynamicWindowId = objectId
            if not DoesWindowNameExist( windowName ) then
                CreateWindowFromTemplate( windowName, "ContainerWindow", "Root" )
                ContainerWindow.UpdateContents(objectId)
            end
        end
    end
end
