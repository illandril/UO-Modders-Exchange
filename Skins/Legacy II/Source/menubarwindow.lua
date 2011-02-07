----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MenuBarWindow = {}
MenuBarWindow.MenuBarData = {}
--MenuBarWindow.MenuBarData["MenuBarWindowToggleHelp"] = {}
--MenuBarWindow.MenuBarData["MenuBarWindowToggleHelp"].ToolTipTid = 1061037 -- Help
--MenuBarWindow.MenuBarData["MenuBarWindowToggleHelp"].ToggleWindow = nil
MenuBarWindow.MenuBarData["MenuBarWindowToggleMainMenu"] = {}
MenuBarWindow.MenuBarData["MenuBarWindowToggleMainMenu"].ToolTipTid = 1049755 -- Main Menu
MenuBarWindow.MenuBarData["MenuBarWindowToggleMainMenu"].ToggleWindow = "MainMenuWindow"
MenuBarWindow.MenuBarData["MenuBarWindowToggleMap"] = {}
MenuBarWindow.MenuBarData["MenuBarWindowToggleMap"].ToolTipTid = 1077438 -- World Map
MenuBarWindow.MenuBarData["MenuBarWindowToggleMap"].ToggleWindow = nil
MenuBarWindow.MenuBarData["MenuBarWindowToggleGuild"] = {}
MenuBarWindow.MenuBarData["MenuBarWindowToggleGuild"].ToolTipTid = 1063308 -- Guild
MenuBarWindow.MenuBarData["MenuBarWindowToggleGuild"].ToggleWindow = nil
MenuBarWindow.MenuBarData["MenuBarWindowToggleSkills"] = {}
MenuBarWindow.MenuBarData["MenuBarWindowToggleSkills"].ToolTipTid = 3000084 -- Skills
MenuBarWindow.MenuBarData["MenuBarWindowToggleSkills"].ToggleWindow = nil
MenuBarWindow.MenuBarData["MenuBarWindowToggleVirtues"] = {}
MenuBarWindow.MenuBarData["MenuBarWindowToggleVirtues"].ToolTipTid = 1077439 -- Virtues
MenuBarWindow.MenuBarData["MenuBarWindowToggleVirtues"].ToggleWindow = nil
MenuBarWindow.MenuBarData["MenuBarWindowToggleQuests"] = {}
MenuBarWindow.MenuBarData["MenuBarWindowToggleQuests"].ToolTipTid = 1077440 -- Quest Journal
MenuBarWindow.MenuBarData["MenuBarWindowToggleQuests"].ToggleWindow = nil
MenuBarWindow.MenuBarData["MenuBarWindowTogglePaperdoll"] = {}
MenuBarWindow.MenuBarData["MenuBarWindowTogglePaperdoll"].ToolTipTid = 3000133 -- Character
MenuBarWindow.MenuBarData["MenuBarWindowTogglePaperdoll"].ToggleWindow = nil
MenuBarWindow.MenuBarData["MenuBarWindowToggleChat"] = {}
MenuBarWindow.MenuBarData["MenuBarWindowToggleChat"].ToolTipTid = 1114078 -- Chat
MenuBarWindow.MenuBarData["MenuBarWindowToggleChat"].ToggleWindow = nil

MenuBarWindow.WarMode = 0

MenuBarWindow.MAXIMIZED = 1
MenuBarWindow.MINIMIZED = 2
MenuBarWindow.NUMSTATES = 2

MenuBarWindow.WindowStates = {}
MenuBarWindow.WindowStates[MenuBarWindow.MAXIMIZED] = "MenuBarWindow"
MenuBarWindow.WindowStates[MenuBarWindow.MINIMIZED] = "MenuBarWindowMinimized"

MenuBarWindow.CurState = MenuBarWindow.MAXIMIZED
MenuBarWindow.MinimizedOffset = 333

----------------------------------------------------------------
-- General Functions
----------------------------------------------------------------

function MenuBarWindow.Initialize()
	WindowRegisterEventHandler("MenuBarWindow", SystemData.Events.TOGGLE_BACKPACK_WINDOW, "MenuBarWindow.ToggleInventoryWindow")
	WindowRegisterEventHandler("MenuBarWindow", SystemData.Events.TOGGLE_PAPERDOLL_CHARACTER_WINDOW, "MenuBarWindow.TogglePaperdollWindow")
	WindowRegisterEventHandler("MenuBarWindow", SystemData.Events.TOGGLE_GUILD_WINDOW, "MenuBarWindow.ToggleGuildWindow")
	WindowRegisterEventHandler("MenuBarWindow", SystemData.Events.TOGGLE_SKILLS_WINDOW, "MenuBarWindow.ToggleSkillsWindow")
	WindowRegisterEventHandler("MenuBarWindow", SystemData.Events.TOGGLE_VIRTUES_WINDOW, "MenuBarWindow.ToggleVirtuesWindow")
	WindowRegisterEventHandler("MenuBarWindow", SystemData.Events.TOGGLE_QUEST_LOG_WINDOW, "MenuBarWindow.ToggleQuestWindow")
	WindowRegisterEventHandler("MenuBarWindow", SystemData.Events.TOGGLE_HELP_WINDOW, "MenuBarWindow.ToggleHelpWindow")
	WindowRegisterEventHandler("MenuBarWindow", SystemData.Events.TOGGLE_WORLD_MAP_WINDOW, "MenuBarWindow.ToggleMapWindow")
    WindowRegisterEventHandler("MenuBarWindow", WindowData.PlayerStatus.Event, "MenuBarWindow.ToggleWarMode")

	RegisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)
	RegisterWindowData(WindowData.PlayerStatus.Type, 0)
	
	WindowUtils.RestoreWindowPosition("MenuBarWindow")
	
	CreateWindow("MenuBarWindowMinimized",false)
	
	ButtonSetStayDownFlag("MenuBarWindowWarButton", true)
	ButtonSetStayDownFlag("MenuBarWindowMinimizedWarButton", true)
end

function MenuBarWindow.Shutdown()
	UnregisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)
	UnregisterWindowData(WindowData.PlayerStatus.Type, 0)
	
	MenuBarWindow.SetWindowState(MenuBarWindow.MAXIMIZED)
	WindowUtils.SaveWindowPosition("MenuBarWindow")
end

----------------------------------------------------------------
-- Menu Bar Functions
----------------------------------------------------------------

function MenuBarWindow.SetWindowState(newState)
    local curState = MenuBarWindow.CurState
    if( newState == MenuBarWindow.CurState ) then
        return
    end

    local offset
    if( newState == MenuBarWindow.MAXIMIZED ) then
        offset = -1 * MenuBarWindow.MinimizedOffset * InterfaceCore.scale
    else
        offset = MenuBarWindow.MinimizedOffset * InterfaceCore.scale
    end
    
    WindowSetShowing(MenuBarWindow.WindowStates[curState],false)
    WindowUtils.CopyScreenPosition(MenuBarWindow.WindowStates[curState],MenuBarWindow.WindowStates[newState],offset,0)
    local newWindowPosX, newWindowPosY = WindowGetScreenPosition(MenuBarWindow.WindowStates[newState])
    if(newWindowPosX < 0) then
		WindowUtils.CopyScreenPosition(MenuBarWindow.WindowStates[newState],MenuBarWindow.WindowStates[newState],-newWindowPosX,0)
    end
    WindowSetShowing(MenuBarWindow.WindowStates[newState],true)    
    
    MenuBarWindow.CurState = newState
end

function MenuBarWindow.ToggleWindowState()
    if( MenuBarWindow.CurState == MenuBarWindow.MAXIMIZED ) then
        MenuBarWindow.SetWindowState(MenuBarWindow.MINIMIZED)
    else
        MenuBarWindow.SetWindowState(MenuBarWindow.MAXIMIZED)
    end
end

function MenuBarWindow.GetData()
    local windowName = SystemData.ActiveWindow.name
    return MenuBarWindow.MenuBarData[windowName]
end

function MenuBarWindow.OnMouseoverMenuBtn()
	data = MenuBarWindow.GetData()
	btnName = SystemData.ActiveWindow.name
	
	if data ~= nil then
		text = GetStringFromTid(data.ToolTipTid)
		Tooltips.CreateTextOnlyTooltip(btnName, text)
		Tooltips.Finalize()
		Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	else
		--Debug.Print(L"Tooltip data was nil")
	end 
end

function MenuBarWindow.ToggleMenuButton()	
--Debug.Print( L"Called MenuBarWindow.ToggleMenuButton()" )
	data = MenuBarWindow.GetData()
	
	-- Setting ToggleWindow to nil indicates that we have to use a custom handler
    if (data.ToggleWindow) then
    	ToggleWindowByName(data.ToggleWindow, SystemData.ActiveWindow.name, MenuBarWindow.ToggleMenuButton)	
	else
		--Debug.Print( L"ERROR MenuBarWindow.ToggleMenuButton - no data found for window = "..StringToWString(SystemData.ActiveWindow.name) )
    end
end

function MenuBarWindow.ToggleInventoryWindow()
--Debug.Print( L"Called MenuBarWindow.ToggleInventoryWindow()" )
	local objectId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
	    DragSlotDropObjectToObject(WindowData.PlayerStatus.PlayerId)
	else
		local windowName = "ContainerWindow_"..objectId
		local showing = false
		
		if( DoesWindowNameExist(windowName) ) then
		    showing = WindowGetShowing(windowName)
		end
		
		if (showing == true) then
			DestroyWindow(windowName)
		else
			UserActionUseItem(objectId,false)
		end
	end
end

function MenuBarWindow.ToggleMapWindow()

	if WindowGetShowing("RadarWindow") then
		MapWindow.ActivateMap()
	elseif WindowGetShowing("MapWindow") then
		WindowSetShowing("MapWindow", false)
		WindowSetShowing("RadarWindow", false) 	
		MapCommon.ActiveView = nil
	else
		RadarWindow.ActivateRadar()
	end		
end

function MenuBarWindow.ToggleGuildWindow()
    -- DAB TODO: Make this a toggle
	BroadcastEvent( SystemData.Events.REQUEST_OPEN_GUILD_WINDOW)
end

function MenuBarWindow.ToggleChatWindow()
	if( not DoesWindowExist("ChannelWindow") ) then
		CreateWindow("ChannelWindow", true)
	else
		DestroyWindow("ChannelWindow")
	end
end

function MenuBarWindow.ToggleSkillsWindow()
	SkillsWindow.ToggleSkillsWindow()

	-- if window is active, hilite button on menu bar
	local WindowName = "SkillsWindow"
	showing = WindowGetShowing(WindowName)
end

function MenuBarWindow.ToggleVirtuesWindow()
    -- DAB TODO: Make this a toggle
	BroadcastEvent( SystemData.Events.REQUEST_OPEN_VIRTUES_LIST )
end

function MenuBarWindow.ToggleQuestWindow()
    -- DAB TODO: Make this a toggle
	BroadcastEvent( SystemData.Events.REQUEST_OPEN_QUEST_LOG )
end

function MenuBarWindow.ToggleHelpWindow()
    -- DAB TODO: Make this a toggle
	BroadcastEvent( SystemData.Events.REQUEST_OPEN_HELP_MENU )
end

function MenuBarWindow.TogglePaperdollWindow()
	playerId = WindowData.PlayerStatus.PlayerId
	local windowName = "PaperdollWindow"..playerId

	if(DoesWindowNameExist(windowName)) then
		DestroyWindow(windowName)
	else
	    UserActionUseItem(playerId,true)
	end
end


function MenuBarWindow.ToggleWarMode()
    if( WindowData.PlayerStatus.InWarMode ) then
            MenuBarWindow.WarMode = 1
            ButtonSetPressedFlag( "MenuBarWindowWarButton", true )          
            ButtonSetPressedFlag( "MenuBarWindowMinimizedWarButton", true )
    else
            MenuBarWindow.WarMode = 0
            ButtonSetPressedFlag( "MenuBarWindowWarButton", false )
            ButtonSetPressedFlag( "MenuBarWindowMinimizedWarButton", false ) 
    end
end


function MenuBarWindow.ToggleWarModeButton()
        UserActionToggleWarMode()
end

function MenuBarWindow.OnMoveMaximizedEnd()
	WindowSetMoving("MenuBarWindow", false)
end

function MenuBarWindow.OnMoveMaximizedStart()
	WindowSetMoving("MenuBarWindow", true)
end

function MenuBarWindow.OnMoveMinimizedEnd()
	WindowSetMoving("MenuBarWindowMinimized", false)
end

function MenuBarWindow.OnMoveMinimizedStart()
	WindowSetMoving("MenuBarWindowMinimized", true)
end