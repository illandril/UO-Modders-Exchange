----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

PartyListWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

PartyListWindow.windowName = "PartyListWindow"
PartyListWindow.hasWindow = {}
PartyListWindow.mobileID = {}
PartyListWindow.reverseIndexId = {}
PartyListWindow.windowX = 215
PartyListWindow.windowY = 284
PartyListWindow.totalWindows = 0
----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function PartyListWindow.Initialize()
	--Debug.Print("PartyListWindow.Initalize()")
	local windowName = "PartyListWindow"
	local titleName = windowName.."ShowViewName"
	LabelSetText(titleName, L"Party" )
	LabelSetTextColor(titleName, 255,255,0)
	
	RegisterWindowData(WindowData.PartyMember.Type, 0)	
	WindowRegisterEventHandler( "PartyListWindow", WindowData.PartyMember.Event, "PartyListWindow.UpdateParty")

	WindowUtils.RestoreWindowPosition("PartyListWindow")
	PartyListWindow.UpdateParty()
end


function PartyListWindow.Shutdown()
	local windowName = "PartyListWindow"
	local showName = windowName.."ShowView"
	SnapUtils.SnappableWindows[showName] = nil
	
	--for key,value in pairs(PartyListWindow.hasWindow) do
		--PartyListWindow.ClearHealthBarData(key)
	--end
	UnregisterWindowData(WindowData.PartyMember.Type, 0)	
	--WindowUnregisterEventHandler( "PartyWindow", WindowData.PartyMember.Event)
	WindowUtils.SaveWindowPosition(windowName)
end

function PartyListWindow.UpdateParty()
	--Debug.Print("Made it to UpdateParty")
	PartyListWindow.ClearPartyList()
	PartyListWindow.PopulatePartyList()
end

function PartyListWindow.PopulatePartyList()
    --if( WindowData.WaypointDisplay.displayTypes.ATLAS ~= nil and WindowData.WaypointDisplay.typeNames ~= nil ) then
        local prevWindowName = nil
        local index = 1
		if (WindowData.PartyMember.NUM_PARTY_MEMBERS > 0) then
			while (index <= WindowData.PartyMember.NUM_PARTY_MEMBERS) do
				local id = WindowData.PartyMember[index].memberId 
				--Debug.Print(L""..id)
				local data = WindowData.MobileName[id]
				local windowName = "PartyList"..index  
				
				PartyListWindow.hasWindow[index] = true
				PartyListWindow.mobileID[id] = index
				
				--Debug.Print(windowName)
				CreateWindowFromTemplate(windowName,"PartyListTemplate", "PartyListWindowShowView" )
				WindowSetId(windowName, index)
	            
				if( prevWindowName == nil ) then
					WindowAddAnchor(windowName, "top", "PartyListWindow", "top", -25, 40)
				else
					WindowAddAnchor(windowName, "bottom", prevWindowName, "top", 0, 5)
				end
				prevWindowName = windowName

				--local nameTemp ="["..index.."]"..data.MobName
				LabelSetText(windowName.."MemberName", data.MobName)           
				LabelSetTextColor(windowName.."MemberName", 0, 0,0)       
				index=index + 1  
			end
			PartyListWindow.totalWindows = index
		end
end

function PartyListWindow.ClearPartyList()
	local windowName = "PartyList"
	local index = 1
	
		for key, index in pairs(PartyListWindow.mobileID) do
			--Debug.Print("ClearOldPartyHealthBars")
		--if(PartyWindow.IsPartyMember(mobileId) == false) then
			PartyListWindow.CloseWindow(index)
		--end
	end	
	
	----Debug.Print(L"Total Windows "..PartyListWindow.totalWindows)
	--if WindowGetShowing(windowName.."1") then
		--DestroyWindow(windowName.."1")		
	--end
	--
	--if WindowGetShowing(windowName.."2") then
		--DestroyWindow(windowName.."2")		
	--end
--
	--if WindowGetShowing(windowName.."3") then
		--DestroyWindow(windowName.."3")		
	--end
--
	--if WindowGetShowing(windowName.."4") then
		--DestroyWindow(windowName.."4")		
	--end
--
	--if WindowGetShowing(windowName.."5") then
		--DestroyWindow(windowName.."5")		
	--end
--
	--if WindowGetShowing(windowName.."6") then
		--DestroyWindow(windowName.."6")		
	--end
		--if WindowGetShowing(windowName.."7") then
		--DestroyWindow(windowName.."7")		
	--end
		--if WindowGetShowing(windowName.."8") then
		--DestroyWindow(windowName.."8")		
	--end
		--if WindowGetShowing(windowName.."9") then
		--DestroyWindow(windowName.."9")		
	--end
		--if WindowGetShowing(windowName.."10") then
		--DestroyWindow(windowName.."10")		
	--end
	--
	--while (index <= WindowData.PartyMember.NUM_PARTY_MEMBERS) do
		--local windowName = "PartyList"..index
		--Debug.Print("ClearWindow "..windowName)
		--if PartyListWindow.hasWindow[index] == true then
			--Debug.Print("Has Window "..windowName)
			--DestroyWindow(windowName)
		--end
		--index = index + 1
	--end
	--WindowSetDimensions(PartyListWindow.windowName, PartyListWindow.windowX, PartyListWindow.windowY)
end

function PartyListWindow.CloseWindow(index)
	local windowName = "PartyList"..index
	if( DoesWindowNameExist(windowName) == true) then
		--Debug.Print("Destroying..."..windowName)
		DestroyWindow(windowName)
	end
end

function PartyListWindow.OnDblClick()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)	
	UserActionUseItem(mobileId,false)
end

function PartyListWindow.OnRClick()
	local windowName = "PartyListWindow"
	WindowSetShowing(windowName, false)
end

function PartyListWindow.OnMouseDrag()
	--Debug.Print(SystemData.ActiveWindow.name)
	local windowName = "PartyListWindow"
	local showName = windowName.."ShowView"
	if (SnapUtils.SnappableWindows[showName] == true) then
		SnapUtils.StartWindowSnap(showName)
	end
end