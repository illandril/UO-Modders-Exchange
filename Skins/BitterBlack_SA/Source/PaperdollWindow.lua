----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

PaperdollWindow = {}
PaperdollWindow.TID = {}
PaperdollWindow.TID.CLOTHING	= 1077861	--CLOTHING
PaperdollWindow.TID.ARMOR		= 1077862	--ARMOR
PaperdollWindow.TID.PAPERDOLL	= 1077863 	--PAPERDOLL
PaperdollWindow.TID.PROFILE 	= 1078990   --PROFILE

PaperdollWindow.PAPERDOLLSLOTID 	= {}
PaperdollWindow.PAPERDOLLSLOTID.FEET 	= 13   
PaperdollWindow.PAPERDOLLSLOTID.HEAD 	= 1   
PaperdollWindow.PAPERDOLLSLOTID.HANDS 	= 11   
PaperdollWindow.HUMAN = 1
PaperdollWindow.ELF = 2
PaperdollWindow.GARGOYLE = 3

PaperdollWindow.WINDOWSCALE = 0.86

PaperdollWindow.CurrentTab = 1

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------
ItemSlot = {}
ItemSlot.NUM_BUTTONS = 12

ItemSlot.BUTTONSTATE_EMPTY = 0
ItemSlot.BUTTONSTATE_NORMAL = 1
ItemSlot.BUTTONSTATE_ACTIVE = 2
ItemSlot.BUTTONSTATE_DISABLED = 3

ItemSlot.ItemIds = {}
ItemSlot.ObjectTypes = {}
ItemSlot.ButtonStates = {}

PaperdollWindow.OpenPaperdolls = {}
PaperdollWindow.ActivePaperdollImage = 0
PaperdollWindow.ActivePaperdollObject = 0
PaperdollWindow.ArmorSlots = 12

PaperdollWindow.BlankSlot = {}
PaperdollWindow.BlankSlot[1]  = { SlotNameTid = 1079897, SlotDescTid = 1079916 }
PaperdollWindow.BlankSlot[2]  = { SlotNameTid = 1079898, SlotDescTid = 1079916 }
PaperdollWindow.BlankSlot[3]  = { SlotNameTid = 1079899, SlotDescTid = 1079916 }
PaperdollWindow.BlankSlot[4]  = { SlotNameTid = 1079900, SlotDescTid = 1079917 }
PaperdollWindow.BlankSlot[5]  = { SlotNameTid = 1079901, SlotDescTid = 1079918 }
PaperdollWindow.BlankSlot[6]  = { SlotNameTid = 1079902, SlotDescTid = 1079916 }
PaperdollWindow.BlankSlot[7]  = { SlotNameTid = 1079903, SlotDescTid = 1079919 }
PaperdollWindow.BlankSlot[8]  = { SlotNameTid = 1079904, SlotDescTid = 1079916 }
PaperdollWindow.BlankSlot[9]  = { SlotNameTid = 1079905, SlotDescTid = 1079920 }
PaperdollWindow.BlankSlot[10] = { SlotNameTid = 1079906, SlotDescTid = 1079917 }
PaperdollWindow.BlankSlot[11] = { SlotNameTid = 1079907, SlotDescTid = 1079916 }
PaperdollWindow.BlankSlot[12] = { SlotNameTid = 1079908, SlotDescTid = 1079921 }
PaperdollWindow.BlankSlot[13] = { SlotNameTid = 1079909, SlotDescTid = nil }
PaperdollWindow.BlankSlot[14] = { SlotNameTid = 1079910, SlotDescTid = nil }
PaperdollWindow.BlankSlot[15] = { SlotNameTid = 1079911, SlotDescTid = nil }
PaperdollWindow.BlankSlot[16] = { SlotNameTid = 1079912, SlotDescTid = nil }
PaperdollWindow.BlankSlot[17] = { SlotNameTid = 1079913, SlotDescTid = nil }
PaperdollWindow.BlankSlot[18] = { SlotNameTid = 1079914, SlotDescTid = nil }
PaperdollWindow.BlankSlot[19] = { SlotNameTid = 1079915, SlotDescTid = nil }

---------------------------------------------------------------------

function PaperdollWindow.Initialize()	
	local id = SystemData.Paperdoll.Id
	local windowName = "PaperdollWindow"..id

	Interface.DestroyWindowOnClose[windowName] = true

	RegisterWindowData(WindowData.Paperdoll.Type,id)
	RegisterWindowData(WindowData.PlayerStatus.Type,0)

	WindowRegisterEventHandler( windowName, WindowData.Paperdoll.Event, "PaperdollWindow.HandleUpdatePaperdollEvent")
	WindowRegisterEventHandler( windowName, SystemData.Events.UPDATE_CHAR_PROFILE, "PaperdollWindow.UpdateCharProfile")
	
	WindowSetId(windowName, id)
	
	PaperdollWindow.OpenPaperdolls[id] = true
	
	local scale = WindowGetScale(windowName)
	local PDScale = SettingsWindow.PDScale
	WindowSetScale(windowName, scale * PaperdollWindow.WINDOWSCALE * PDScale)
	
	--When the paperdoll first gets created with item slots
	PaperdollWindow.UpdatePaperdoll(windowName,id)
	
	ButtonSetText(windowName.."TabButton2", GetStringFromTid(PaperdollWindow.TID.CLOTHING))
	ButtonSetText(windowName.."TabButton1", GetStringFromTid(PaperdollWindow.TID.ARMOR) )
	ButtonSetText(windowName.."TabButton3", GetStringFromTid(PaperdollWindow.TID.PROFILE) )

	PaperdollWindow.CurrentTab = 1
	PaperdollWindow.UnselectAllTabs(windowName, id, 3)
	PaperdollWindow.SelectTab(windowName, 1)
	
	WindowUtils.SetActiveDialogTitle( GetStringFromTid(PaperdollWindow.TID.PAPERDOLL) )
	
	-- set the bar at the bottom to the full name
	if( SystemData.Paperdoll.Name ~= nil ) then
		LabelSetText(windowName.."TitleName",SystemData.Paperdoll.Name)
	end
	
	WindowSetShowing(windowName.."ToggleCharacterSheet", false)
	WindowSetShowing(windowName.."ToggleCharacterAbilities", false)

	local playerId = WindowData.PlayerStatus.PlayerId
	-- if this is the players backpack then use the saved position
	if( id == playerId ) then
		if(WindowData.Paperdoll[id].backpackId ~= nil ) then
			local backpackName = "ContainerWindow_"..WindowData.Paperdoll[id].backpackId
			if DoesWindowNameExist(backpackName) and WindowGetShowing(backpackName) then
				ButtonSetPressedFlag( windowName.."ToggleInventory", true )
			end		
		end
		WindowSetShowing(windowName.."ToggleCharacterSheet", true)
		WindowSetShowing(windowName.."ToggleCharacterAbilities", true)
		WindowUtils.RestoreWindowPosition(windowName)
		local characterSheetName = windowName.."ToggleCharacterSheet"
		local showing = WindowGetShowing("CharacterSheet")
		ButtonSetPressedFlag( characterSheetName, showing )
		
		WindowSetShowing(windowName.."TabWindow3ProfileView",false)
		
		ButtonSetPressedFlag("MenuBarWindowTogglePaperdoll",true)
    else
        WindowSetShowing(windowName.."TabWindow3ProfileEdit",false)		
	end

	RegisterWindowData(WindowData.MobileStatus.Type, id)	
	if (WindowData.MobileStatus[id].Race == PaperdollWindow.GARGOYLE) then
		WindowSetShowing(windowName.."TabWindow2ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.FEET, false)
		WindowClearAnchors(windowName.."TabWindow2ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.FEET+1)
		WindowAddAnchor(windowName.."TabWindow2ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.FEET+1, "topleft", windowName.."TabWindow2", "topleft", 2, 54)

		WindowSetShowing(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.HEAD, false)
		WindowClearAnchors(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.HEAD+1)
		WindowAddAnchor(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.HEAD+1, "topleft", windowName.."TabWindow1", "topleft", 2, 54)

		WindowSetShowing(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.HANDS, false)
		WindowClearAnchors(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.HANDS+1)
		WindowAddAnchor(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.HANDS+1, "bottomleft", windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.HANDS-1, "topleft", 0, 0)

	end
	UnregisterWindowData(WindowData.MobileStatus.Type, id)	
end

function PaperdollWindow.Shutdown()
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	windowName = "PaperdollWindow"..paperdollId
		
	-- only save the position of the players character window
	local playerId = WindowData.PlayerStatus.PlayerId
	if( paperdollId == playerId ) then
		WindowUtils.SaveWindowPosition(windowName)
		
		ButtonSetPressedFlag("MenuBarWindowTogglePaperdoll",false)
		
		-- update profile text
		if(PaperdollWindow.CurrentTab == 3) then
			local infoText = TextEditBoxGetText(windowName.."TabWindow3ProfileEditText")
			UpdateCharProfile(paperdollId,infoText)
		end
	end
	
	UnregisterWindowData(WindowData.Paperdoll.Type,paperdollId)
	UnregisterWindowData(WindowData.PlayerStatus.Type,0)
	
	PaperdollWindow.OpenPaperdolls[paperdollId] = false
	
	if( ItemProperties.GetCurrentWindow() == windowName ) then
		ItemProperties.ClearMouseOverItem()
	end
end

function PaperdollWindow.HandleUpdatePaperdollEvent()
    PaperdollWindow.UpdatePaperdoll(SystemData.ActiveWindow.name,WindowData.UpdateInstanceId)
end

function PaperdollWindow.UpdatePaperdoll(windowName,paperdollId)
	if( paperdollId == WindowGetId(windowName) ) then
		local elementIcon
		local elementBg
		local topButton 
		for index = 1, WindowData.Paperdoll[paperdollId].numSlots  do
			
			if( index <= PaperdollWindow.ArmorSlots) then
				elementIcon = windowName.."TabWindow1ItemSlotButton"..tostring(index).."SquareIcon"
				elementBg =  windowName.."TabWindow1ItemSlotButton"..tostring(index).."SquareBg"
				topButton = windowName.."TabWindow1ItemSlotButton"..index
			else
				elementIcon = windowName.."TabWindow2ItemSlotButton"..tostring(index).."SquareIcon"
				elementBg =  windowName.."TabWindow2ItemSlotButton"..tostring(index).."SquareBg"
				topButton = windowName.."TabWindow2ItemSlotButton"..index
			end
			
			--Debug.Print("Index = "..index.." window name = "..tostring(elementIcon))
			
			if (WindowData.Paperdoll[paperdollId][index].slotId == 0) then
				ItemSlot.ButtonStates[index] = ItemSlot.BUTTONSTATE_EMPTY
				ItemSlot.ItemIds[index] = 0
				ItemSlot.ObjectTypes[index] = 0	
				WindowSetShowing(elementIcon, false)
				WindowSetShowing(elementBg, false)
				
			else
			--Debug.Print(" window name slotId textureName = "..tostring(WindowData.Paperdoll[paperdollId][index].slotTextureName))
				ItemSlot.ItemIds[index] = WindowData.Paperdoll[paperdollId][index].slotId
				ItemSlot.ObjectTypes[index] = WindowData.Paperdoll[paperdollId][index].slotTextureName
				ItemSlot.ButtonStates[index] = ItemSlot.BUTTONSTATE_NORMAL
	
				data = WindowData.Paperdoll[paperdollId][index]
				EquipmentData.UpdateItemIcon(elementIcon, data)			
				
				-- DAB TODO UPDATE ANCHORS
				parent = WindowGetParent(elementIcon)
				WindowClearAnchors(elementIcon)
				WindowAddAnchor(elementIcon, "topleft", parent, "topleft", (58-data.newWidth)/2, (58-data.newHeight)/2)

				WindowSetShowing(elementIcon, true)
				WindowSetShowing(elementBg, true)
			end	
		end
		
		local textureData = SystemData.PaperdollTexture[paperdollId]
		if( textureData ~= nil) then
			local tabName = windowName.."TabWindow1Texture"
			local tabSecondName = windowName.."TabWindow2Texture"
			local texWidth, texHeight = WindowGetDimensions(tabName)
			local newWidth = textureData.Width
			local newHeight = textureData.Height
			if( texWidth ~= newWidth or texHeight ~= newHeight ) then
				WindowSetDimensions(tabName,newWidth,newHeight)
				DynamicImageSetTexture(tabName,"paperdoll_texture"..paperdollId,0,-18)	
				WindowSetDimensions(tabSecondName,newWidth,newHeight)
				DynamicImageSetTexture(tabSecondName,"paperdoll_texture"..paperdollId,0,-18)	
			end
			
			-- always adjust the offset
			WindowClearAnchors(tabName)
			WindowAddAnchor(tabName,"center",windowName.."TabWindow1","topleft",textureData.xOffset,textureData.yOffset)	
			WindowClearAnchors(tabSecondName)
			WindowAddAnchor(tabSecondName,"center",windowName.."TabWindow2","topleft",textureData.xOffset,textureData.yOffset)			
		end
	end
end

function PaperdollWindow.OnPaperdollTextureLButtonDown()
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "PaperdollWindow"..paperdollId
	local slotId = GetPaperdollObject(paperdollId, WindowGetScale(windowName))
	
	if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true and slotId ~= 0 )
	then
		RegisterWindowData(WindowData.ObjectInfo.Type, slotId)
        HandleSingleLeftClkTarget(slotId)
		UnregisterWindowData(WindowData.ObjectInfo.Type, slotId)
		return
	end
	
	--Debug.Print("PaperdollWindow.OnPaperdollTextureLButtonDblClk()"..paperdollId)
	if( slotId ~= 0 ) then	
		DragSlotSetObjectMouseClickData(slotId, SystemData.DragSource.SOURCETYPE_PAPERDOLL)
	end
end

function PaperdollWindow.OnPaperdollTextureLButtonDblClk()
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "PaperdollWindow"..paperdollId
	local SlotId = GetPaperdollObject(paperdollId, WindowGetScale(windowName))
	
	UserActionUseItem(SlotId,false)
end


function PaperdollWindow.OnPaperdollTextureRButtonDown()
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "PaperdollWindow"..paperdollId
	local slotId = GetPaperdollObject(paperdollId, WindowGetScale(windowName))
	
	if( slotId ~= 0 ) then
		RequestContextMenu(slotId)
	end
end

function PaperdollWindow.OnPaperdollTextureMouseOver()
	local dialog = WindowUtils.GetActiveDialog()
	local PaperdollId = WindowGetId(dialog)
	
	PaperdollWindow.ActivePaperdollImage = PaperdollId
end

function PaperdollWindow.OnPaperdollTextureMouseEnd()
	PaperdollWindow.ActivePaperdollImage = 0
	PaperdollWindow.ActivePaperdollObject = 0

	ItemProperties.ClearMouseOverItem()
end

function PaperdollWindow.SlotLButtonDown()
	local slotIndex = WindowGetId(SystemData.ActiveWindow.name)
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	local slotId = WindowData.Paperdoll[paperdollId][slotIndex].slotId
	
	if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true and slotId ~= 0 )
	then
		RegisterWindowData(WindowData.ObjectInfo.Type, slotId)
        HandleSingleLeftClkTarget(slotId)
		UnregisterWindowData(WindowData.ObjectInfo.Type, slotId)
		return
	end

	DragSlotSetObjectMouseClickData(slotId, SystemData.DragSource.SOURCETYPE_PAPERDOLL)
end

function PaperdollWindow.ItemRelease()
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
		DragSlotDropObjectToPaperdoll(paperdollId)
	end
end

function PaperdollWindow.SlotLButtonDblClk()
    local dialog = WindowUtils.GetActiveDialog()
	local PaperdollId = WindowGetId(dialog)
	local SlotNum = WindowGetId(SystemData.ActiveWindow.name)
	local SlotId = WindowData.Paperdoll[PaperdollId][SlotNum].slotId	
	
	UserActionUseItem(SlotId,false)
end

function PaperdollWindow.SlotRButtonDown()
	local slotIndex = WindowGetId(SystemData.ActiveWindow.name)
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	local slotId = WindowData.Paperdoll[paperdollId][slotIndex].slotId

	local playerId = WindowData.PlayerStatus.PlayerId
	if( paperdollId == playerId and slotId ~= 0 ) then
		RequestContextMenu(slotId)
	end
end

function PaperdollWindow.ItemMouseOver()
	local SlotNum = WindowGetId(SystemData.ActiveWindow.name)
	local dialog = WindowUtils.GetActiveDialog()
	local PaperdollId = WindowGetId(dialog)
	local SlotId = WindowData.Paperdoll[PaperdollId][SlotNum].slotId
	local itemData
	
	if SlotId ~= 0 then
		itemData = {
			windowName = dialog,
			itemId = SlotId,
			itemType = WindowData.ItemProperties.TYPE_ITEM,
		}
	else
		local EmptySlotBodyText
		if PaperdollWindow.BlankSlot[SlotNum].SlotDescTid then
			EmptySlotBodyText = GetStringFromTid(  PaperdollWindow.BlankSlot[SlotNum].SlotDescTid )
		else
			EmptySlotBodyText = L""
		end
	-- Remove the next two lines of comments to show these only for the player's own paperdoll.
-- 		if( SystemData.Paperdoll.Id == WindowData.PlayerStatus.PlayerId ) then
			itemData = {
				windowName = "EmptyPaperdollSlot"..SlotNum,
				itemId = SlotNum,
				itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
				binding = L"",
				detail = nil,
				title =	GetStringFromTid( PaperdollWindow.BlankSlot[SlotNum].SlotNameTid ),
				body = EmptySlotBodyText,
			}	
--		end 
	end
	ItemProperties.SetActiveItem(itemData)
end

function PaperdollWindow.OnUpdate()
	if( PaperdollWindow.ActivePaperdollImage ~= 0 ) then
		local dialog = WindowUtils.GetActiveDialog()
		local windowName = "PaperdollWindow"..PaperdollWindow.ActivePaperdollImage
		local SlotId = GetPaperdollObject(PaperdollWindow.ActivePaperdollImage, WindowGetScale(windowName))

		if SlotId ~= 0 and (PaperdollWindow.ActivePaperdollObject == 0 or
		                   PaperdollWindow.ActivePaperdollObject ~= SlotId) then
			PaperdollWindow.ActivePaperdollObject = SlotId
			local itemData = { windowName = dialog,
								itemId = SlotId,
								itemType = WindowData.ItemProperties.TYPE_ITEM }
			ItemProperties.SetActiveItem(itemData)
		elseif SlotId == 0 and PaperdollWindow.ActivePaperdollObject ~= 0 then
			PaperdollWindow.ActivePaperdollObject = 0
			ItemProperties.ClearMouseOverItem()
		end
	end
end

function PaperdollWindow.ToggleInventoryWindow()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "PaperdollWindow"..id
	local inventoryName = windowName.."ToggleInventory"
	if (ButtonGetDisabledFlag(inventoryName) ) then
		return
	end
	local showing = false
	local playerId = WindowData.PlayerStatus.PlayerId
	if( id == playerId ) then
		MenuBarWindow.ToggleInventoryWindow()	
	elseif( WindowData.Paperdoll[id].backpackId ~= nil ) then
		UserActionUseItem(WindowData.Paperdoll[id].backpackId,false)
	end
	
	local backpackName = "ContainerWindow_"..WindowData.Paperdoll[id].backpackId
	if(DoesWindowNameExist(backpackName)) then
		showing = WindowGetShowing(backpackName)
	end
		
	--ButtonSetPressedFlag( inventoryName, not showing )	
end

function PaperdollWindow.ToggleTab()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	local buttonId = WindowGetId(SystemData.ActiveWindow.name)
	local parent = "PaperdollWindow"..id
	
	PaperdollWindow.UnselectAllTabs(parent, id, 3)
	PaperdollWindow.SelectTab(parent, buttonId)

end

function PaperdollWindow.UnselectAllTabs(parent, id, numTabs)
	-- update profile text if paperdoll belongs to player
	local playerId = WindowData.PlayerStatus.PlayerId
	if( id == playerId and PaperdollWindow.CurrentTab == 3 ) then
		local windowName = "PaperdollWindow"..id
		local infoText = TextEditBoxGetText(windowName.."TabWindow3ProfileEditText")
		UpdateCharProfile(id,infoText)
	end
	
	for i = 1, numTabs do
		local tabName = parent.."TabButton"..i
		local tabSelected = tabName.."TabSelected"
		local tabWindow = parent.."TabWindow"..i
		WindowSetShowing(tabSelected, false)
		WindowSetShowing(tabWindow, false)
		ButtonSetDisabledFlag(tabName, false)
	end
end

function PaperdollWindow.SelectTab(parent, tabNum)
	local tabName = parent.."TabButton"..tabNum
	local tabSelected= tabName.."TabSelected"
	local tabWindow = parent.."TabWindow"..tabNum
	WindowSetShowing(tabSelected, true)
	WindowSetShowing(tabWindow, true)
	ButtonSetDisabledFlag(tabName, true)
	
	local characterSheetButton = parent.."ToggleCharacterSheet"
	local characterAbilitiesButton = parent.."ToggleCharacterAbilities"
	local inventoryButton = parent.."ToggleInventory"
	
	PaperdollWindow.CurrentTab = tabNum
	
	if (PaperdollWindow.CurrentTab == 3) then
		-- get the character's profile data
		SystemData.ActiveObject.Id = WindowGetId(WindowUtils.GetActiveDialog())
		BroadcastEvent(SystemData.Events.REQUEST_OPEN_CHAR_PROFILE)
	
		WindowSetShowing(characterSheetButton, false)
		WindowSetShowing(characterAbilitiesButton, false)
		WindowSetShowing(inventoryButton, false)
	else
		WindowSetShowing(inventoryButton, true)
		local playerId = WindowData.PlayerStatus.PlayerId
		local id = WindowGetId(WindowUtils.GetActiveDialog())
		
		if (playerId == id) then
			WindowSetShowing(characterSheetButton, true)
			WindowSetShowing(characterAbilitiesButton, true)
		end
	end
end

function PaperdollWindow.ToggleCharacterSheet()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "PaperdollWindow"..id
	local characterSheetName = windowName.."ToggleCharacterSheet"
	if (ButtonGetDisabledFlag(characterSheetName) ) then
		return
	end
	showing = WindowGetShowing("CharacterSheet")
	local playerId = WindowData.PlayerStatus.PlayerId
	-- if this is the players paperdoll toggle character sheet
	if( id == playerId ) then
		ToggleWindowByName("CharacterSheet", "", nil)
		ButtonSetPressedFlag( characterSheetName, not showing )
	end
end

function PaperdollWindow.ToggleCharacterAbilities()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "PaperdollWindow"..id
	local characterSheetName = windowName.."ToggleCharacterAbilities"
	if (ButtonGetDisabledFlag(characterSheetName) ) then
		return
	end
	showing = WindowGetShowing("CharacterAbilities")
	local playerId = WindowData.PlayerStatus.PlayerId
	-- if this is the players paperdoll toggle character sheet
	if( id == playerId ) then
		ToggleWindowByName("CharacterAbilities", "", nil)
		ButtonSetPressedFlag( characterSheetName, not showing )
	end
end

function PaperdollWindow.UpdateCharProfile()
    local id = WindowGetId(SystemData.ActiveWindow.name)
    if( id == WindowData.CharProfile.Id ) then
        local tabName = SystemData.ActiveWindow.name.."TabWindow3"
        if( id == WindowData.PlayerStatus.PlayerId ) then
            TextEditBoxSetText(tabName.."ProfileEditText",WindowData.CharProfile.Info)
            LabelSetText(tabName.."Age",WindowData.CharProfile.Age)
        else
            LabelSetText(tabName.."ProfileViewScrollChildText",WindowData.CharProfile.Info)
            ScrollWindowUpdateScrollRect(tabName.."ProfileViewScroll")
        end
    end
end

function PaperdollWindow.OnMouseOverToggleCharacterAbilities()
	local text = GetStringFromTid(1112228)
	local buttonName = SystemData.ActiveWindow.name
	Tooltips.CreateTextOnlyTooltip(buttonName, text)
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function PaperdollWindow.OnMouseOverToggleCharacterSheet()
	local text = GetStringFromTid(1077437)
	local buttonName = SystemData.ActiveWindow.name
	Tooltips.CreateTextOnlyTooltip(buttonName, text)
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function PaperdollWindow.RightClickClose()
	UO_DefaultWindow.CloseDialog()
end