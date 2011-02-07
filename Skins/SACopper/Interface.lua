----------------------------------------------------------------
-- Global functions
----------------------------------------------------------------

function ToggleWindowByName( wndName, btnName, toggleFunction, onOpenFunction, onCloseFunction )
	local showing = WindowGetShowing( wndName )
	showing = not showing	
	WindowSetShowing( wndName, showing )
	
	if (btnName ~= "") then
		ButtonSetPressedFlag( btnName, showing )
	end
	
	if( onOpenFunction ~= nil and showing == true ) then
	    onOpenFunction()
	elseif( onCloseFunction ~= nil and showing == false ) then
	    onCloseFunction()
	end
end

----------------------------------------------------------------
-- In-Game Interface Initialization Variables
----------------------------------------------------------------

-- In the future, this could be exposed by c++:
Interface.PLAYWINDOWSET = 2

function Interface.CreatePlayWindowSet()
	--Builds the data for player
	UOBuildTableFromCSV("Data/GameData/playerstats.csv", "PlayerStatsDataCSV")
	
	CreateWindow( "ResizeWindow", true )
	CreateWindow( "MainMenuWindow", false )
	CreateWindow( "SettingsWindow", false )
	CreateWindow( "CharacterSheet", false )
	CreateWindow( "CharacterAbilities", false )
	CreateWindow( "ItemProperties", false )
	CreateWindow( "BugReportWindow", false )
	CreateWindow( "SkillsWindow", false )
	CreateWindow( "MacroWindow", false )	
	CreateWindow( "StatusWindow", true )
	CreateWindow( "MenuBarWindow", true )
	CreateWindow( "TargetWindow", false )
	CreateWindow( "ContextMenu", false )
	CreateWindow( "PetWindow", true )
	CreateWindow( "ActionsWindow", false )
	CreateWindow( "ActionEditText", false )
	CreateWindow( "ActionEditSlider", false )
	CreateWindow( "ActionEditMacro", false )
	CreateWindow( "ActionEditEquip", false )
	CreateWindow( "ActionEditUnEquip", false )
	CreateWindow( "ActionEditArmDisarm", false )
	CreateWindow( "ActionEditTargetByResource", false )
	CreateWindow( "ActionEditTargetByObjectId", false )
	CreateWindow( "MapWindow", false )
	CreateWindow( "RadarWindow", true )
	CreateWindow( "SkillsInfo", false )
	CreateWindow( "TrackingPointer", true )
	CreateWindow( "UserWaypointWindow", false)
	
	if( SystemData.Settings.Interface.showTipoftheDay ) then
		CreateWindow( "TipoftheDayWindow", true)
	end
			
	WindowRegisterEventHandler("Root", SystemData.Events.BUG_REPORT_SCREEN, "Interface.InitBugReport")
	WindowRegisterEventHandler( "Root", SystemData.Events.UPDATE_CHARACTER_SETTINGS, "Interface.SendCharacterSettings")
	WindowRegisterEventHandler( "Root", SystemData.Events.CHARACTER_SETTINGS_UPDATED, "Interface.RetrieveCharacterSettings")	
	
	Tooltips.Initialize()
	HotbarSystem.Initialize()
	GGManager.Initialize()
	CGManager.Initialize()
	DamageWindow.Initialize()
	EquipmentData.Initialize()
	MobileHealthBarWindow.InitializeSystem()
	ObjectHandleWindow.Initialize()
	OverheadText.InitializeEvents()
    StaticTextWindow.Initialize()
    MapCommon.Initialize()
    
	WindowRegisterEventHandler( "Root", SystemData.Events.DEBUGPRINT_TO_CONSOLE, "Interface.OnDebugPrint")
	
	RadarWindow.ActivateRadar()
	
	-- Legacy Macro Importer: Not functional (Work in Progress)
	--Interface.QueryImportLegacyMacros()
end

function Interface.InitBugReport()
	ToggleWindowByName( "BugReportWindow", "", MainMenuWindow.ToggleBugReportWindow )
end

function Interface.Update( timePassed )
	Tooltips.Update( timePassed )
	BuffDebuff.Update( timePassed )
	
	DamageWindow.UpdateTime( timePassed )
	ResizeWindow.Update(timePassed)
	OverheadText.Update(timePassed)
	ContainerWindow.UpdatePickupTimer(timePassed)
	ContextMenu.Update(timePassed)
	StaticTextWindow.Update( timePassed )
	HotbarSystem.Update(timePassed)
	MapCommon.Update(timePassed)
end

function Interface.Shutdown()
	EquipmentData.Shutdown()
	HotbarSystem.Shutdown()
	
	MapCommon.Shutdown()
	--Unload playerstatsData used for character sheet and the hotbar system
	UOUnloadCSVTable("PlayerStatsDataCSV")
end

function Interface.OnDebugPrint()
	Debug.PrintToDebugConsole(DebugData.DebugString)
end

function Interface.SendCharacterSettings()
	WindowUtils.SendWindowSettings()
	HotbarSystem.SendHotbarData()
end

function Interface.RetrieveCharacterSettings()
	WindowUtils.RetrieveWindowSettings()
	HotbarSystem.RetrieveHotbarData()
end

function Interface.QueryImportLegacyMacros()
	if( SystemData.Settings.Interface.scannedLegacyMacros == false and MacroSystemDoLegacyMacrosExist() == true ) then
		local yesButton = { textTid = SettingsWindow.TID_YES, callback = function()BroadcastEvent(SystemData.Events.IMPORT_LEGACY_MACROS_ACCEPT)end }
		local noButton = { textTid = SettingsWindow.TID_NO, callback = function()BroadcastEvent(SystemData.Events.IMPORT_LEGACY_MACROS_DECLINE)end }
		local windowData = 
		{
			windowName = "Root", 
			titleTid = 1112448, -- "UPDATE"
			bodyTid = 1112449, -- Dialog stating that Legacy macros exist and asking the user if he/she wishes to import them.
			buttons = { yesButton, noButton }
		}
		UO_StandardDialog.CreateDialog( windowData )	
	end
end