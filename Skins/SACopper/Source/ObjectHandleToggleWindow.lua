LoadResources( "./UserInterface/"..SystemData.Settings.Interface.customUiName.."/ObjectHandleToggleWindow", "ObjectHandleToggleWindow.xml", "ObjectHandleToggleWindow.xml" )

----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ObjectHandleToggleWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

ObjectHandleToggleWindow.WindowName = "ObjectHandleToggleWindow"
ObjectHandleToggleWindow.LabelName = ObjectHandleToggleWindow.WindowName .. "Type"

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function ObjectHandleToggleWindow.Initialize()
    WindowRegisterEventHandler( ObjectHandleToggleWindow.WindowName, SystemData.Events.USER_SETTINGS_UPDATED, "ObjectHandleToggleWindow.UpdateText")
    ObjectHandleToggleWindow.UpdateText()
    WindowUtils.RestoreWindowPosition(ObjectHandleToggleWindow.WindowName)
end

function ObjectHandleToggleWindow.Shutdown()
    WindowUtils.SaveWindowPosition(ObjectHandleToggleWindow.WindowName)
end

function ObjectHandleToggleWindow.ContextMenuCallback( returnCode, param )
    if( param ~= nil ) then
        SystemData.Settings.GameOptions.objectHandleFilter = returnCode-1
        UserSettingsChanged()
        ObjectHandleToggleWindow.UpdateText()
    end
end

function ObjectHandleToggleWindow.UpdateText()
    local filter
    for filter = 1, SettingsWindow.NUM_OBJHANDLE_FILTERS do
        if( SystemData.Settings.GameOptions.objectHandleFilter == SettingsWindow.ObjectHandles[filter].id )then
            LabelSetText(ObjectHandleToggleWindow.LabelName, GetStringFromTid(SettingsWindow.ObjectHandles[filter].tid))
        end
    end
    
end

function ObjectHandleToggleWindow.ShowContextMenu()
    local filter
    for filter = 1, SettingsWindow.NUM_OBJHANDLE_FILTERS do
        local text = GetStringFromTid( SettingsWindow.ObjectHandles[filter].tid )
        ContextMenu.CreateLuaContextMenuItem(SettingsWindow.ObjectHandles[filter].tid,0,filter,filter,SystemData.Settings.GameOptions.objectHandleFilter == SettingsWindow.ObjectHandles[filter].id)
    end
    ContextMenu.ActivateLuaContextMenu(ObjectHandleToggleWindow.ContextMenuCallback)
end
