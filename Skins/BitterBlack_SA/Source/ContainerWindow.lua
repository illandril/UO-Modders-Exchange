----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ContainerWindow = {}
ContainerWindow.OpenContainers = {}
ContainerWindow.RegisteredItems = {}
ContainerWindow.ViewModes = {}

ContainerWindow.DEFAULT_START_POSITION = { x=100,y=100 }
ContainerWindow.MAX_VALUES = { x=1280, y=1024 }
ContainerWindow.POSITION_OFFSET = 30
ContainerWindow.CurPosition = {}
ContainerWindow.CurPosition.x = ContainerWindow.DEFAULT_START_POSITION.x
ContainerWindow.CurPosition.y = ContainerWindow.DEFAULT_START_POSITION.y
ContainerWindow.TimePassedSincePickUp = 0
ContainerWindow.CanPickUp = true

ContainerWindow.TID_GRID_MODE = 1079439
ContainerWindow.TID_FREEFORM_MODE = 1079440
ContainerWindow.TID_LIST_MODE = 1079441
----------------------------------------------------------------
-- ContainerWindow Functions
----------------------------------------------------------------

-- Helper function
function ContainerWindow.ReleaseRegisteredObjects(id)
	if( ContainerWindow.RegisteredItems[id] ~= nil ) then
		for id, value in pairs(ContainerWindow.RegisteredItems[id]) do
			UnregisterWindowData(WindowData.ObjectInfo.Type, id)
		end
	end
	ContainerWindow.RegisteredItems[id] = {}
end

-- sets legacy container art
function ContainerWindow.SetLegacyContainer( gumpID, windowID )
	this = SystemData.ActiveWindow.name
	
	-- hide unwanted container elements
	WindowSetShowing( this.."Chrome", false )
	WindowSetShowing( this.."Title", false )

    if( gumpID == nil ) then
        --Debug.Print("ContainerWindow.SetLegacyContainer: gumpID is nil!")
        return
    end

	local texture = gumpID
	local xSize, ySize
	local scale = SystemData.FreeformInventory.Scale
	texture, xSize, ySize = RequestGumpArt( texture )
	local textureSize = xSize
	if (textureSize < ySize) then
		textureSize = ySize
	end
	
	-- show legacy container art
	WindowSetDimensions( this, xSize * scale, ySize * scale )
	WindowSetShowing( this.."LegacyContainerArt", true )
	WindowAddAnchor( this.."LegacyContainerArt", "topleft", this, "topleft", 0, 0 )
	WindowSetDimensions( this.."LegacyContainerArt", xSize * scale, ySize * scale )
	DynamicImageSetTexture( this.."LegacyContainerArt", texture, 0, 0 )
	DynamicImageSetTextureScale( this.."LegacyContainerArt", scale )
	
	DynamicImageSetTextureDimensions(this.."FreeformView", textureSize * scale, textureSize * scale)
	WindowSetDimensions(this.."FreeformView", textureSize * scale, textureSize * scale)
	DynamicImageSetTexture(this.."FreeformView", "freeformcontainer_texture"..windowID, 0, 0)
	DynamicImageSetTextureScale(this.."FreeformView", InterfaceCore.scale * scale)
	
	requestedContainerArt = requestedContainerArt or {}
	requestedContainerArt = texture
end

-- OnInitialize Handler
function ContainerWindow.Initialize()
	this = SystemData.ActiveWindow.name
	local id = SystemData.DynamicWindowId
	local legacyContainersMode = SystemData.Settings.Interface.LegacyContainers
	
	WindowSetId(this, id)
	
	Interface.DestroyWindowOnClose[this] = true

	ContainerWindow.OpenContainers[id] = true

	RegisterWindowData(WindowData.ContainerWindow.Type, id)
	RegisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)
	WindowRegisterEventHandler(this, WindowData.ContainerWindow.Event, "ContainerWindow.MiniModelUpdate")
	WindowRegisterEventHandler(this, WindowData.ObjectInfo.Event, "ContainerWindow.HandleUpdateObjectEvent")

	local gumpID = WindowData.ContainerWindow[id].gumpNum
	--Debug.PrintToDebugConsole( "legacyContainersMode = "..tostring( legacyContainersMode ) )
	--Debug.PrintToDebugConsole( "container id = "..gumpID )
	
	-- determine view mode
	local playerBackpack = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
    --if( WindowData.ContainerWindow[id].isSnooped == true or legacyContainersMode == true ) then
    if( legacyContainersMode == true ) then
        ContainerWindow.ViewModes[id] = "Freeform"
	elseif( WindowData.ContainerWindow[id].isCorpse == true ) then
		ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.defaultCorpseMode
	elseif( id == playerBackpack ) then
		ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.inventoryMode
		if( ContainerWindow.ViewModes[id] == "Freeform" ) then
			ContainerWindow.ViewModes[id] = "Grid"
		end
	else
		ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.defaultContainerMode
		if( ContainerWindow.ViewModes[id] == "Freeform" ) then
			ContainerWindow.ViewModes[id] = "Grid"
		end
	end

	if (ContainerWindow.ViewModes[id] == "Freeform") then
		ContainerWindow.SetLegacyContainer( gumpID, id )
		WindowSetShowing( this.."ViewButton", false )
	else
		WindowSetShowing( this.."ViewButton", true )
	end
	
	ContainerWindow.CreateGridViewSockets(this, id)

	WindowData.ContainerWindow[id].numCreatedSlots = 0
	
	-- position window
	local playerBackpack = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	-- if this is the players backpack then use the saved position
	if( id == playerBackpack ) then
		WindowUtils.RestoreWindowPosition(this)
		ButtonSetPressedFlag("MenuBarWindowToggleInventory",true)
		local my_paperdoll = "PaperdollWindow"..WindowData.PlayerStatus.PlayerId
		local my_paperdoll_backpackicon = "PaperdollWindow"..WindowData.PlayerStatus.PlayerId.."ToggleInventory"
		if DoesWindowNameExist(my_paperdoll) and WindowGetShowing(my_paperdoll) then
			ButtonSetPressedFlag( my_paperdoll_backpackicon, true )
		end	
	-- else tile them like the old client
	else
		WindowClearAnchors(this)
		WindowAddAnchor(this, "topleft","Root" , "topleft", ContainerWindow.CurPosition.x, ContainerWindow.CurPosition.y)
		ContainerWindow.CurPosition.x = ContainerWindow.CurPosition.x + ContainerWindow.POSITION_OFFSET
		ContainerWindow.CurPosition.y = ContainerWindow.CurPosition.y + ContainerWindow.POSITION_OFFSET

		local winX, winY = WindowGetDimensions(this)
		--Debug.Print("CurPosX: "..ContainerWindow.CurPosition.x.." WinWidth: "..winX.." ScreenWidth: "..SystemData.screenResolution.x)
		if( (ContainerWindow.CurPosition.x + winX) >= ContainerWindow.MAX_VALUES.x ) then
			ContainerWindow.CurPosition.x = ContainerWindow.DEFAULT_START_POSITION.x
		end
		--Debug.Print("CurPosY: "..ContainerWindow.CurPosition.y.." WinHeight: "..winY.." ScreenHeight: "..SystemData.screenResolution.y)
		if( (ContainerWindow.CurPosition.y + winY) >= ContainerWindow.MAX_VALUES.y ) then
			ContainerWindow.CurPosition.y = ContainerWindow.DEFAULT_START_POSITION.y
		end
	end
end

function ContainerWindow.Shutdown()
	--Debug.Print("ContainerWindow.Shutdown: "..WindowUtils.GetActiveDialog())

	if requestedContainerArt then
		ReleaseGumpArt( tonumber( requestedContainerArt ) )
	end

	local id = WindowGetId(WindowUtils.GetActiveDialog())
	this = "ContainerWindow_"..id
	
	local playerBackpack = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	-- if this is the players backpack then use the saved position
	if( id == playerBackpack ) then
		WindowUtils.SaveWindowPosition(this)
		ButtonSetPressedFlag("MenuBarWindowToggleInventory",false)
		local my_paperdoll = "PaperdollWindow"..WindowData.PlayerStatus.PlayerId
		local my_paperdoll_backpackicon = "PaperdollWindow"..WindowData.PlayerStatus.PlayerId.."ToggleInventory"
		if DoesWindowNameExist(my_paperdoll) and WindowGetShowing(my_paperdoll) then
			ButtonSetPressedFlag( my_paperdoll_backpackicon, false )
		end		
	end 
	
	ContainerWindow.ReleaseRegisteredObjects(id)
	
	-- clear view mode
	ContainerWindow.ViewModes[id] = nil
	
	UnregisterWindowData(WindowData.ContainerWindow.Type, id)
	UnregisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)
	
	ContainerWindow.OpenContainers[id] = nil
	
	if( ItemProperties.GetCurrentWindow() == this ) then
		ItemProperties.ClearMouseOverItem()
	end
	
	GumpManagerOnCloseContainer(id)
end

function ContainerWindow.HideAllContents(parent, numItems)
	for i=1,125 do
		DynamicImageSetTexture(parent.."GridViewSocket"..i.."Icon", "", 0, 0);
		LabelSetText(parent.."GridViewSocket"..i.."Quantity", L"")
		if i <= numItems then
			WindowSetShowing(parent.."ListViewScrollChildItem"..i, false)
		end
	end
end

function ContainerWindow.CreateSlots(dialog, low, high)
	-- TODO: Create other views as well/instead
	local parent = dialog.."ListViewScrollChild"
	for i=low, high do
		slotName = parent.."Item"..i
		CreateWindowFromTemplate(slotName, "ContainerItemTemplate", parent)
		WindowSetId(slotName,i)
		WindowSetId(slotName.."Icon", i)
		
		if i == 1 then
			WindowAddAnchor(slotName, "topleft", parent, "topleft", 0, 0)
		else
			WindowAddAnchor(slotName, "bottomleft", parent.."Item"..i-1, "topleft", 0, 0)
		end
	end
end

function ContainerWindow.CreateGridViewSockets(dialog, windowId)
	local GRID_WIDTH = 5
	local parent = dialog.."GridViewScrollChild"
	for i = 1, 125 do
		local socketName = dialog.."GridViewSocket"..i 
		local socketTemplate = "GridViewSocketTemplate"
		
		-- use the transparent grid background for legacy container views
		local legacyContainersMode = SystemData.Settings.Interface.LegacyContainers
		if( legacyContainersMode == true ) then
		    socketTemplate = "GridViewSocketLegacyTemplate"
		end
		
		CreateWindowFromTemplate(socketName, socketTemplate, parent)
		WindowSetId(socketName, i)
		if i == 1 then
			WindowAddAnchor(socketName, "topleft", parent, "topleft", 0, 0)
		elseif (i % GRID_WIDTH) == 1 then
			WindowAddAnchor(socketName, "bottomleft", dialog.."GridViewSocket"..i-GRID_WIDTH, "topleft", 0, 1)
		else
			WindowAddAnchor(socketName, "topright", dialog.."GridViewSocket"..i-1, "topleft", 1, 0)
		end

		WindowSetShowing(socketName, true)
	end

	ScrollWindowUpdateScrollRect(dialog.."GridView") 
	WindowSetShowing(dialog.."GridView", false)
end

function ContainerWindow.MiniModelUpdate()
	local id = WindowData.UpdateInstanceId
	
	if( id == WindowGetId(SystemData.ActiveWindow.name) ) then
		ContainerWindow.UpdateContents(id)
	end
end

function ContainerWindow.UpdateContents(id)
	this = "ContainerWindow_"..id
	local list_view_this = this.."ListView"        
	local grid_view_this = this.."GridView"
	local freeform_view_this = this.."FreeformView"
	
	local data = WindowData.ContainerWindow[id]
	
	-- store the scrollbar offset so we can restore it when we are done
	local listOffset = ScrollWindowGetOffset(list_view_this)
	local gridOffset = ScrollWindowGetOffset(grid_view_this)
	
	-- Create any contents slots we need
	local contents = data.ContainedItems
	local numItems = data.numItems
	local numCreatedSlots = data.numCreatedSlots or 0
	if numItems > numCreatedSlots then
		ContainerWindow.CreateSlots(this, numCreatedSlots+1, numItems)
		data.numCreatedSlots = numItems
	end
	
	-- Turn off all contents to start
	ContainerWindow.HideAllContents(this, numCreatedSlots)

	if ContainerWindow.ViewModes[id] == "List" then
		WindowSetShowing(list_view_this , true)
		WindowSetShowing(grid_view_this, false)
		WindowSetShowing(freeform_view_this, false)
	elseif ContainerWindow.ViewModes[id] == "Grid" then
		WindowSetShowing(list_view_this, false)
		WindowSetShowing(grid_view_this, true)
		WindowSetShowing(freeform_view_this, false)
	elseif ContainerWindow.ViewModes[id] == "Freeform" then
		WindowSetShowing(list_view_this, false)
		WindowSetShowing(grid_view_this, false)
		WindowSetShowing(freeform_view_this, true)	
	end
	
	LabelSetText(this.."Title", data.containerName)
	if (data.containerName and data.containerName ~= L"" and data.containerName ~= "") then
		WindowUtils.FitTextToLabel(this.."Title", data.containerName)
	end
	
	ContainerWindow.ReleaseRegisteredObjects(id)
	
	if( ContainerWindow.ViewModes[id] ~= "Freeform" ) then
		for i = 1, numItems do
			item = data.ContainedItems[i]
			ContainerWindow.RegisteredItems[id][item.objectId] = true
			RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
			-- perform the initial update of this object
			ContainerWindow.UpdateObject(this,item.objectId)
			WindowSetShowing(this.."ListViewScrollChildItem"..i,true)
		end
		
		-- Update the scroll windows
		ScrollWindowUpdateScrollRect( list_view_this )   	
		local maxOffset = VerticalScrollbarGetMaxScrollPosition(list_view_this.."Scrollbar")
		if( listOffset > maxOffset ) then
		    listOffset = maxOffset
		end
		ScrollWindowSetOffset(list_view_this,listOffset)

		ScrollWindowUpdateScrollRect(grid_view_this) 
		maxOffset = VerticalScrollbarGetMaxScrollPosition(grid_view_this.."Scrollbar")
		if( gridOffset > maxOffset ) then
		    gridOffset = maxOffset
		end
		ScrollWindowSetOffset(grid_view_this,gridOffset)		
		
	end

end

function ContainerWindow.HandleUpdateObjectEvent()
    ContainerWindow.UpdateObject(SystemData.ActiveWindow.name,WindowData.UpdateInstanceId)
end

function ContainerWindow.UpdateObject(windowName,updateId)
	if( WindowData.ObjectInfo[updateId] ~= nil ) then
	    local containerId = WindowData.ObjectInfo[updateId].containerId
    	
	    -- if this object is in my container
	    if( containerId == WindowGetId(windowName) ) then
		    -- find the slot index
		    containedItems = WindowData.ContainerWindow[containerId].ContainedItems
		    numItems = WindowData.ContainerWindow[containerId].numItems
		    listIndex = 0
		    for i=1, numItems do
			    if( containedItems[i].objectId == updateId ) then
				    listIndex = i
				    gridIndex = (containedItems[i].gridIndex)
				    break
			    end
		    end
		    item = WindowData.ObjectInfo[updateId]

		    -- Name
		    ElementName = windowName.."ListViewScrollChildItem"..listIndex.."Name"
		    LabelSetText(ElementName, item.name )
		    WindowSetShowing(ElementName, true)

		    -- Icon
		    elementIcon = windowName.."ListViewScrollChildItem"..listIndex.."Icon"
		    if( item.iconName ~= "" ) then
                EquipmentData.UpdateItemIcon(elementIcon, item)
    			
			    parent = WindowGetParent(elementIcon)
			    WindowClearAnchors(elementIcon)
			    WindowAddAnchor(elementIcon, "topleft", parent, "topleft", 1+((45-item.newWidth)/2), 1+((45-item.newHeight)/2))
    			
			    WindowSetShowing(elementIcon, true)
		    else
			    WindowSetShowing(elementIcon, false)
		    end

		    -- Grid View Icon & Quantity Label
		    if( item.iconName ~= "" ) then
			    elementIcon = windowName.."GridViewSocket"..gridIndex.."Icon"

                EquipmentData.UpdateItemIcon(elementIcon, item)	
			    
			    local gridViewItemLabel = windowName.."GridViewSocket"..gridIndex.."Quantity"
			    LabelSetText(gridViewItemLabel, L"")
			    if( item.quantity ~= nil and item.quantity > 1 ) then 
				    LabelSetText(gridViewItemLabel, L""..item.quantity)
				end
		    end
	    end
	end
end

function ContainerWindow.ToggleView()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	
	if( WindowData.ContainerWindow[id].isSnooped == false ) then
        if (ContainerWindow.ViewModes[id] == "List") then
		    ContainerWindow.ViewModes[id] = "Grid"
        elseif( ContainerWindow.ViewModes[id] == "Grid" ) then 
    	    ContainerWindow.ViewModes[id] = "List"
	    end

	    local this = WindowUtils.GetActiveDialog()
	    local id = WindowGetId(this)
        ContainerWindow.UpdateContents(id)
    end
    
    local playerBackpack = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	if( id == playerBackpack ) then
		SystemData.Settings.Interface.inventoryMode = ContainerWindow.ViewModes[id]
	elseif( WindowData.ContainerWindow[id].isCorpse == true ) then
		SystemData.Settings.Interface.defaultCorpseMode = ContainerWindow.ViewModes[id]
	else
		SystemData.Settings.Interface.defaultContainerMode = ContainerWindow.ViewModes[id]
	end
	
	SettingsWindow.UpdateSettings()
	UserSettingsChanged()	
end

function ContainerWindow.GetSlotNumFromGridIndex(containerId, gridIndex)
    local slotNum = nil
    
    if( ContainerWindow.ViewModes[containerId] == "Grid" ) then
        local containedItems = WindowData.ContainerWindow[containerId].ContainedItems
        
        if( WindowData.ContainerWindow[containerId].ContainedItems ) then
            for index, item in ipairs(WindowData.ContainerWindow[containerId].ContainedItems) do
                --Debug.Print("Comparing to: "..tostring(item.gridIndex))
	            if( item.gridIndex == gridIndex ) then
		            slotNum = index
		            break
	            end
            end
        end
    else
        slotNum = gridIndex
    end
    
    return slotNum
end

function ContainerWindow.OnItemClicked()
	local containerId = WindowGetId(WindowUtils.GetActiveDialog())
	local slotNum = WindowGetId(SystemData.ActiveWindow.name)
	
	slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, slotNum)

    if( slotNum ~= nil ) then
	    if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true ) then
			local objectId = WindowData.ContainerWindow[containerId].ContainedItems[slotNum].objectId
			HandleSingleLeftClkTarget(objectId)
	    elseif( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE ) then
			local objectId = WindowData.ContainerWindow[containerId].ContainedItems[slotNum].objectId
			DragSlotSetObjectMouseClickData(objectId, SystemData.DragSource.SOURCETYPE_CONTAINER)
	    end
	end
end

function ContainerWindow.OnItemRelease()
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
	    local containerId = WindowGetId(WindowUtils.GetActiveDialog())
		local gridIndex = WindowGetId(SystemData.ActiveWindow.name)
		local slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, gridIndex)
		local slot = nil
	
        if( WindowData.ContainerWindow[containerId].ContainedItems ~= nil and slotNum ~= nil) then
            slot = WindowData.ContainerWindow[containerId].ContainedItems[slotNum]
        end
        
        --Debug.Print("OnItemRelease: "..tostring(slot))
		-- This happens when you drop an item onto an empty grid socket
		if (not slot) then
            DragSlotDropObjectToContainer(containerId,gridIndex)
			return
		end
		
		local clickedObjId = slot.objectId

        -- 0 tells code to use the source grid index
		DragSlotDropObjectToObject(clickedObjId)
	end
end

function ContainerWindow.OnContainerRelease(slotNum)
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
		local containerId = WindowGetId(WindowUtils.GetActiveDialog())
		DragSlotDropObjectToContainer(containerId,0)
	end
end

function ContainerWindow.OnItemDblClicked()
	local containerId = WindowGetId(WindowUtils.GetActiveDialog())
	local slotNum = WindowGetId(SystemData.ActiveWindow.name)
	
	slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, slotNum)
	if( slotNum ~= nil ) then
	    local objectId = WindowData.ContainerWindow[containerId].ContainedItems[slotNum].objectId
    	
	    UserActionUseItem(objectId,false)
	end
end

function ContainerWindow.OnItemRButtonUp()

end

function ContainerWindow.ItemMouseOver()
	local this = SystemData.ActiveWindow.name
	local index = WindowGetId(this)
	local dialog = WindowUtils.GetActiveDialog()
	local containerId = WindowGetId(dialog)
	local containedItems = WindowData.ContainerWindow[containerId].ContainedItems

    local slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, index)
    
    if( slotNum ~= nil and containedItems and containedItems[slotNum] ~= nil ) then
	    objectId = containedItems[slotNum].objectId
    	
	    if objectId then
		    local itemData = { windowName = dialog,
						       itemId = objectId,
		    			       itemType = WindowData.ItemProperties.TYPE_ITEM }
		    ItemProperties.SetActiveItem(itemData)
	    end
	end
end

function ContainerWindow.OnItemGet()
	local index = WindowGetId(SystemData.ActiveWindow.name)
	local containerId = WindowGetId(WindowUtils.GetActiveDialog())
	local slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, index)
	
	if (slotNum ~= nil) then
		local objectId = WindowData.ContainerWindow[containerId].ContainedItems[slotNum].objectId
	
		if (objectId ~= nil or objectId ~= 0) then
			-- If player is trying to get objects from a container that is not from the players backpack have it dropped
			-- into the players backpack
			if(WindowData.ContainerWindow[containerId].isCorpse == true) then
				if( ContainerWindow.CanPickUp == true) then
					DragSlotAutoPickupObject(objectId)
					ContainerWindow.TimePassedSincePickUp = 0
					ContainerWindow.CanPickUp = false
				else
					PrintTidToChatWindow(1045157,1)
				end
			else
				RequestContextMenu(objectId)
			end
		end
	end
end

function ContainerWindow.UpdatePickupTimer(timePassed)
	if(ContainerWindow.CanPickUp == false) then
		ContainerWindow.TimePassedSincePickUp = ContainerWindow.TimePassedSincePickUp + timePassed
		if(ContainerWindow.TimePassedSincePickUp >= 1) then
			ContainerWindow.CanPickUp = true	
		end
	end
end

function ContainerWindow.ViewButtonMouseOver()
	local messageText = L""
	local containerId = WindowGetId(WindowUtils.GetActiveDialog())
	
	if (ContainerWindow.ViewModes[containerId] == "Grid" ) then
        messageText = GetStringFromTid(ContainerWindow.TID_LIST_MODE)
	elseif (ContainerWindow.ViewModes[containerId] == "List" ) then
        messageText = GetStringFromTid(ContainerWindow.TID_GRID_MODE)
    end
    
	local itemData = { windowName = SystemData.ActiveWindow.name,
						itemId = containerId,
						itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
						binding = L"",
						detail = nil,
						title =	messageText,
						body = L""}

	ItemProperties.SetActiveItem(itemData)
end