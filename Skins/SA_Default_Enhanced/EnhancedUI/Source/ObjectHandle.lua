ObjectHandleWindowEnhancements = {}

function ObjectHandleWindowEnhancements.Initialize()

    -- We don't save the old, because we're overwriting the whole function. We could call the old... but it would just waste CPU cycles.
    ObjectHandleWindow.OnRClick = ObjectHandleWindowEnhancements.OnRClickNew
	ObjectHandle.DestroyObjectWindow = ObjectHandleWindowEnhancements.DestroyObjectWindow
	ObjectHandleWindow.OnDblClick = ObjectHandleWindowEnhancements.OnDblClick
	ObjectHandleWindow.OnClickClose = ObjectHandleWindowEnhancements.OnClickClose
end

function ObjectHandleWindowEnhancements.OnClickClose()
	local objectId = WindowGetId(WindowUtils.GetActiveDialog())
	local tableLoc = ObjectHandleWindow.ReverseObjectLookUp[objectId]
	--Request context menu if the object handle they right click is an object
	if( (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE) and ObjectHandleWindow.ObjectsData.IsMobile[tableLoc]) then
		ObjectHandle.DestroyObjectWindow(objectId, true) 
		RequestContextMenu(objectId)
	else
		ObjectHandle.DestroyObjectWindow(objectId, true) 
	end
end


-- Closes object handle windows with a right click if they don't have a context menu
function ObjectHandleWindowEnhancements.OnRClickNew()
	local objectId = WindowGetId(WindowUtils.GetActiveDialog())
	local tableLoc = ObjectHandleWindow.ReverseObjectLookUp[objectId]
	--Request context menu if the object handle they left click is an object
	if( (Cursor.IconOnCursor() == false) and ObjectHandleWindow.ObjectsData.IsMobile[tableLoc]) then
		RequestContextMenu(objectId)
	else
		--Simple Change states if the object doesn't have a context menu then close on right click
		ObjectHandleWindowEnhancements.DestroyObjectWindow(objectId, true) 
	end
end

-- leaves object handles onscreen if object filter corpse, must click to close or switch object filter to other than corpse only
function ObjectHandleWindowEnhancements.DestroyObjectWindow(objectId, click) 

	if( SystemData.Settings.GameOptions.objectHandleFilter == 1 and click == nil) then
		Debug.Print("Do not Auto close when keys released")
	else

		local windowName = "ObjectHandleWindow"..objectId
		if( ObjectHandleWindow.hasWindow[objectId] == true) then
			DestroyWindow(windowName)
			ObjectHandleWindow.hasWindow[objectId] = nil
			ObjectHandleWindow.ReverseObjectLookUp[objectId] = nil
		end	
	end
end
-- this will automatically close object handle if set to corpse only and double click on handle
function ObjectHandleWindowEnhancements.OnDblClick()
	local objectId = WindowGetId(WindowUtils.GetActiveDialog())
	UserActionUseItem(objectId,false)
	if( SystemData.Settings.GameOptions.objectHandleFilter == 1) then
		ObjectHandleWindowEnhancements.DestroyObjectWindow(objectId, true)
	end
end