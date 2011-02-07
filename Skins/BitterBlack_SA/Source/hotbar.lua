----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

Hotbar = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

Hotbar.NUM_BUTTONS = 38

Hotbar.CurrentUseSlot = 0
Hotbar.CurrentUseHotbar = 0

Hotbar.DarkItemLabel = { r=245,g=229,b=0 }
Hotbar.LightItemLabel = { r=0,g=0,b=0 }

Hotbar.RecordingKey = false
Hotbar.RecordingSlot = 0
Hotbar.RecordingHotbar = 0

Hotbar.HANDLE_OFFSET = 12
Hotbar.BUTTON_SIZE = 50

Hotbar.TID_BINDING_CONFLICT_TITLE = 1079169
Hotbar.TID_BINDING_CONFLICT_BODY = 1079170
Hotbar.TID_BINDING_CONFLICT_QUESTION = 1094839
Hotbar.TID_YES = 1049717
Hotbar.TID_NO = 1049718

Hotbar.TID_TARGET = 1079927 -- "Target:"
Hotbar.TID_BINDING = 1079928 -- "Binding:"

Hotbar.TID_HOTBAR = 1079167 -- "Hotbar"
Hotbar.TID_SLOT = 1079168 -- "Slot"

function Hotbar.SetHotbarItem(hotbarId, slot)
	local itemIndex = slot
	local element = "Hotbar"..hotbarId.."Button"..slot	
	local hasItem = HotbarHasItem(hotbarId, itemIndex)
	
	--Debug.Print("Hotbar.SetHotbarItem: "..tostring(slot).." itemIndex: "..tostring(itemIndex).." hasItem: "..tostring(hasItem))
	
	-- bail out if this item doesnt exist in c++
	if( hasItem == false ) then
		return
	end
	
	HotbarSystem.RegisterAction(element, hotbarId, itemIndex, 0)
end

function Hotbar.ClearHotbarItem(hotbarId, slot, bUnregister)
	--Debug.PrintToDebugConsole(L"Hotbar::ClearHotbarSlot Slot: "..slot)
	
	local itemIndex = slot
	local element = "Hotbar"..hotbarId.."Button"..slot
	
	HotbarSystem.ClearActionIcon(element, hotbarId, itemIndex, 0, bUnregister)
end

function Hotbar.ReloadHotbar(hotbarId)
	--Debug.Print("Hotbar.ReloadHotbar")
	
	for slot = 1, Hotbar.NUM_BUTTONS do	
		Hotbar.SetHotbarItem(hotbarId,slot)
	end
end

function Hotbar.UseSlot(hotbarId, slot)
	local itemIndex = slot
		
	if( HotbarHasItem(hotbarId, itemIndex) ) then
		HotbarExecuteItem(hotbarId, itemIndex)
	end
end

-- OnInitialize Handler
function Hotbar.Initialize()
	this = SystemData.ActiveWindow.name
	local hotbarId = SystemData.DynamicWindowId
	
	SnapUtils.SnappableWindows[this] = true
	
	WindowSetId(this,hotbarId)
	
	WindowRegisterEventHandler( this, SystemData.Events.INTERFACE_KEY_RECORDED, "Hotbar.KeyRecorded" )
	WindowRegisterEventHandler( this, SystemData.Events.INTERFACE_KEY_CANCEL_RECORD, "Hotbar.KeyCancelRecord" )
	
	-- hotbars positions and sizes are tracked
	WindowUtils.RestoreWindowPosition(this,true)
	
	Hotbar.OnResizeEnd(this)
	
	-- set the hotbar labels based on the hotkey
	-- and initialize the slots
	for slot = 1, Hotbar.NUM_BUTTONS do
	   local HotkeyLabel = this.."Button"..slot.."Hotkey"
	   local key = SystemData.Hotbar[hotbarId].BindingDisplayStrings[slot]
	   LabelSetText(HotkeyLabel, key)
	   
	   Hotbar.ClearHotbarItem(hotbarId,slot,false)
	end	
	
	Hotbar.ReloadHotbar(hotbarId)
end

-- OnShutdown Handler
function Hotbar.Shutdown()
	--Debug.Print("Hotbar.Shutdown")
	
	this = SystemData.ActiveWindow.name
	hotbarId = WindowGetId(this)
	
	SnapUtils.SnappableWindows[this] = nil
	
	for slot = 1, Hotbar.NUM_BUTTONS do
		Hotbar.ClearHotbarItem(hotbarId,slot,true)
	end
	
	if( ItemProperties.GetCurrentWindow() == "Hotbar"..hotbarId ) then
		ItemProperties.ClearMouseOverItem()
	end
	
	-- save the position of dynamic bars
	WindowUtils.SaveWindowPosition(this)
end

-- OnLButtonDown Handler
function Hotbar.ItemLButtonDown()
	local slot = WindowGetId(SystemData.ActiveWindow.name)
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())
	
	--Debug.PrintToDebugConsole(L"Hotbar::OnLButtonDown(): Slot "..slot)

	local itemIndex = slot
		
	if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true and hotbarId ~= 0 )
	then
		if ( UserActionGetType( hotbarId, slot, 0 ) == SystemData.UserAction.TYPE_USE_ITEM ) then
			local objID = UserActionGetId(hotbarId, slot, 0)
			if objID
			and objID ~= 0 
			and (not WindowGetShowing("Hotbar"..hotbarId.."Button"..slot.."Disabled" ))
			then
				HandleSingleLeftClkTarget(objID)
				Hotbar.CurrentUseHotbar = nil
				Hotbar.CurrentUseSlot = nil
			end
		elseif( UserActionGetType( hotbarId, slot, 0 ) == SystemData.UserAction.TYPE_USE_OBJECTTYPE )
		then
			local specID = UserActionGetId(hotbarId, slot, 0)
			if specID 
			and specID ~= 0 
			then
				local objID = UserActionGetNextObjectId(specID)
				if objID 
				and objID ~= 0 
				and (not WindowGetShowing("Hotbar"..hotbarId.."Button"..slot.."Disabled" ))
				then
					HandleSingleLeftClkTarget(objID)
					Hotbar.CurrentUseHotbar = nil
					Hotbar.CurrentUseSlot = nil
				end
			end
		else
			if HotbarHasItem(hotbarId, itemIndex)
			and (not WindowGetShowing("Hotbar"..hotbarId.."Button"..slot.."Disabled" ))
			then
				Hotbar.CurrentUseHotbar = hotbarId
				Hotbar.CurrentUseSlot = slot
			end
		end
	else
		if HotbarHasItem(hotbarId, itemIndex) then
			DragSlotSetExistingActionMouseClickData(hotbarId,slot,0)
			
		    if (not WindowGetShowing("Hotbar"..hotbarId.."Button"..slot.."Disabled" )) then
				Hotbar.CurrentUseHotbar = hotbarId
				Hotbar.CurrentUseSlot = slot
			end
		end
	end
end

-- OnLButtonUP Handler
function Hotbar.ItemLButtonUp()
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())
	local slot = WindowGetId(SystemData.ActiveWindow.name)
	
	--Debug.PrintToDebugConsole(L"Hotbar::OnLButtonUp(): Slot = "..StringToWString(tostring(slot)))
	--Debug.PrintToDebugConsole(L"Hotbar::OnLButtonUp(): SystemData.DragItem.DragType =  "..StringToWString(tostring(SystemData.DragItem.DragType)))
	
	if( SystemData.DragItem.DragType ~= SystemData.DragItem.TYPE_NONE ) then		
	    local dropSuccess = DragSlotDropAction(hotbarId,slot,0)
	    
	    if( dropSuccess ) then
	        -- clear existing hotbar icon
	        Hotbar.ClearHotbarItem(hotbarId,slot,true)	   

            -- get the new action type for this item
	        local actionType = UserActionGetType(hotbarId,slot,0)

			-- update hotbar item in ui
	        Hotbar.SetHotbarItem(hotbarId,slot)
	        
	        -- open action window if applicable
		    local slotWindow = "Hotbar"..hotbarId.."Button"..slot
		    ActionEditWindow.OpenEditWindow(actionType,slotWindow,hotbarId,slot)	    
		end
	elseif( slot == Hotbar.CurrentUseSlot and hotbarId == Hotbar.CurrentUseHotbar ) then
		Hotbar.UseSlot(hotbarId, slot)
	end
end

function Hotbar.ContextMenuCallback(returnCode,param)
	if( param ~= nil ) then
		local bHandled = HotbarSystem.ContextMenuCallback(returnCode,param) 
		
		-- if it wasnt handled then check for hotbar specific options
		if( bHandled == false ) then	
			if( returnCode == HotbarSystem.ContextReturnCodes.CLEAR_ITEM ) then
				HotbarSystem.ClearActionIcon(param.SlotWindow, param.HotbarId, param.ItemIndex, param.SubIndex, true)
				HotbarClearItem(param.HotbarId,param.ItemIndex)
			elseif( returnCode == HotbarSystem.ContextReturnCodes.ASSIGN_KEY ) then
				WindowClearAnchors("AssignHotkeyInfo")
				WindowAddAnchor("AssignHotkeyInfo","topright","Hotbar"..param.HotbarId.."Button"..param.Slot,"bottomleft",0,-6)
				WindowSetShowing("AssignHotkeyInfo",true)
			
				Hotbar.RecordingSlot = param.Slot
				Hotbar.RecordingHotbar = param.HotbarId
				Hotbar.RecordingKey = true
				BroadcastEvent( SystemData.Events.INTERFACE_RECORD_KEY )
			elseif( returnCode == HotbarSystem.ContextReturnCodes.NEW_HOTBAR ) then
				HotbarSystem.SpawnNewHotbar()
			elseif( returnCode == HotbarSystem.ContextReturnCodes.DESTROY_HOTBAR ) then
                local okayButton = { textTid=UO_StandardDialog.TID_OKAY, callback=function() HotbarSystem.DestroyHotbar(param.HotbarId) end }
                local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL }
				local DestroyConfirmWindow = 
				{
				    windowName = "Hotbar"..param.HotbarId,
					titleTid = HotbarSystem.TID_DESTROY_HOTBAR,
					bodyTid = HotbarSystem.TID_DESTROY_CONFIRM,
					buttons = { okayButton, cancelButton }
				}
					
				UO_StandardDialog.CreateDialog(DestroyConfirmWindow)
			end	
		end						 
	end
end

function Hotbar.ItemRButtonUp()
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())
	local slot = WindowGetId(SystemData.ActiveWindow.name)
	local param = {Slot=slot,HotbarId=hotbarId}	
	
	--Debug.Print("Hotbar.ItemRButtonUp hotbarId: "..hotbarId.." slot: " .. slot)
	
	ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_NEW_HOTBAR,0,HotbarSystem.ContextReturnCodes.NEW_HOTBAR,param)
	
	if( hotbarId ~= HotbarSystem.STATIC_HOTBAR_ID ) then
		ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_DESTROY_HOTBAR,0,HotbarSystem.ContextReturnCodes.DESTROY_HOTBAR,param)
	end
	
	ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_ASSIGN_HOTKEY,0,HotbarSystem.ContextReturnCodes.ASSIGN_KEY,param)
	
	local itemIndex = slot
	
	if( HotbarHasItem(hotbarId,itemIndex) == true ) then
		local slotWindow = "Hotbar"..hotbarId.."Button"..slot
		HotbarSystem.CreateUserActionContextMenuOptions(hotbarId, itemIndex, 0, slotWindow)
	end
	
	ContextMenu.ActivateLuaContextMenu(Hotbar.ContextMenuCallback)
end

-- OnMouseOver Handler
function Hotbar.ItemMouseOver()
	local this = SystemData.ActiveWindow.name
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())
	local slot = WindowGetId(this)
	local itemIndex = slot
	
	local actionType = SystemData.UserAction.TYPE_NONE
	-- default id to the slot so it shows the item properties when there is only a binding
	local itemId = slot
	
	if( HotbarHasItem(hotbarId,itemIndex) == true ) then
	    actionType = UserActionGetType(hotbarId,itemIndex,0)
		local actionId = UserActionGetId(hotbarId,itemIndex,0)
		if( actionId ~= 0 ) then
			itemId = actionId
		end
		
		-- if its a macro reference, we need to dereference it
		if( actionType == SystemData.UserAction.TYPE_MACRO_REFERENCE ) then
			local macroId = UserActionGetId(hotbarId,itemIndex,0)
			local macroIndex = MacroSystemGetMacroIndexById(macroId)
			actionType = SystemData.UserAction.TYPE_MACRO
			hotbarId = SystemData.MacroSystem.STATIC_MACRO_ID -- - 1000 -- ???
			itemIndex = macroIndex
		end
	end
	
	local bindingText = L""
	if( SystemData.Hotbar[hotbarId] ~= nil) then
		bindingText = bindingText..SystemData.Hotbar[hotbarId].Bindings[slot]
		if bindingText ~= L"" then
			bindingText = GetStringFromTid(Hotbar.TID_BINDING)..L" "..bindingText -- "Binding:"..L" "..<KEY>
		end
	end

	if( actionType == SystemData.UserAction.TYPE_SKILL ) then
		bindingText = bindingText..L"\n"
		if bindingText == L"\n" then bindingText = L"" end
		bindingText = bindingText..SkillsWindow.FormatSkillValue(WindowData.SkillDynamicData[itemId].RealSkillValue)..L"%" -- Tack on the formatted skill level.
	end	
	
	if(actionType == SystemData.UserAction.TYPE_PLAYER_STATS) then
		bindingText = L""		
	end	
				
	local targetText = L""
	if ( ( UserActionHasTargetType(hotbarId,itemIndex,0) ) and ( SystemData.Settings.GameOptions.legacyTargeting == false ) ) then
		local targetType = UserActionGetTargetType(hotbarId,itemIndex,0)
		targetText = GetStringFromTid(Hotbar.TID_TARGET) -- "Target:"
		if targetType == 1 then -- Current
			targetText = targetText..L" "..GetStringFromTid(HotbarSystem.TID_CURRENT)
		elseif targetType == 2 then -- Cursor
			targetText = targetText..L" "..GetStringFromTid(HotbarSystem.TID_CURSOR)
		elseif targetType == 3 then -- Self
			targetText = targetText..L" "..GetStringFromTid(HotbarSystem.TID_SELF)
		elseif targetType == 4 then -- Object Id
			targetText = targetText..L" "..GetStringFromTid(HotbarSystem.TID_OBJECT_ID)
		else
			targetText = L"" -- Bad case; forget about it.
		end
	end
	
	local itemData = { windowName = "Hotbar"..hotbarId,
						itemId = itemId,
						itemType = WindowData.ItemProperties.TYPE_ACTION,
						actionType = actionType,
						itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
						binding = bindingText, -- As defined above
						myTarget = targetText, }

	ItemProperties.SetActiveItem(itemData)
	
end

function Hotbar.KeyRecorded()
	if( Hotbar.RecordingKey == true ) then
		Hotbar.RecordingKey = false
		WindowSetShowing("AssignHotkeyInfo",false)
		
		if( SystemData.BindingConflictType ~= SystemData.BindType.BINDTYPE_NONE )then
			body = GetStringFromTid( Hotbar.TID_BINDING_CONFLICT_BODY )..L"\n\n"..HotbarSystem.GetKeyName(SystemData.BindingConflictHotbarId, SystemData.BindingConflictItemIndex, SystemData.BindingConflictType)..L"\n\n"..GetStringFromTid( Hotbar.TID_BINDING_CONFLICT_QUESTION )
			
			local yesButton = { textTid = Hotbar.TID_YES,
								callback =	function()
											HotbarSystem.ReplaceKey(
												SystemData.BindingConflictHotbarId, SystemData.BindingConflictItemIndex, SystemData.BindingConflictType,
												Hotbar.RecordingHotbar, Hotbar.RecordingSlot, SystemData.BindType.BINDTYPE_HOTBAR,
												SystemData.RecordedKey, SystemData.RecordedKeySmallDisplay)
											end
							  }
			local noButton = { textTid = Hotbar.TID_NO }
			local windowData = 
			{
				windowName = "Hotbar", 
				titleTid = Hotbar.TID_BINDING_CONFLICT_TITLE, 
				body = body, 
				buttons = { yesButton, noButton }
			}
			UO_StandardDialog.CreateDialog( windowData )
	    else
            SystemData.Hotbar[Hotbar.RecordingHotbar].Bindings[Hotbar.RecordingSlot] = SystemData.RecordedKey
	        SystemData.Hotbar[Hotbar.RecordingHotbar].BindingDisplayStrings[Hotbar.RecordingSlot] = SystemData.RecordedKeySmallDisplay
        		
	        HotbarUpdateBinding(Hotbar.RecordingHotbar,Hotbar.RecordingSlot,SystemData.RecordedKey)
	        local HotkeyLabel = "Hotbar"..Hotbar.RecordingHotbar.."Button"..Hotbar.RecordingSlot.."Hotkey"
	        LabelSetText(HotkeyLabel, SystemData.RecordedKeySmallDisplay)
		end
	end
end

function Hotbar.KeyCancelRecord()
	if( Hotbar.RecordingKey == true ) then
		Hotbar.RecordingKey = false
		WindowSetShowing("AssignHotkeyInfo",false)
	end
end

function Hotbar.OnResizeBegin()
	this = WindowUtils.GetActiveDialog()
	local width, height = WindowGetDimensions(this)
	local widthMin = 70
	local heightMin = 70
	if (width >= height) then
		heightMin = 50
	else
		widthMin = 50
	end
    WindowUtils.BeginResize( this, "topleft", widthMin, heightMin, false, Hotbar.OnResizeEnd)
end

function Hotbar.OnResizeEnd(curWindow)
	local width, height = WindowGetDimensions(curWindow)
	
	--Debug.Print("Hotbar.OnResizeEnd: "..curWindow.." width: "..width..", height: "..height)
	
	if( width >= height ) then
		-- show the correct handle
		WindowSetShowing(curWindow.."HorizHandle",true)
		WindowSetShowing(curWindow.."VertHandle",false)
		
		-- anchor the first button to the handle
		WindowClearAnchors(curWindow.."Button"..1)
		WindowAddAnchor(curWindow.."Button"..1,"topright",curWindow.."HorizHandle","topleft",0,0)
		
		-- anchor the rest of the buttons to the previous one
		-- and hide the ones that are outside the window
		for slot=2, Hotbar.NUM_BUTTONS do
			local button = curWindow.."Button"..slot
			if( (slot * Hotbar.BUTTON_SIZE) > (width - Hotbar.HANDLE_OFFSET) ) then
				WindowSetShowing(button, false)
			else
				local relativeTo = curWindow.."Button"..(slot-1)
				WindowClearAnchors(button)
				WindowAddAnchor(button,"topright",relativeTo,"topleft",0,0)			
				WindowSetShowing(button, true)
			end
		end
		
		local numVisibleButtons = math.min(math.floor((width-Hotbar.HANDLE_OFFSET)/Hotbar.BUTTON_SIZE),Hotbar.NUM_BUTTONS)
		local newHeight = Hotbar.BUTTON_SIZE
		local newWidth = math.min((numVisibleButtons * Hotbar.BUTTON_SIZE) + Hotbar.HANDLE_OFFSET, (Hotbar.BUTTON_SIZE * Hotbar.NUM_BUTTONS) + Hotbar.HANDLE_OFFSET)

		WindowSetDimensions(curWindow,newWidth,newHeight)
	else
		-- show the correct handle
		WindowSetShowing(curWindow.."HorizHandle",false)
		WindowSetShowing(curWindow.."VertHandle",true)
		
		-- anchor the first button to the handle
		WindowClearAnchors(curWindow.."Button"..1)
		WindowAddAnchor(curWindow.."Button"..1,"bottomright",curWindow.."VertHandle","topright",0,0)
		
		-- anchor the rest of the buttons to the previous one
		-- and hide the ones that are outside the window
		for slot=2, Hotbar.NUM_BUTTONS do
			local button = curWindow.."Button"..slot
			if( (slot * Hotbar.BUTTON_SIZE) > (height - Hotbar.HANDLE_OFFSET) ) then
				WindowSetShowing(button, false)
			else
				local relativeTo = curWindow.."Button"..(slot-1)
				WindowClearAnchors(button)
				WindowAddAnchor(button,"bottomleft",relativeTo,"topleft",0,0)			
				WindowSetShowing(button, true)
			end
		end

		local numVisibleButtons = math.floor((height-Hotbar.HANDLE_OFFSET)/Hotbar.BUTTON_SIZE)
		local newHeight = math.min((numVisibleButtons * Hotbar.BUTTON_SIZE) + Hotbar.HANDLE_OFFSET, (Hotbar.BUTTON_SIZE * Hotbar.NUM_BUTTONS) + Hotbar.HANDLE_OFFSET)
		local newWidth = Hotbar.BUTTON_SIZE
		WindowSetDimensions(curWindow,newWidth,newHeight)		
	end
end

function Hotbar.OnHandleLButtonDown(flags, x, y)
    hotbarWindow = WindowGetParent(SystemData.ActiveWindow.name)
    SnapUtils.StartWindowSnap( hotbarWindow )
end
