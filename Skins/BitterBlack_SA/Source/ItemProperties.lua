----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ItemProperties = {}

ItemProperties.DETAIL_SHORT = 1
ItemProperties.DETAIL_LONG = 2

ItemProperties.CurrentItemData = {}

ItemProperties.TITLE_COLOR = { r=242, g=212, b=167 }
ItemProperties.BODY_COLOR = { r=255, g=255, b=255 }

ItemProperties.VirtueData = {}
ItemProperties.VirtueData[1]	= { iconId = 701, nameTid = 1051005 } -- Honor
ItemProperties.VirtueData[2]	= { iconId = 706, nameTid = 1051001 } -- Sacrifice
ItemProperties.VirtueData[3]	= { iconId = 700, nameTid = 1051004 } -- Valor
ItemProperties.VirtueData[4]	= { iconId = 702, nameTid = 1051002 } -- Compassion
ItemProperties.VirtueData[5]	= { iconId = 704, nameTid = 1051007 } -- Honesty
ItemProperties.VirtueData[6]	= { iconId = 707, nameTid = 1051000 } -- Humility
ItemProperties.VirtueData[7]	= { iconId = 703, nameTid = 1051006 } -- Justice
ItemProperties.VirtueData[8]	= { iconId = 705, nameTid = 1051003 } -- Spirituality

---------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler
function ItemProperties.Initialize()
	WindowSetAlpha("ItemPropertiesWindowBackground", 0.8)
	
	WindowData.ItemProperties.numLabels = 0
	
	RegisterWindowData(WindowData.ItemProperties.Type, 0)
	WindowRegisterEventHandler( "ItemProperties", SystemData.Events.UPDATE_ITEM_PROPERTIES, "ItemProperties.UpdateItemPropertiesData")
end

function ItemProperties.Shutdown()
	UnregisterWindowData(WindowData.ItemProperties.Type, 0)
end

function ItemProperties.UpdateItemPropertiesData()
	local this = WindowUtils.GetActiveDialog()
	local id = WindowData.ItemProperties.CurrentHover
	local labelText = {}
	local labelColors = {}
	local numLabels = 0
	
	-- update the item type incase it has changed from code
	ItemProperties.CurrentItemData.itemType = WindowData.ItemProperties.CurrentType
	
	ItemProperties.HideAllPropsLabels()
	
	if( ItemProperties.CurrentItemData.itemType == WindowData.ItemProperties.TYPE_ITEM ) then
		-- use instance id 0 for the current item properties object
		data = WindowData.ItemProperties[0]
	
		if data and data.PropertiesList then
			propList = data.PropertiesList
			propLen = table.getn(propList)
			
			for i = 1, propLen do
				numLabels = numLabels + 1
				-- DAB TODO: Show bold strings, for now just rip out the tag
				labelText[numLabels] = WindowUtils.translateMarkup(propList[i])
				
				if( i==1 ) then 
					if ( (WindowData.ItemProperties.CustomColorTitle) and (WindowData.ItemProperties.CustomColorTitle.Enable) and (i == WindowData.ItemProperties.CustomColorTitle.LabelIndex) and (WindowData.ItemProperties.CustomColorTitle.NotorietyEnable) ) then
						labelColors[numLabels] = NameColor.TextColors[WindowData.ItemProperties.CustomColorTitle.NotorietyIndex+1]
					else
						labelColors[numLabels] = ItemProperties.TITLE_COLOR
					end
				else
					if WindowData.ItemProperties.CustomColorBody and WindowData.ItemProperties.CustomColorBody.Enable and i == WindowData.ItemProperties.CustomColorBody.LabelIndex then
						labelColors[numLabels] = WindowData.ItemProperties.CustomColorBody.Color
					elseif WindowData.ItemProperties.CustomColorBody2 and WindowData.ItemProperties.CustomColorBody2.Enable and i == WindowData.ItemProperties.CustomColorBody2.LabelIndex then
						labelColors[numLabels] = WindowData.ItemProperties.CustomColorBody2.Color
					else
						labelColors[numLabels] = ItemProperties.BODY_COLOR
					end
				end 
			end
		end	
	elseif( ItemProperties.CurrentItemData.itemType == WindowData.ItemProperties.TYPE_ACTION ) then
		-- first get its location if it has one and set the subindex to 0 by default
		local itemLoc = ItemProperties.CurrentItemData.itemLoc
		if( itemLoc ~= nil and itemLoc.subIndex == nil ) then
			itemLoc.subIndex = 0
		end
		
		if( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_SKILL ) then
			-- translate the server id into a row into the ability csv
			local abilityId = CSVUtilities.getRowIdWithColumnValue(WindowData.SkillsCSV, "ServerId", id)
			numLabels = numLabels + 1
			labelText[numLabels] = GetStringFromTid(WindowData.SkillsCSV[abilityId].NameTid)
			labelColors[numLabels] = ItemProperties.TITLE_COLOR
		elseif( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_SPELL ) then
			local icon, serverId, tid, desctid = GetAbilityData(id)

			if( desctid ~= nil and ItemProperties.CurrentItemData.detail == ItemProperties.DETAIL_LONG ) then
				if( tid ~= nil ) then
					numLabels = numLabels + 1
					labelText[numLabels] = GetStringFromTid(tid)..L"\n"
					labelColors[numLabels] = ItemProperties.TITLE_COLOR		
				end				
				numLabels = numLabels + 1
				labelText[numLabels] = GetStringFromTid(desctid)
				labelColors[numLabels] = ItemProperties.BODY_COLOR	
			elseif( tid ~= nil ) then
				numLabels = numLabels + 1
				labelText[numLabels] = GetStringFromTid(tid)
				labelColors[numLabels] = ItemProperties.TITLE_COLOR		
			end		
			
			if(ItemProperties.CurrentItemData.body ~= nil and ItemProperties.CurrentItemData.body ~= L"") then
				numLabels = numLabels + 1
				labelText[numLabels] = WindowUtils.translateMarkup(ItemProperties.CurrentItemData.body)
				labelColors[numLabels] = ItemProperties.BODY_COLOR	
			end
		elseif( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_INVOKE_VIRTUE ) then
			local nameTid = ItemProperties.VirtueData[id].nameTid
			if( nameTid ~= nil and nameTid ~= 0 ) then
				numLabels = numLabels + 1
				labelText[numLabels] = GetStringFromTid(nameTid)	
				labelColors[numLabels] = ItemProperties.TITLE_COLOR
			end
		elseif( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_WEAPON_ABILITY ) then
			if( EquipmentData.CurrentWeaponAbilities[id] ~= nil and EquipmentData.CurrentWeaponAbilities[id] ~= 0 ) then
				local abilityId = EquipmentData.CurrentWeaponAbilities[id] + EquipmentData.WEAPONABILITY_ABILITYOFFSET
				local icon, serverId, tid, desctid = GetAbilityData(abilityId)
				
				-- Always show the ability name
				if( tid ~= nil ) then
					numLabels = numLabels + 1
					labelText[numLabels] = GetStringFromTid(tid)
					labelColors[numLabels] = ItemProperties.TITLE_COLOR
				end

				if( desctid ~= nil and ItemProperties.CurrentItemData.detail == ItemProperties.DETAIL_LONG ) then
					numLabels = numLabels + 1
					labelText[numLabels] = GetStringFromTid(desctid)	
					labelColors[numLabels] = ItemProperties.BODY_COLOR			
				end
			end
		elseif( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_USE_OBJECTTYPE) then
			RegisterWindowData(WindowData.ObjectTypeQuantity.Type, ItemProperties.CurrentItemData.itemId)
			item = WindowData.ObjectTypeQuantity[ItemProperties.CurrentItemData.itemId]
			if( item ~= nil ) then
				if( item.name ~= nil ) then
					numLabels = numLabels + 1
					local itemName = Shopkeeper.stripFirstNumber(item.name)
				    labelText[numLabels] = item.quantity..L" "..itemName
				    labelColors[numLabels] = ItemProperties.TITLE_COLOR	
				end
			end
			
			UnregisterWindowData(WindowData.ObjectTypeQuantity.Type, ItemProperties.CurrentItemData.itemId)
			
		elseif(ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_PLAYER_STATS) then
			--If the user action is TYPE_PLAYER_STATS just show the tid of the stats ex: strength, dexterity
				tid = WindowData.PlayerStatsDataCSV[id].tid
				-- Always show the ability name
				if( tid ~= nil ) then
					numLabels = numLabels + 1
					labelText[numLabels] = GetStringFromTid(tid)
					labelColors[numLabels] = ItemProperties.TITLE_COLOR
				end	
			
		-- Blanket case for generic actions
		else
			local actionData = ActionsWindow.GetActionDataForType(ItemProperties.CurrentItemData.actionType)
			
			if( actionData ~= nil ) then
			    if( actionData.nameTid ~= nil and actionData.nameTid ~= 0 ) then
				    numLabels = numLabels + 1
				    labelText[numLabels] = GetStringFromTid(actionData.nameTid)
				    labelColors[numLabels] = ItemProperties.TITLE_COLOR	
			    end
			    if( actionData.detailTid ~= nil and actionData.detailTid ~= 0 ) then
				    numLabels = numLabels + 1
				    labelText[numLabels] = GetStringFromTid(actionData.detailTid)
				    labelColors[numLabels] = ItemProperties.BODY_COLOR	
			    end						
			end
		end
		
		-- add aditional information if the action has a hotbar location
		if( itemLoc ~= nil ) then
			if( UserActionIsSpeechType(itemLoc.hotbarId, itemLoc.itemIndex, itemLoc.subIndex) ) then
				local speechText = UserActionSpeechGetText(itemLoc.hotbarId, itemLoc.itemIndex, itemLoc.subIndex)
				if( speechText ~= L"" ) then
					numLabels = numLabels + 1
					labelText[numLabels] = speechText
					labelColors[numLabels] = ItemProperties.BODY_COLOR
				end
			elseif( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_DELAY ) then
				local delay = UserActionDelayGetDelay(itemLoc.hotbarId, itemLoc.itemIndex, itemLoc.subIndex)
				numLabels = numLabels + 1
				labelText[numLabels] = wstring.format(L"%.1f",delay)
				labelColors[numLabels] = ItemProperties.BODY_COLOR
			elseif( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_MACRO ) then
				local macroName = UserActionMacroGetName(itemLoc.hotbarId, itemLoc.itemIndex)
				if( macroName ~= L"" ) then
					numLabels = numLabels + 1
					labelText[numLabels] = macroName
					labelColors[numLabels] = ItemProperties.BODY_COLOR
				end
			end
		end
		
	elseif( ItemProperties.CurrentItemData.itemType == WindowData.ItemProperties.TYPE_WSTRINGDATA ) then
		if( ItemProperties.CurrentItemData.title ~= nil and ItemProperties.CurrentItemData.title ~= L"" ) then
			numLabels = numLabels + 1
			labelText[numLabels] = ItemProperties.CurrentItemData.title
			labelColors[numLabels] = ItemProperties.TITLE_COLOR	
		end
		if( ItemProperties.CurrentItemData.body ~= nil and ItemProperties.CurrentItemData.body ~= L"" ) then
			numLabels = numLabels + 1
			labelText[numLabels] = ItemProperties.CurrentItemData.body
			labelColors[numLabels] = ItemProperties.BODY_COLOR	
		end	
	end
	
	if( ItemProperties.CurrentItemData.binding ~= nil and ItemProperties.CurrentItemData.binding ~= L"" ) then
		numLabels = numLabels + 1
		labelText[numLabels] = ItemProperties.CurrentItemData.binding
		labelColors[numLabels] = ItemProperties.BODY_COLOR	
	end

	if( ItemProperties.CurrentItemData.myTarget ~= nil and ItemProperties.CurrentItemData.myTarget ~= L"" ) then
		numLabels = numLabels + 1
		labelText[numLabels] = ItemProperties.CurrentItemData.myTarget
		labelColors[numLabels] = ItemProperties.BODY_COLOR	
	end
			
	numLabels = table.getn(labelText)
	--Debug.Print("numLabels: "..numLabels)
	if( numLabels > 0 ) then
		ItemProperties.CreatePropsLabels(numLabels)
	
		local propWindowWidth = 100
		local propWindowHeight = 4
		
		for i = 1, numLabels do
			labelName = "ItemPropertiesItemLabel"..i
			LabelSetText(labelName, labelText[i])
			LabelSetTextColor(labelName, labelColors[i].r, labelColors[i].g, labelColors[i].b)
			w, h = LabelGetTextDimensions(labelName)
			propWindowWidth = math.max(propWindowWidth, w)
			propWindowHeight = propWindowHeight + h + 4 -- Allow for spacing
			WindowSetShowing(labelName, true)
		end
	
		propWindowWidth = propWindowWidth + 12
		WindowSetDimensions("ItemProperties", propWindowWidth, propWindowHeight)

		-- Set the window position
		windowOffset = 16
		scaleFactor = 1/InterfaceCore.scale	
		
		mouseX = SystemData.MousePosition.x
		propWindowX = mouseX - windowOffset - (propWindowWidth / scaleFactor)
		if propWindowX < 0 then
			propWindowX = mouseX + windowOffset
		end
			
		mouseY = SystemData.MousePosition.y
		propWindowY = mouseY - windowOffset - (propWindowHeight / scaleFactor)
		if propWindowY < 0 then
			propWindowY = mouseY + windowOffset
		end

		WindowSetOffsetFromParent("ItemProperties", propWindowX * scaleFactor, propWindowY * scaleFactor)
		WindowSetShowing("ItemProperties",true)
	end
end

-- Values in itemdata table
--   windowName - name of base window that contains hover
--   itemId     - unique id of item
--   itemType   - WindowData.ItemProperties
--	 binding    - (default L"") shown on last line
--   detail     - (default SHORT) ItemProperties.DETAIL_SHORT
--				  ItemProperties.DETAIL_LONG 
--   actionType - (default NONE) SystemData.UserAction
--	title		- Used for item properties that have the title wstring (default L"")
--	body		- Outputs the body of your text given a wstring, goes below the title (default L"")	
function ItemProperties.SetActiveItem(itemData)
	if( itemData == nil ) then
		itemData = {}
	end
	
	-- USE_ITEM actions are the same information as item
	if( itemData.actionType == SystemData.UserAction.TYPE_USE_ITEM ) then
		itemData.itemType = WindowData.ItemProperties.TYPE_ITEM
	end
	
	--Debug.Print("ItemProperties.SetActiveItem: id="..tostring(itemData.itemId).." type="..tostring(itemData.itemType).." action="..tostring(itemData.actionType))
	
	WindowData.ItemProperties.CurrentHover = itemData.itemId
	WindowData.ItemProperties.CurrentType = itemData.itemType
	ItemProperties.CurrentItemData = itemData
end

function ItemProperties.CreatePropsLabels(numLabelsNeeded)
	-- Dynamically create a bunch of labels for the individual property lines.
	numHave = WindowData.ItemProperties.numLabels 
	
	if numHave >= numLabelsNeeded then
		return
	end

	for i = numHave + 1, numLabelsNeeded do
		labelName = "ItemPropertiesItemLabel"..i
		
		if i == 1 then
			CreateWindowFromTemplate(labelName, "ItemPropItemDef", "ItemProperties")
			WindowAddAnchor(labelName, "top", "ItemProperties", "top", 0, 4)
		else
			CreateWindowFromTemplate(labelName, "ItemPropItemDef", "ItemProperties")
			WindowAddAnchor(labelName, "bottom", "ItemPropertiesItemLabel"..i-1, "top", 0, 4)
		end
	end
	
	WindowData.ItemProperties.numLabels = numLabelsNeeded
end

function ItemProperties.HideAllPropsLabels()
	numHave = WindowData.ItemProperties.numLabels 
	
	if numHave then
		for i = 1, numHave do
			WindowSetShowing("ItemPropertiesItemLabel"..i, false)
		end
	end
end

function ItemProperties.ClearMouseOverItem()
	--Debug.Print("ItemProperties.ClearMouseOverItem")
	WindowData.ItemProperties.CurrentHover = 0
	WindowData.ItemProperties.CurrentType = WindowData.ItemProperties.TYPE_NONE
	ItemProperties.CurrentItemData = {}
end

function ItemProperties.GetCurrentWindow()
    local windowName = nil
    if( ItemProperties.CurrentItemData ~= nil ) then
        windowName = ItemProperties.CurrentItemData.windowName
    end
    
    return windowName
end