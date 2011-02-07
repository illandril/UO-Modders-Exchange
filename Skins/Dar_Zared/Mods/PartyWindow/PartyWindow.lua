----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

PartyWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

PartyWindow.windowName = "PartyWindow"
PartyWindow.hasWindow = {}
PartyWindow.reverseIndexId = {}
PartyWindow.OffetSize = 40
PartyWindow.windowX = 175
PartyWindow.windowY = 60
PartyWindow.windowOffset = 0
PartyWindow.windowCount = 1
PartyWindow.groupMemberIds = {}
PartyWindow.Spells = { Heal = 29, Cure = 11}
----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function PartyWindow.Initialize()
	--Debug.Print("PartyWindow.Initalize()")
	local windowName = "PartyWindow"
	local titleName = windowName.."ShowViewName"
	LabelSetText(titleName, L"Party" )
	
	RegisterWindowData(WindowData.PartyMember.Type, 0)	
	WindowRegisterEventHandler( "PartyWindow", WindowData.PartyMember.Event, "PartyWindow.UpdateParty")
	WindowRegisterEventHandler( "PartyWindow", WindowData.MobileStatus.Event, "PartyWindow.HandleUpdateStatusEvent")
	WindowRegisterEventHandler( "PartyWindow", WindowData.HealthBarColor.Event, "PartyWindow.HandleTintHealthBarEvent")
	
	local backgroundName = windowName.."ShowViewBackground"
	WindowSetAlpha(backgroundName, 0.5)
	WindowUtils.RestoreWindowPosition("PartyWindow")
	PartyWindow.UpdateParty()
	
	PartyWindow.ShowParty()
end


function PartyWindow.Shutdown()
	local windowName = "PartyWindow"
	local showName = windowName.."ShowView"
	SnapUtils.SnappableWindows[showName] = nil
	
	for key,value in pairs(PartyWindow.hasWindow) do
		PartyWindow.ClearHealthBarData(key)
	end
	UnregisterWindowData(WindowData.PartyMember.Type, 0)	
	WindowUnregisterEventHandler( "PartyWindow", WindowData.PartyMember.Event)
	WindowUtils.SaveWindowPosition(windowName)
end

function PartyWindow.HideAll()
	WindowSetShowing(PartyWindow.windowName, false)
end

function PartyWindow.ShowWindow()
	if  not WindowGetShowing(PartyWindow.windowName) then
		WindowSetShowing(PartyWindow.windowName, true)
	end
end

function PartyWindow.UpdateParty()
	--Debug.Print("Made it to UpdateParty")
	if (CustomSettings.LoadBooleanValue( { settingName="dzUsePartyWindow", defaultValue=true } )) then
		PartyWindow.ClearOldPartyHealthBars()
		PartyWindow.ShowWindow()
		PartyWindow.CreatePartyHealthBars()
	end
end

function PartyWindow.IsPartyMember(mobileId)
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

function PartyWindow.ClearOldPartyHealthBars()
	for key, mobileId in pairs(PartyWindow.groupMemberIds) do
			--Debug.Print("ClearOldPartyHealthBars")
		--if(PartyWindow.IsPartyMember(mobileId) == false) then
			PartyWindow.CloseHealthBar(mobileId)
		--end
	end	
	WindowSetDimensions(PartyWindow.windowName, PartyWindow.windowX, PartyWindow.windowY)
	PartyWindow.groupMemberIds = {}
	PartyWindow.reverseIndexId = {}
end

function PartyWindow.CreatePartyHealthBars()
	local i = 1
    if (WindowData.PartyMember.NUM_PARTY_MEMBERS > 0) then
		while (i <= WindowData.PartyMember.NUM_PARTY_MEMBERS) do
	    	local currentPartyMemberId = WindowData.PartyMember[i].memberId
	    	--Debug.Print("CreatePartyHealthBars "..currentPartyMemberId)
	    	PartyWindow.groupMemberIds[i] = currentPartyMemberId
	    	PartyWindow.CreateHealthBar(i, currentPartyMemberId)
			i = i+1
	    end
	else
		PartyWindow.HideAll()
    end
end

function PartyWindow.CloseHealthBar(mobileId)
	local windowName = "PartyWindowShowViewPartyHealthBar"..PartyWindow.reverseIndexId[mobileId]
	
			--Debug.Print("Destroying..."..windowName)
	if( DoesWindowNameExist(windowName) == true) then
		UnregisterWindowData(WindowData.MobileStatus.Type, mobileId)
		UnregisterWindowData(WindowData.MobileName.Type, mobileId)
		UnregisterWindowData(WindowData.HealthBarColor.Type, mobileId)
		DestroyWindow(windowName)
	end
end

function PartyWindow.OnRClick()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	RequestContextMenu(mobileId)
end

function PartyWindow.UpdateHealthBarId(index, mobileId)
	local parent = PartyWindow.windowName
	local showName = parent.."ShowView"
	local healthName = showName.."PartyHealthBar"..index
	--local inputName = healthName.."InputName"	
	
	--Debug.Print("Player Id "..mobileId)
	--WindowSetId(healthName, mobileId)
	--WindowSetId(inputName, mobileId)	
	
	--PartyWindow.hasWindow[mobileId] = true
	--PartyWindow.reverseIndexId[mobileId] = index
	

	RegisterWindowData(WindowData.MobileStatus.Type, mobileId)	
	RegisterWindowData(WindowData.MobileName.Type, mobileId)
	RegisterWindowData(WindowData.HealthBarColor.Type, mobileId)
	
	WindowSetShowing(healthName, true)
	
	--Size of window is default size 200 time 45 every time a new healthbar gets created
	local propWindowHeight = PartyWindow.windowY + (PartyWindow.OffetSize * index)
	WindowSetDimensions(parent, PartyWindow.windowX, propWindowHeight)
	WindowSetDimensions(showName, PartyWindow.windowX, propWindowHeight)
	PartyWindow.UpdateStatus(mobileId)
	PartyWindow.UpdateName(mobileId)
	--Debug.Print("Going to Tint PartyHealthBar")
	PartyWindow.TintHealthBar(mobileId)

end

function PartyWindow.CreateHealthBar(index, mobileId)
	local parent = "PartyWindow"
	local showName = parent.."ShowView"
	local healthName = showName.."PartyHealthBar"..index

	--Debug.Print("CreatingHealthBar "..healthName)
	CreateWindowFromTemplate(healthName, "PartyHealthBarTemplate", showName)

	WindowSetId(healthName, mobileId)
	PartyWindow.hasWindow[mobileId] = true
	PartyWindow.reverseIndexId[mobileId] = index
	PartyWindow.windowCount = PartyWindow.windowCount + 1
	
	--Debug.Print("Index = "..index)
	
	Debug.Print(L""..mobileId)
	if ( index == 1 ) then
		WindowAddAnchor(healthName, "bottomleft", showName.."TitleBar", "topleft", 10, -10 )
		--Debug.Print("1st Time")
	else
		WindowAddAnchor(healthName, "bottomleft", showName.."PartyHealthBar"..(index-1), "topleft", 0, PartyWindow.windowOffset)
		--Debug.Print("2nd Time....")
	end
	PartyWindow.UpdateHealthBarId(index, mobileId)
	PartyWindow.UpdateName(mobileId)
	 
end

function PartyWindow.ClearHealthBarData(mobileId)
	if(PartyWindow.reverseIndexId[mobileId] ~= nil) then
		local parent = "PartyWindow"
		local showName = parent.."ShowView"
		local healthName = showName.."PartyHealthBar"..PartyWindow.reverseIndexId[mobileId]
		WindowSetShowing(healthName, false)
		
		PartyWindow.hasWindow[mobileId] = false
		PartyWindow.reverseIndexId[mobileId] = nil
		UnregisterWindowData(WindowData.MobileStatus.Type, mobileId)
		UnregisterWindowData(WindowData.MobileName.Type, mobileId)
		UnregisterWindowData(WindowData.HealthBarColor.Type, mobileId)
	end
end

function PartyWindow.HandleUpdateNameEvent()
    PartyWindow.UpdateName(WindowData.UpdateInstanceId)
end

function PartyWindow.UpdateName(mobileId)
	local windowName = "PartyWindowShowViewPartyHealthBar"..PartyWindow.reverseIndexId[mobileId]
	--Debug.Print("UpdateNames "..windowName)
	if( (PartyWindow.hasWindow[mobileId] == true) ) then
		--Debug.Print("UpdateNames HAS WINDOW")
		if(WindowData.MobileName[mobileId] ~= nil) then
			local data = WindowData.MobileName[mobileId]
			LabelSetText(windowName.."LabelName", data.MobName)
			WindowUtils.FitTextToLabel(windowName.."LabelName", data.MobName)
			
			NameColor.UpdateLabelNameColor(windowName.."LabelName", data.Notoriety+1)
		else
			LabelSetText(windowName.."Name", L"???" )
		end
	end
end

function PartyWindow.HandleUpdateStatusEvent()
    PartyWindow.UpdateStatus(WindowData.UpdateInstanceId)
end

function PartyWindow.UpdateStatus(mobileId)
	if(PartyWindow.reverseIndexId[mobileId] ~= nil) then
		local windowName = "PartyWindowShowViewPartyHealthBar"..PartyWindow.reverseIndexId[mobileId]
		--Debug.Print("UpdateStatus "..windowName)
		--Set mobiles health status bar and name if their health bar is showing and not disabled
		if( (PartyWindow.hasWindow[mobileId] == true) ) then
			
			StatusBarSetCurrentValue( windowName.."HealthBar", WindowData.MobileStatus[mobileId].CurrentHealth )	
			StatusBarSetMaximumValue( windowName.."HealthBar", WindowData.MobileStatus[mobileId].MaxHealth )
		end
	end
end

function PartyWindow.HideParty()
	--Debug.Print("PartyWindow.HideParty")
	local windowName = "PartyWindow"
	local showName = windowName.."ShowView"
	local hideName = windowName.."HideView"
	
	local newWindowPosX, newWindowPosY = WindowGetScreenPosition(windowName)
    if(newWindowPosX < 0) then
		WindowUtils.CopyScreenPosition(windowName,windowName,-newWindowPosX,0)
    end
	
	WindowSetShowing(showName, false)
	WindowSetShowing(hideName, true)
	
	SnapUtils.SnappableWindows[showName] = nil
end

function PartyWindow.ShowParty()
	--Debug.Print("PartyWindow.ShowParty")
	local windowName = "PartyWindow"
	local showName = windowName.."ShowView"
	local hideName = windowName.."HideView"
	
	WindowSetShowing(showName, true)
	WindowSetShowing(hideName, false)
	
	SnapUtils.SnappableWindows[showName] = true
end

function PartyWindow.OnItemClicked()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	if(mobileId ~= nil)then
		--Handle Single Left Click on pet window in uo_targetmanager
		HandleSingleLeftClkTarget(mobileId)
	end
end

--When player double clicks the object handle window it acts as if they double-clicked the object itself
function PartyWindow.OnDblClick()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)	
	UserActionUseItem(mobileId,false)
end

function PartyWindow.OnRClick()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	--Debug.Print("PartyWindow.OnRClick() id="..mobileId)
	RequestContextMenu(mobileId)
end

function PartyWindow.OnMouseDrag()
	--Debug.Print("PartyWindow.OnMouseDrag")
	local windowName = "PartyWindow"
	local showName = windowName.."ShowView"
	if (SnapUtils.SnappableWindows[showName] == true) then
		SnapUtils.StartWindowSnap(showName)
	end
end

function PartyWindow.HandleTintHealthBarEvent()
    PartyWindow.TintHealthBar(WindowData.UpdateInstanceId)
end

function PartyWindow.TintHealthBar(mobileId)
	--Debug.Print("TintHealthBar"..PartyWindow.reverseIndexId[mobileId].." - "..mobileId)
	if( IsMobile(mobileId) ) then
		local windowTintName = "PartyWindowShowViewPartyHealthBar"..PartyWindow.reverseIndexId[mobileId].."HealthBar"
	--Debug.Print("TintHealthBar "..windowTintName)
		--Colors the health bar to the correct color
		HealthBarColor.UpdateHealthBarColor(windowTintName, WindowData.HealthBarColor[mobileId].VisualStateId)
	end
end
	
function PartyWindow.HealMember()
	local mobileId = WindowGetId( WindowGetParent(SystemData.ActiveWindow.name))
	--Debug.Print(SystemData.ActiveWindow.name)
	--Debug.Print(L""..mobileId)
	if(mobileId) then
		UserActionCastSpellOnId(PartyWindow.Spells.Heal, mobileId)
	end
end

function PartyWindow.CureMember()
	local mobileId = WindowGetId( WindowGetParent(SystemData.ActiveWindow.name))
	--Debug.Print(SystemData.ActiveWindow.name)
	if(mobileId) then
	--Debug.Print(L""..mobileId)
		UserActionCastSpellOnId(PartyWindow.Spells.Cure, mobileId)
	end
end

function PartyWindow.PartyClose()
	SendChat(L"/quit")
end

function PartyWindow.CloseButtonToolTip()
	if (WindowData.PartyMember.partyLeaderId == WindowData.PlayerStatus.PlayerId) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, L"Disband the Party")
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, L"Leave Party")
	end
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end