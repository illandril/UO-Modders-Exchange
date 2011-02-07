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
ContainerWindow.TimePassedSincePickUp = 0
ContainerWindow.CanPickUp = true

ContainerWindow.TID_GRID_MODE = 1079439
ContainerWindow.TID_FREEFORM_MODE = 1079440
ContainerWindow.TID_LIST_MODE = 1079441

ContainerWindow.ScrollbarWidth = 12

ContainerWindow.Grid = {}
ContainerWindow.Grid.PaddingTop = 50
ContainerWindow.Grid.PaddingLeft = 12
ContainerWindow.Grid.PaddingBottom = 5
ContainerWindow.Grid.PaddingRight = 23
ContainerWindow.Grid.SocketSize = 52
ContainerWindow.Grid.MinWidth = 320
ContainerWindow.Grid.NumSockets = {}

ContainerWindow.List = {}
ContainerWindow.List.PaddingTop = 50
ContainerWindow.List.PaddingLeft = 0
ContainerWindow.List.PaddingBottom = 15
ContainerWindow.List.PaddingRight = 14
ContainerWindow.List.LabelPaddingRight = ContainerWindow.ScrollbarWidth + ContainerWindow.List.PaddingRight + 5
ContainerWindow.List.ItemHeight = 60
ContainerWindow.List.MinWidth = 320

ContainerWindow.MAX_INVENTORY_SLOTS = 125

-- used for windows the player doesn't own
ContainerWindow.Cascade = {}
ContainerWindow.Cascade.Movement = { x=0, y=0 }

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

	ContainerWindow.OpenContainers[id] = {open = true, cascading = false, slotsWide = 0, slotsHigh = 0}

	RegisterWindowData(WindowData.ContainerWindow.Type, id)
	RegisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)
	WindowRegisterEventHandler(this, WindowData.ContainerWindow.Event, "ContainerWindow.MiniModelUpdate")
	WindowRegisterEventHandler(this, WindowData.ObjectInfo.Event, "ContainerWindow.HandleUpdateObjectEvent")

	local gumpID = WindowData.ContainerWindow[id].gumpNum
	--Debug.PrintToDebugConsole( "legacyContainersMode = "..tostring( legacyContainersMode ) )
	--Debug.PrintToDebugConsole( "container id = "..gumpID )
	
	-- determine the container's view mode
	if legacyContainersMode then
        ContainerWindow.ViewModes[id] = "Freeform"	
		
	elseif WindowData.ContainerWindow[id].isCorpse then
		ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.defaultCorpseMode
		
	elseif IsInPlayerBackPack(id) then
		-- iterate through the shared vector looking for our container id
		for i, windowId in ipairs(SystemData.Settings.Interface.ContainerViewModes.Ids) do
			if windowId == id then -- we found the preserved viewmode
				ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.ContainerViewModes.ViewModes[i]
				break
			end
		end
		
		-- if the id wasn't found or if the container's viewmode was manually changed to "Freeform" with legacy containers 
		-- turned off, use the default setting
		if not ContainerWindow.ViewModes[id] or ContainerWindow.ViewModes[id] == "Freeform" then
			ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.defaultContainerMode
			
			-- insert the new container setting into the shared vector
			local newContainerIndex = table.getn(SystemData.Settings.Interface.ContainerViewModes.ViewModes) + 1
			SystemData.Settings.Interface.ContainerViewModes.Ids[newContainerIndex] = id
			SystemData.Settings.Interface.ContainerViewModes.ViewModes[newContainerIndex] = ContainerWindow.ViewModes[id]
		end
		
	else
		-- use the default container mode
		ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.defaultContainerMode
	end
	-- done getting view mode
	
	if (ContainerWindow.ViewModes[id] == "Freeform") then
		ContainerWindow.SetLegacyContainer( gumpID, id )
		WindowSetShowing( this.."ViewButton", false )
		WindowSetShowing( this.."ResizeButton", false )
	else
		WindowSetShowing( this.."ViewButton", true )
	end

	WindowData.ContainerWindow[id].numCreatedSlots = 0
		
	-- if this container belongs to the player then use the saved position
	if IsInPlayerBackPack(id) then
		WindowUtils.RestoreWindowPosition(this, true)
		
		-- if the window position can't be restored, try to place this container near its parent container
		if not WindowUtils.CanRestorePosition(this) then
			local parentContainerId = GetParentContainer(id)
			
			WindowClearAnchors(this)
			if parentContainerId ~= 0 then
				-- offset this container from the parent
				local x, y = WindowGetScreenPosition("ContainerWindow_"..parentContainerId)	
				x = math.floor((x + ContainerWindow.POSITION_OFFSET) / InterfaceCore.scale + 0.5)
				y = math.floor((y + ContainerWindow.POSITION_OFFSET) / InterfaceCore.scale + 0.5)
				WindowAddAnchor(this, "topleft", "Root", "topleft", x, y)	
			else
				WindowAddAnchor(this, "topleft", "Root", "topleft", 200, 200)	
			end
		end
		
		-- if this is the players backpack then update the paperdoll backpack icon
		local playerBackpack = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
		if( id == playerBackpack ) then
			ContainerWindow.SetInventoryButtonPressed(true)
		end
		
	-- else tile them like the old client
	else
		WindowUtils.RestoreWindowPosition(this)
		
		if not WindowUtils.CanRestorePosition(this) then
			-- if window position couldn't be restored, cascade the containers from the top left of the screen
			local x, y;
			
			local topCascadingId = ContainerWindow.GetTopOfCascade()
			if not topCascadingId then
				x = ContainerWindow.DEFAULT_START_POSITION.x
				y = ContainerWindow.DEFAULT_START_POSITION.y
			else
				x, y = WindowGetScreenPosition("ContainerWindow_"..topCascadingId)
				x = x + ContainerWindow.POSITION_OFFSET
				y = y + ContainerWindow.POSITION_OFFSET
			end
			
			x = math.floor(x / InterfaceCore.scale + 0.5)
			y = math.floor(y / InterfaceCore.scale + 0.5)
			WindowClearAnchors(this)
			WindowAddAnchor(this, "topleft", "Root", "topleft", x, y)	
			
			ContainerWindow.AddToCascade(id)
		end

	end
	
	if (ContainerWindow.ViewModes[id] == "List") then
		ContainerWindow.UpdateListViewSockets(id)
	elseif (ContainerWindow.ViewModes[id] ~= "Freeform") then
		-- default to grid view if not using list or freeform containers
		ContainerWindow.ViewModes[id] = "Grid"
		ContainerWindow.UpdateGridViewSockets(id)
	end
	
	ContainerWindow.UpdateContents(id)
end

function ContainerWindow.Shutdown()
	--Debug.Print("ContainerWindow.Shutdown: "..WindowUtils.GetActiveDialog())

	if requestedContainerArt then
		ReleaseGumpArt( tonumber( requestedContainerArt ) )
	end

	local id = WindowGetId(WindowUtils.GetActiveDialog())
	this = "ContainerWindow_"..id
	
	-- if the container is in the cascade, don't save its position
	if ContainerWindow.IsCascading(id) then
		ContainerWindow.RemoveFromCascade(id)
	else
		WindowUtils.SaveWindowPosition(this)
	end
	
	if IsInPlayerBackPack(id) then
		
		-- iterate through the shared vector looking for our container id
		for i, windowId in ipairs(SystemData.Settings.Interface.ContainerViewModes.Ids) do
			if windowId == id then
				SystemData.Settings.Interface.ContainerViewModes.ViewModes[i] = ContainerWindow.ViewModes[id]
				break
			end
		end
		
		local playerBackpack = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
		if( id == playerBackpack ) then
			ContainerWindow.SetInventoryButtonPressed(false)
		end 
	end
	
	ContainerWindow.ReleaseRegisteredObjects(id)
	
	ContainerWindow.ViewModes[id] = nil
	ContainerWindow.OpenContainers[id] = nil
	
	UnregisterWindowData(WindowData.ContainerWindow.Type, id)
	UnregisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)
	
	if( ItemProperties.GetCurrentWindow() == this ) then
		ItemProperties.ClearMouseOverItem()
	end
	
	GumpManagerOnCloseContainer(id)
end


function ContainerWindow.OnSetMoving(isMoving)
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	
	if ContainerWindow.IsCascading(id) then
		local windowName = "ContainerWindow_"..id
		local x, y = WindowGetScreenPosition(windowName)
		if isMoving then
			ContainerWindow.Cascade.Movement.x = x
			ContainerWindow.Cascade.Movement.y = y
		else
			if ContainerWindow.Cascade.Movement.x ~= x and ContainerWindow.Cascade.Movement.y ~= y then
				ContainerWindow.RemoveFromCascade(id)
			end
		end
	end
	
end

function ContainerWindow.SetInventoryButtonPressed(pressed)
	ButtonSetPressedFlag("MenuBarWindowToggleInventory", pressed)
	local my_paperdoll = "PaperdollWindow"..WindowData.PlayerStatus.PlayerId
	local my_paperdoll_backpackicon = "PaperdollWindow"..WindowData.PlayerStatus.PlayerId.."ToggleInventory"
	if DoesWindowNameExist(my_paperdoll) and WindowGetShowing(my_paperdoll) then
		ButtonSetPressedFlag( my_paperdoll_backpackicon, pressed)
	end	
end

function ContainerWindow.HideAllContents(parent, numItems)
	for i=1,ContainerWindow.MAX_INVENTORY_SLOTS do
		DynamicImageSetTexture(parent.."GridViewSocket"..i.."Icon", "", 0, 0);
		LabelSetText(parent.."GridViewSocket"..i.."Quantity", L"")
		if i <= numItems then
			WindowSetShowing(parent.."ListViewScrollChildItem"..i, false)
		end
	end
end

function ContainerWindow.CreateListViewSlots(dialog, low, high)
	local parent = dialog.."ListViewScrollChild"
	for i=low, high do
		slotName = parent.."Item"..i
		CreateWindowFromTemplate(slotName, "ContainerItemTemplate", parent)
		WindowSetId(slotName,i)
		WindowSetId(slotName.."Icon", i)
        
		if i == 1 then
			WindowAddAnchor(slotName, "topleft", parent, "topleft", 0, 0)
            WindowAddAnchor(slotName, "topright", dialog, "topright", -ContainerWindow.List.LabelPaddingRight, 0)
		else
			WindowAddAnchor(slotName, "bottomleft", parent.."Item"..i-1, "topleft", 0, 0)
            WindowAddAnchor(slotName, "bottomright", dialog, "topright", -ContainerWindow.List.LabelPaddingRight, 0)
		end
	end
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
		ContainerWindow.CreateListViewSlots(this, numCreatedSlots+1, numItems)
		data.numCreatedSlots = numItems
	end
		
	if not data.numGridSockets or data.numGridSockets < ContainerWindow.MAX_INVENTORY_SLOTS then
		ContainerWindow.CreateGridViewSockets(this, 1, ContainerWindow.MAX_INVENTORY_SLOTS)
		data.numGridSockets = ContainerWindow.MAX_INVENTORY_SLOTS
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
			    WindowAddAnchor(elementIcon, "topleft", parent, "topleft", 15+((45-item.newWidth)/2), 15+((45-item.newHeight)/2))
    			
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
			ContainerWindow.UpdateGridViewSockets(id)
        elseif( ContainerWindow.ViewModes[id] == "Grid" ) then 
    	    ContainerWindow.ViewModes[id] = "List"
			ContainerWindow.UpdateListViewSockets(id)
	    end

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
		
		SystemData.ActiveContainer.SlotsWide = ContainerWindow.OpenContainers[containerId].slotsWide
		SystemData.ActiveContainer.SlotsHigh = ContainerWindow.OpenContainers[containerId].slotsHigh
        
        --Debug.Print("OnItemRelease: "..tostring(slot))
		-- This happens when you drop an item onto an empty grid socket
		
		if (not slot) then
            DragSlotDropObjectToContainer(containerId,gridIndex)
			return
		end
		
		local clickedObjId = slot.objectId
		DragSlotDropObjectToObjectAtIndex(clickedObjId,gridIndex)
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
		    			       itemType = WindowData.ItemProperties.TYPE_ITEM,
		    			       detail = ItemProperties.DETAIL_LONG }
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

function ContainerWindow.OnResizeBegin()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	local minHeight
	local minWidth

	if (ContainerWindow.ViewModes[id] == "List") then
		minWidth = ContainerWindow.List.MinWidth
		minHeight = minWidth
	else -- "Grid"
		minWidth = ContainerWindow.Grid.MinWidth
		minHeight = minWidth
	end
	
    WindowUtils.BeginResize( WindowUtils.GetActiveDialog(), "topleft", minWidth, minHeight, false, ContainerWindow.OnResizeEnd)
end

function ContainerWindow.OnResizeEnd()
	local windowName = WindowUtils.resizeWindow
	local id = WindowGetId(windowName)

	if (ContainerWindow.ViewModes[id] == "List" ) then
        ContainerWindow.UpdateListViewSockets(id)
	elseif (ContainerWindow.ViewModes[id] == "Grid" ) then
        ContainerWindow.UpdateGridViewSockets(id)
    end
	
    ContainerWindow.UpdateContents(id) 
end

function ContainerWindow.UpdateListViewSockets(id)	
	--Debug.Print("ContainerWindow.UpdateListViewSockets("..id..")")
	
	local windowName = "ContainerWindow_"..id
	local listViewName = windowName.."ListView"
	local scrollchildName = listViewName.."ScrollChild"
	
	local windowWidth, windowHeight = WindowGetDimensions(windowName)
	local newListHeight = windowHeight - (ContainerWindow.List.PaddingTop + ContainerWindow.List.PaddingBottom)
	local newListWidth = windowWidth - (ContainerWindow.List.PaddingRight + ContainerWindow.List.PaddingLeft)
    
	WindowSetDimensions(listViewName, newListWidth, newListHeight)
    WindowSetDimensions(scrollchildName, newListWidth, newListHeight)
	
	ScrollWindowUpdateScrollRect(listViewName) 
end

function ContainerWindow.UpdateGridViewSockets(id)
	--Debug.Print("ContainerWindow.UpdateGridViewSockets("..id..")")
	
	local data = WindowData.ContainerWindow[id]
	
	local windowName = "ContainerWindow_"..id
	local gridViewName = windowName.."GridView"
	local scrollViewChildName = gridViewName.."ScrollChild"
	
	-- determine the grid dimensions based on window width and height
	local windowWidth, windowHeight = WindowGetDimensions(windowName)
	local GRID_WIDTH = math.floor((windowWidth - (ContainerWindow.Grid.PaddingLeft + ContainerWindow.Grid.PaddingRight)) / ContainerWindow.Grid.SocketSize + 0.5)	
	local GRID_HEIGHT = math.floor((windowHeight - (ContainerWindow.Grid.PaddingTop + ContainerWindow.Grid.PaddingBottom)) / ContainerWindow.Grid.SocketSize + 0.5)
	local numSockets = GRID_WIDTH * GRID_HEIGHT
	local allSocketsVisible = numSockets >= ContainerWindow.MAX_INVENTORY_SLOTS
		
	-- if numSockets is less than 125, we need additional rows to provide at least 125 sockets.
	if not allSocketsVisible then
		GRID_HEIGHT = math.ceil(ContainerWindow.MAX_INVENTORY_SLOTS / GRID_WIDTH)
		numSockets = GRID_WIDTH * GRID_HEIGHT
	end
	
	if not data.numGridSockets then
		ContainerWindow.CreateGridViewSockets(windowName, 1, numSockets)
	else
		-- create additional padding sockets if needed or destroy extra ones from the last resize
		if data.numGridSockets > numSockets then
			ContainerWindow.DestroyGridViewSockets(windowName, numSockets + 1, data.numGridSockets)
		elseif data.numGridSockets < numSockets then
			ContainerWindow.CreateGridViewSockets(windowName, data.numGridSockets + 1, numSockets)
		end
	end
	data.numGridSockets = numSockets
	
	-- position and anchor the sockets
	for i = 1, data.numGridSockets do
		local socketName = windowName.."GridViewSocket"..i 
		WindowClearAnchors(socketName)
			
		if i == 1 then
			WindowAddAnchor(socketName, "topleft", scrollViewChildName, "topleft", 0, 0)
		elseif (i % GRID_WIDTH) == 1 then
			WindowAddAnchor(socketName, "bottomleft", windowName.."GridViewSocket"..i-GRID_WIDTH, "topleft", 0, 0)
		else
			WindowAddAnchor(socketName, "topright", windowName.."GridViewSocket"..i-1, "topleft", 0, 0)
		end

		WindowSetShowing(socketName, true)
	end
	
	-- dimensions for the entire grid view with GRID_WIDTH x GRID_HEIGHT dimensions
	local newGridWidth = GRID_WIDTH * ContainerWindow.Grid.SocketSize + ContainerWindow.Grid.PaddingLeft
	local newGridHeight = GRID_HEIGHT * ContainerWindow.Grid.SocketSize + ContainerWindow.Grid.PaddingTop
	
	-- fit the window width to the grid width
	local newWindowWidth = newGridWidth + ContainerWindow.Grid.PaddingRight
	local newWindowHeight = windowHeight
	
	-- if we can see every slot in the container, snap the window height to the grid and hide the void created 
	-- by the missing scrollbar
	if allSocketsVisible then
		newWindowHeight = newGridHeight + ContainerWindow.Grid.PaddingBottom
		newWindowWidth = newWindowWidth - ContainerWindow.ScrollbarWidth
	else
		newWindowHeight = windowHeight
		newGridHeight = windowHeight - (ContainerWindow.Grid.PaddingBottom + ContainerWindow.Grid.PaddingTop)
	end
	
	WindowSetDimensions(windowName, newWindowWidth, newWindowHeight)
	WindowSetDimensions(gridViewName, newGridWidth, newGridHeight)
	WindowSetDimensions(scrollViewChildName, newGridWidth, newGridHeight)
	
	ScrollWindowUpdateScrollRect(gridViewName) 
	
	if ContainerWindow.OpenContainers[id] then
		ContainerWindow.OpenContainers[id].slotsWide = GRID_WIDTH
		ContainerWindow.OpenContainers[id].slotsHigh = GRID_HEIGHT
	end
	
end

function ContainerWindow.CreateGridViewSockets(dialog, lower, upper)
	if not lower then
		lower = 1
	end
	
	if not upper then
		upper = ContainerWindow.MAX_INVENTORY_SLOTS
	end

	--Debug.Print("ContainerWindow.CreateGridViewSockets("..dialog..") lower = "..lower.." upper = "..upper)
	
	local parent = dialog.."GridViewScrollChild"
	
	for i = lower, upper do
		local socketName = dialog.."GridViewSocket"..i 
		local socketTemplate

		if i > ContainerWindow.MAX_INVENTORY_SLOTS then
			socketTemplate = "GridViewSocketBaseTemplate"
		else
			socketTemplate = "GridViewSocketTemplate"
		end
		
		-- use the transparent grid background for legacy container views
		local legacyContainersMode = SystemData.Settings.Interface.LegacyContainers
		if( legacyContainersMode == true ) then
		    socketTemplate = "GridViewSocketLegacyTemplate"
		end
		
		CreateWindowFromTemplate(socketName, socketTemplate, parent)
		WindowSetId(socketName, i)
		WindowSetShowing(socketName, false)
		
		if i > ContainerWindow.MAX_INVENTORY_SLOTS then
			WindowSetAlpha(socketName, 0.5)
			WindowSetTintColor(socketName, 10, 10, 10)
		end
	end
	
	WindowSetShowing(dialog.."GridView", false)
end

function ContainerWindow.DestroyGridViewSockets(dialog, lower, upper)
	if not lower then
		lower = 1
	end
	
	if not upper then
		upper = ContainerWindow.MAX_INVENTORY_SLOTS
	end

	for i = lower, upper do
		local socketName = dialog.."GridViewSocket"..i 
		DestroyWindow(socketName)
	end
end

function ContainerWindow.GetTopOfCascade()
	local cascadeSize = table.getn(ContainerWindow.Cascade)
	if cascadeSize > 0 then
		-- loop from n to 1 , removing windows with cascading == false and returning the first
		-- with cascading == true
		for i = cascadeSize, 1, -1 do
			local windowId = ContainerWindow.Cascade[i]
			if ContainerWindow.IsCascading(windowId) then
				return windowId
			else
				ContainerWindow.Cascade[i] = nil
			end
		end
	end
	
	return nil;
end

function ContainerWindow.IsCascading(windowId)
	if ContainerWindow.OpenContainers[windowId] then
		return ContainerWindow.OpenContainers[windowId].cascading
	else
		return false
	end
end

function ContainerWindow.AddToCascade(windowId)
	if ContainerWindow.OpenContainers[windowId] then
		local cascadeSize = table.getn(ContainerWindow.Cascade) + 1
		ContainerWindow.Cascade[cascadeSize] = windowId
		ContainerWindow.OpenContainers[windowId].cascading = true
	end
end

function ContainerWindow.RemoveFromCascade(windowId)
	-- since this is called often. the ContainerWindow.Cascade array is resized in GetTopOfCascade
	if ContainerWindow.OpenContainers[windowId] then
		ContainerWindow.OpenContainers[windowId].cascading = false
	end
end