----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MainMenuWindow = {}
MainMenuWindow.TID ={}
MainMenuWindow.TID.MAIN_MENU	 = 1049755	-- Main Menu
MainMenuWindow.TID.LOG_OUT		 = 3000128	-- Log Out
MainMenuWindow.TID.EXIT_GAME	 = 1077859	-- Exit Game
MainMenuWindow.TID.USER_SETTINGS = 1077814	-- User Settings
MainMenuWindow.TID.BUG_REPORT	 = 1077790	-- Bug Report
MainMenuWindow.TID.HELP          = 1061037  -- Help
MainMenuWindow.TID.MACROS        = 3000172	-- Macros 
MainMenuWindow.TID.ACTIONS       = 1079812	-- Actions 

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler
function MainMenuWindow.Initialize()
	
	WindowSetAlpha( "MainMenuWindow", 1.00 )
	WindowSetAlpha( "MainMenuWindow", 1.00 )
	
	-- Label & Button Titles
	WindowUtils.SetWindowTitle("MainMenuWindow",GetStringFromTid(MainMenuWindow.TID.MAIN_MENU))
	
	LabelSetText("MainMenuWindowLogOutItemText", GetStringFromTid(MainMenuWindow.TID.LOG_OUT) )
	LabelSetText("MainMenuWindowExitGameItemText", GetStringFromTid(MainMenuWindow.TID.EXIT_GAME) )
	LabelSetText("MainMenuWindowUserSettingsItemText", GetStringFromTid(MainMenuWindow.TID.USER_SETTINGS) )
	LabelSetText("MainMenuWindowMacrosItemText", GetStringFromTid(MainMenuWindow.TID.MACROS) )
	LabelSetText("MainMenuWindowActionsItemText", GetStringFromTid(MainMenuWindow.TID.ACTIONS) )
	LabelSetText("MainMenuWindowHelpItemText", GetStringFromTid(MainMenuWindow.TID.HELP) )
	
	LabelSetText("MainMenuWindowBugReportItemText", GetStringFromTid(MainMenuWindow.TID.BUG_REPORT) )
	LabelSetText("MainMenuWindowDebugWindowItemText", L"Debug Window" )
end

-- OnShutdown Handler
function MainMenuWindow.Shutdown()
end

function MainMenuWindow.OnLogOut()	
	-- Broadcast the event
	BroadcastEvent( SystemData.Events.LOG_OUT )
end

function MainMenuWindow.OnOpenUserSettings()	
	ToggleWindowByName( "SettingsWindow", "", MainMenuWindow.ToggleSettingsWindow )
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.OnOpenMacros()	
	ToggleWindowByName( "MacroWindow", "", MainMenuWindow.OnOpenMacros )
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.OnOpenActions()	
	ToggleWindowByName( "ActionsWindow", "", MainMenuWindow.OnOpenActions )
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.OnOpenBugReportItem()	
	ToggleWindowByName( "BugReportWindow", "", MainMenuWindow.ToggleBugReportWindow )
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.OnOpenDebugWindowItem()	
	WindowSetShowing("DebugWindow", true)
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.OnOpenHelp()
    BroadcastEvent( SystemData.Events.REQUEST_OPEN_HELP_MENU )
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.ToggleSettingsWindow()	
	ToggleWindowByName( "SettingsWindow", "", MainMenuWindow.ToggleSettingsWindow )	
end

function MainMenuWindow.ToggleBugReportWindow()	
	ToggleWindowByName( "BugReportWindow", "", MainMenuWindow.ToggleBugReportWindow )	
end

function MainMenuWindow.OnShown()
    ButtonSetPressedFlag("MenuBarWindowToggleMainMenu",true)
end

function MainMenuWindow.OnHidden()
    ButtonSetPressedFlag("MenuBarWindowToggleMainMenu",false)
end
