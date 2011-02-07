----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

PetWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

PetWindow.hasWindow = {}
PetWindow.reverseIndexId = {}
PetWindow.tid = { PET = 1077432}
PetWindow.OffetSize =40
PetWindow.windowX = 175
PetWindow.windowY = 60
PetWindow.windowOffset = 0
PetWindow.windowCount = 1
PetWindow.Spells = { Heal = 29, Cure = 11}
----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function PetWindow.Initialize()
	--Debug.Print("PetWindow.Initalize()")
	local windowName = "PetWindow"
	local titleName = windowName.."ShowViewName"
	LabelSetText(titleName, GetStringFromTid(PetWindow.tid.PET) )
	
	RegisterWindowData(WindowData.Pets.Type, 0)	
	WindowRegisterEventHandler( "PetWindow", WindowData.Pets.Event, "PetWindow.UpdatePets")
	WindowRegisterEventHandler( "PetWindow", WindowData.MobileName.Event, "PetWindow.HandleUpdateNameEvent")
	WindowRegisterEventHandler( "PetWindow", WindowData.MobileStatus.Event, "PetWindow.HandleUpdateStatusEvent")
	WindowRegisterEventHandler( "PetWindow", WindowData.HealthBarColor.Event, "PetWindow.HandleTintHealthBarEvent")
	--WindowRegisterEventHandler( "Root", SystemData.Events.BEGIN_DRAG_HEALTHBAR_WINDOW, "PetWindow.OnBeginDragHealthBar")
	--WindowRegisterEventHandler( "Root", SystemData.Events.END_DRAG_HEALTHBAR_WINDOW, "PetWindow.OnEndDragHealthBar")
	
	local backgroundName = windowName.."ShowViewBackground"
	WindowSetAlpha(backgroundName, 0.5)
	WindowUtils.RestoreWindowPosition("PetWindow")
	PetWindow.UpdatePets()
	
	PetWindow.ShowPet()
end

function PetWindow.Shutdown()
	local windowName = "PetWindow"
	local showName = windowName.."ShowView"
	SnapUtils.SnappableWindows[showName] = nil
	
	for key,value in pairs(PetWindow.hasWindow) do
		PetWindow.ClearHealthBarData(key)
	end
	UnregisterWindowData(WindowData.Pets.Type, 0)	
	WindowUtils.SaveWindowPosition(windowName)
end

function PetWindow.HideAll()
	local windowName = "PetWindow"
	WindowSetShowing(windowName, false)
end

function PetWindow.ShowWindow()
	local windowName = "PetWindow"
	WindowSetShowing(windowName, true)
end

function PetWindow.UpdatePets()
	--Debug.Print("PetWindow.UpdatePets()")
	--Need to clear out the old pet information before creation new healthbar information
	local petSize = table.getn(WindowData.Pets.PetId)
	local numPet
	local totalPet = 0
	for numPet = 1, petSize do
		if(IsMobile(WindowData.Pets.PetId[numPet])) then
			totalPet = totalPet + 1
		end
	end
	
	for key,value in pairs(PetWindow.hasWindow) do
		PetWindow.ClearHealthBarData(key)
	end
	
	if(totalPet == 0) then
		local parent = "PetWindow"
		local showName = parent.."ShowView"
		--local propWindowHeight = PetWindow.windowY + (PetWindow.OffetSize * totalPet)
		WindowSetDimensions(parent, PetWindow.windowX, PetWindow.windowY)
		WindowSetDimensions(showName, PetWindow.windowX,  PetWindow.windowY)
		PetWindow.HideAll()
		return
	else
		PetWindow.ShowWindow()
	end

	--Debug.Print("PetWindow.UpdatePets() size= "..totalPet)
	if(totalPet >= PetWindow.windowCount ) then
		local howMany = PetWindow.windowCount
		local j
		for j=howMany, totalPet  do
			PetWindow.CreateHealthBar(j)
		end
	end
	
	local i
	local count = 1
	for i=1, petSize do
		if(IsMobile(WindowData.Pets.PetId[i])) then
			PetWindow.UpdateHealthBarId(count, WindowData.Pets.PetId[i])
			count = count + 1
		end
	end
end

function PetWindow.UpdateHealthBarId(index, mobileId)
	local parent = "PetWindow"
	local showName = parent.."ShowView"
	local healthName = showName.."PetHealthBar"..index
	local inputName = healthName.."InputName"	
	
	--Debug.Print("Pet Id "..mobileId)
	WindowSetId(healthName, mobileId)
	--WindowSetId(inputName, mobileId)
	WindowSetId(healthName.."EditName", mobileId)
	
	PetWindow.hasWindow[mobileId] = true
	PetWindow.reverseIndexId[mobileId] = index
	RegisterWindowData(WindowData.MobileStatus.Type, mobileId)	
	RegisterWindowData(WindowData.MobileName.Type, mobileId)
	RegisterWindowData(WindowData.HealthBarColor.Type, mobileId)
	
	WindowSetShowing(healthName, true)
	
	--Size of window is default size 200 time 45 every time a new healthbar gets created
	local propWindowHeight = PetWindow.windowY + (PetWindow.OffetSize * index)
	WindowSetDimensions(parent, PetWindow.windowX, propWindowHeight)
	WindowSetDimensions(showName, PetWindow.windowX, propWindowHeight)
	PetWindow.UpdateStatus(mobileId)
	PetWindow.UpdateName(mobileId)
	PetWindow.TintHealthBar(mobileId)

end

function PetWindow.CreateHealthBar(index)
	local parent = "PetWindow"
	local showName = parent.."ShowView"
	local healthName = showName.."PetHealthBar"..index

	CreateWindowFromTemplate(healthName, "PetHealthBarTemplate", showName)

	PetWindow.windowCount = PetWindow.windowCount + 1

	if ( index == 1 ) then
		WindowAddAnchor(healthName, "bottomleft", showName.."TitleBar", "topleft", 10, -10 )
	else
		WindowAddAnchor(healthName, "bottomleft", showName.."PetHealthBar"..(index-1), "topleft", 0, PetWindow.windowOffset)
	end
end

function PetWindow.ClearHealthBarData(mobileId)
	if(PetWindow.reverseIndexId[mobileId] ~= nil) then
		local parent = "PetWindow"
		local showName = parent.."ShowView"
		local healthName = showName.."PetHealthBar"..PetWindow.reverseIndexId[mobileId]
		WindowSetShowing(healthName, false)
		
		PetWindow.hasWindow[mobileId] = false
		PetWindow.reverseIndexId[mobileId] = nil
		UnregisterWindowData(WindowData.MobileStatus.Type, mobileId)
		UnregisterWindowData(WindowData.MobileName.Type, mobileId)
		UnregisterWindowData(WindowData.HealthBarColor.Type, mobileId)
	end
end

function PetWindow.HandleUpdateNameEvent()
    PetWindow.UpdateName(WindowData.UpdateInstanceId)
end

function PetWindow.UpdateName(mobileId)
	if(PetWindow.reverseIndexId[mobileId] ~= nil) then
		local windowName = "PetWindowShowViewPetHealthBar"..PetWindow.reverseIndexId[mobileId]
		local data = WindowData.MobileName[mobileId]
		--Set mobiles health status bar and name if their health bar is showing and not disabled
		if( (PetWindow.hasWindow[mobileId] == true) and (data ~= nil and data.MobName ~= nil) ) then
			local labelName = windowName.."LabelName"
			LabelSetText(labelName, data.MobName)
			WindowUtils.FitTextToLabel(labelName, data.MobName)
			NameColor.UpdateLabelNameColor(labelName, data.Notoriety+1)
		end
	end
end

function PetWindow.HandleUpdateStatusEvent()
    PetWindow.UpdateStatus(WindowData.UpdateInstanceId)
end

function PetWindow.UpdateStatus(mobileId)
	if(PetWindow.reverseIndexId[mobileId] ~= nil) then
		local windowName = "PetWindowShowViewPetHealthBar"..PetWindow.reverseIndexId[mobileId]
		--Set mobiles health status bar and name if their health bar is showing and not disabled
		if( (PetWindow.hasWindow[mobileId] == true) ) then
			
			StatusBarSetCurrentValue( windowName.."HealthBar", WindowData.MobileStatus[mobileId].CurrentHealth )	
			StatusBarSetMaximumValue( windowName.."HealthBar", WindowData.MobileStatus[mobileId].MaxHealth )
		end
	end
end

function PetWindow.HidePet()
	----Debug.Print("PetWindow.HidePet")
	local windowName = "PetWindow"
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

function PetWindow.ShowPet()
	--Debug.Print("PetWindow.ShowPet")
	local windowName = "PetWindow"
	local showName = windowName.."ShowView"
	local hideName = windowName.."HideView"
	
	WindowSetShowing(showName, true)
	WindowSetShowing(hideName, false)
	
	SnapUtils.SnappableWindows[showName] = true
end

function PetWindow.OnItemClicked()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	if(mobileId ~= nil)then
		--Handle Single Left Click on pet window in uo_targetmanager
		HandleSingleLeftClkTarget(mobileId)
	end
end

function PetWindow.OnTextItemClicked()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
		if(mobileId ~= nil)then
		--Debug.Print(L""..mobileId)
		--Handle Single Left Click on pet window in uo_targetmanager
		HandleSingleLeftClkTarget(mobileId)
	end
	
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	local this = "PetWindowShowViewPetHealthBar"..PetWindow.reverseIndexId[mobileId]
	local labelName = this.."LabelName"
	local inputName = this.."InputName"
	TextEditBoxSetText(inputName, LuaUtils.stripBeginEndSpace(LabelGetText(labelName)))
	WindowSetShowing(labelName, false)
end

--When player double clicks the object handle window it acts as if they double-clicked the object itself
function PetWindow.OnDblClick()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)	
	UserActionUseItem(mobileId,false)
end

function PetWindow.OnRClick()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	--Debug.Print("PetWindow.OnRClick() id="..mobileId)
	RequestContextMenu(mobileId)
end

function PetWindow.OnKeyEnter()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	local this = "PetWindowShowViewPetHealthBar"..PetWindow.reverseIndexId[mobileId]
	local labelName = this.."LabelName"
	local inputName = this.."InputName"
	
	nameText = TextEditBoxGetText(inputName)
	
	WindowAssignFocus(inputName, false)
	WindowSetShowing(labelName, true)
	TextEditBoxSetText(inputName, L"")
	
	if(nameText == L"") then
		return
	end
	
	WindowData.Pets.RenameId = mobileId
	WindowData.Pets.Name = WStringToString(nameText)
	
	BroadcastEvent(SystemData.Events.RENAME_MOBILE)	
end

function PetWindow.OnKeyEscape()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	local this = "PetWindowShowViewPetHealthBar"..PetWindow.reverseIndexId[mobileId]
	local labelName = this.."LabelName"
	local inputName = this.."InputName"
	
	WindowAssignFocus(inputName, false)
	WindowSetShowing(labelName, true)
	TextEditBoxSetText(inputName, L"")
end


function PetWindow.OnMouseDrag()
	--Debug.Print("PetWindow.OnMouseDrag")
	local windowName = "PetWindow"
	local showName = windowName.."ShowView"
	if (SnapUtils.SnappableWindows[showName] == true) then
		SnapUtils.StartWindowSnap(showName)
	end
end

function PetWindow.HandleTintHealthBarEvent()
    PetWindow.TintHealthBar(WindowData.UpdateInstanceId)
end

function PetWindow.TintHealthBar(mobileId)
	if( IsMobile(mobileId) ) then
		local windowTintName = "PetWindowShowViewPetHealthBar"..PetWindow.reverseIndexId[mobileId].."HealthBar"
		--Colors the health bar to the correct color
		HealthBarColor.UpdateHealthBarColor(windowTintName, WindowData.HealthBarColor[mobileId].VisualStateId)
	end
	
function PetWindow.HealMember()
	local mobileId = WindowGetId( WindowGetParent(SystemData.ActiveWindow.name))
	--Debug.Print(SystemData.ActiveWindow.name)
	--Debug.Print(L""..mobileId)
	if(mobileId) then
		UserActionCastSpellOnId(PetWindow.Spells.Heal, mobileId)
	end
end
function PetWindow.CureMember()
	local mobileId = WindowGetId( WindowGetParent(SystemData.ActiveWindow.name))
	--Debug.Print(SystemData.ActiveWindow.name)
	if(mobileId) then
	--Debug.Print(L""..mobileId)
		UserActionCastSpellOnId(MobileHealthBarWindow.Spells.Cure, mobileId)
	end
end
end

function PetWindow.RenameComplete()
	-- Lucitus TODO: Needs more control of the name in interest of legal iusses
	local mobileId = PetRenameWindow.id 
	WindowData.Pets.RenameId = mobileId
	WindowData.Pets.Name = WStringToString(PetRenameWindow.TextEntered)
	BroadcastEvent(SystemData.Events.RENAME_MOBILE)	
end

function PetWindow.RenamePet()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	local rdata = {}
	Debug.Print(WindowData.MobileName[mobileId].MobName)
	rdata.text = WindowData.MobileName[mobileId].MobName
	rdata.title = L"Enter the new name of your pet:"
	rdata.callfunction = PetWindow.RenameComplete
	rdata.id = mobileId
	rdata.IllegalCharacters="[^A-Za-z ]"
	PetRenameWindow.Create(rdata)
end

function PetWindow.ViewButtonMouseOver()
	--Lucitus TODO: Show Tooltip on Renamebutton
	--Lucitus Done 19.03.2009
	local messageText = L"Rename Pet"
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)

	local itemData = { windowName = SystemData.ActiveWindow.name,
						itemId = mobileId,
						itemType = ItemProperties.type.TYPE_WSTRINGDATA,
						binding = L"",
						detail = nil,
						title =	messageText,
						body = L""}

	ItemProperties.SetActiveItem(itemData)
end