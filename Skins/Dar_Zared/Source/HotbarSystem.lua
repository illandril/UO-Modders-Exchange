----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

HotbarSystem = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
HotbarSystem.RegisteredSpellIcons = {}

HotbarSystem.CurRequestInfoItem = nil

HotbarSystem.HighlightSpellIconInput = {}
HotbarSystem.HighlightSpellIconInput.highlightSpellID = 0
HotbarSystem.HighlightSpellIconInput.highlightSpellEnabled = 0

HotbarSystem.ContextReturnCodes = {}
HotbarSystem.ContextReturnCodes.CLEAR_ITEM = 1
HotbarSystem.ContextReturnCodes.ASSIGN_KEY = 2
HotbarSystem.ContextReturnCodes.NEW_HOTBAR = 3
HotbarSystem.ContextReturnCodes.DESTROY_HOTBAR = 4
HotbarSystem.ContextReturnCodes.TARGET_SELF = 5
HotbarSystem.ContextReturnCodes.TARGET_CURRENT = 6
HotbarSystem.ContextReturnCodes.TARGET_CURSOR = 7
HotbarSystem.ContextReturnCodes.TARGET_OBJECT_ID = 8
HotbarSystem.ContextReturnCodes.EDIT_ITEM = 9
HotbarSystem.ContextReturnCodes.ENABLE_REPEAT = 10
HotbarSystem.ContextReturnCodes.DISABLE_REPEAT = 11

HotbarSystem.TID_CLEAR_ITEM = 1077858
HotbarSystem.TID_ASSIGN_HOTKEY = 1078019
HotbarSystem.TID_NEW_HOTBAR = 1078020
HotbarSystem.TID_DESTROY_HOTBAR = 1078026
HotbarSystem.TID_DESTROY_CONFIRM = 1078027
HotbarSystem.TID_CURSOR = 1078071
HotbarSystem.TID_SELF = 1078072
HotbarSystem.TID_CURRENT = 1078073
HotbarSystem.TID_OBJECT_ID = 1094772
HotbarSystem.TID_TARGET = 1078074
HotbarSystem.TID_EDIT_ITEM = 1078196
HotbarSystem.TID_ENABLE_REPEAT = 1079431 -- "Enable Repeating"
HotbarSystem.TID_DISABLE_REPEAT = 1079433 -- "Disable Repeating"

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

HotbarSystem.STATIC_HOTBAR_ID = 1
HotbarSystem.MAX_HOTBAR_ID = 5000

HotbarSystem.TID_ASSIGN_HOTKEY_DESC = 1078096
HotbarSystem.TID_REQUEST_TARGET_ID_DESC = 1094788

HotbarSystem.BANDAGE_OBJTYPE = 3617
HotbarSystem.BANDAGE_SECOND_OBJTYPE = 3817

-- TEMP VARIABLES
HotbarSystem.OffsetX = 945
HotbarSystem.OffsetY = 910
HotbarSystem.OffsetIncrement = -60

HotbarSystem.BandageDelayTime = 0 -- Starts off at 0 since no bandages have been used yet
HotbarSystem.BandageDelayDiff = 1 -- Counts down the timer with a 1 second counter
HotbarSystem.CurrentDelta = 0	  -- How much time has passed since the previous update time
HotbarSystem.BandageSlots = {}


HotbarSystem.RegisteredGenericObjectType = {}
HotbarSystem.RegisteredObjects = {}
HotbarSystem.ReferencedTextures = {}
HotbarSystem.ObjectSlots = {}
HotbarSystem.ObjectSlotsSize = {}
HotbarSystem.MacroReferenceSlots = {}
HotbarSystem.PlayerStatsElements = {}

HotbarSystem.DarkItemLabel = { r=245,g=229,b=0 }
HotbarSystem.LightItemLabel = { r=0,g=0,b=0 }

HotbarSystem.WARNINGLEVEL = 10

HotbarSystem.TargetTypeTintColors = {
    [SystemData.Hotbar.TargetType.TARGETTYPE_SELF] = { 0,0,255 },
    [SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT] = { 255,0,0 },
    [SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR] = { 0,255,0 },
    [SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID] = { 0,0,0 }
}

function HotbarSystem.Initialize()
	-- setup the assign key description window
	CreateWindow("AssignHotkeyInfo",false)
	LabelSetText("AssignHotkeyInfoText",GetStringFromTid(HotbarSystem.TID_ASSIGN_HOTKEY_DESC))
	local x, y = LabelGetTextDimensions( "AssignHotkeyInfoText" )
	WindowSetDimensions("AssignHotkeyInfo",x+16,y+16)
	
	-- setup the "Request Target ID" description window
	CreateWindow("RequestTargetIdInfo",false)
	LabelSetText("RequestTargetIdInfoText",GetStringFromTid(HotbarSystem.TID_REQUEST_TARGET_ID_DESC))
	local x, y = LabelGetTextDimensions( "RequestTargetIdInfoText" )
	WindowSetDimensions("RequestTargetIdInfo",x+16,y+16)
		
	-- create a hotbar for each id in the list
	for index, hotbarId in pairs(SystemData.Hotbar.HotbarIds) do
		HotbarSystem.SpawnNewHotbar(hotbarId)
	end
	
	--Used to show the stats when players drag their stats into the hotbar
	RegisterWindowData(WindowData.PlayerStatus.Type, 0)
	WindowRegisterEventHandler( "Root", WindowData.PlayerStatus.Event, "HotbarSystem.UpdatePlayerStat")
	
	WindowRegisterEventHandler( "Root", WindowData.ObjectInfo.Event, "HotbarSystem.UpdateItemSlot")	
	WindowRegisterEventHandler( "Root", SystemData.Events.MACRO_CHANGED, "HotbarSystem.UpdateMacroReferenceSlot")
	WindowRegisterEventHandler( "Root", SystemData.Events.HOTBAR_HIGHLIGHT_SPELL_ICON, "HotbarSystem.HighlightSpellIcon")
	WindowRegisterEventHandler( "Root", SystemData.Events.HOTBAR_UNHIGHLIGHT_SPELL_ICON, "HotbarSystem.UnhighlightSpellIcon")
	WindowRegisterEventHandler( "Root", WindowData.ObjectTypeQuantity.Event, "HotbarSystem.UpdateQuantity")
	WindowRegisterEventHandler( "Root", SystemData.Events.OBJECT_DELAY_TIME, "HotbarSystem.UpdateDelayTime")
	WindowRegisterEventHandler( "Root", SystemData.Events.UPDATE_ACTION_ITEM, "HotbarSystem.HandleUpdateActionItem")
end

function HotbarSystem.Shutdown()
	UnregisterWindowData(WindowData.PlayerStatus.Type, 0)
end

function HotbarSystem.DestroyHotbar(hotbarId)
	for i=1,12 do
		HotbarSystem.UnbindKey(hotbarId, i, SystemData.BindType.BINDTYPE_HOTBAR)
	end

	HotbarUnregister(hotbarId)

	DestroyWindow("Hotbar"..hotbarId)
	-- We dont want to keep track of window positions for hotbars that are permanently destroyed
	WindowUtils.ClearWindowPosition("Hotbar"..hotbarId)
end

function HotbarSystem.SpawnNewHotbar(hotbarId)
	-- If the hotbarId is passed in, this thing is already registered in code (from loading UserSettings)
	local setPosition = false
	if( hotbarId == nil ) then
		hotbarId = HotbarSystem.GetNextHotbarId()
		HotbarRegisterNew(hotbarId)
		setPosition = true
	end
	
	--Debug.Print("HotbarSystem.SpawnNewHotbar: "..hotbarId)
	
	SystemData.DynamicWindowId = hotbarId
	CreateWindowFromTemplate("Hotbar"..hotbarId, "Hotbar", "Root")
	
	-- dynamic hotbars need to have their position generated when created for the first time
	if( setPosition == true ) then
		if( hotbarId ~= HotbarSystem.STATIC_HOTBAR_ID ) then
			WindowClearAnchors("Hotbar"..hotbarId)
			WindowAddAnchor("Hotbar"..hotbarId, "topleft", "Root", "topleft", HotbarSystem.OffsetX, HotbarSystem.OffsetY)
			HotbarSystem.OffsetY = HotbarSystem.OffsetY + HotbarSystem.OffsetIncrement	
			-- when we get to the top, start over at the bottom
			if( HotbarSystem.OffsetY < 0 ) then
			    HotbarSystem.OffsetY = 910
			end
		end
	end
end

function HotbarSystem.GetNextHotbarId()
	-- find the next available id
	local newHotbarId = 2
	
	while newHotbarId ~= HotbarSystem.MAX_HOTBAR_ID do
		local found = false
		for index, hotbarId in pairs(SystemData.Hotbar.HotbarIds) do
			if( hotbarId == newHotbarId ) then
				found = true
			end
		end
		
		if( found ~= true ) then
			break
		end
		
		newHotbarId = newHotbarId + 1
	end
	
	return newHotbarId
end

function HotbarSystem.RegisterAction(element, hotbarId, itemIndex, subIndex)
	local type = UserActionGetType(hotbarId, itemIndex, subIndex)
	local id = UserActionGetId(hotbarId, itemIndex, subIndex)
	local iconId = UserActionGetIconId(hotbarId, itemIndex, subIndex)
	local disabled = not UserActionIsTargetModeCompat(hotbarId, itemIndex, subIndex)
	
    if( type == SystemData.UserAction.TYPE_USE_ITEM or
	    type == SystemData.UserAction.TYPE_USE_OBJECTTYPE) then    
		if( HotbarSystem.ObjectSlots[id] == nil ) then
			HotbarSystem.ObjectSlots[id] = {}
			HotbarSystem.ObjectSlotsSize[id] = 0
		end
		HotbarSystem.ObjectSlotsSize[id] = HotbarSystem.ObjectSlotsSize[id] + 1
		HotbarSystem.ObjectSlots[id][element] = {type=type,iconId=iconId}
    elseif( type == SystemData.UserAction.TYPE_MACRO_REFERENCE ) then
		if(	HotbarSystem.MacroReferenceSlots[id] == nil ) then
			HotbarSystem.MacroReferenceSlots[id] = {}
		end
		HotbarSystem.MacroReferenceSlots[id][element] = {hotbarId=hotbarId, itemIndex=itemIndex, subIndex=subIndex}
		
		local macroId = UserActionGetId(hotbarId,itemIndex,0)
		local macroIndex = MacroSystemGetMacroIndexById(macroId)
		disabled = not UserActionIsTargetModeCompat(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex, 0)
	elseif( type == SystemData.UserAction.TYPE_PLAYER_STATS ) then
		HotbarSystem.PlayerStatsElements[element] = id
	end
	
	HotbarSystem.UpdateActionButton(element, type, id, iconId, disabled )
	HotbarSystem.UpdateTargetTypeIndicator(element,hotbarId,itemIndex,subIndex)
end

function HotbarSystem.UpdateActionButton(element, type, id, iconId, disabled )
	local bDisabled = disabled

	local elementIcon = element.."SquareIcon"
	local elementHotkey = element.."Hotkey"
	
	--Debug.Print("UpdateActionButton: element: "..tostring(element).." actionType: "..tostring(actionType).." actionId: "..tostring(actionId).." iconId: "..tostring(iconId).." isActive: "..tostring(isActive))
	
	-- use item is a crazy special case so handle that first
	if( type == SystemData.UserAction.TYPE_USE_ITEM or
	    type == SystemData.UserAction.TYPE_USE_OBJECTTYPE) then

        local item = nil
        local playerHasItem = false
        
		--Debug.Print("Step 1: "..tostring(type))
        
        if( type == SystemData.UserAction.TYPE_USE_ITEM ) then
		    -- register for this object if its not already registered
		    if( HotbarSystem.RegisteredObjects[element] == nil ) then
			    RegisterWindowData(WindowData.ObjectInfo.Type, id)
			    HotbarSystem.RegisteredObjects[element] = id		
		    end	
		    
	        item = WindowData.ObjectInfo[id]
	        playerHasItem = DoesPlayerHaveItem(id)	
		elseif( type == SystemData.UserAction.TYPE_USE_OBJECTTYPE ) then
	        -- register for this object if its not already registered
	        if( HotbarSystem.RegisteredGenericObjectType[element] == nil ) then
	        --Debug.Print("REGISTER for OBJECTYPE "..id)
		        RegisterWindowData(WindowData.ObjectTypeQuantity.Type, id)
		        HotbarSystem.RegisteredGenericObjectType[element] = id
	        end	

		    item = WindowData.ObjectTypeQuantity[id]
		    playerHasItem = (item~= nil and item.quantity >= 1) 	        
		end
	
		--Debug.Print("Step 2: "..tostring(playerHasItem))
		if( playerHasItem ) then
			--Debug.Print("Step 3: "..tostring(item.name))	
			if( item ~= nil ) then
			    if( item.name ~= nil and item.quantity >= 1) then
					--Debug.Print("Step 4: UpdateItemIcon")
                    EquipmentData.UpdateItemIcon(elementIcon, item)
			    end
    			
			    if( item.quantity ~= nil) then
				    LabelSetText(element.."Quantity",L""..item.quantity)
			    end
			end
			
			LabelSetTextColor(elementHotkey,HotbarSystem.DarkItemLabel.r,HotbarSystem.DarkItemLabel.g,HotbarSystem.DarkItemLabel.b)
		-- If its not in your pack anymore just use the icon and disable it
		elseif( iconId ~= 0 and iconId ~= nil ) then
			name, x, y, scale, newWidth, newHeight = RequestTileArt(iconId,50,50)
			DynamicImageSetTextureDimensions(elementIcon, newWidth, newHeight)
			WindowSetDimensions(elementIcon, newWidth, newHeight)
			DynamicImageSetTexture(elementIcon, name, x, y )
			DynamicImageSetTextureScale(elementIcon, scale)
			
			LabelSetTextColor(elementHotkey,HotbarSystem.DarkItemLabel.r,HotbarSystem.DarkItemLabel.g,HotbarSystem.DarkItemLabel.b)
			
			HotbarSystem.ReferencedTextures[element] = iconId	
			
			bDisabled = true
		end
	elseif (type == SystemData.UserAction.TYPE_WEAPON_ABILITY) then
		EquipmentData.RegisterWeaponAbilitySlot(element,id)
		LabelSetTextColor(elementHotkey,HotbarSystem.LightItemLabel.r,HotbarSystem.LightItemLabel.g,HotbarSystem.LightItemLabel.b)
	else
		HotbarSystem.SetHotbarIcon(element, iconId)
		HotbarSystem.RegisterSpellIcon(element,id)
	end
	
	if( bDisabled == true ) then
		WindowSetShowing(element.."Disabled",true)
		ButtonSetDisabledFlag(element,true)
	else	
		WindowSetShowing(element.."Disabled",false)
		ButtonSetDisabledFlag(element,false)
	end
	
	--Need to update label here in case iconId changes
	if (type == SystemData.UserAction.TYPE_PLAYER_STATS) then
		HotbarSystem.UpdatePlayerStatLabel(element, id)
	end
end

function HotbarSystem.UpdateTargetTypeIndicator(element,hotbarId,itemIndex,subIndex)
    --Debug.Print("UpdateTargetTypeIndicator: "..tostring(element)..", "..tostring(hotbarId)..", "..tostring(itemIndex)..", "..tostring(subIndex))
	if( UserActionHasTargetType(hotbarId,itemIndex,subIndex) and
	        SystemData.Settings.GameOptions.legacyTargeting == false ) then
	    WindowSetShowing(element.."TargetType",true)
	    local targetType = UserActionGetTargetType(hotbarId,itemIndex,subIndex)
	    local tintColor = HotbarSystem.TargetTypeTintColors[targetType]
	    --Debug.Print("targettype: "..tostring(targetType)..", "..tostring(texCoords[0])..", "..texCoords[1])
	    WindowSetTintColor(element.."TargetType",tintColor[1],tintColor[2],tintColor[3])
	else
	    WindowSetShowing(element.."TargetType",false)
	end
end

function HotbarSystem.ClearActionIcon(element, hotbarId, itemIndex, subIndex, bUnregister)
	local elementIcon = element.."SquareIcon"
	local elementHotkey = element.."Hotkey"
	
	--Debug.Print("HotbarSystem.ClearActionIcon: "..tostring(element).." hotbarId: "..tostring(hotbarId).." itemIndex: "..tostring(itemIndex).." subIndex: "..tostring(subIndex))
	
	DynamicImageSetTextureDimensions(elementIcon, 50, 50)
	WindowSetDimensions(elementIcon, 50, 50)
	DynamicImageSetTexture(elementIcon, "", 0, 0 )
	DynamicImageSetTextureScale(elementIcon, 0.78 )	
	WindowSetTintColor(elementIcon,255,255,255)
	WindowSetAlpha(elementIcon,1.0)
	
    LabelSetText(element.."Quantity",L"")
		
	LabelSetTextColor(elementHotkey,HotbarSystem.DarkItemLabel.r,HotbarSystem.DarkItemLabel.g,HotbarSystem.DarkItemLabel.b)
	
	WindowSetShowing(element.."Disabled",false)
	ButtonSetDisabledFlag(element,false)
	
	WindowSetShowing(element.."TargetType",false)
	
	--Clear the label text when the players stats icon is cleared
	LabelSetText(element.."Stats", L"")
	LabelSetText(element.."StatsTop", L"")
	LabelSetText(element.."StatsBottom",L"")
	HotbarSystem.PlayerStatsElements[element] = nil
	
	if( bUnregister == true ) then
		-- clear out the macro reference if necesary
		for itemId, elements in pairs(HotbarSystem.MacroReferenceSlots) do
			elements[element] = nil
			if( table.getn(elements) == 0 ) then
				elements = nil
			end			
		end

		-- clear the weapon ability (this does nothing if its not a weapon ability)
		EquipmentData.UnregisterWeaponAbilitySlot(element)
		-- clear the spell registration (this does nothing if it is not a spell
		HotbarSystem.UnregisterSpellIcon(element)
		
		-- unregister the object info for this slot if necesary
		if( HotbarSystem.RegisteredObjects[element] ~= nil ) then
			local itemId = HotbarSystem.RegisteredObjects[element]
			--Debug.Print("UNREGISTERING HOTBAR OBJECT: "..tostring(hotbarId)..", "..tostring(itemIndex).." itemId: "..tostring(itemId))
			HotbarSystem.ObjectSlots[itemId][element] = nil
			if( HotbarSystem.ObjectSlots[itemId] ~= nil) then
				if( HotbarSystem.ObjectSlotsSize[itemId] == 1 ) then
					HotbarSystem.ObjectSlots[itemId] = nil
				end
				HotbarSystem.ObjectSlotsSize[itemId] = HotbarSystem.ObjectSlotsSize[itemId] - 1
			end			
			
			UnregisterWindowData(WindowData.ObjectInfo.Type,HotbarSystem.RegisteredObjects[element])
			HotbarSystem.RegisteredObjects[element] = nil
		end
		
		-- unregister the generic object type info for this slot if necesary
		if( HotbarSystem.RegisteredGenericObjectType[element] ~= nil) then
			local itemId = HotbarSystem.RegisteredGenericObjectType[element]
			--Debug.Print("UNREGISTERING HOTBAR OBJECT: "..tostring(hotbarId)..", "..tostring(itemIndex).." itemId: "..tostring(itemId).." element "..element)
			
			HotbarSystem.UpdateQuantityForOneSlot(element)
			HotbarSystem.ObjectSlots[itemId][element] = nil
			if( HotbarSystem.ObjectSlots[itemId] ~= nil) then
				if (HotbarSystem.ObjectSlotsSize[itemId] == 1 ) then
					HotbarSystem.ObjectSlots[itemId] = nil
				end
				HotbarSystem.ObjectSlotsSize[itemId] = HotbarSystem.ObjectSlotsSize[itemId] - 1
			end		
			
			
			UnregisterWindowData(WindowData.ObjectTypeQuantity.Type,HotbarSystem.RegisteredGenericObjectType[element])
			HotbarSystem.RegisteredGenericObjectType[element] = nil
		end
		
		if( HotbarSystem.ReferencedTextures[element] ~= nil ) then
			ReleaseTileArt(HotbarSystem.ReferencedTextures[element])
			HotbarSystem.ReferencedTextures[element] = nil
		end
	end
end

function HotbarSystem.UpdateItemSlot()
	local id = WindowData.UpdateInstanceId
	
	if( HotbarSystem.ObjectSlots[id] ~= nil ) then
		-- if the player has this item then enable it
		if( DoesPlayerHaveItem(id) ) then
			for element, itemLoc in pairs(HotbarSystem.ObjectSlots[id]) do
				WindowSetShowing(element.."Disabled",false)
				ButtonSetDisabledFlag(element,false)
					
				local item = WindowData.ObjectInfo[id]	
				
				-- also update the image if it isnt set yet
				local elementIcon = element.."SquareIcon"
				-- always update the hue
				DynamicImageSetCustomShader(elementIcon, "UOSpriteUIShader", {item.hueId})
				WindowSetTintColor(elementIcon,item.hue.r,item.hue.g,item.hue.b)
				WindowSetAlpha(elementIcon,item.hue.a/255)									
				if( UserActionGetIconId(itemLoc.hotbarId,itemLoc.itemIndex,itemLoc.subIndex) == 0 ) then
                    EquipmentData.UpdateItemIcon(elementIcon, item)
				end			
			end
		-- if this item has left the players backpack then disable it
		else
			for element, itemLoc in pairs(HotbarSystem.ObjectSlots[id]) do
				WindowSetShowing(element.."Disabled",true)
				ButtonSetDisabledFlag(element,true)
			end
		end
	end
end

function HotbarSystem.SetHotbarIcon(element, iconId)
	local elementIcon = element.."SquareIcon"
	local elementHotkey = element.."Hotkey"

	if( iconId ~= nil ) then
		local texture, x, y = GetIconData( iconId )
		DynamicImageSetTextureDimensions(elementIcon, 50, 50)
		WindowSetDimensions(elementIcon, 50, 50)
		DynamicImageSetTexture( elementIcon, texture, x, y )		
		DynamicImageSetTextureScale(elementIcon, 0.78 )
		
		LabelSetTextColor(elementHotkey,HotbarSystem.LightItemLabel.r,HotbarSystem.LightItemLabel.g,HotbarSystem.LightItemLabel.b)
	end
end

function HotbarSystem.UpdatePlayerStatLabel(element, id)
	local statsName = WStringToString(WindowData.PlayerStatsDataCSV[id].name)
	
	if( WindowData.PlayerStatsDataCSV[id].hasDivider  == true) then
		local curVal = statsName

		local topValue = WindowData.PlayerStatus[curVal]
		local bottomValue = WindowData.PlayerStatus["Max"..statsName]
		if( (statsName == "Health") or (statsName == "Stamina") or (statsName == "Mana") ) then
			curVal = "Current"..statsName
			topValue = WindowData.PlayerStatus[curVal]
			if( topValue <= HotbarSystem.WARNINGLEVEL ) then
				HotbarSystem.SetHotbarIcon(element, WindowData.PlayerStatsDataCSV[id].warningIconId)
			else
				HotbarSystem.SetHotbarIcon(element, WindowData.PlayerStatsDataCSV[id].iconId)
			end	
		end
		
		if( (statsName == "Weight") ) then
			if (topValue >= (bottomValue - HotbarSystem.WARNINGLEVEL) ) then
				HotbarSystem.SetHotbarIcon(element, WindowData.PlayerStatsDataCSV[id].warningIconId)	
			else
				HotbarSystem.SetHotbarIcon(element, WindowData.PlayerStatsDataCSV[id].iconId)
			end
		end
		
		LabelSetText(element.."StatsTop", StringToWString(tostring(topValue))  )
		LabelSetText(element.."StatsBottom", StringToWString(tostring(bottomValue)) )
	else
		local labelString = StringToWString(tostring(WindowData.PlayerStatus[statsName]))
		
		if(statsName == "Damage") then
			labelString = StringToWString(tostring(WindowData.PlayerStatus[statsName]).."-"..tostring(WindowData.PlayerStatus["Max"..statsName])) 
		end
		
		if(statsName == "TithingPoints")then 
			if (WindowData.PlayerStatus[statsName] >= 10000 )then				
				local tithConcat = WindowData.PlayerStatus[statsName] / 1000
				tithConcat = math.floor(tithConcat)
				labelString = StringToWString(tostring(tithConcat).."K")				
			end				
		end		
		LabelSetText(element.."Stats", labelString )
	end
end

--Update the players stats on the hotbar when the player stats updates
function HotbarSystem.UpdatePlayerStat()
	local element
	local id
	for element, id in pairs (HotbarSystem.PlayerStatsElements) do
		HotbarSystem.UpdatePlayerStatLabel(element, id)
	end
end

function HotbarSystem.UpdateQuantityForOneSlot(element)
	local elementIcon = element.."SquareIcon"
	LabelSetText(element.."Quantity",L"")
end

function HotbarSystem.UpdateQuantity()
	local id = WindowData.UpdateInstanceId
	local quantity = 0
	
	if( HotbarSystem.ObjectSlots[id] ~= nil ) then
		local item = WindowData.ObjectTypeQuantity[id]
		
		if( item ~= nil ) then
			quantity = item.quantity
		end

		for element, itemLoc in pairs(HotbarSystem.ObjectSlots[id]) do
			local elementIcon = element.."SquareIcon"
			if(item ~= nil and quantity > 0) then
				WindowSetShowing(element.."Disabled",false)
				ButtonSetDisabledFlag(element,false)
				
                EquipmentData.UpdateItemIcon(elementIcon, item)
			    
				LabelSetText(element.."Quantity",L""..quantity)	
			else
				WindowSetShowing(element.."Disabled",true)
				ButtonSetDisabledFlag(element,true)
				LabelSetText(element.."Quantity",L"")
			end
			
		end
	end
end

function HotbarSystem.UpdateDelayTime()
	for id, element in pairs(HotbarSystem.ObjectSlots) do
		for curElement, itemLoc in pairs(HotbarSystem.ObjectSlots[id]) do
			local objectType, hue = UserActionUseObjectTypeGetObjectTypeHue(id)
			if(objectType == HotbarSystem.BANDAGE_OBJTYPE or objectType == HotbarSystem.BANDAGE_SECOND_OBJTYPE) then
				HotbarSystem.BandageDelayTime = SystemData.Hotbar.BandageDelay.time
				if( HotbarSystem.BandageSlots[id] == nil ) then
					HotbarSystem.BandageSlots[id] = {}
				end
				 HotbarSystem.BandageSlots[id][curElement] = curElement
				LabelSetText(curElement.."BandageTime", HotbarSystem.BandageDelayTime..L"s")
				BuffDebuff.CreateBandageBuff( HotbarSystem.BandageDelayTime..L"s" )
			end
		end
	end
end

function HotbarSystem.HandleUpdateActionItem()
	--Debug.Print("OOO: " .. tostring(SystemData.UpdateActionItem.hotbarId)..", "..tostring(SystemData.UpdateActionItem.itemIndex))
	if( SystemData.UpdateActionItem.hotbarId == SystemData.MacroSystem.STATIC_MACRO_ID ) then
		MacroEditWindow.UpdateMacroActionList("ActionEditMacro", SystemData.UpdateActionItem.hotbarId, SystemData.UpdateActionItem.itemIndex)
	else
		Hotbar.ClearHotbarItem(SystemData.UpdateActionItem.hotbarId,SystemData.UpdateActionItem.itemIndex,true)
		Hotbar.SetHotbarItem(SystemData.UpdateActionItem.hotbarId,SystemData.UpdateActionItem.itemIndex)
	end
end

function HotbarSystem.Update(timePassed)
	if( HotbarSystem.BandageDelayTime > 0 ) then
		HotbarSystem.CurrentDelta = HotbarSystem.CurrentDelta + timePassed
		if(HotbarSystem.CurrentDelta >= HotbarSystem.BandageDelayDiff) then
			HotbarSystem.BandageDelayTime = HotbarSystem.BandageDelayTime - HotbarSystem.BandageDelayDiff
			for id, nextElement in pairs (HotbarSystem.BandageSlots) do
				for element, curElement in pairs(HotbarSystem.BandageSlots[id]) do
					LabelSetText(curElement.."BandageTime", HotbarSystem.BandageDelayTime..L"s")
					BuffDebuff.UpdateBandageCounter(HotbarSystem.BandageDelayTime..L"s")
					if( HotbarSystem.BandageDelayTime <= 0 ) then
						HotbarSystem.BandageSlots[id][element] = nil
						LabelSetText(curElement.."BandageTime", L"")
						Debug.Print(L"Remove Heal Buff")
						local buffId = 1
						BuffDebuff.HandleBuffRemoved( buffId )
					end
				end
			end
			HotbarSystem.CurrentDelta = 0
		end
	end
end

function HotbarSystem.UpdateMacroReferenceSlot(macroIndex)
	local id = WindowData.UpdateInstanceId
	if(macroIndex ~= nil) then
		id = macroIndex
	end
	
	if( HotbarSystem.MacroReferenceSlots[id] ~= nil ) then
		local macroIndex = MacroSystemGetMacroIndexById(id)
		
		for element, itemLoc in pairs(HotbarSystem.MacroReferenceSlots[id]) do
			-- if macroIndex is 0 then the macro was deleted
			if( macroIndex == 0 ) then
				HotbarSystem.ClearActionIcon(element, itemLoc.hotbarId, itemLoc.itemIndex, itemLoc.subIndex, true)
				-- right now macro references can only exist in the hotbar
				HotbarClearItem(itemLoc.hotbarId,itemLoc.itemIndex)
			-- else the icon might have changed so reset it
			else
				HotbarSystem.RegisterAction(element, itemLoc.hotbarId, itemLoc.itemIndex, itemLoc.subIndex)
			end
		end
	end
end

function HotbarSystem.CreateUserActionContextMenuOptions(hotbarId, itemIndex, subIndex, slotWindow)
	local actionType = UserActionGetType(hotbarId,itemIndex,subIndex)

	--Debug.Print("HotbarSystem.CreateUserActionContextMenuOptions: "..tostring(hotbarId)..", "..tostring(itemIndex)..", "..tostring(subIndex).." actionType: "..tostring(actionType))
	
	local param = {HotbarId=hotbarId, ItemIndex=itemIndex, SubIndex=subIndex, SlotWindow=slotWindow, ActionType=actionType}
	
	ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_CLEAR_ITEM,0,HotbarSystem.ContextReturnCodes.CLEAR_ITEM,param)
	
	if( ( UserActionHasTargetType(hotbarId,itemIndex,subIndex) ) and ( SystemData.Settings.GameOptions.legacyTargeting == false ) ) then
		local targetType = UserActionGetTargetType(hotbarId,itemIndex,subIndex)
		-- determine which target type is pressed (add one to type for 1 based lua array)
		local pressed = { false, false, false, false }
		pressed[targetType+1] = true
		--Debug.Print("TargetType: "..targetType)
		local subMenu = {
			{ tid = HotbarSystem.TID_SELF,flags=0,returnCode=HotbarSystem.ContextReturnCodes.TARGET_SELF,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_SELF] },
			{ tid = HotbarSystem.TID_CURSOR,flags=0,returnCode=HotbarSystem.ContextReturnCodes.TARGET_CURSOR,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR] },
			{ tid = HotbarSystem.TID_OBJECT_ID,flags=0,returnCode=HotbarSystem.ContextReturnCodes.TARGET_OBJECT_ID,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID] },
			{ tid = HotbarSystem.TID_CURRENT,flags=0,returnCode=HotbarSystem.ContextReturnCodes.TARGET_CURRENT,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT] } }

		ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_TARGET,0,0,param,false,subMenu) 
	end	
	
	-- if its a macro reference, we need to dereference it for the edit window
	local editParam = {HotbarId=hotbarId, ItemIndex=itemIndex, SubIndex=subIndex, SlotWindow=slotWindow, ActionType=actionType}
	if( actionType == SystemData.UserAction.TYPE_MACRO_REFERENCE ) then
		local macroId = UserActionGetId(hotbarId,itemIndex,0)
		local macroIndex = MacroSystemGetMacroIndexById(macroId)
		editParam.ActionType = SystemData.UserAction.TYPE_MACRO
		editParam.HotbarId = SystemData.MacroSystem.STATIC_MACRO_ID
		editParam.ItemIndex = macroIndex
		if not UserActionMacroGetRepeatEnabled( editParam.HotbarId, editParam.ItemIndex ) then
			ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_ENABLE_REPEAT,0,HotbarSystem.ContextReturnCodes.ENABLE_REPEAT,editParam)
		else
			ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_DISABLE_REPEAT,0,HotbarSystem.ContextReturnCodes.DISABLE_REPEAT,editParam)
		end
	end			
	
	local actionData = ActionsWindow.GetActionDataForType(editParam.ActionType)
	if( actionData ~= nil and actionData.editWindow ~= nil ) then
		ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_EDIT_ITEM,0,HotbarSystem.ContextReturnCodes.EDIT_ITEM,editParam)
	end
end

function HotbarSystem.ContextMenuCallback(returnCode,param)
	local bHandled = true
	
	if( returnCode == HotbarSystem.ContextReturnCodes.TARGET_SELF ) then
		UserActionSetTargetType(param.HotbarId,param.ItemIndex,param.SubIndex,SystemData.Hotbar.TargetType.TARGETTYPE_SELF)
		HotbarSystem.UpdateTargetTypeIndicator(param.SlotWindow,param.HotbarId,param.ItemIndex,param.SubIndex)
	elseif( returnCode == HotbarSystem.ContextReturnCodes.TARGET_CURRENT ) then
		UserActionSetTargetType(param.HotbarId,param.ItemIndex,param.SubIndex,SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT)
		HotbarSystem.UpdateTargetTypeIndicator(param.SlotWindow,param.HotbarId,param.ItemIndex,param.SubIndex)
	elseif( returnCode == HotbarSystem.ContextReturnCodes.TARGET_CURSOR ) then
		UserActionSetTargetType(param.HotbarId,param.ItemIndex,param.SubIndex,SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR)
		HotbarSystem.UpdateTargetTypeIndicator(param.SlotWindow,param.HotbarId,param.ItemIndex,param.SubIndex)
	elseif( returnCode == HotbarSystem.ContextReturnCodes.TARGET_OBJECT_ID ) then
		HotbarSystem.RequestTargetInfo(param.SlotWindow,param.HotbarId,param.ItemIndex,param.SubIndex)
	elseif( returnCode == HotbarSystem.ContextReturnCodes.EDIT_ITEM ) then
		WindowSetShowing("ActionsWindow",true) -- Open the actions window
		ActionEditWindow.OpenEditWindow(param.ActionType,param.SlotWindow,param.HotbarId,param.ItemIndex,param.SubIndex)
	elseif( returnCode == HotbarSystem.ContextReturnCodes.ENABLE_REPEAT ) then
		UserActionMacroSetRepeatEnabled(param.HotbarId,param.ItemIndex,true)
	elseif( returnCode == HotbarSystem.ContextReturnCodes.DISABLE_REPEAT ) then
		UserActionMacroSetRepeatEnabled(param.HotbarId,param.ItemIndex,false)
	else
		bHandled = false
	end
	
	return bHandled
end

function HotbarSystem.RegisterSpellIcon(iconWindow,spellId)
	HotbarSystem.RegisteredSpellIcons[iconWindow] = spellId	
end

function HotbarSystem.UnregisterSpellIcon(iconWindow)
	HotbarSystem.RegisteredSpellIcons[iconWindow] = nil	
end

function HotbarSystem.HighlightSpellIcon()
	local spellId = SystemData.HotbarSystem.HighlightSpellIconInput.highlightSpellID
	local highlightEnabled = SystemData.HotbarSystem.HighlightSpellIconInput.highlightSpellEnabled
	for iconWindow, id in pairs(HotbarSystem.RegisteredSpellIcons) do
		if( iconWindow ~= nil and id == spellId ) then
			if (highlightEnabled ~= 0) then	
				WindowSetTintColor(iconWindow.."SquareIcon",255,0,0)
			end
		end
	end
end

function HotbarSystem.UnhighlightSpellIcon()
	local spellId = SystemData.HotbarSystem.UnhighlightSpellIconInput.highlightSpellID
	local highlightEnabled = SystemData.HotbarSystem.UnhighlightSpellIconInput.highlightSpellEnabled
	for iconWindow, id in pairs(HotbarSystem.RegisteredSpellIcons) do
		if( iconWindow ~= nil and id == spellId ) then
			if (highlightEnabled == 0) then	
				WindowSetTintColor(iconWindow.."SquareIcon",255,255,255)
			end
		end
	end
end

function HotbarSystem.RequestTargetInfo(windowName, hotbarId, itemIndex, subIndex)
	HotbarSystem.CurRequestInfoItem =
	{
		windowName = windowName,
		hotbarId = hotbarId,
		itemIndex = itemIndex,				
		subIndex = subIndex,
	}

	RequestTargetInfo()
	
	WindowClearAnchors("RequestTargetIdInfo")
	WindowAddAnchor("RequestTargetIdInfo", "topright", windowName, "bottomleft", 0, -6)
	WindowSetShowing("RequestTargetIdInfo", true)
	WindowRegisterEventHandler("RequestTargetIdInfo", SystemData.Events.TARGET_SEND_ID_CLIENT, "HotbarSystem.RequestTargetInfoReceived")
end

function HotbarSystem.RequestTargetInfoReceived()
	local objectId = SystemData.RequestInfo.ObjectId
	
	if (objectId ~= 0 and HotbarSystem.CurRequestInfoItem ~= nil) then
		UserActionSetTargetId(HotbarSystem.CurRequestInfoItem.hotbarId, HotbarSystem.CurRequestInfoItem.itemIndex, HotbarSystem.CurRequestInfoItem.subIndex, objectId)
		UserActionSetTargetType(HotbarSystem.CurRequestInfoItem.hotbarId, HotbarSystem.CurRequestInfoItem.itemIndex, HotbarSystem.CurRequestInfoItem.subIndex, SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID)
		HotbarSystem.UpdateTargetTypeIndicator(HotbarSystem.CurRequestInfoItem.windowName,HotbarSystem.CurRequestInfoItem.hotbarId,HotbarSystem.CurRequestInfoItem.itemIndex,HotbarSystem.CurRequestInfoItem.subIndex)
	end
	
	WindowSetShowing("RequestTargetIdInfo", false)
	WindowUnregisterEventHandler("RequestTargetIdInfo", SystemData.Events.TARGET_SEND_ID_CLIENT)
end

function HotbarSystem.ReplaceKey(oldHotbarId, oldItemIndex, oldType, hotbarId, itemIndex, type, key, shortKey)
	HotbarSystem.UnbindKey(oldHotbarId, oldItemIndex, oldType)
	HotbarSystem.BindKey(hotbarId, itemIndex, type, key, shortKey)
	
	BroadcastEvent( SystemData.Events.KEYBINDINGS_UPDATED )
end

function HotbarSystem.BindKey(hotbarId, itemIndex, type, key, shortKey)
	if(type == SystemData.BindType.BINDTYPE_SETTINGS) then
		SettingsWindow.Keybindings[itemIndex].newValue = key
		SettingsWindow.UpdateKeyBindings()
		
	elseif(type == SystemData.BindType.BINDTYPE_HOTBAR) then
		SystemData.Hotbar[hotbarId].Bindings[itemIndex] = key
		SystemData.Hotbar[hotbarId].BindingDisplayStrings[itemIndex] = shortKey
		
		HotbarUpdateBinding(hotbarId, itemIndex, key)
		local HotkeyLabel = "Hotbar"..hotbarId.."Button"..itemIndex.."Hotkey"
		LabelSetText(HotkeyLabel, shortKey)
		
	elseif(type == SystemData.BindType.BINDTYPE_MACRO) then
		UserActionMacroUpdateBinding(hotbarId, itemIndex, key)
		local MacroLabel = "MacroScrollWindowScrollChildItem"..itemIndex.."Binding"
		if( key ~= L"" ) then
			LabelSetText(MacroLabel, key)
		else
			LabelSetText(MacroLabel, GetStringFromTid(MacroWindow.TID_NO_KEYBINDING))
		end
	end
end

function HotbarSystem.UnbindKey(hotbarId, itemIndex, type)
	if( type == SystemData.BindType.BINDTYPE_SETTINGS ) then
		SettingsWindow.Keybindings[itemIndex].newValue = L""
		SettingsWindow.UpdateKeyBindings()
		
	elseif( type == SystemData.BindType.BINDTYPE_HOTBAR ) then
		SystemData.Hotbar[hotbarId].Bindings[itemIndex] = L""
		SystemData.Hotbar[hotbarId].BindingDisplayStrings[itemIndex] = L""
		
		HotbarUpdateBinding(hotbarId, itemIndex, L"")
		local HotkeyLabel = "Hotbar"..hotbarId.."Button"..itemIndex.."Hotkey"
		LabelSetText(HotkeyLabel, L"")
		
	elseif( type == SystemData.BindType.BINDTYPE_MACRO ) then
		UserActionMacroUpdateBinding(hotbarId, itemIndex, L"")
		local MacroLabel = "MacroScrollWindowScrollChildItem"..itemIndex.."Binding"
		LabelSetText(MacroLabel, GetStringFromTid(MacroWindow.TID_NO_KEYBINDING))
	end
end

function HotbarSystem.GetKeyName(hotbarId, itemIndex, type)
	if( type == SystemData.BindType.BINDTYPE_SETTINGS ) then
		return GetStringFromTid( SettingsWindow.Keybindings[itemIndex].tid )
	elseif( type == SystemData.BindType.BINDTYPE_HOTBAR ) then
		return GetStringFromTid( Hotbar.TID_HOTBAR )..L" "..hotbarId..L"  "..GetStringFromTid( Hotbar.TID_SLOT )..L" "..itemIndex
	elseif( type == SystemData.BindType.BINDTYPE_MACRO ) then
		return GetStringFromTid( MacroWindow.TID_MACROCOLON )..L"  "..UserActionMacroGetName(SystemData.MacroSystem.STATIC_MACRO_ID, itemIndex)
	end
end