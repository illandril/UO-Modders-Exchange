----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

OverheadText = {}

-- Edit to add Overhead spell translation

----------------------------------------------------------------
-- Words of Power
----------------------------------------------------------------

-- For now we will use this as the trigger on how to display, can be toggled in game using a command script

OverheadText.currentSpell = 4

OverheadText.WordsNum = 2
OverheadText.WordsQuickRegex = nil
OverheadText.Words ={}
OverheadText.Words[1] = { name = "Ex Uus", desc = "Agility" }
OverheadText.Words[2] = { name = "Vas An Nox", desc = "Arch Cure" }
OverheadText.Words[3] = { name = "Vas Uus Sanct", desc = "Arch Protection" }
OverheadText.Words[4] = { name = "In Jux Hur Ylem", desc = "Blade Spirits" }
OverheadText.Words[5] = { name = "Rel Sanct", desc = "Bless" }
OverheadText.Words[6] = { name = "Vas Ort Grav", desc = "Chain Lightning" }
OverheadText.Words[7] = { name = "Uus Jux", desc = "Clumsy" }
OverheadText.Words[8] = { name = "In Mani Yelm", desc = "Create Food" }
OverheadText.Words[9] = { name = "Uus Wis", desc = "Cunning" }
OverheadText.Words[10] = { name = "An Nox", desc = "Cure" }
OverheadText.Words[11] = { name = "Des Sanct", desc = "Curse" }
OverheadText.Words[12] = { name = "An Ort", desc = "Dispel" }
OverheadText.Words[13] = { name = "An Grav", desc = "Dispel Field" }
OverheadText.Words[14] = { name = "In Vas Por", desc = "Earthquake" }
OverheadText.Words[15] = { name = "Corp Por", desc = "Energy Bolt" }
OverheadText.Words[16] = { name = "In Sanct Grav", desc = "Energy Field" }
OverheadText.Words[17] = { name = "Vas Corp Por", desc = "Energy Vortex" }
OverheadText.Words[18] = { name = "Vas Ort Flam", desc = "Explosion" }
OverheadText.Words[19] = { name = "Rel Wis", desc = "Feeblemind" }
OverheadText.Words[20] = { name = "In Flam Grav", desc = "Fire Field" }
OverheadText.Words[21] = { name = "Vas Flam", desc = "Fireball" }
OverheadText.Words[22] = { name = "Kal Vas Flam", desc = "Flamestrike" }
OverheadText.Words[23] = { name = "Vas Rel Por", desc = "Gate Travel" }
OverheadText.Words[24] = { name = "In Vas Mani", desc = "Greater Heal" }
OverheadText.Words[25] = { name = "An Mani", desc = "Harm" }
OverheadText.Words[26] = { name = "In Mani", desc = "Heal" }
OverheadText.Words[27] = { name = "Kal In Ex", desc = "Incognito" }
OverheadText.Words[28] = { name = "An Lor Xen", desc = "Invisibility" }
OverheadText.Words[29] = { name = "Por Ort Grav", desc = "Lightning" }
OverheadText.Words[30] = { name = "In Por Ylem", desc = "Magic Arrow" }
OverheadText.Words[31] = { name = "An Por", desc = "Magic Lock" }
OverheadText.Words[32] = { name = "In Jux Sanct", desc = "Magic Reflection" }
OverheadText.Words[33] = { name = "In Jux", desc = "Magic Trap" }
OverheadText.Words[34] = { name = "An Jux", desc = "Magic Untrap" }
OverheadText.Words[35] = { name = "Ort Rel", desc = "Mana Drain" }
OverheadText.Words[36] = { name = "Ort Sanct", desc = "Mana Vampire" }
OverheadText.Words[37] = { name = "Kal Por Ylem", desc = "Mark" }
OverheadText.Words[38] = { name = "Vas Des Sanct", desc = "Mass Curse" }
OverheadText.Words[39] = { name = "Vas An Ort", desc = "Mass Dispel" }
OverheadText.Words[40] = { name = "Flam Kal Des Ylem", desc = "Meteor Swarm" }
OverheadText.Words[41] = { name = "Por Corp Wis", desc = "Mind Blast" }
OverheadText.Words[42] = { name = "In Lor", desc = "Nightsight" }
OverheadText.Words[43] = { name = "An Ex Por", desc = "Paralyze" }
OverheadText.Words[44] = { name = "In Ex Grav", desc = "Paralyze Field" }
OverheadText.Words[45] = { name = "In Nox", desc = "Poison" }
OverheadText.Words[46] = { name = "In Nox Grav", desc = "Poison Field" }
OverheadText.Words[47] = { name = "Vas Ylem Rel", desc = "Polymorph" }
OverheadText.Words[48] = { name = "Uus Sanct", desc = "Protection" }
OverheadText.Words[49] = { name = "Flam Sanct", desc = "Reactive Armor" }
OverheadText.Words[50] = { name = "Kal Ort Por", desc = "Recall" }
OverheadText.Words[51] = { name = "An Corp", desc = "Resurrection" }
OverheadText.Words[52] = { name = "Wis Quas", desc = "Reveal" }
OverheadText.Words[53] = { name = "Uus Mani", desc = "Strength" }
OverheadText.Words[54] = { name = "Kal Xen", desc = "Summ. Creature" }
OverheadText.Words[55] = { name = "Kal Vas Xen Hur", desc = "Summon Air Elemental" }
OverheadText.Words[56] = { name = "Kal Vas Xen Corp", desc = "Summon Daemon" }
OverheadText.Words[57] = { name = "Kal Vas Xen Ylem", desc = "Summon Earth Elemental" }
OverheadText.Words[58] = { name = "Kal Vas Xen Flam", desc = "Summon Fire Elemental" }
OverheadText.Words[59] = { name = "Kal Vas Xen An Flam", desc = "Summon Water Elemental" }
OverheadText.Words[60] = { name = "Ort Por Ylem", desc = "Telekinesis" }
OverheadText.Words[61] = { name = "Rel Por", desc = "Teleport" }
OverheadText.Words[62] = { name = "Ex Por", desc = "Unlock" }
OverheadText.Words[63] = { name = "In Sanct Ylem", desc = "Wall of Stone" }
OverheadText.Words[64] = { name = "Des Mani", desc = "Weaken" }
OverheadText.Words[65] = { name = "In Aglo Corp Ylem", desc = "Corpse Skin" }
OverheadText.Words[66] = { name = "In Bal Nox", desc = "Strangle" }
OverheadText.Words[67] = { name = "In Jux Mani Xen", desc = "Blood Oath" }
OverheadText.Words[68] = { name = "In Sar", desc = "Pain Spike" }
OverheadText.Words[69] = { name = "In Vas Nox", desc = "Poison Strike" }
OverheadText.Words[70] = { name = "Kal Vas An Flam", desc = "Wither" }
OverheadText.Words[71] = { name = "Kal Xen Bal", desc = "Summon Familiar" }
OverheadText.Words[72] = { name = "Kal Xen Bal Beh", desc = "Vengeful Spirit" }
OverheadText.Words[73] = { name = "Ort Corp Grav", desc = "Exorcism" }
OverheadText.Words[74] = { name = "Pas Tym An Sanct", desc = "Evil Omen" }
OverheadText.Words[75] = { name = "Rel Xen An Sanct", desc = "Vampiric Embrace" }
OverheadText.Words[76] = { name = "Rel Xen Corp Ort", desc = "Lich Form" }
OverheadText.Words[77] = { name = "Rel Xen Um", desc = "Wraith Form" }
OverheadText.Words[78] = { name = "Rel Xen Vas Bal", desc = "Horrific Beast" }
OverheadText.Words[79] = { name = "Uus Corp", desc = "Animate Dead" }
OverheadText.Words[80] = { name = "Wis An Ben", desc = "Mind Rot" }
OverheadText.Words[81] = { name = "Alalithra", desc = "Summon Fey" }
OverheadText.Words[82] = { name = "Anathrae", desc = "Essense of Wind" }
OverheadText.Words[83] = { name = "Aslavdra", desc = "Arcane Empowerment" }
OverheadText.Words[84] = { name = "Erelonia", desc = "Thunderstorm" }
OverheadText.Words[85] = { name = "Haeldril", desc = "Attunement" }
OverheadText.Words[86] = { name = "Haelyn", desc = "Wildfire" }
OverheadText.Words[87] = { name = "Illorae", desc = "Gift of Life" }
OverheadText.Words[88] = { name = "Myrshalee", desc = "Arcane Circle" }
OverheadText.Words[89] = { name = "Nylisstra", desc = "Summon Fiend" }
OverheadText.Words[90] = { name = "Nyraxle", desc = "Word of Death" }
OverheadText.Words[91] = { name = "Olorisstra", desc = "Gift of Renewal" }
OverheadText.Words[92] = { name = "Orlavdra", desc = "Ethereal Voyage" }
OverheadText.Words[93] = { name = "Rathril", desc = "Dryad Allure" }
OverheadText.Words[94] = { name = "Rauvvrae", desc = "Nature's Fury" }
OverheadText.Words[95] = { name = "Tarisstree", desc = "Reaper Form" }
OverheadText.Words[96] = { name = "Thalshara", desc = "Immolating Weapon" }
OverheadText.Words[97] = { name = "Augus Luminos", desc = "Holy Light" }
OverheadText.Words[98] = { name = "Consecrus Arma", desc = "Consecrate Weapon" }
OverheadText.Words[99] = { name = "Dispiro Malas", desc = "Dispel Evil" }
OverheadText.Words[100] = { name = "Dium Prostra", desc = "Noble Sacrifice" }
OverheadText.Words[101] = { name = "Divinum Furis", desc = "Divine Fury" }
OverheadText.Words[102] = { name = "Expor Flamus", desc = "Cleanse by Fire" }
OverheadText.Words[103] = { name = "Extermo Vomica", desc = "Remove Curse" }
OverheadText.Words[104] = { name = "Forul Solum", desc = "Enemy of One" }
OverheadText.Words[105] = { name = "Obsu Vulni", desc = "Close Wounds" }
OverheadText.Words[106] = { name = "Sanctum Viatas", desc = "Sacred Journey" }
OverheadText.Words[107] = { name = "In Corp Ylem", desc = "Nether Bolt" }
OverheadText.Words[108] = { name = "Kal In Mani", desc = "Healing Stone" }
OverheadText.Words[109] = { name = "An Ort Sanct", desc = "Purge Magic" }
OverheadText.Words[110] = { name = "In Ort Ylem", desc = "Enhanct" }
OverheadText.Words[111] = { name = "In Zu", desc = "Sleep" }
OverheadText.Words[112] = { name = "Kal Por Xen", desc = "Eagle Strike" }
OverheadText.Words[113] = { name = "In Jux Por Ylem", desc = "Animated Weapon" }
OverheadText.Words[114] = { name = "In Rel Ylem", desc = "Stone Form" }
OverheadText.Words[115] = { name = "In Vas Ort Ex", desc = "Spell Trigger" }
OverheadText.Words[116] = { name = "Vas Zu", desc = "Mass Sleep" }
OverheadText.Words[117] = { name = "In Vas Mani Hur", desc = "Cleansing Winds" }
OverheadText.Words[118] = { name = "Corp Por Ylem", desc = "Bombard" }
OverheadText.Words[119] = { name = "Vas Rel Jux Ort", desc = "Spell Plague" }
OverheadText.Words[120] = { name = "Kal Des Ylem", desc = "Hail Storm" }
OverheadText.Words[121] = { name = "Grav Hur", desc = "Nether Cyclone" }
OverheadText.Words[122] = { name = "Kal Vas Xen Corp Ylem", desc = "Rising Colossus" }

----------------------------------------------------------------
-- Added function to filter spammers
----------------------------------------------------------------
OverheadText.SilenceFilter = "/silence"
OverheadText.QuietFilter = "/quiet"
OverheadText.VoiceFilter = "/voice"
OverheadText.FilterMode = OverheadText.QuietFilter
OverheadText.Repeats = {}



----------------------------------------------------------------
-- *** Local Variables
----------------------------------------------------------------
OverheadText.ActiveIdList = {}
OverheadText.FadeTimeId = {}
OverheadText.TimePassed = {}
OverheadText.AlphaStart = 1
OverheadText.AlphaDiff = 0.01
OverheadText.FadeStartTime = 4

OverheadText.ChatData = {}
--how long the overhead chats will stay on screen (in sec's)
OverheadText.OverheadAlive = 10
OverheadText.MaxOverheadHeight = 150

OverheadText.GetsOverhead = {
	false,	--	System
	true,	--	Say
	false,	--	Private
	false,	--	Custom
	true,	--	Emote
	true,	--	Gesture
	true,	--	Whisper
	true,	--	Yell
	false,	--	Party
	false,	--	Guild
	false,	--	Alliance
--	false,	--	Faction
}

----------------------------------------------------------------
-- OverheadText Functions
----------------------------------------------------------------
function OverheadText.InitializeEvents()
    -- we only want to register for these events once so we dont get the event for every instance of the name window
    WindowRegisterEventHandler("Root", WindowData.MobileName.Event, "OverheadText.HandleMobileNameUpdate")
    WindowRegisterEventHandler("Root", SystemData.Events.SHOWNAMES_UPDATED, "OverheadText.HandleSettingsUpdate")
    WindowRegisterEventHandler("Root", SystemData.Events.SHOWNAMES_FLASH_TEMP, "OverheadText.HandleFlashTempNames")
end

function OverheadText.Initialize()
	local this = SystemData.ActiveWindow.name
	local mobileId = SystemData.DynamicWindowId

	WindowSetId(this, mobileId)
	
	OverheadText.FadeTimeId[mobileId] = OverheadText.AlphaStart
	OverheadText.TimePassed[mobileId] = 0
	OverheadText.ActiveIdList[mobileId] = true

	OverheadText.ChatData[mobileId] = {}
	OverheadText.ChatData[mobileId].numVisibleChat = 0
	OverheadText.ChatData[mobileId].timePassed = {}
	OverheadText.ChatData[mobileId].timePassed[1] = 0
	OverheadText.ChatData[mobileId].timePassed[2] = 0
	OverheadText.ChatData[mobileId].timePassed[3] = 0
	
	RegisterWindowData(WindowData.MobileName.Type, mobileId)	

	--  Power Word setup function
	
	OverheadText.PrepareWordsRegex()
	
	OverheadText.UpdateName(mobileId)
	WindowSetShowing(this.."Chat1", false)
	WindowSetShowing(this.."Chat2", false)
	WindowSetShowing(this.."Chat3", false)
end

function OverheadText.Shutdown()
	local this = SystemData.ActiveWindow.name
	local mobileId = WindowGetId(this)
	
	OverheadText.FadeTimeId[mobileId] = nil
	OverheadText.TimePassed[mobileId] = nil
	OverheadText.ActiveIdList[mobileId] = nil
	OverheadText.ChatData[mobileId] = nil
	
	DetachWindowFromWorldObject( mobileId, "OverheadTextWindow_"..mobileId )
	UnregisterWindowData(WindowData.MobileName.Type, mobileId)
end

function OverheadText.HandleMobileNameUpdate()
    OverheadText.UpdateName(WindowData.UpdateInstanceId)
end

function OverheadText.HandleSettingsUpdate()
	for i, id in pairs(OverheadText.ActiveIdList) do
		local windowName = "OverheadTextWindow_"..i
		if(SystemData.Settings.GameOptions.showNames == SystemData.Settings.GameOptions.SHOWNAMES_NONE) then
			OverheadText.HideName(i)
		elseif(SystemData.Settings.GameOptions.showNames == SystemData.Settings.GameOptions.SHOWNAMES_APPROACHING or SystemData.Settings.GameOptions.showNames == SystemData.Settings.GameOptions.SHOWNAMES_ALL) then
			OverheadText.ShowName(i)
		end
	end
end

-- Used in the Macro Action 'All Names'
-- If the Show Names setting isn't set on 'Always', it will show all the names temporarily on the screen.
function OverheadText.HandleFlashTempNames()
	for i, id in pairs(OverheadText.ActiveIdList) do
		OverheadText.ShowName(i)
	end
end

function OverheadText.UpdateName(mobileId)
	-- Player name is not displayed
	if( mobileId == WindowData.PlayerStatus.PlayerId ) then
		return
	end

	local data = WindowData.MobileName[mobileId]
	local windowName = "OverheadTextWindow_"..mobileId
	
	--If windowName does not exist exit funciton
	if( DoesWindowNameExist( windowName) == false ) then
		return
	end
	
	if(data.MobName ~= nil) then
		local labelName = windowName.."Name"
		LabelSetText(labelName, L""..data.MobName)
		
		LabelSetFont(labelName, "UO_Chat_Helvetica_18pt", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		
		local x, y = LabelGetTextDimensions(labelName)
		WindowSetDimensions(windowName, x, y)
		
		NameColor.UpdateLabelNameColor(labelName, data.Notoriety+1)
	else
		--Destroy the entire overhead text window if the mobile status is not there anymore.
		--Player probably teleported and we didn't delete the mobiles name.
  		DestroyWindow(windowName)
	end
end

function OverheadText.Update( timePassed )
	--timer for overhead msg
	if SystemData.Settings.Interface.OverheadChat then
		for id, data in pairs(OverheadText.ChatData) do
			for index, totalTimePassed in pairs(data.timePassed) do
				if totalTimePassed < OverheadText.OverheadAlive then
					data.timePassed[index] = totalTimePassed + timePassed
					if data.timePassed[index] > OverheadText.OverheadAlive then
						local windowName = "OverheadTextWindow_"..id
						local overheadChatWindow = windowName.."Chat"..index
						
						WindowSetShowing(overheadChatWindow, false)
						LabelSetText( overheadChatWindow, L"")
						
						data.timePassed[index] = nil
						data.numVisibleChat = data.numVisibleChat - 1
					end
				end
			end
		end
	end

	if (SystemData.Settings.GameOptions.showNames ~= SystemData.Settings.GameOptions.SHOWNAMES_ALL) then
		for i, id in pairs(OverheadText.ActiveIdList) do
			if( OverheadText.FadeTimeId[i] ~= nil ) then
				OverheadText.TimePassed[i] = OverheadText.TimePassed[i] + timePassed
				if(OverheadText.TimePassed[i] > OverheadText.FadeStartTime ) then
					local windowName = "OverheadTextWindow_"..i
					OverheadText.FadeTimeId[i] = OverheadText.FadeTimeId[i] - OverheadText.AlphaDiff
					if(OverheadText.FadeTimeId[i] <= 0) then
						--Hide Name Window
						OverheadText.HideName(i)
					else
						local labelName = windowName.."Name"
						WindowSetFontAlpha(labelName, OverheadText.FadeTimeId[i])
					end
				end
			end
		end
	end
end

function OverheadText.ShowName(mobileId)
	OverheadText.FadeTimeId[mobileId] = OverheadText.AlphaStart
	OverheadText.TimePassed[mobileId] = 0
	
	local windowName = "OverheadTextWindow_"..mobileId
	WindowSetShowing(windowName.."Name", true)
	WindowSetFontAlpha(windowName.."Name", 1)
	
	OverheadText.UpdateOverheadAnchors(mobileId)
end

function OverheadText.HideName(mobileId)
	OverheadText.FadeTimeId[mobileId] = nil
	OverheadText.TimePassed[mobileId] = nil
	
	local windowName = "OverheadTextWindow_"..mobileId
	WindowSetShowing(windowName.."Name", false)
	
	OverheadText.UpdateOverheadAnchors(mobileId)
end

function OverheadText.UpdateOverheadAnchors(mobileId)
	local windowName = "OverheadTextWindow_"..mobileId
	local overheadNameWindow = windowName.."Name"
	local overheadChatWindow = windowName.."Chat1"
	
	if(DoesWindowNameExist(windowName) == true) then
		-- NOTE: Player name is not displayed, do not anchor chat window to name window.
		if( WindowGetShowing(overheadNameWindow) == true and mobileId ~= WindowData.PlayerStatus.PlayerId ) then
			WindowClearAnchors(overheadChatWindow)
			WindowAddAnchor(overheadChatWindow, "top", overheadNameWindow, "bottom", 0, -10)
		else
			WindowClearAnchors(overheadChatWindow)
			WindowAddAnchor(overheadChatWindow, "bottom", windowName, "bottom", 0, 0)
		end
	end
end

function OverheadText.OnShown()
    -- window was shown so reset the timers and the font alpha
	local this = SystemData.ActiveWindow.name
	local mobileId = WindowGetId(this)
	
	OverheadText.FadeTimeId[mobileId] = OverheadText.AlphaStart
	OverheadText.TimePassed[mobileId] = 0
	
	local labelName = this.."Name"
	WindowSetFontAlpha( labelName, OverheadText.AlphaStart)
end

function OverheadText.NameOnLClick()
	local this = SystemData.ActiveWindow.name
	local parent = WindowGetParent(this)
	local mobileId = WindowGetId(parent)
	
	--Let the targeting manager handle single left click on the target
	HandleSingleLeftClkTarget(mobileId)
end

function OverheadText.ShowOverheadText()

	if SystemData.TextSourceID == -1 then
		return
	end

	if (not OverheadText.GetsOverhead[SystemData.TextChannelID]) then
		return
	end
	
	-- Anti Spammer code
	
	RegisterWindowData(WindowData.MobileName.Type, SystemData.TextSourceID)
    local data = WindowData.MobileName[SystemData.TextSourceID]

    --Debug.Print(GGManager.tableToString( WindowData.MobileName))
    --Debug.Print(tostring(SystemData.TextSourceID))
    --Debug.Print(tostring(data.MobName).." has noto of "..tostring(data.Notoriety))
    UnregisterWindowData(WindowData.MobileName.Type, SystemData.TextSourceID)
    local quietMode = ( OverheadText.FilterMode == OverheadText.QuietFilter )
    local silenceMode = ( OverheadText.FilterMode == OverheadText.SilenceFilter )
	local noOverHead = false
	if ( quietMode or silenceMode ) and data.Notoriety < 7 then
        if silenceMode then
            noOverHead = true
        else -- Quiet Mode
            if OverheadText.Repeats[SystemData.TextSourceID] == SystemData.Text then
                noOverHead = true
            else
                OverheadText.Repeats[SystemData.TextSourceID] = SystemData.Text
            end
        end
	end
	if (noOverHead == true) then
		return
	end
	
	
	
	
	local windowName = "OverheadTextWindow_"..SystemData.TextSourceID	
	local overheadChatWindow = windowName.."Chat1"
	
	if OverheadText.ChatData[SystemData.TextSourceID] == nil then
	    if( DoesWindowNameExist(windowName) == false ) then
			if( SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId ) then
				SystemData.DynamicWindowId = SystemData.TextSourceID
				CreateWindowFromTemplate(windowName, "OverheadTextWindow", "Root")
				AttachWindowToWorldObject( SystemData.TextSourceID, windowName )
			else
				return
			end
		end
	end
	
    if OverheadText.currentSpell > 1 then
	
        local textAsString = WStringToString( SystemData.Text )

        if string.find( textAsString, OverheadText.WordsQuickRegex ) ~= nil then
            if OverheadText.currentSpell == 2 then
                for wordidx, word in ipairs(OverheadText.Words) do
                    if textAsString == word.name then
                        return
                    end
                end
            elseif OverheadText.currentSpell == 3 then
                for wordidx, word in ipairs(OverheadText.Words) do
                    if textAsString == word.name then
                        SystemData.Text = SystemData.Text..L" - "..StringToWString(word.desc)
                        break
                    end
                end
            elseif OverheadText.currentSpell == 4 then
                for wordidx, word in ipairs(OverheadText.Words) do
                    if textAsString == word.name then
                        SystemData.Text = StringToWString(word.desc)
                        break
                    end
                end
            end
        end
	end

	
	-- if there are other chats move them all up one
	if( OverheadText.ChatData[SystemData.TextSourceID].numVisibleChat > 0 ) then
		for i=OverheadText.ChatData[SystemData.TextSourceID].numVisibleChat+1, 2, -1 do 
			if( i <= 3 ) then
				local oldWindow = windowName.."Chat"..(i-1)
				local newWindow = windowName.."Chat"..i
				
				local text = LabelGetText(oldWindow)
				local r,g,b = LabelGetTextColor(oldWindow)
				LabelSetText(newWindow,text)
				LabelSetTextColor(newWindow,r,g,b)
				--default overhead is UO_Overhead_Chat
				LabelSetFont(newWindow, "UO_Chat_Helvetica_18pt", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
				Debug.Print(tostring(LabelGetFont(newWindow)))
				WindowSetShowing(newWindow,true)
				OverheadText.ChatData[SystemData.TextSourceID].timePassed[i] = OverheadText.ChatData[SystemData.TextSourceID].timePassed[i-1]
			end
		end
	end
	if( OverheadText.ChatData[SystemData.TextSourceID].numVisibleChat < 3 ) then
		OverheadText.ChatData[SystemData.TextSourceID].numVisibleChat = OverheadText.ChatData[SystemData.TextSourceID].numVisibleChat + 1
	end
		
	OverheadText.ChatData[SystemData.TextSourceID].timePassed[1] = 0

	local hueR,hueG,hueB = HueRGBAValue(SystemData.TextColor)
	if( SystemData.TextColor == 0 ) then 
		color = ChatSettings.ChannelColors[SystemData.TextChannelID]
		hueR,hueG,hueB = color.r, color.g, color.b
	end
	
	LabelSetTextColor( overheadChatWindow, hueR, hueG, hueB )
	LabelSetFont(overheadChatWindow, "UO_Chat_Helvetica_18pt", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	--Debug.Print(tostring(LabelGetFont(newWindow)))
	LabelSetText( overheadChatWindow, SystemData.Text)
	Debug.Print(tostring(LabelGetFont(overheadChatWindow)))
	
	if( WindowGetShowing(overheadChatWindow) == false ) then
		OverheadText.UpdateOverheadAnchors(SystemData.TextSourceID)
		WindowSetShowing(overheadChatWindow, true)
	end
end

function OverheadText.OnOverheadChatShutdown()
    local windowName = SystemData.ActiveWindow.name
    local id = WindowGetId(windowName)
    
    OverheadText.ChatData[id] = nil
end

-- Edit adding functions for Spell Power Words

function OverheadText.PrepareWordsRegex()
    local regex = { "[", "[", "[", "[", "[" }
    for i,v in ipairs( OverheadText.Words ) do
		
        local chars = {}
        for i2,v2 in ipairs( regex ) do
            local char = string.sub(v.name, i2, i2)
            if string.find( regex[i2], char ) == nil then
                regex[i2] = v2..char
            end
        end
    end
    OverheadText.WordsQuickRegex = "^"
    for i,v in ipairs( regex ) do
        OverheadText.WordsQuickRegex = OverheadText.WordsQuickRegex..v.."]"
    end

end