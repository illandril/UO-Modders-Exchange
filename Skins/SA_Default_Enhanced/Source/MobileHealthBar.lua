----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MobileHealthBarWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

--If the health bar for it is already open
MobileHealthBarWindow.hasWindow = {}
MobileHealthBarWindow.windowDisabled = {}
MobileHealthBarWindow.groupExtend = {}
MobileHealthBarWindow.numHealthBar = 0
MobileHealthBarWindow.isDragging = false

MobileHealthBarWindow.groupMemberIds = {}
MobileHealthBarWindow.Spells = { Heal = 29, Cure = 11, Curse = 17 }

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function MobileHealthBarWindow.InitializeSystem()

	RegisterWindowData(WindowData.PartyMember.Type,0)
	WindowRegisterEventHandler( "Root", SystemData.Events.BEGIN_DRAG_HEALTHBAR_WINDOW, "MobileHealthBarWindow.OnBeginDragHealthBar")
	WindowRegisterEventHandler( "Root", SystemData.Events.END_DRAG_HEALTHBAR_WINDOW, "MobileHealthBarWindow.OnEndDragHealthBar")
	WindowRegisterEventHandler( "Root", WindowData.PartyMember.Event, "MobileHealthBarWindow.HandlePartyMemberUpdate")

	MobileHealthBarWindow.CreatePartyHealthBars()
end

function MobileHealthBarWindow.OnBeginDragHealthBar(id)

	local mobileId = SystemData.ActiveMobile.Id
	if(id ~= nil) then
		mobileId = id
	end
	
	MobileHealthBarWindow.isDragging = true
	WindowUtils.BeginDrag( MobileHealthBarWindow.CreateHealthBar, mobileId )
end

function MobileHealthBarWindow.OnEndDragHealthBar()

	MobileHealthBarWindow.isDragging = false
	WindowUtils.EndDrag()
end

function MobileHealthBarWindow.CreateHealthBar(mobileId)

    local windowName = "MobileHealthBarWindow"..mobileId
    local anchorToDefault = false
	
	chivalrySkillLevel = WindowData.SkillDynamicData[WindowData.SkillsCSV[13].ServerId].RealSkillValue
	magerySkillLevel = WindowData.SkillDynamicData[WindowData.SkillsCSV[32].ServerId].RealSkillValue

		if chivalrySkillLevel > magerySkillLevel then
			MobileHealthBarWindow.Spells = { Heal = 202, Cure = 201, Curse = 209 }
		end
	
	--Players can only have a max of 10 health bars out at a time
	if( MobileHealthBarWindow.numHealthBar >= 10 )then
		if( MobileHealthBarWindow.hasWindow[mobileId] == true ) then
			MobileHealthBarWindow.HandleAnchorWindow(windowName, anchorToDefault)
			WindowSetMoving(windowName, true)
			WindowAssignFocus(windowName, true)	
		end
		return
	end

	-- Create and register if doesn't exist
	if( DoesWindowNameExist(windowName) ~= true ) then
		CreateWindowFromTemplate(windowName, "MobileHealthBarWindow", "Root")
		
		MobileHealthBarWindow.hasWindow[mobileId] = true
		SnapUtils.SnappableWindows[windowName] = true
		Interface.DestroyWindowOnClose[windowName] = true
		
		WindowSetId(windowName, mobileId)
		
		RegisterWindowData(WindowData.MobileStatus.Type, mobileId)	
		RegisterWindowData(WindowData.MobileName.Type, mobileId)
		RegisterWindowData(WindowData.HealthBarColor.Type, mobileId)
		
		WindowRegisterEventHandler( windowName, WindowData.MobileStatus.Event, "MobileHealthBarWindow.HandleMobileStatusUpdate")
		WindowRegisterEventHandler( windowName, WindowData.MobileName.Event, "MobileHealthBarWindow.HandleMobileNameUpdate")
		WindowRegisterEventHandler( windowName, WindowData.HealthBarColor.Event, "MobileHealthBarWindow.HandleHealthBarColorUpdate")
		WindowRegisterEventHandler( windowName, SystemData.Events.ENABLE_HEALTHBAR_WINDOW, "MobileHealthBarWindow.HandleHealthBarState")
		WindowRegisterEventHandler( windowName, SystemData.Events.DISABLE_HEALTHBAR_WINDOW, "MobileHealthBarWindow.HandleHealthBarState")		
		
		MobileHealthBarWindow.windowDisabled[mobileId] = false
		WindowSetShowing(windowName.."ImageDisabled", false)
		
		MobileHealthBarWindow.numHealthBar = MobileHealthBarWindow.numHealthBar + 1
		
		anchorToDefault = true
	end
	
	-- Set party window appearance
	
	
	local petSize = table.getn(WindowData.Pets.PetId)
	local numPet
	local totalPet = 0
	local isPet = false
	for numPet = 1, petSize do
		if( WindowData.Pets.PetId[numPet] == mobileId) then
			isPet = true
		end
	end

	if (MobileHealthBarWindow.IsPartyMember(mobileId) == true or mobileId == WindowData.PlayerStatus.PlayerId) then

		WindowSetShowing(windowName.."HealthBar", false)
		WindowSetShowing(windowName.."Toggle", true)
		WindowSetShowing(windowName.."GroupBackground", true)
		WindowSetShowing(windowName.."GroupHealthBar", true)
		WindowSetShowing(windowName.."GroupManaBar", true)
		WindowSetShowing(windowName.."GroupStaminaBar", true)
		WindowSetShowing(windowName.."GroupHeal", true)
		WindowSetShowing(windowName.."GroupCure", true)
		WindowSetShowing(windowName.."GroupCurse", true)
		WindowSetShowing(windowName.."MhbWindowHits", false)
		WindowSetId(windowName.."GroupHeal", mobileId)
        WindowSetId(windowName.."GroupCure", mobileId)
		WindowSetId(windowName.."GroupCurse", mobileId)
        
        local mainWindowDimensionsX, mainWindowDimensionsY = _WindowGetDimensions(windowName.."Image")
        local partyWindowDimensionsX, partyWindowDimensionsY = _WindowGetDimensions(windowName.."GroupBackground")
		WindowSetDimensions(windowName, mainWindowDimensionsX, mainWindowDimensionsY + partyWindowDimensionsY) -- Dimensions of mobile bar and party extension together
		
		MobileHealthBarWindow.groupExtend[mobileId] = true
		
	-- Set normal window appearance
	-- consider a secondary clause test if mobileId is in Pets list
	elseif (isPet == true) then
	
		WindowClearAnchors( windowName.."GroupHeal" )
		WindowAddAnchor( windowName.."GroupHeal", "topleft", windowName.."Close", "topleft", -65, 15)	
		WindowClearAnchors( windowName.."GroupCurse" )
		WindowAddAnchor( windowName.."GroupCurse", "topright", windowName.."GroupCure", "topleft", 4, 0)	
		WindowSetShowing(windowName.."HealthBar", true)		
		
		WindowSetShowing(windowName.."Toggle", false)
		WindowSetShowing(windowName.."GroupBackground", false)
		WindowSetShowing(windowName.."GroupHealthBar", false)
		WindowSetShowing(windowName.."GroupManaBar", false)
		WindowSetShowing(windowName.."GroupStaminaBar", false)
		WindowSetShowing(windowName.."MhbWindowHits", false)
		WindowSetShowing(windowName.."GroupHeal", true)
		WindowSetShowing(windowName.."GroupCure", true)
		WindowSetShowing(windowName.."GroupCurse", true)
		WindowSetId(windowName.."GroupHeal", mobileId)
        WindowSetId(windowName.."GroupCure", mobileId)
		WindowSetId(windowName.."GroupCurse", mobileId)
		local mainWindowDimensionsX, mainWindowDimensionsY = _WindowGetDimensions(windowName.."Image")
		WindowSetDimensions(windowName, mainWindowDimensionsX, mainWindowDimensionsY) -- Dimensions of mobile bar and party extension together

		MobileHealthBarWindow.groupExtend[mobileId] = false
	else

		WindowSetShowing(windowName.."HealthBar", true)
		WindowSetShowing(windowName.."Toggle", false)
		WindowSetShowing(windowName.."GroupBackground", false)
		WindowSetShowing(windowName.."GroupHealthBar", false)
		WindowSetShowing(windowName.."GroupManaBar", false)
		WindowSetShowing(windowName.."GroupStaminaBar", false)
		WindowSetShowing(windowName.."MhbWindowHits", true)
		WindowSetShowing(windowName.."GroupHeal", false)
		WindowSetShowing(windowName.."GroupCure", false)
		WindowSetShowing(windowName.."GroupCurse", false)
		
		local mainWindowDimensionsX, mainWindowDimensionsY = _WindowGetDimensions(windowName.."Image")
		WindowSetDimensions(windowName, mainWindowDimensionsX, mainWindowDimensionsY) -- Dimensions of mobile bar and party extension together


		
		MobileHealthBarWindow.groupExtend[mobileId] = false		
	end

	local labelName = windowName.."MhbWindowHits"
	local curr =WindowData.MobileStatus[mobileId].CurrentHealth 
	local max = WindowData.MobileStatus[mobileId].MaxHealth 
	if ( curr < 0 or max <=0) then
		LabelSetText(labelName, StringToWString("Hits: Unknow"))
	else
		--Debug.Print(tostring(curr) .. "/" .. tostring(max))
		local perc = (curr/max)*100
		perc = math.floor(perc)
		--Debug.Print(tostring(perc))
		local gb = math.floor(2.55 * perc)
		if (MobileHealthBarWindow.windowDisabled[mobileId]==false) then
			LabelSetTextColor(labelName, 255, gb, gb)
			LabelSetText(labelName, StringToWString(tostring(perc) .. "%"))
		else
			LabelSetTextColor("MhbWindowHits", 150, 150, 150)
			LabelSetText(labelName, StringToWString("Hits: Unknow"))
		end
	end
	
	MobileHealthBarWindow.HandleAnchorWindow(windowName, anchorToDefault)
	MobileHealthBarWindow.TintHealthBar(mobileId)
	MobileHealthBarWindow.UpdateStatus(mobileId)
	MobileHealthBarWindow.UpdateName(mobileId)
	MobileHealthBarWindow.UpdateHealthBarState(mobileId)

	WindowAssignFocus(windowName, true)
end

function MobileHealthBarWindow.HandleHealthBarState()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	MobileHealthBarWindow.UpdateHealthBarState(mobileId)
end

--Sets the health window active
function MobileHealthBarWindow.UpdateHealthBarState(mobileId)
	-- enable window
	if( IsHealthBarEnabled(mobileId) == true and MobileHealthBarWindow.windowDisabled[mobileId]==true ) then
		local windowName = "MobileHealthBarWindow"..mobileId
		WindowSetShowing(windowName.."ImageDisabled", false)
		WindowSetShowing(windowName.."Image", true)
		
		local petSize = table.getn(WindowData.Pets.PetId)
		local numPet
		local totalPet = 0
		local isPet = false
		for numPet = 1, petSize do
			if( WindowData.Pets.PetId[numPet] == mobileId) then
				isPet = true
			end
		end
		if (mobileId == WindowData.PlayerStatus.PlayerId) then
			isPet = false
		end
		if (MobileHealthBarWindow.groupExtend[mobileId] == true) then
			WindowSetShowing(windowName.."GroupHealthBar", true)
			WindowSetShowing(windowName.."GroupManaBar", true)
			WindowSetShowing(windowName.."GroupStaminaBar", true)
			WindowSetShowing(windowName.."GroupHeal", true)
			WindowSetShowing(windowName.."GroupCure", true)
			WindowSetShowing(windowName.."GroupCurse", true)
		elseif (isPet == true) then
			WindowSetShowing(windowName.."HealthBar", true)
			WindowSetShowing(windowName.."GroupHealthBar", false)
			WindowSetShowing(windowName.."GroupManaBar", false)
			WindowSetShowing(windowName.."GroupStaminaBar", false)
			WindowSetShowing(windowName.."GroupHeal", true)
			WindowSetShowing(windowName.."GroupCure", true)
			WindowSetShowing(windowName.."GroupCurse", true)		
		else
			WindowSetShowing(windowName.."HealthBar", true)
		end
		
		MobileHealthBarWindow.windowDisabled[mobileId] = false
		RegisterWindowData(WindowData.MobileStatus.Type, mobileId)	
		RegisterWindowData(WindowData.HealthBarColor.Type, mobileId)
	 	MobileHealthBarWindow.UpdateStatus(mobileId)
	 	
	-- disable window
	elseif( IsHealthBarEnabled(mobileId) == false and MobileHealthBarWindow.windowDisabled[mobileId]==false ) then
		local windowName = "MobileHealthBarWindow"..mobileId
		WindowSetShowing(windowName.."ImageDisabled", true)
		WindowSetShowing(windowName.."Image", false)
		WindowSetShowing(windowName.."HealthBar",false)
		WindowSetShowing(windowName.."GroupHealthBar", false)
		WindowSetShowing(windowName.."GroupManaBar", false)
		WindowSetShowing(windowName.."GroupStaminaBar", false)
		WindowSetShowing(windowName.."GroupHeal", false)
		WindowSetShowing(windowName.."GroupCure", false)
		WindowSetShowing(windowName.."GroupCurse", false)
		
		MobileHealthBarWindow.windowDisabled[mobileId] = true
		UnregisterWindowData(WindowData.MobileStatus.Type, mobileId)
		UnregisterWindowData(WindowData.HealthBarColor.Type, mobileId)
	end
end

--Sets the Window close to where the player dragged their mouse
function MobileHealthBarWindow.HandleAnchorWindow(healthWindow, defaultAnchor)
	local propWindowX = 0
	local propWindowY = 0
	local scaleFactor = 1/InterfaceCore.scale	
	
	if(MobileHealthBarWindow.isDragging == true) then
		local propWindowWidth = 180
		local propWindowHeight = 38
		
		-- Set the position
		mouseX = SystemData.MousePosition.x - 30
		if mouseX + (propWindowWidth / scaleFactor) > SystemData.screenResolution.x then
			propWindowX = mouseX - (propWindowWidth / scaleFactor)
		else
			propWindowX = mouseX
		end
			
		mouseY = SystemData.MousePosition.y - 15
		if mouseY + (propWindowHeight / scaleFactor) > SystemData.screenResolution.y then
			propWindowY = mouseY - (propWindowHeight / scaleFactor)
		else
			propWindowY = mouseY
		end
		
		SnapUtils.StartWindowSnap(healthWindow)
		MobileHealthBarWindow.isDragging = false
		
		WindowSetOffsetFromParent(healthWindow, propWindowX * scaleFactor, propWindowY * scaleFactor)
		
	elseif(defaultAnchor == true) then
		for key, mobileId in pairs(MobileHealthBarWindow.groupMemberIds) do
			local windowName = "MobileHealthBarWindow"..mobileId
			if(healthWindow == windowName) then
				local partyWindowYStart = 100
				local mainWindowDimensionsX, mainWindowDimensionsY = _WindowGetDimensions(windowName.."Image")
				local partyWindowDimensionsX, partyWindowDimensionsY = _WindowGetDimensions(windowName.."GroupBackground")
				propWindowY = partyWindowYStart + (key * ((mainWindowDimensionsY + partyWindowDimensionsY )/ scaleFactor) )
				break
			end
		end
		
		WindowSetOffsetFromParent(healthWindow, propWindowX * scaleFactor, propWindowY * scaleFactor)
	end
end

function MobileHealthBarWindow.HandleMobileNameUpdate()
    MobileHealthBarWindow.UpdateName(WindowData.UpdateInstanceId)
end

function MobileHealthBarWindow.UpdateName(mobileId)
	local windowName = "MobileHealthBarWindow"..mobileId
	if( (MobileHealthBarWindow.hasWindow[mobileId] == true) ) then
		if(WindowData.MobileName[mobileId] ~= nil) then
			local data = WindowData.MobileName[mobileId]
			LabelSetText(windowName.."Name", data.MobName)
			WindowUtils.FitTextToLabel(windowName.."Name", data.MobName)
			
			NameColor.UpdateLabelNameColor(windowName.."Name", data.Notoriety+1)
		else
			LabelSetText(windowName.."Name", L"???" )
		end
	end
end

function MobileHealthBarWindow.HandleMobileStatusUpdate()
    MobileHealthBarWindow.UpdateStatus(WindowData.UpdateInstanceId)
end

function MobileHealthBarWindow.UpdateStatus(mobileId)
	local windowName = "MobileHealthBarWindow"..mobileId

	--Set mobile's health status bar if their health bar is showing and not disabled
	if( MobileHealthBarWindow.hasWindow[mobileId] == true and MobileHealthBarWindow.windowDisabled[mobileId] == false ) then
		local curHealth = WindowData.MobileStatus[mobileId].CurrentHealth
		local maxHealth = WindowData.MobileStatus[mobileId].MaxHealth
		local curMana =  WindowData.MobileStatus[mobileId].CurrentMana
		local maxMana =  WindowData.MobileStatus[mobileId].MaxMana
		local curStamina = WindowData.MobileStatus[mobileId].CurrentStamina
		local maxStamina = WindowData.MobileStatus[mobileId].MaxStamina
		
		-- If current and max mana and stamina are zero and mobileId isn't dead, then updates have not come in yet
		if( curMana == 0 and maxMana == 0 and WindowData.MobileStatus[mobileId].IsDead == false) then
			curMana = 1
			maxMana = 1
		end
		if( curStamina == 0 and maxStamina == 0 and WindowData.MobileStatus[mobileId].IsDead == false) then
			curStamina = 1
			maxStamina = 1
		end
		
		StatusBarSetCurrentValue( windowName.."HealthBar", curHealth )	
		StatusBarSetMaximumValue( windowName.."HealthBar", maxHealth )
		StatusBarSetCurrentValue( windowName.."GroupHealthBar", curHealth )	
		StatusBarSetMaximumValue( windowName.."GroupHealthBar", maxHealth )
		StatusBarSetCurrentValue( windowName.."GroupManaBar", curMana )	
		StatusBarSetMaximumValue( windowName.."GroupManaBar", maxMana )
		StatusBarSetCurrentValue( windowName.."GroupStaminaBar", curStamina )	
		StatusBarSetMaximumValue( windowName.."GroupStaminaBar", maxStamina )
	local labelName = windowName.."MhbWindowHits"
	local curr =WindowData.MobileStatus[mobileId].CurrentHealth 
	local max = WindowData.MobileStatus[mobileId].MaxHealth 
	if ( curr < 0 or max <=0) then
		LabelSetText(labelName, StringToWString("Hits: Unknow"))
	else
		--Debug.Print(tostring(curr) .. "/" .. tostring(max))
		local perc = (curr/max)*100
		perc = math.floor(perc)
		--Debug.Print(tostring(perc))
		local gb = math.floor(2.55 * perc)
		if (MobileHealthBarWindow.windowDisabled[mobileId]==false) then
			LabelSetTextColor(labelName, 255, gb, gb)
			LabelSetText(labelName, StringToWString(tostring(perc) .. "%"))
		else
			LabelSetTextColor("MhbWindowHits", 150, 150, 150)
			LabelSetText(labelName, StringToWString("Hits: Unknow"))
		end
	end

	end
end

function MobileHealthBarWindow.HandleHealthBarColorUpdate()
    MobileHealthBarWindow.TintHealthBar(WindowData.UpdateInstanceId)
end

function MobileHealthBarWindow.TintHealthBar(mobileId)
	local windowName = "MobileHealthBarWindow"..mobileId
	
	--Colors the health bar to the correct color
	local windowTintName = windowName.."HealthBar"
	HealthBarColor.UpdateHealthBarColor(windowTintName, WindowData.HealthBarColor[mobileId].VisualStateId)
	
	windowTintName = windowName.."GroupHealthBar"
	HealthBarColor.UpdateHealthBarColor(windowTintName, WindowData.HealthBarColor[mobileId].VisualStateId)
end

function MobileHealthBarWindow.HandlePartyMemberUpdate()
	MobileHealthBarWindow.ClearOldPartyHealthBars()
	MobileHealthBarWindow.CreatePartyHealthBars()
end

function MobileHealthBarWindow.ClearOldPartyHealthBars()
	for key, mobileId in pairs(MobileHealthBarWindow.groupMemberIds) do
		if(MobileHealthBarWindow.IsPartyMember(mobileId) == false) then
			MobileHealthBarWindow.CloseHealthBar(mobileId)
		end
	end
	
	MobileHealthBarWindow.groupMemberIds = {}
end

function MobileHealthBarWindow.CreatePartyHealthBars()
	local i = 1
    if (WindowData.PartyMember.NUM_PARTY_MEMBERS > 0) then
		while (i <= WindowData.PartyMember.NUM_PARTY_MEMBERS) do
	    	local currentPartyMemberId = WindowData.PartyMember[i].memberId
	    	MobileHealthBarWindow.groupMemberIds[i] = currentPartyMemberId
	    	MobileHealthBarWindow.CreateHealthBar(currentPartyMemberId)
			i = i+1
	    end
    end
end

function MobileHealthBarWindow.IsPartyMember(mobileId)
	local i = 1
	if (WindowData.PartyMember.NUM_PARTY_MEMBERS > 0) then
		while (i <= WindowData.PartyMember.NUM_PARTY_MEMBERS) do
	    	local currentPartyMemberId = WindowData.PartyMember[i].memberId
	    	if (currentPartyMemberId == mobileId) then
	    		return true
			end
			i = i+1
	    end
	end
	
	return false
end

function MobileHealthBarWindow.UnRegisterVariables(healthId)
	--Only unregister window data if the window is not disabled since it was already unregistered
	if(MobileHealthBarWindow.windowDisabled[healthId] == nil or MobileHealthBarWindow.windowDisabled[healthId] == false ) then
		UnregisterWindowData(WindowData.MobileStatus.Type, healthId)
		UnregisterWindowData(WindowData.HealthBarColor.Type, healthId)
	end
	
	UnregisterWindowData(WindowData.MobileName.Type, healthId)
	MobileHealthBarWindow.hasWindow[healthId] = nil
	MobileHealthBarWindow.windowDisabled[healthId] = nil
	MobileHealthBarWindow.groupExtend[healthId] = nil
end

function MobileHealthBarWindow.CloseHealthBar(mobileId)
	local windowName = "MobileHealthBarWindow"..mobileId
	if( DoesWindowNameExist(windowName) == true) then
		DestroyWindow(windowName)
	end
end

function MobileHealthBarWindow.Shutdown()
    windowName = WindowUtils.GetActiveDialog()
	local mobileId = WindowGetId(windowName)
	MobileHealthBarWindow.UnRegisterVariables(mobileId)
	MobileHealthBarWindow.numHealthBar = MobileHealthBarWindow.numHealthBar - 1
	SnapUtils.SnappableWindows[windowName] = nil
end

function MobileHealthBarWindow.OnMobileDblClicked()
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	--If health window is not disabled trigger object use
	if( MobileHealthBarWindow.windowDisabled[mobileId] ~= true) then
		UserActionUseItem(mobileId,false)
	end
end

function MobileHealthBarWindow.OnItemClicked()
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	--If health window is not disabled do handle left single click
	if( MobileHealthBarWindow.windowDisabled[mobileId] ~= true) then
		HandleSingleLeftClkTarget(mobileId)
	end
end

function MobileHealthBarWindow.OnMouseDrag()
    SnapUtils.StartWindowSnap(WindowUtils.GetActiveDialog())
end

function MobileHealthBarWindow.LeftClickClose()
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "MobileHealthBarWindow"..mobileId
	if( MobileHealthBarWindow.hasWindow[mobileId] == true) then
		DestroyWindow(windowName)
	end	
end

function MobileHealthBarWindow.ToggleGroupExtend()
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "MobileHealthBarWindow"..mobileId
		
	local petSize = table.getn(WindowData.Pets.PetId)
	local numPet
	local totalPet = 0
	local isPet = false
	for numPet = 1, petSize do
		if( WindowData.Pets.PetId[numPet] == mobileId) then
			isPet = true
		end
	end
	if (mobileId == WindowData.PlayerStatus.PlayerId) then
		isPet = false
	end
	-- Set party window appearance
	if ( WindowGetShowing( windowName.."GroupBackground" ) == false ) then
		WindowSetShowing(windowName.."HealthBar", false)
		WindowSetShowing(windowName.."GroupBackground", true)
		WindowSetShowing(windowName.."GroupHealthBar", true)
		if (isPet == false) then
			WindowSetShowing(windowName.."GroupManaBar", true)
			WindowSetShowing(windowName.."GroupStaminaBar", true)
		end
		WindowSetShowing(windowName.."GroupHeal", true)
		WindowSetShowing(windowName.."GroupCure", true)
		WindowSetShowing(windowName.."GroupCurse", true)
		WindowSetId(windowName.."GroupHeal", mobileId)
        WindowSetId(windowName.."GroupCure", mobileId)
		WindowSetId(windowName.."GroupCurse", mobileId)
        
        local mainWindowDimensionsX, mainWindowDimensionsY = _WindowGetDimensions(windowName.."Image")
        local partyWindowDimensionsX, partyWindowDimensionsY = _WindowGetDimensions(windowName.."GroupBackground")
		WindowSetDimensions(windowName, mainWindowDimensionsX, mainWindowDimensionsY + partyWindowDimensionsY) -- Dimensions of mobile bar and party extension together
		
		MobileHealthBarWindow.groupExtend[mobileId] = true
	
	-- Set normal window appearance
	else
		WindowSetShowing(windowName.."HealthBar", true)
		WindowSetShowing(windowName.."GroupBackground", false)
		WindowSetShowing(windowName.."GroupHealthBar", false)
		WindowSetShowing(windowName.."GroupManaBar", false)
		WindowSetShowing(windowName.."GroupStaminaBar", false)
		WindowSetShowing(windowName.."GroupHeal", false)
		WindowSetShowing(windowName.."GroupCure", false)
		WindowSetShowing(windowName.."GroupCurse", false)
		
		local mainWindowDimensionsX, mainWindowDimensionsY = _WindowGetDimensions(windowName.."Image")
		WindowSetDimensions(windowName, mainWindowDimensionsX, mainWindowDimensionsY) -- Dimensions of mobile bar and party extension together
		
		MobileHealthBarWindow.groupExtend[mobileId] = false
	end
end

function MobileHealthBarWindow.OnRClick()
	RequestContextMenu(SystemData.ActiveMobile.Id)
end

--Steals the L Button Up when it is above this window, so that way when you drag it off a player
--it doesn't try to do another mouse click interaction with it.
function MobileHealthBarWindow.OnLButtonUp()

end

function MobileHealthBarWindow.HealMember()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	if(mobileId) then
		UserActionCastSpellOnId(MobileHealthBarWindow.Spells.Heal, mobileId)
	end
end

function MobileHealthBarWindow.CureMember()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	if(mobileId) then
		UserActionCastSpellOnId(MobileHealthBarWindow.Spells.Cure, mobileId)
	end
end

function MobileHealthBarWindow.CurseMember()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	if(mobileId) then
		UserActionCastSpellOnId(MobileHealthBarWindow.Spells.Curse, mobileId)
	end
end


function MobileHealthBarWindow.ViewHealButtonMouseOver()
	local messageText = L"Cast Heal/Close Wounds"
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)

	local itemData = { windowName = SystemData.ActiveWindow.name,
						itemId = mobileId,
						itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
						binding = L"",
						detail = nil,
						title =	messageText,
						body = L""}

	ItemProperties.SetActiveItem(itemData)
end

function MobileHealthBarWindow.ViewCureButtonMouseOver()
	local messageText = L"Cast Cure/Cleanse"
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)

	local itemData = { windowName = SystemData.ActiveWindow.name,
						itemId = mobileId,
						itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
						binding = L"",
						detail = nil,
						title =	messageText,
						body = L""}

	ItemProperties.SetActiveItem(itemData)
end

function MobileHealthBarWindow.ViewCurseButtonMouseOver()
	local messageText = L"Cast Bless/Remove Curse"
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)

	local itemData = { windowName = SystemData.ActiveWindow.name,
						itemId = mobileId,
						itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
						binding = L"",
						detail = nil,
						title =	messageText,
						body = L""}

	ItemProperties.SetActiveItem(itemData)
end