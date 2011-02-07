----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

QuicklinksWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

QuicklinksWindow.Links = {}
QuicklinksWindow.SettingsPrefix = "QuicklinksWindow_"

----------------------------------------------------------------
-- QuicklinksWindow Functions
----------------------------------------------------------------

function QuicklinksWindow.Initialize()
    QuicklinksWindow.AddLink( "OpenDebugWindow", "DebugWindow", QuicklinksWindow.OpenWindow, "DebugWindow" )
    if SkinData ~= nil then
        CreateWindow( "VersionInfoLabel", true )
        LabelSetText( "VersionInfoLabel", StringToWString( SkinData.Skin.." - "..SkinData.Version ) )
    end
end

function QuicklinksWindow.AddLink( internalName, ctid, callback, arg )
    table.insert( QuicklinksWindow.Links, { internalName=internalName, ctid=ctid, params={ callback=callback, arg=arg } } )
end

function QuicklinksWindow.Shutdown()
end

function QuicklinksWindow.ShowContextMenu()
	local subMenu = {}
    for linkIdx,link in ipairs( QuicklinksWindow.Links ) do
        local settingName = QuicklinksWindow.SettingsPrefix..link.internalName
        local enabled = CustomSettings.LoadBooleanValue( { settingName=settingName, defaultValue=false } )
        local str = CustomLocalization.Load( link.ctid )
        table.insert( subMenu, { str=str, flags=0, returnCode=settingName, param=not enabled, pressed=enabled } )
        if enabled then
            ContextMenu.CreateLuaContextMenuItemWithString( CustomLocalization.Load( link.ctid ), 0, 0, link.params, false )
        end
    end
	ContextMenu.CreateLuaContextMenuItemWithString( CustomLocalization.Load( "Setup" ), 0 , nil, nil, nil, subMenu )
    ContextMenu.ActivateLuaContextMenu( QuicklinksWindow.ContextMenuCallback )
end

function QuicklinksWindow.OpenWindow( window )
	if not DoesWindowExist( window ) then
		CreateWindow( window, false )
	end
	WindowSetShowing( window, true )
end

function QuicklinksWindow.ContextMenuCallback( returnCode, param )
    if returnCode == 0 then
        param.callback( param.arg )
    elseif returnCode ~= nil then
        CustomSettings.SaveBooleanValue( { settingName=returnCode, settingValue=param } )
    end
end
