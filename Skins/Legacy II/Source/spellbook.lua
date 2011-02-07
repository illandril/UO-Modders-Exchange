----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

Spellbook = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

Spellbook.uniqueOrdinals = { L"st", L"nd", L"rd" }
Spellbook.bardMasteries = { L"Provocation", L"Peacemaking", L"Discordance" }

-- TODO: Obviously, TIDs should be in abilities.csv
Spellbook.baseTid = 1028319

-- Indexed by firstSpellNum, MAX per page is 8
Spellbook.numSpellsPerTab = {}
Spellbook.numSpellsPerTab[1] = 8 -- Magery
Spellbook.numSpellsPerTab[101] = 8 -- Necromancy
Spellbook.numSpellsPerTab[201] = 8 -- Chivalry
Spellbook.numSpellsPerTab[401] = 8 -- Bushido
Spellbook.numSpellsPerTab[501] = 8 -- Ninjitsu
Spellbook.numSpellsPerTab[601] = 8 -- Spellweaving
Spellbook.numSpellsPerTab[678] = 8 -- Mysticism
Spellbook.numSpellsPerTab[701] = 2 -- Bard

Spellbook.MAX_SPELLS_PER_TAB = 8

Spellbook.tithId = 44

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler
function Spellbook.Initialize()
	local this = SystemData.ActiveWindow.name
	local id = SystemData.DynamicWindowId
	WindowSetId(this, id)
	
	Spellbook[id] = {}
	Spellbook[id].activeTab = 1
	Spellbook[id].tabsCreated = false
	Spellbook[id].numTabs = 0
	
	Interface.DestroyWindowOnClose[this] = true
	RegisterWindowData(WindowData.Spellbook.Type, id)
	RegisterWindowData(WindowData.PlayerStatus.Type, 0)
	WindowRegisterEventHandler(this, WindowData.Spellbook.Event, "Spellbook.UpdateSpells")
	WindowRegisterEventHandler(this, WindowData.PlayerStatus.Event, "Spellbook.UpdateTithing")	
	
end

function Spellbook.UpdateTithing()
	local this = WindowUtils.GetActiveDialog()
	local id = WindowGetId(this)
	local data = WindowData.Spellbook[id]
	--If it is a paladin/chivarlry spellbook show the updated tithing points
	if (WindowData.Spellbook[id].firstSpellNum == 201) then -- PALADIN/CHIVALRY
		local tithingName = "Spellbook_"..id.."Tithing"
		LabelSetText(tithingName, GetStringFromTid(1078097)..L"<br>"..towstring(tostring(WindowData.PlayerStatus.TithingPoints)))
																													-- Added line break to shorten tithing line
	end
end

function Spellbook.CreateTabs(parent, numTabs)
	for i = 1, numTabs do
		local tabName = parent.."TabButton"..i
		CreateWindowFromTemplate(tabName, "SpellbookTabButton", parent)
		
		if i == 1 then
			WindowAddAnchor(tabName, "bottomleft", parent.."TabWindow", "bottomleft", 0, 18) 					-- Set position of tabs here.  
		else																																												-- Tabs are moved to the bottom
			WindowAddAnchor(tabName, "bottomright", parent.."TabButton"..i-1, "bottomleft", 4, 0)			-- for spellbook page numbers.
		end

		WindowSetShowing(tabName.."TabSelected", false)
	end
end

function Spellbook.CreateTabsLarge(parent, numTabs)
	for i = 1, numTabs do
		local tabName = parent.."TabButton"..i
		CreateWindowFromTemplate(tabName, "SpellbookTabButtonLarge", parent)
		
		if i == 1 then
			WindowAddAnchor(tabName, "topleft", parent.."TabWindow", "topleft", 2, -22)
		else
			WindowAddAnchor(tabName, "topright", parent.."TabButton"..i-1, "topleft", 4, 0)
		end

		WindowSetShowing(tabName.."TabSelected", false)
	end
end

function Spellbook.UnselectAllTabs(parent, numTabs)
	for i = 1, numTabs do
		local tabName = parent.."TabButton"..i
		WindowSetShowing(tabName.."TabSelected", false)
		ButtonSetDisabledFlag(tabName, false)
	end
end

function Spellbook.SelectTab(parent, tabNum)
	local tabName = parent.."TabButton"..tabNum
	WindowSetShowing(tabName.."TabSelected", true)
	ButtonSetDisabledFlag(tabName, true);
end
	
-- Called when a minimodel event causes a refresh
-- Update the spells on the current page & set the tab text
-- Doing this in Initialize was causing a bunch of "doesn't exist" error messages
function Spellbook.UpdateSpells()
    local this = SystemData.ActiveWindow.name
	local windowId = WindowGetId(this)
	local id = WindowData.UpdateInstanceId
	if (windowId ~= id) then
		Debug.Print("Window Id doesn't match InstanceId: windowId="..tostring(WindowId).."id="..tostring(id))
		return
	end	
	local data = WindowData.Spellbook[id]
	if Spellbook[id].activeTab then
		if not Spellbook[id].tabsCreated then
            local numTabs = 0
            for i = data.firstSpellNum, data.firstSpellNum + 100, Spellbook.numSpellsPerTab[data.firstSpellNum] do
				local icon, serverId, tid = GetAbilityData(i)
				if(tid ~= nil and tid > 0) then
					numTabs = numTabs + 1
				else
					break
				end        
            end
            
            Spellbook[id].numTabs = numTabs
            
            if(data.firstSpellNum == 701) then -- BARD, create longer tabs
				Spellbook.CreateTabsLarge(this, Spellbook[id].numTabs)
            else
				Spellbook.CreateTabs(this, Spellbook[id].numTabs)
			end
			
			Spellbook[id].tabsCreated = true
			local buttonId = 1
			for i = data.firstSpellNum, data.firstSpellNum + Spellbook.numSpellsPerTab[data.firstSpellNum] do
				local icon, serverId, tid = GetAbilityData(i)
				if(tid ~= nil and tid > 0) then
					Spellbook.RegisterSpellIcon(id, buttonId, serverId)
					buttonId = buttonId + 1    
				else
					break
				end        
			end 
		end
        if (data.firstSpellNum == 1) then -- MAGERY
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1002106) )
        elseif (WindowData.Spellbook[id].firstSpellNum == 101) then -- NECROMANCY
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1061677) )
        elseif (WindowData.Spellbook[id].firstSpellNum == 201) then -- PALADIN/CHIVALRY
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1061666) )
            local tithingName = "Spellbook_"..id.."Tithing"
            LabelSetText(tithingName, GetStringFromTid(1078097)..L" "..towstring(tostring(WindowData.PlayerStatus.TithingPoints)))
        elseif (WindowData.Spellbook[id].firstSpellNum == 401) then -- BUSHIDO
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1070814) )
        elseif (WindowData.Spellbook[id].firstSpellNum == 501) then -- NINJITSU
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1070815) )
        elseif (WindowData.Spellbook[id].firstSpellNum == 601) then -- SPELLWEAVING
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1031600) )
        elseif (WindowData.Spellbook[id].firstSpellNum == 1001) then -- WEAPONS ABILITIES
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1044566) )
        elseif (WindowData.Spellbook[id].firstSpellNum == 678) then -- MYSTICISM
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1031677) )
        elseif (WindowData.Spellbook[id].firstSpellNum == 701) then -- BARD
			WindowUtils.SetActiveDialogTitle( GetStringFromTid(1028794) )
        end
		
		if(WindowData.Spellbook[id].firstSpellNum == 701) then -- BARD uses mastery names for each tab
			for i = 1, Spellbook[id].numTabs do
				local mastery = Spellbook.bardMasteries[i] or L""
				ButtonSetText( this.."TabButton"..i, L""..mastery)
			end
		else
			for i = 1, Spellbook[id].numTabs do
				local ordinal = Spellbook.uniqueOrdinals[i] or L"th"
				ButtonSetText( this.."TabButton"..i, L""..i..ordinal)
			end
		end
            
		Spellbook.ShowTab(Spellbook[id].activeTab)    
	else
		return
	end
end

function Spellbook.ShowTab(tabnum)
        
    local this = WindowUtils.GetActiveDialog()
    local id = WindowGetId(this)
    local data = WindowData.Spellbook[id]    
	--Show Tithing Icon
	if (WindowData.Spellbook[id].firstSpellNum == 201) then -- PALADIN/CHIVALRY
		local iconId = WindowData.PlayerStatsDataCSV[Spellbook.tithId].iconId
		Spellbook.SetMiniIconStats(this,iconId)
		WindowSetShowing(this.."SquareIcon",true)
	else
		WindowSetShowing(this.."SquareIcon",false)
	end
   
    -- Update tabs to highlight the correct one
    Spellbook.UnselectAllTabs(this, Spellbook[id].numTabs)
    Spellbook.SelectTab(this, tabnum)
    Spellbook[id].activeTab = tabnum
    	
	local pageOffset = (tabnum-1)*Spellbook.numSpellsPerTab[data.firstSpellNum]
	for i=1, Spellbook.MAX_SPELLS_PER_TAB do
		local buttonName = "Spellbook_"..id.."TabWindowButton"..i
		local iconName = buttonName.."SquareIcon"
		local labelName = buttonName.."Desc"
		local wordName = buttonName.."WordPower"
		local abilityId = data.firstSpellNum + pageOffset + i - 1
		
		--Debug.Print(L"abilityId: "..data.firstSpellNum..L"+"..pageOffset..L"+"..i..L"-1="..abilityId)
		--Debug.PrintToDebugConsole(L"Spellbook.ShowTab: i =  "..StringToWString(tostring(i))..L" abilityId = "..StringToWString(tostring(abilityId)))
	
		local icon, serverId, tid, desctid, reagents, powerword = GetAbilityData(abilityId)
		if(icon ~= nil and icon ~= 0 and i <= Spellbook.numSpellsPerTab[data.firstSpellNum]) then
			--Debug.PrintToDebugConsole(L"Spellbook.ShowTab: has ability data for icon  "..StringToWString(tostring(icon)))
			local texture, x, y = GetIconData( icon )
			DynamicImageSetTexture( iconName, texture, x, y )
		
-- Set colors for spell name/description text here
			if data.spells[pageOffset+i] == 1 then
				LabelSetTextColor(labelName, 50, 50, 0)
				LabelSetTextColor(wordName,  0, 51, 0)
				ButtonSetDisabledFlag(buttonName, false)
			else
				LabelSetTextColor(labelName, 130, 130, 130)
				LabelSetTextColor(wordName, 130, 130, 130)
				ButtonSetDisabledFlag(buttonName, true)
			end
			        
			LabelSetText(labelName, GetStringFromTid(tid))

			--Show the power words for the spell
			if(powerword ~= nil) then
				--Debug.Print("Words of Power = "..powerword)
				LabelSetText(wordName, StringToWString(powerword))
			end

			-- show the entry
			WindowSetShowing (buttonName, true)
			WindowSetShowing (labelName, true)
		else
			-- hide the entry
			WindowSetShowing (buttonName, false)
			WindowSetShowing (labelName, false)
		end
	end	
end

-- OnShutdown Handler
function Spellbook.Shutdown()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	UnregisterWindowData(WindowData.Spellbook.Type, id)
	UnregisterWindowData(WindowData.PlayerStatus.Type, 0)
end

-- OnLButtonDown Handler
function Spellbook.SpellLButtonDown()
    local this = WindowUtils.GetActiveDialog()
    local id = WindowGetId(this)
    local data = WindowData.Spellbook[id]
    local page = Spellbook[id].activeTab
    local index = WindowGetId(SystemData.ActiveWindow.name)
    local curSpell = (page-1)*Spellbook.numSpellsPerTab[data.firstSpellNum] + index + data.firstSpellNum - 1

    local icon, serverId = GetAbilityData(curSpell)
    
    DragSlotSetActionMouseClickData(SystemData.UserAction.TYPE_SPELL,serverId,icon)
end

-- OnLButtonUP Handler
function Spellbook.SpellLButtonUp()
	local this = WindowUtils.GetActiveDialog()
    local id = WindowGetId(this)
    local data = WindowData.Spellbook[id]
    local page = Spellbook[id].activeTab
    local index = WindowGetId(SystemData.ActiveWindow.name)
    local curSpell = (page-1)*Spellbook.numSpellsPerTab[data.firstSpellNum] + index + data.firstSpellNum - 1

    local icon, serverId = GetAbilityData(curSpell)

    if( serverId ~= nil ) then
		UserActionCastSpell(serverId)
    end
end

-- OnMouseOver Handler
function Spellbook.SpellMouseOver()
	local this = WindowUtils.GetActiveDialog()
    local id = WindowGetId(this)
    local data = WindowData.Spellbook[id]
    local page = Spellbook[id].activeTab
    local index = WindowGetId(SystemData.ActiveWindow.name)
    local curSpell = (page-1)*Spellbook.numSpellsPerTab[data.firstSpellNum] + index + data.firstSpellNum - 1

    local icon, serverId, tid, desctid, reagents, powerword, tithingcost, minskill, manacost  = GetAbilityData(curSpell)
    local reagentsStr = L""
    local tithingStr = L""
    local minskillStr = L"<BR>"
    local manacostStr = L""
  
    if(reagents ~= nil and reagents ~= "") then
		  --TID says "Reagents"
		reagentsStr = L"<BR>== "..GetStringFromTid(1002127)..L" ==<BR>"..StringToWString(reagents)
	--Debug.Print("reagents ="..reagents)
    end
    
    if(tithingcost ~= nil and tithingcost > 0) then
		-- Paladin
		if(serverId >= 201 and serverId <= 210) then
			-- TID says "Tithing Cost:"
			tithingStr =  L"<BR>"..GetStringFromTid(1062099)..StringToWString(tostring(tithingcost))
		-- Bard
		elseif(serverId >= 701 and serverId <= 706) then
			-- TID says "Upkeep Cost:"
			tithingStr =  L"<BR>"..GetStringFromTid(1115718)..StringToWString(tostring(tithingcost))
		end
    end
    
    if(minskill ~= nil and minskill > 0) then
		-- TID says "Min Skill:"
		minskillStr =  minskillStr..L"<BR>"..GetStringFromTid(1062101)..L" "..StringToWString(tostring(minskill))
    end
    
    if(manacost ~= nil and manacost > 0) then
		-- TID says "Mana Cost:"
		manacostStr =  L"<BR>"..GetStringFromTid(1062100)..L" "..StringToWString(tostring(manacost))
    end
    
	local itemData = { windowName = this,
						itemId = curSpell,
						itemType = WindowData.ItemProperties.TYPE_ACTION,
						actionType = SystemData.UserAction.TYPE_SPELL,
						detail = ItemProperties.DETAIL_LONG,
						title = L"",	
						body = reagentsStr..tithingStr..minskillStr..manacostStr	}
	ItemProperties.SetActiveItem(itemData)	    
end

-- Tab Handler
function Spellbook.ToggleTab()
    -- Get the number of the tab clicked, which should be the last character of its name
    -- NOTE: Obviously, this won't work if you have more than ten tabs
    tab_clicked = tonumber (string.sub( SystemData.ActiveWindow.name, -1, -1))
	Spellbook.ShowTab(tab_clicked)  
end


function Spellbook.RegisterSpellIcon(spellbookId, buttonId, serverId)
	local buttonName = "Spellbook_"..spellbookId.."TabWindowButton"..buttonId
	HotbarSystem.RegisterSpellIcon(buttonName, serverId)
end

-- OnShutdown Handler
function Spellbook.ShutdownSpellIcon()
	HotbarSystem.UnregisterSpellIcon(SystemData.ActiveWindow.name)
end

function Spellbook.TithLButtonDown()
	local id = Spellbook.tithId
	local iconId = 899999 --WindowData.PlayerStatsDataCSV[id].iconId	(original code)  changed to a custom icon for tithing.
	DragSlotSetActionMouseClickData(SystemData.UserAction.TYPE_PLAYER_STATS,id,iconId)
end

function Spellbook.SetMiniIconStats(iconWindow, iconId)
	local texture, x, y = GetIconData( 899999 )	-- 899999 is the designation for a custom tithing icon
	--Start position of the texture, need to be offset by x and y to get the stat icon image
	x = 4  
	y = 4
	WindowSetDimensions(iconWindow.."SquareIcon", 30, 30)
	DynamicImageSetTexture( iconWindow.."SquareIcon", texture, x, y )	   
	DynamicImageSetTextureScale(iconWindow.."SquareIcon", 1 )			
end

function Spellbook.TithMouseOver()
	local buttonName = SystemData.ActiveWindow.name
	local text = GetStringFromTid(1112081)
	Tooltips.CreateTextOnlyTooltip(buttonName, text)
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end
