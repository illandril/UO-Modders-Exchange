
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ChatManager = {}

----------------------------------------------------------------
-- Words of Power
----------------------------------------------------------------

ChatManager.WordsNum = 2
ChatManager.WordsQuickRegex = nil
ChatManager.Words ={}
ChatManager.Words[1] = { name = "Ex Uus", desc = "Agility" }
ChatManager.Words[2] = { name = "Vas An Nox", desc = "Arch Cure" }
ChatManager.Words[3] = { name = "Vas Uus Sanct", desc = "Arch Protection" }
ChatManager.Words[4] = { name = "In Jux Hur Ylem", desc = "Blade Spirits" }
ChatManager.Words[5] = { name = "Rel Sanct", desc = "Bless" }
ChatManager.Words[6] = { name = "Vas Ort Grav", desc = "Chain Lightning" }
ChatManager.Words[7] = { name = "Uus Jux", desc = "Clumsy" }
ChatManager.Words[8] = { name = "In Mani Yelm", desc = "Create Food" }
ChatManager.Words[9] = { name = "Uus Wis", desc = "Cunning" }
ChatManager.Words[10] = { name = "An Nox", desc = "Cure" }
ChatManager.Words[11] = { name = "Des Sanct", desc = "Curse" }
ChatManager.Words[12] = { name = "An Ort", desc = "Dispel" }
ChatManager.Words[13] = { name = "An Grav", desc = "Dispel Field" }
ChatManager.Words[14] = { name = "In Vas Por", desc = "Earthquake" }
ChatManager.Words[15] = { name = "Corp Por", desc = "Energy Bolt" }
ChatManager.Words[16] = { name = "In Sanct Grav", desc = "Energy Field" }
ChatManager.Words[17] = { name = "Vas Corp Por", desc = "Energy Vortex" }
ChatManager.Words[18] = { name = "Vas Ort Flam", desc = "Explosion" }
ChatManager.Words[19] = { name = "Rel Wis", desc = "Feeblemind" }
ChatManager.Words[20] = { name = "In Flam Grav", desc = "Fire Field" }
ChatManager.Words[21] = { name = "Vas Flam", desc = "Fireball" }
ChatManager.Words[22] = { name = "Kal Vas Flam", desc = "Flamestrike" }
ChatManager.Words[23] = { name = "Vas Rel Por", desc = "Gate Travel" }
ChatManager.Words[24] = { name = "In Vas Mani", desc = "Greater Heal" }
ChatManager.Words[25] = { name = "An Mani", desc = "Harm" }
ChatManager.Words[26] = { name = "In Mani", desc = "Heal" }
ChatManager.Words[27] = { name = "Kal In Ex", desc = "Incognito" }
ChatManager.Words[28] = { name = "An Lor Xen", desc = "Invisibility" }
ChatManager.Words[29] = { name = "Por Ort Grav", desc = "Lightning" }
ChatManager.Words[30] = { name = "In Por Ylem", desc = "Magic Arrow" }
ChatManager.Words[31] = { name = "An Por", desc = "Magic Lock" }
ChatManager.Words[32] = { name = "In Jux Sanct", desc = "Magic Reflection" }
ChatManager.Words[33] = { name = "In Jux", desc = "Magic Trap" }
ChatManager.Words[34] = { name = "An Jux", desc = "Magic Untrap" }
ChatManager.Words[35] = { name = "Ort Rel", desc = "Mana Drain" }
ChatManager.Words[36] = { name = "Ort Sanct", desc = "Mana Vampire" }
ChatManager.Words[37] = { name = "Kal Por Ylem", desc = "Mark" }
ChatManager.Words[38] = { name = "Vas Des Sanct", desc = "Mass Curse" }
ChatManager.Words[39] = { name = "Vas An Ort", desc = "Mass Dispel" }
ChatManager.Words[40] = { name = "Flam Kal Des Ylem", desc = "Meteor Swarm" }
ChatManager.Words[41] = { name = "Por Corp Wis", desc = "Mind Blast" }
ChatManager.Words[42] = { name = "In Lor", desc = "Nightsight" }
ChatManager.Words[43] = { name = "An Ex Por", desc = "Paralyze" }
ChatManager.Words[44] = { name = "In Ex Grav", desc = "Paralyze Field" }
ChatManager.Words[45] = { name = "In Nox", desc = "Poison" }
ChatManager.Words[46] = { name = "In Nox Grav", desc = "Poison Field" }
ChatManager.Words[47] = { name = "Vas Ylem Rel", desc = "Polymorph" }
ChatManager.Words[48] = { name = "Uus Sanct", desc = "Protection" }
ChatManager.Words[49] = { name = "Flam Sanct", desc = "Reactive Armor" }
ChatManager.Words[50] = { name = "Kal Ort Por", desc = "Recall" }
ChatManager.Words[51] = { name = "An Corp", desc = "Resurrection" }
ChatManager.Words[52] = { name = "Wis Quas", desc = "Reveal" }
ChatManager.Words[53] = { name = "Uus Mani", desc = "Strength" }
ChatManager.Words[54] = { name = "Kal Xen", desc = "Summ. Creature" }
ChatManager.Words[55] = { name = "Kal Vas Xen Hur", desc = "Summon Air Elemental" }
ChatManager.Words[56] = { name = "Kal Vas Xen Corp", desc = "Summon Daemon" }
ChatManager.Words[57] = { name = "Kal Vas Xen Ylem", desc = "Summon Earth Elemental" }
ChatManager.Words[58] = { name = "Kal Vas Xen Flam", desc = "Summon Fire Elemental" }
ChatManager.Words[59] = { name = "Kal Vas Xen An Flam", desc = "Summon Water Elemental" }
ChatManager.Words[60] = { name = "Ort Por Ylem", desc = "Telekinesis" }
ChatManager.Words[61] = { name = "Rel Por", desc = "Teleport" }
ChatManager.Words[62] = { name = "Ex Por", desc = "Unlock" }
ChatManager.Words[63] = { name = "In Sanct Ylem", desc = "Wall of Stone" }
ChatManager.Words[64] = { name = "Des Mani", desc = "Weaken" }
ChatManager.Words[65] = { name = "In Aglo Corp Ylem", desc = "Corpse Skin" }
ChatManager.Words[66] = { name = "In Bal Nox", desc = "Strangle" }
ChatManager.Words[67] = { name = "In Jux Mani Xen", desc = "Blood Oath" }
ChatManager.Words[68] = { name = "In Sar", desc = "Pain Spike" }
ChatManager.Words[69] = { name = "In Vas Nox", desc = "Poison Strike" }
ChatManager.Words[70] = { name = "Kal Vas An Flam", desc = "Wither" }
ChatManager.Words[71] = { name = "Kal Xen Bal", desc = "Summon Familiar" }
ChatManager.Words[72] = { name = "Kal Xen Bal Beh", desc = "Vengeful Spirit" }
ChatManager.Words[73] = { name = "Ort Corp Grav", desc = "Exorcism" }
ChatManager.Words[74] = { name = "Pas Tym An Sanct", desc = "Evil Omen" }
ChatManager.Words[75] = { name = "Rel Xen An Sanct", desc = "Vampiric Embrace" }
ChatManager.Words[76] = { name = "Rel Xen Corp Ort", desc = "Lich Form" }
ChatManager.Words[77] = { name = "Rel Xen Um", desc = "Wraith Form" }
ChatManager.Words[78] = { name = "Rel Xen Vas Bal", desc = "Horrific Beast" }
ChatManager.Words[79] = { name = "Uus Corp", desc = "Animate Dead" }
ChatManager.Words[80] = { name = "Wis An Ben", desc = "Mind Rot" }
ChatManager.Words[81] = { name = "Alalithra", desc = "Summon Fey" }
ChatManager.Words[82] = { name = "Anathrae", desc = "Essense of Wind" }
ChatManager.Words[83] = { name = "Aslavdra", desc = "Arcane Empowerment" }
ChatManager.Words[84] = { name = "Erelonia", desc = "Thunderstorm" }
ChatManager.Words[85] = { name = "Haeldril", desc = "Attunement" }
ChatManager.Words[86] = { name = "Haelyn", desc = "Wildfire" }
ChatManager.Words[87] = { name = "Illorae", desc = "Gift of Life" }
ChatManager.Words[88] = { name = "Myrshalee", desc = "Arcane Circle" }
ChatManager.Words[89] = { name = "Nylisstra", desc = "Summon Fiend" }
ChatManager.Words[90] = { name = "Nyraxle", desc = "Word of Death" }
ChatManager.Words[91] = { name = "Olorisstra", desc = "Gift of Renewal" }
ChatManager.Words[92] = { name = "Orlavdra", desc = "Ethereal Voyage" }
ChatManager.Words[93] = { name = "Rathril", desc = "Dryad Allure" }
ChatManager.Words[94] = { name = "Rauvvrae", desc = "Nature's Fury" }
ChatManager.Words[95] = { name = "Tarisstree", desc = "Reaper Form" }
ChatManager.Words[96] = { name = "Thalshara", desc = "Immolating Weapon" }
ChatManager.Words[97] = { name = "Augus Luminos", desc = "Holy Light" }
ChatManager.Words[98] = { name = "Consecrus Arma", desc = "Consecrate Weapon" }
ChatManager.Words[99] = { name = "Dispiro Malas", desc = "Dispel Evil" }
ChatManager.Words[100] = { name = "Dium Prostra", desc = "Noble Sacrifice" }
ChatManager.Words[101] = { name = "Divinum Furis", desc = "Divine Fury" }
ChatManager.Words[102] = { name = "Expor Flamus", desc = "Cleanse by Fire" }
ChatManager.Words[103] = { name = "Extermo Vomica", desc = "Remove Curse" }
ChatManager.Words[104] = { name = "Forul Solum", desc = "Enemy of One" }
ChatManager.Words[105] = { name = "Obsu Vulni", desc = "Close Wounds" }
ChatManager.Words[106] = { name = "Sanctum Viatas", desc = "Sacred Journey" }





----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

-- Sometime in the future we may want to hide the unique IDs from the players.
-- Disabling this toggle will cause all the function calls dealing with the uniqueID column to be skipped over.
ChatManager.ENABLE_UNIQUE_ID_COLUMN = true

ChatManager.OverheadFont = nil
ChatManager.OverheadFontSettingName = "OverheadChatFont"
ChatManager.ChatWindowFont = nil
ChatManager.ChatWindowFontSettingName = "ChatWindowFont"
ChatManager.UseTimestampsSetting = "ChatWindowUseTimestamp"

ChatManager.ScaleOverheadName = "ChatManagerScaleOverhead"

ChatManager.OverheadWindowTimePassed = {}
ChatManager.OverheadWindowTimeAlive = {}
--how long the overhead chats will stay on screen (in sec's)
ChatManager.OverheadAlive = 10
ChatManager.MaxOverheadHeight = 150
ChatManager.MaxLogEntries = 100  -- Max number of entries to keep in the log

ChatManager.SystemMessageTimePassed = {}
ChatManager.ChatTextTimePassed = {}
ChatManager.SystemMessageAlive = 10
ChatManager.ChatTextAlive = 60
--ChatManager.MouseOverOn = {}

ChatManager.TextEntryUnicodeCode = -1
ChatManager.TextEntryUnicodeSender = -1
ChatManager.TextEntryUnicodeId = -1

ChatManager.DefaultHue = 1	-- Black

ChatManager.TextColors = {}
--ChatManager.TextColors[0]    = { r=255, g=255, b=255 } --- NONE
--ChatManager.TextColors[34]   = { r=255, g=0  , b=0   } --- RED
--ChatManager.TextColors[53]   = { r=255, g=255, b=0   } --- YELLOW/HELP
--ChatManager.TextColors[63]   = { r=0,   g=0,   b=255 } --- GREEN
--ChatManager.TextColors[89]   = { r=0,   g=0,   b=255 } --- BLUE
--ChatManager.TextColors[119]  = { r=255, g=0,   b=255 } --- PURPLE
--ChatManager.TextColors[144]  = { r=255, g=128, b=0   } --- ORANGE
--ChatManager.TextColors[1121] = { r=255, g=255, b=255 } --- RUNEBOOK

ChatManager.DelayValueToSeconds = { [1] = 5, [2] = 10, [3] = 30, [4] = 60, [5] = 300, [6] = 1000000 }

WindowData.ChatChannelCount = 12

--ChatManager.SYSTEM_CHANNEL = 1
--ChatManager.CHAT_CHANNEL = 2

--WindowData.ChannelsOnTab = {[1] = {[1]=true}, [2] = {[2]=true, [3]=true}}
--WindowData.ChannelsOnTab = {}

ChatManager.ChannelNames = {
	L"System",
	L"Say",
	L"Private",
	L"Custom",
	L"Emote",
	L"Gesture",
	L"Whisper",
	L"Yell",
	L"Party",
	L"Guild",
	L"Alliance",
--	L"Faction",
    L"Combat",
}
ChatManager.CombatChannelId = 12
ChatManager.CombatChannelActive = false

ChatManager.GetsOverhead = {
	false,	--	System
	true,	--	Say
	false,	--	Private
	false,	--	Custom
	true,	--	Emote
	true,	--	Gesture
	false,	--	Whisper
	true,	--	Yell
	false,	--	Party
	false,	--	Guild
	false,	--	Alliance
--	false,	--	Faction
	false,	--	Combat
}

--WindowData.TabName = {L"System", L"Chat"}

--this is the format of the chat window data struct
--the c code will load it from a file at startup
--WindowData.ChatWindow =
--{
--	{x = 0, y = 760, TabCount = 2, ActiveTab = 1, Tabs = {[1]=true, [2]=true}}
--}

ChatManager.IsDragging = false
ChatManager.DraggingTabId = nil
ChatManager.CurrentDropTargetChatWindowId = nil

ChatManager.PreviousFriendsListCount = 0
ChatManager.CurFriendsListIdx = -1

ChatManager.RenameTabId = -1

ChatManager.Resizing = false
ChatManager.ResizingWindow = ""
ChatManager.MinX = 250
ChatManager.MinY = 150

ChatManager.IsEnteringChat = false

ChatManager.TabWidth = 103
ChatManager.HelpButtonWidth = 50

ChatManager.FriendsListItemColorOnline = {r=253, g=210, b=69, a=255}
ChatManager.FriendsListItemColorOffline = {r=102, g=80, b=80, a=255}
ChatManager.FriendsListItemColorSelected = {r=255, g=255, b=255, a=255}

ChatManager.SilenceFilter = "/silence"
ChatManager.QuietFilter = "/quiet"
ChatManager.VoiceFilter = "/voice"
ChatManager.FilterMode = ChatManager.VoiceFilter
ChatManager.Repeats = {}

----------------------------------------------------------------
-- ChatOverhead Functions
----------------------------------------------------------------


-- Window Creater
function ChatManager.Initialize()
	WindowRegisterEventHandler( "Root", SystemData.Events.CHAT_ENTER_START, "ChatManager.BeginChatInput")
	WindowRegisterEventHandler( "Root", SystemData.Events.CHAT_ENTER_END, "ChatManager.EndChatInput")
	WindowRegisterEventHandler( "Root", SystemData.Events.TEXT_ARRIVED, "ChatManager.TextArrived")
	WindowRegisterEventHandler( "Root", SystemData.Events.TEXT_ENTRY_UNICODE_ARRIVED, "ChatManager.TextEntryUnicodeArrived")
	WindowRegisterEventHandler( "Root", SystemData.Events.FRIENDSLIST_UPDATED, "ChatManager.FriendsListUpdated")
	WindowRegisterEventHandler( "Root", SystemData.Events.SAVECHATWINDOWDATA, "ChatManager.Save")

	--create the text input	box
	CreateWindow( "ChatInput", false )

	--create the label for the text input box
	CreateWindow( "InputPrefixLabel", false )

	--create the rename tab edit box
	CreateWindow( "TabRename", false )

	CreateWindow("ChatInputBackground", false)
	WindowUtils.RestoreWindowPosition("ChatInputBackground", false)


	--Retrieve Max Entries Variable from Custom settings

	ChatManager.MaxLogEntries = CustomSettings.LoadNumberValue( { settingName="MaxLogEntries", defaultValue=ChatManager.MaxLogEntries } )
	if ChatManager.MaxLogEntries < 10 then
        ChatManager.MaxLogEntries = 10
        Debug.Print("Low max log entries")
	end
	--create all tab buttons
	if WindowData.ChatWindow ~= nil then
		for id, win in pairs(WindowData.ChatWindow) do
			if(win.Tabs ~= nil) then 
				for tab, na in pairs(win.Tabs) do
					ChatManager.CreateTab(tab)
				end
			end
		end
	
		--create one more tab button to use as indicator of dropping a chat window onto another one
		CreateWindowFromTemplate( "ChatTabTarget", "ChatTab", "Root" )
		WindowSetShowing("ChatTabTarget", false)	

		--create all chat windows
		for id, win in pairs(WindowData.ChatWindow) do
			ChatManager.CreateChatWindow(id)
		end 

		ChatManager.GetDelaysFromSettings()

		ChatManager.CreateFriendsList()
	end

    for tab, ch in pairs(WindowData.ChannelsOnTab) do
        if ch[ChatManager.CombatChannelId] then
            ChatManager.CombatChannelActive = true
        end
    end
    
	--create the channel color pickers
	local defaultColors = {
		0, --HUE_NONE 
		34, --HUE_RED
		53, --HUE_YELLOW
		63, --HUE_GREEN
		89, --HUE_BLUE
		119, --HUE_PURPLE
		144, --HUE_ORANGE
		368, --HUE_GREEN_2
		946, --HUE_GREY
	}
	local hueTable = {}
	for idx, hue in pairs(defaultColors) do
		for i=0,8 do
			hueTable[(idx-1)*10+i+1] = hue+i
		end
	end
	local Brightness = 1
	CreateWindowFromTemplate( "ChannelColorPicker", "ColorPickerWindowTemplate", "Root" )
	WindowSetShowing("ChannelColorPicker", false)
	WindowClearAnchors( "ChannelColorPicker" )
	WindowAddAnchor( "ChannelColorPicker", "topleft", "Root", "topleft", 500, 400)
	ColorPickerWindow.SetNumColorsPerRow(9)
	ColorPickerWindow.SetSwatchSize(30)
	ColorPickerWindow.SetAfterColorSelectionFunction(ChatManager.ChannelColorPicked)
	ColorPickerWindow.SetWindowPadding(4,4)
	ColorPickerWindow.SetFrameEnabled(true)
	ColorPickerWindow.SetCloseButtonEnabled(true)
	ColorPickerWindow.SetColorTable(hueTable,"ChannelColorPicker")
	ColorPickerWindow.DrawColorTable("ChannelColorPicker")
	
	WindowRegisterEventHandler( "ChatInput", SystemData.Events.USER_SETTINGS_CHANGED, "ChatManager.UpdateSettings" )
    ChatManager.PrepareWordsRegex()
    CustomSettingsWindow.AddOtherBooleanSetting( "ChatWindowUseTimestamps", ChatManager.UseTimestampsSetting, false )
    ChatManager.UpdateSettings()
end

function ChatManager.PrepareWordsRegex()
    local regex = { "[", "[", "[", "[", "[" }
    for i,v in ipairs( ChatManager.Words ) do
        local chars = {}
        for i2,v2 in ipairs( regex ) do
            local char = string.sub(v.name, i2, i2)
            if string.find( regex[i2], char ) == nil then
                regex[i2] = v2..char
            end
        end
    end
    ChatManager.WordsQuickRegex = "^"
    for i,v in ipairs( regex ) do
        ChatManager.WordsQuickRegex = ChatManager.WordsQuickRegex..v.."]"
    end
end

function ChatManager.UpdateSettings()
    ChatManager.OverheadFont = CustomSettings.LoadStringValue( { settingName=ChatManager.OverheadFontSettingName, defaultValue=ChatManager.OverheadFont } )
    ChatManager.ChatWindowFont = CustomSettings.LoadStringValue( { settingName=ChatManager.ChatWindowFontSettingName, defaultValue=ChatManager.ChatWindowFont } )
    local useTimestamp = CustomSettings.LoadBooleanValue( { settingName = ChatManager.UseTimestampsSetting, defaultValue=false } )
    for i, win in pairs(WindowData.ChatWindow) do
        if ChatManager.ChatWindowFont ~= nil then
            LogDisplaySetFont( "SystemMessageFrame"..i.."LogDisplay", ChatManager.ChatWindowFont )
        end
        LogDisplaySetShowTimestamp( "SystemMessageFrame"..i.."LogDisplay", useTimestamp )
    end
    if ChatManager.ChatWindowFont ~= nil then
        TextEditBoxSetFont( "ChatInput", ChatManager.ChatWindowFont )
        LabelSetFont( "InputPrefixLabel", ChatManager.ChatWindowFont, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING )
    end
end

function ChatManager.CreateTab(id)
	CreateWindowFromTemplate( "ChatTab"..id, "ChatTab", "Root" )
	if WindowData.TabName[id] == nil then
		WindowData.TabName[id] = L"Tab"..id
	end
	if WindowData.ChannelsOnTab[id] == nil then
		WindowData.ChannelsOnTab[id] = {}
	end

	ButtonSetText("ChatTab"..id, WindowData.TabName[id])
--	ChatManager.MouseOverOn[id] = false
--	WindowSetAlpha("ChatTab"..id, 0.5)
	-- create one TextLog per tab
	TextLogCreateWithLimit("SystemMessageLog"..id, ChatManager.MaxLogEntries)

-- This section retrieves custom setting and if Save Logs is enabled will activate the auto save functions built into UI
-- This will save Each chat tab that is created with the tab name included in the file name

	if CustomSettings.LoadBooleanValue( { settingName="SaveChatLogs", defaultValue=false } ) then
		local tabLogName = "logs/chat-"..tostring(WindowData.TabName[id])..".log"
		TextLogSetIncrementalSaving("SystemMessageLog"..id, true, tabLogName)
		TextLogSetEnabled("SystemMessageLog"..id, true)
	end
-- End edit

--	for colorId, color in pairs( ChatManager.TextColors[id] ) do
--		TextLogAddFilterType("SystemMessageLog"..id, colorId, L"" )
--	end

end

function ChatManager.CreateFriendsList()
	CreateWindow("FriendsList", false)
	WindowUtils.SetWindowTitle( "FriendsList", GetStringFromTid(1078517))
	LabelSetText("FriendsListNameLabel", GetStringFromTid(1079364))
	LabelSetText("FriendsListOnlineLabel", GetStringFromTid(1079366))
	ButtonSetText("FriendsListTellButton", GetStringFromTid(1079283))
	ButtonSetText("FriendsListDeleteButton", GetStringFromTid(3000176))
	ButtonSetText("FriendsListAddButton", GetStringFromTid(1079279))
	--ButtonSetText("FriendsListAddByIdButton", GetStringFromTid(1079282)) -- The Add by ID button has been removed
	if ChatManager.ENABLE_UNIQUE_ID_COLUMN then
		LabelSetText("FriendsListIdLabel", GetStringFromTid(1079365))
	end
--	ChatManager.PopulateFriendsList()
end

function ChatManager.PopulateFriendsList()
	-- clear friends list
	for i=1, ChatManager.PreviousFriendsListCount do
		--hide instead of destroy because destroyWindow dosen't actually destroy it, it just puts it into the destroy queue
		WindowSetShowing("FriendsListItem"..i, false)
	end
	
	-- list all player in the ignore list
	local first = true
	for i=1, WindowData.FriendsListCount do
		if i > ChatManager.PreviousFriendsListCount then
			CreateWindowFromTemplate( "FriendsListItem"..i, "FriendsListItem", "FriendsListItemList" )
		else
			WindowClearAnchors( "FriendsListItem"..i )
		end
		WindowSetShowing("FriendsListItem"..i, true)
		LabelSetText("FriendsListItem"..i.."Name", WindowData.FriendsNameList[i])
		if ChatManager.ENABLE_UNIQUE_ID_COLUMN then
			LabelSetText("FriendsListItem"..i.."Id", StringToWString(tostring(WindowData.FriendsIdList[i])))
		end
		LabelSetText("FriendsListItem"..i.."Online", L"  OFF")
		local color = ChatManager.FriendsListItemColorOffline
		if WindowData.FriendsOnline and WindowData.FriendsOnline[WindowData.FriendsIdList[i]] then
			color = ChatManager.FriendsListItemColorOnline
			LabelSetText("FriendsListItem"..i.."Online", L"  ON")
		end
		LabelSetTextColor( "FriendsListItem"..i.."Name", color.r, color.g, color.b )
		if ChatManager.ENABLE_UNIQUE_ID_COLUMN then
			LabelSetTextColor( "FriendsListItem"..i.."Id", color.r, color.g, color.b )
		end
		LabelSetTextColor( "FriendsListItem"..i.."Online", color.r, color.g, color.b )
		if (first)  then
			first = false
			WindowAddAnchor( "FriendsListItem"..i, "topleft", "FriendsListItemList", "topleft", 4, 10)
		else
			WindowAddAnchor( "FriendsListItem"..i, "bottomleft", previousListItem, "topleft", 0, 0)
		end
	
		previousListItem = "FriendsListItem"..i
	end
	
	ChatManager.PreviousFriendsListCount = WindowData.FriendsListCount
	ScrollWindowUpdateScrollRect("FriendsListList")	
end

function ChatManager.RearrangeTabButton(windowId)
--	Debug.PrintToDebugConsole(L"RearragenTabButton "..windowId)
	local tabIdx = 1
	local windowName = "SystemMessageFrame"..windowId
	if(WindowData.ChatWindow[windowId].Tabs ~= nil) then
		for i, j in pairs(WindowData.ChatWindow[windowId].Tabs) do
			local tabButtonName = "ChatTab"..i

			WindowClearAnchors( tabButtonName )
	--		Debug.PrintToDebugConsole(L"anchoring "..StringToWString(tabButtonName)..L" to "..StringToWString(windowName))
			WindowAddAnchor( tabButtonName, "topleft", windowName, "bottomleft", 26+(tabIdx-1)*100, 20)
			tabIdx = tabIdx + 1
			
			if WindowData.ChatWindow[windowId].ActiveTab == i then
				ButtonSetDisabledFlag(tabButtonName, false)
			else
				ButtonSetDisabledFlag("ChatTab"..i, true)
			end
		end
	end
end

function ChatManager.CreateChatWindow(windowId)
--	Debug.PrintToDebugConsole(L"CreateWindow "..windowId)

	--create the window
	local windowName = "SystemMessageFrame"..windowId
	CreateWindowFromTemplate( windowName, "SystemMessageFrame", "Root" )
	WindowUtils.RestoreWindowPosition(windowName, true)
--	WindowClearAnchors( windowName )
--	Debug.PrintToDebugConsole(L"anchoring "..StringToWString(windowName)..L" to Root x="..WindowData.ChatWindow[windowId].x..L" y="..WindowData.ChatWindow[windowId].y)
--	WindowAddAnchor( windowName, "topleft", "Root", "topleft", WindowData.ChatWindow[windowId].x, WindowData.ChatWindow[windowId].y)
--	WindowSetOffsetFromParent( windowName, WindowData.ChatWindow[windowId].x, WindowData.ChatWindow[windowId].y)
	WindowSetMovable(windowName, not WindowData.ChatWindow[windowId].Locked)

	if (not WindowData.ChatWindow[windowId].BackgroundColor) then
		WindowData.ChatWindow[windowId].BackgroundColor = ChatManager.DefaultHue
	end
	local hueR,hueG,hueB,hueA = HueRGBAValue(WindowData.ChatWindow[windowId].BackgroundColor)
	WindowSetTintColor("SystemMessageFrame"..windowId.."Background2", hueR, hueG, hueB)

	-- rearrange tab buttons	
	ChatManager.RearrangeTabButton(windowId)

	-- display the active tab
	LogDisplayAddLog("SystemMessageFrame"..windowId.."LogDisplay", "SystemMessageLog"..WindowData.ChatWindow[windowId].ActiveTab, true)
	ChatManager.ShowTab(WindowData.ChatWindow[windowId].ActiveTab)

	--set display timer
	ChatManager.SystemMessageTimePassed[windowId] = 0
	ChatManager.ChatTextTimePassed[windowId] = 0
	WindowData.ChatWindow[windowId].MostRecentTab = WindowData.ChatWindow[windowId].ActiveTab
end

function ChatManager.ShowOverheadText()
	if SystemData.TextSourceID == -1 then
		return
	end

	if (not ChatManager.GetsOverhead[SystemData.TextChannelID]) then
		return
	end
	RegisterWindowData(WindowData.MobileName.Type, SystemData.TextSourceID)
    local data = WindowData.MobileName[SystemData.TextSourceID]

    --Debug.Print(GGManager.tableToString( WindowData.MobileName))
    --Debug.Print(tostring(SystemData.TextSourceID))
    --Debug.Print(tostring(data.MobName).." has noto of "..tostring(data.Notoriety))
    UnregisterWindowData(WindowData.MobileName.Type, SystemData.TextSourceID)
    local quietMode = ( ChatManager.FilterMode == ChatManager.QuietFilter )
    local silenceMode = ( ChatManager.FilterMode == ChatManager.SilenceFilter )
	local noOverHead = false
	if ( quietMode or silenceMode ) and data.Notoriety < 7 then
        if silenceMode then
            noOverHead = true
        else -- Quiet Mode
            if ChatManager.Repeats[SystemData.TextSourceID] == SystemData.Text then
                noOverHead = true
            else
                ChatManager.Repeats[SystemData.TextSourceID] = SystemData.Text
            end
        end
	end
	if (noOverHead == true) then
		return
	end

--  First Retrieve custom setting for how to display, default to show as normal
	local currentSpell = CustomSettings.LoadNumberValue( { settingName="DisplaySpells", defaultValue=1 } )

--  Handle each possible choice by either cancelling the overhead or changing the text displayed
--  If it is set to hide all for overhead, it will still show in Chat window
--  If the text is changed it will change the overhead and Chat Window
    if currentSpell > 1 then
        local textAsString = WStringToString( SystemData.Text )
        if string.find( textAsString, ChatManager.WordsQuickRegex ) ~= nil then
            if currentSpell == 2 then
                for wordidx, word in ipairs(ChatManager.Words) do
                    if textAsString == word.name then
                        return
                    end
                end
            elseif currentSpell == 3 then
                for wordidx, word in ipairs(ChatManager.Words) do
                    if textAsString == word.name then
                        SystemData.Text = SystemData.Text..L" - "..StringToWString(word.desc)
                        break
                    end
                end
            elseif currentSpell == 4 then
                for wordidx, word in ipairs(ChatManager.Words) do
                    if textAsString == word.name then
                        SystemData.Text = StringToWString(word.desc)
                        break
                    end
                end
            end
        end
	end

--	Debug.PrintToDebugConsole(L"show over head, source id is "..SystemData.TextSourceID)

	if ChatManager.OverheadWindowTimePassed[SystemData.TextSourceID] == nil then
	    local windowName = "ChatOverhead"..SystemData.TextSourceID
	    if( DoesWindowNameExist(windowName) == false ) then
		    CreateWindowFromTemplate( windowName, "ChatOverhead", "Root" )
		    WindowSetId(windowName, SystemData.TextSourceID)
		end
		ChatManager.OverheadWindowTimePassed[SystemData.TextSourceID] = 0
		ChatManager.OverheadWindowTimeAlive[SystemData.TextSourceID] = 0
		AttachWindowToWorldObject( SystemData.TextSourceID, windowName )
		--hack to force the overhead chat window to update
		--for some reason, LabelSetText won't redraw the window after the first time unless the text is long enough to force a window resize
		-- DAB: This doesnt work anymore with the new drop, we need to find a new way to fix this
		--LabelSetText( "ChatOverhead"..SystemData.TextSourceID, L"                                                                                           ")
	end
	
	local OldChat = LabelGetText("ChatOverhead"..SystemData.TextSourceID)
	ChatManager.OverheadWindowTimePassed[SystemData.TextSourceID] = 0
	local x, y = LabelGetTextDimensions("ChatOverhead"..SystemData.TextSourceID)
	if y >= ChatManager.MaxOverheadHeight then
		local start = wstring.find(OldChat, L"\n")
		if start ~= nil then
			OldChat = wstring.sub(OldChat, start+1, nil)
		end
	end
	local NewChat = OldChat..L"\n"..SystemData.Text
	local overheadAliveTime = ChatManager.OverheadAlive
    if CustomSettings.LoadBooleanValue( { settingName=ChatManager.ScaleOverheadName, defaultValue=false } ) then
        overheadAliveTime = ( wstring.len( SystemData.Text ) + 40 ) * ( ChatManager.OverheadAlive / 80 )
    end
    if ChatManager.OverheadWindowTimeAlive[SystemData.TextSourceID] < overheadAliveTime then 
        ChatManager.OverheadWindowTimeAlive[SystemData.TextSourceID] = overheadAliveTime
    end
    
--	if wstring.len(NewChat) > ChatManager.MaxOverheadText then
--		NewChat = wstring.sub(NewChat, wstring.len(NewChat)-ChatManager.MaxOverheadText, nil)
--	end

	local hueR,hueG,hueB,hueA = HueRGBAValue(WindowData.OverheadColor)
	LabelSetTextColor( "ChatOverhead"..SystemData.TextSourceID, hueR, hueG, hueB )
	LabelSetText( "ChatOverhead"..SystemData.TextSourceID, NewChat)
    if ChatManager.OverheadFont ~= nil then
    	LabelSetFont( "ChatOverhead"..SystemData.TextSourceID, ChatManager.OverheadFont, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING )
    end
end

function ChatManager.OnOverheadChatShutdown()
    local windowName = SystemData.ActiveWindow.name
    local id = WindowGetId(windowName)
    DetachWindowFromWorldObject( id, windowName )
    ChatManager.OverheadWindowTimePassed[id] = nil
    ChatManager.OverheadWindowTimeAlive[id] = nil
end

ChatManager.UOTimeAMPM = nil
function ChatManager.TextArrived()
--	Debug.PrintToDebugConsole(L"text arrived "..SystemData.Text)
--	Debug.PrintToDebugConsole(L"source id "..SystemData.TextSourceID)
--	Debug.PrintToDebugConsole(L"channel id "..SystemData.TextChannelID)
--	Debug.PrintToDebugConsole(L"source name "..StringToWString(SystemData.SourceName))
--	Debug.PrintToDebugConsole(L"color "..SystemData.TextColor)

	if( SystemData.Text == L"" ) then
		return
	end

	if( SystemData.Text == L"As the house owner, you may rename this Parrot.") then
--		Debug.Print("Insert call to open parrot gump")
--		Debug.Print("mobile ID = "..WindowData.CurrentTarget.TargetId)

		itemData = WindowData.MobileName[WindowData.CurrentTarget.TargetId]		
--		Debug.Print("Current name = "..tostring(itemData.MobName))
		local mName = itemData.MobName
--		Debug.Print("mName type = "..type(mName))
		local f2 = wstring.find(mName, L" The Parrot")
--		Debug.Print("f2 = "..f2)
		local nOnly = wstring.sub(mName, 1, f2 - 1)
		Debug.Print("find result = "..string.find(tostring(itemData.MobName), " The Parrot"))
		Debug.Print("mName f2 = "..f2)
		Debug.Print("Name only = "..tostring(nOnly)..".")

		if f2 ~= nil then
			CreateWindow( "ChangeParrotNameWindow", true )
			WindowSetShowing( "ChangeParrotNameWindow", true)
		end

	end
	
    -- Check to see if a clock was used; if so, store the UO time
    if SystemData.SourceName == "" then
        local textAsString = SystemData.Text
        if QuickDetailsWindow.UOTimeClockString == nil then
            QuickDetailsWindow.UOTimeClockString = CustomLocalization.Load("UOTimeClockString")
            QuickDetailsWindow.UOTimeAMStrings = CustomLocalization.Load("UOTimeAMStrings")
            QuickDetailsWindow.UOTimePMStrings = CustomLocalization.Load("UOTimePMStrings")
        end
        if ChatManager.UOTimeAMPM ~= nil then
            local start,finish,hour,minute = wstring.find( textAsString, QuickDetailsWindow.UOTimeClockString )
            Debug.Print( ChatManager.UOTimeAMPM )
            if start ~= nil then
                hour = tonumber( hour )
                if hour == 12 then
                    hour = 0
                end
                if ChatManager.UOTimeAMPM == "PM" then
                    hour = hour + 12
                end
                QuickDetailsWindow.LastKnownUOTimeInMinutes = hour * 60 + tonumber( minute )
                QuickDetailsWindow.LastKnownUOTimer = QuickDetailsWindow.timer
            end
            ChatManager.UOTimeAMPM = nil
        elseif wstring.find( QuickDetailsWindow.UOTimePMStrings, L"|"..textAsString..L"|" ) ~= nil then
            ChatManager.UOTimeAMPM = "PM"
        elseif wstring.find( QuickDetailsWindow.UOTimeAMStrings, L"|"..textAsString..L"|" ) ~= nil then
            ChatManager.UOTimeAMPM = "AM"
        end
    end
	
	--show overhead message if it's attached to something
	if SystemData.Settings.Interface.OverheadChat and SystemData.TextSourceID ~= -1 then
		ChatManager.ShowOverheadText()
	end

	tabId = SystemData.TextChannelID
--	Debug.PrintToDebugConsole(L"text arrived, channel is "..SystemData.TextChannelID..L", tab is "..tabId..L", SystemData.TextColor="..SystemData.TextColor)
	if WindowData.ChannelsOnTab then
		for tab, ch in pairs(WindowData.ChannelsOnTab) do
			if (ch[SystemData.TextChannelID]) then
				local text = SystemData.Text
				if SystemData.TextSourceId ~= -1 and SystemData.SourceName ~= "" then
					text = StringToWString(SystemData.SourceName)..L": "..SystemData.Text
				end
		
				-- Wilki doesn't want the tab to be switched to just because it gets a message:
				local windowId = ChatManager.GetWindowIdByTab(tab)
if CustomSettings.LoadBooleanValue({ settingName="ScrollLockChat", defaultValue=false }) == false then
				ChatManager.ShowTab(WindowData.ChatWindow[windowId].ActiveTab)
else
	local windowId = ChatManager.GetWindowIdByTab(tabId)
	local windowName = "SystemMessageFrame"..windowId
	WindowSetShowing(windowName.."LogDisplay", true)
end

				-- if this color hasn't been used before, get it from the hue table and load it to the filter colors:
				if (not (ChatManager.TextColors[tab] and ChatManager.TextColors[tab][SystemData.TextColor])) then
					local windowId = ChatManager.GetWindowIdByTab(tab)
					local windowName = "SystemMessageFrame"..windowId
					local logDisplayName = windowName.."LogDisplay"
					local textLogName = "SystemMessageLog"..tab
					TextLogAddFilterType(textLogName, SystemData.TextColor, L"" )
					hueR,hueG,hueB,hueA = HueRGBAValue(SystemData.TextColor)
					LogDisplaySetFilterColor (logDisplayName, textLogName, SystemData.TextColor, hueR, hueG, hueB)
					LogDisplaySetFilterState (logDisplayName, textLogName, SystemData.TextColor, true )
					if (not ChatManager.TextColors[tab]) then
						ChatManager.TextColors[tab] = {}
					end
					ChatManager.TextColors[tab][SystemData.TextColor] = {r=hueR, g=hueG, b=hueB}
				end
				--add the message to text log
				TextLogAddEntry("SystemMessageLog"..tab, SystemData.TextColor, text )

				--refresh the system message time passed variable
				ChatManager.SystemMessageTimePassed[windowId] = 0
				ChatManager.ChatTextTimePassed[windowId] = 0

				-- adding customization for alert for new text on tabs not active
				if CustomSettings.LoadBooleanValue( { settingName="NewChatTextAlert", defaultValue=false } ) == true then
					if (tab ~= WindowData.ChatWindow[windowId].ActiveTab) then
						-- routine to change the Button names to add *
						ButtonSetText("ChatTab"..tab, L"+"..WindowData.TabName[tab]..L"+")
						-- Call Mouse over routine to bring up the Chat window frame
						--force every chat window to show up
						if SystemData.Settings.Interface.ShowChatWindow then
							for i, win in pairs(WindowData.ChatWindow) do
								WindowSetShowing("SystemMessageFrame"..i.."Background", true)
								WindowSetShowing("SystemMessageFrame"..i.."Background2", true)
								WindowSetShowing("SystemMessageFrame"..i.."ResizeButton", true)
								WindowSetShowing("SystemMessageFrame"..i.."HelpButton", true)
								TextLogDisplayShowScrollbar("SystemMessageFrame"..i.."LogDisplay", true)
								WindowSetShowing("SystemMessageFrame"..i.."LogDisplay", true)
								for tab, notused in pairs(win.Tabs) do
									WindowSetShowing("ChatTab"..tab, true)
								end
								ChatManager.SystemMessageTimePassed[i] = 0
								ChatManager.ChatTextTimePassed[i] = 0
							end
						end
					end
				end

			end
		end
	end
end

function ChatManager.ShowTab(tabId)
--	Debug.PrintToDebugConsole(L"show tab "..tabId)

	if SystemData.Settings.Interface.ShowChatWindow == false then
		return
	end

	--which window is the requested tab in
	local windowId = ChatManager.GetWindowIdByTab(tabId)
	local windowName = "SystemMessageFrame"..windowId

	--refresh the system message time passed variable
	ChatManager.SystemMessageTimePassed[windowId] = 0
	ChatManager.ChatTextTimePassed[windowId] = 0

	--remove the current text log
	if( WindowData.ChatWindow[windowId] ~= nil ) then
	    LogDisplayRemoveLog(windowName.."LogDisplay", "SystemMessageLog"..WindowData.ChatWindow[windowId].ActiveTab)  		

	    --update active tab
	    WindowData.ChatWindow[windowId].ActiveTab = tabId
	    
	    --update tab button disable/enable state
	    for i, j in pairs(WindowData.ChatWindow[windowId].Tabs) do
    --		Debug.PrintToDebugConsole(L"chatwindow["..windowId..L"] "..i)
		    local tabButtonName = "ChatTab"..i
		    if tabId == i then
			    ButtonSetDisabledFlag(tabButtonName, false)
		    else
			    ButtonSetDisabledFlag("ChatTab"..i, true)
		    end
		WindowSetAlpha("ChatTab"..i, 1)
	    end	    
	    
	    WindowData.ChatWindow[windowId].MostRecentTab = tabId
	end
	
	--add requested text log to log display
	local logDisplayName = windowName.."LogDisplay"
	local textLogName = "SystemMessageLog"..tabId
	
	LogDisplayAddLog(logDisplayName, textLogName, true)
	if ChatManager.TextColors[tabId] then
		for colorId, color in pairs( ChatManager.TextColors[tabId] ) do
			LogDisplaySetFilterColor (logDisplayName, textLogName, colorId, color.r, color.g, color.b)
			LogDisplaySetFilterState (logDisplayName, textLogName, colorId, true )
		end
	end
	
	WindowSetShowing(windowName.."LogDisplay", true)
end

function ChatManager.BeginChatInput()
	WindowSetShowing( "ChatInput", true )
	WindowAssignFocus( "ChatInput", true )
	newChannelName,newHue = CheckForNewChannel("ChatInput")
	ChatManager.SetInputPrefix(newChannelName, newHue)
	WindowSetShowing( "InputPrefixLabel", true )
	WindowSetShowing("ChatInputBackground", true)
	--force every chat window to show up
	if SystemData.Settings.Interface.ShowChatWindow then
		for i, win in pairs(WindowData.ChatWindow) do
			WindowSetShowing("SystemMessageFrame"..i.."Background", true)
			WindowSetShowing("SystemMessageFrame"..i.."Background2", true)
			WindowSetShowing("SystemMessageFrame"..i.."ResizeButton", true)
			WindowSetShowing("SystemMessageFrame"..i.."HelpButton", true)
			TextLogDisplayShowScrollbar("SystemMessageFrame"..i.."LogDisplay", true)
			WindowSetShowing("SystemMessageFrame"..i.."LogDisplay", true)
			for tab, notused in pairs(win.Tabs) do
				WindowSetShowing("ChatTab"..tab, true)
			end
			ChatManager.SystemMessageTimePassed[i] = 0
			ChatManager.ChatTextTimePassed[i] = 0
		end
	end
	ChatManager.IsEnteringChat = true
end

function ChatManager.EndChatInput()
	TextEditBoxSetText("ChatInput", L"")
	WindowAssignFocus( "ChatInput", false )
	WindowSetShowing( "ChatInput", false)
	WindowSetShowing( "InputPrefixLabel", false)
	WindowSetShowing("ChatInputBackground", false)
	ChatManager.IsEnteringChat = false
end

function ChatManager.OnChatKeyEnter()
    local skinCommand = false
	if tostring(ChatInput.Text) == ChatManager.SilenceFilter then
        skinCommand = true
		ChatManager.FilterMode = ChatManager.SilenceFilter
	end
	if tostring(ChatInput.Text) == ChatManager.VoiceFilter then
        skinCommand = true
		ChatManager.FilterMode = ChatManager.VoiceFilter
	end
	if tostring(ChatInput.Text) == ChatManager.QuietFilter then
        skinCommand = true
        ChatManager.Repeats = {}
		ChatManager.FilterMode = ChatManager.QuietFilter
	end
    
    if not skinCommand then
        if ChatManager.TextEntryUnicodeId == -1 then
            SendChat(ChatInput.Text)
        else
            SendTextEntry(ChatManager.TextEntryUnicodeId, ChatManager.TextEntryUnicodeSender, 1, ChatInput.Text)
            ChatManager.TextEntryUnicodeId = -1
            ChatManager.TextEntryUnicodeSender = -1
            ChatManager.TextEntryUnicodeCode = -1
        end
	end
	TextEditBoxSetText("ChatInput", L"")
	


	ChatManager.EndChatInput()
end

--function ChatManager.OnChatKeyEscape()
--	TextEditBoxSetText("ChatInput", L"")   
--	WindowAssignFocus( "ChatInput", false )
--	WindowSetShowing( "ChatInput", false )
--end

function ChatManager.OnTextChanged()
	local newChannelName = L""
	newChannelName,newHue = CheckForNewChannel("ChatInput")
	ChatManager.SetInputPrefix(newChannelName, newHue)
end
	
function ChatManager.Update(updateTimePassed)
	-- TODO: this function can probably use some optimization and refactoring
	-- we don't need to fetch user setting every frame
	-- and many things in this function can be moved to a seprate function
	
	if SystemData.Settings.Interface.ShowChatWindow == false then
		--hide all the chat windows
		for i, win in pairs(WindowData.ChatWindow) do
			WindowSetShowing("SystemMessageFrame"..i.."Background", false)
			WindowSetShowing("SystemMessageFrame"..i.."Background2", false)
			WindowSetShowing("SystemMessageFrame"..i.."ResizeButton", false)
			WindowSetShowing("SystemMessageFrame"..i.."HelpButton", false)
			TextLogDisplayShowScrollbar("SystemMessageFrame"..i.."LogDisplay", false)
			WindowSetShowing("SystemMessageFrame"..i.."LogDisplay", false)
			for tab, notused in pairs(win.Tabs) do
				WindowSetShowing("ChatTab"..tab, false)
			end
		end
	end

	-- Re-set the delays from the user settings, in case the user has changed those settings
	ChatManager.GetDelaysFromSettings()
	
	if SystemData.Settings.Interface.LegacyChat and ChatInput.Text ~= L"" then
		WindowSetShowing( "ChatInput", true )
		WindowSetShowing( "InputPrefixLabel", true )
		WindowSetShowing("ChatInputBackground", true)
	end
	
	--timer for overhead msg
	if SystemData.Settings.Interface.OverheadChat then
		for id, timePassed in pairs(ChatManager.OverheadWindowTimePassed) do
			if timePassed < ChatManager.OverheadWindowTimeAlive[id] then
				ChatManager.OverheadWindowTimePassed[id] = ChatManager.OverheadWindowTimePassed[id] + updateTimePassed
				if ChatManager.OverheadWindowTimePassed[id] > ChatManager.OverheadWindowTimeAlive[id] then
				    -- Dont destroy the window just detach and hide it
					--DestroyWindow("ChatOverhead"..id)
					local windowName = "ChatOverhead"..id
					DetachWindowFromWorldObject( id, windowName )
					WindowSetShowing(windowName,false)
					LabelSetText( windowName, L"")
					ChatManager.OverheadWindowTimePassed[id] = nil
					ChatManager.OverheadWindowTimeAlive[id] = nil
				end
			end
		end
	end
	
	--drag and drop handing
	if ChatManager.IsDragging then
		local draggingChatWindowName = ChatManager.GetDraggingWindowName()
		if draggingChatWindowName ~= nil then
			--still dragging
			ChatManager.CurrentDropTargetChatWindowId = nil
			--by default hide the drop indicator tab button
			WindowSetShowing( "ChatTabTarget", false )
			WindowClearAnchors( "ChatTabTarget" )
			for id, win in pairs(WindowData.ChatWindow) do
				local chatWindowName = "SystemMessageFrame"..id
				if chatWindowName ~= draggingChatWindowName then
					local x, y = WindowGetDimensions( chatWindowName )
					if ChatManager.IsMouseOverWindow(chatWindowName)
					   and (WindowData.ChatWindow[id].TabCount+1) * ChatManager.TabWidth + ChatManager.HelpButtonWidth <= x then
						--is on top of another chat window
--						Debug.PrintToDebugConsole(L"dragging "..StringToWString(draggingChatWindowName)..L" over "..StringToWString(chatWindowName))
						ChatManager.CurrentDropTargetChatWindowId = id
						--show the indicator chat tab button
						WindowAddAnchor( "ChatTabTarget", "topleft", "SystemMessageFrame"..id, "bottomleft", 26+(WindowData.ChatWindow[id].TabCount)*100, 20)
						WindowSetShowing( "ChatTabTarget", true )
						break
					end
				end
			end
		else
			--drag ended
			if ChatManager.CurrentDropTargetChatWindowId ~= nil then
				--player dragged a tab onto another chat window
				local draggingWindowId = ChatManager.GetWindowIdByTab(ChatManager.DraggingTabId)
				local draggingWindowName = "SystemMessageFrame"..draggingWindowId
				local dropWindowId = ChatManager.CurrentDropTargetChatWindowId
				local dropChatWindow = WindowData.ChatWindow[dropWindowId]
--				Debug.PrintToDebugConsole(L"Dragged "..StringToWString(draggingWindowName)..L" onto chat win"..dropWindowId)

				--destroy the dragging window
				WindowData.ChatWindow[draggingWindowId] = nil
				ChatManager.SystemMessageTimePassed[draggingWindowId] = 0
				ChatManager.ChatTextTimePassed[draggingWindowId] = 0
				LogDisplayRemoveLog(draggingWindowName.."LogDisplay", "SystemMessageLog"..ChatManager.DraggingTabId)
				DestroyWindow(draggingWindowName)
				--add the tab to the new window
				dropChatWindow.TabCount = dropChatWindow.TabCount + 1
				dropChatWindow.Tabs[ChatManager.DraggingTabId] = true
				ChatManager.RearrangeTabButton(dropWindowId)
			end

			--clean up		
			ChatManager.IsDragging = false
			ChatManager.DraggingTabId = nil
			ChatManager.CurrentDropTargetChatWindowId = nil
			WindowSetShowing( "ChatTabTarget", false )
			
--			Debug.PrintToDebugConsole(L"-----------------------------------------------")
--			for i, win in pairs(WindowData.ChatWindow) do
--				Debug.PrintToDebugConsole(L"--win "..i..L" tab count "..win.TabCount)
--				for tab, na in pairs(win.Tabs) do
--					Debug.PrintToDebugConsole(L"----tab "..tab)	
--				end
--			end
--			Debug.PrintToDebugConsole(L"-----------------------------------------------")

		end
	
		--don't hide system message windows when dragging
		return
	end
	
	--timer for system message windows
	if WindowData.ChatWindow ~= nil then
		for id, win in pairs(WindowData.ChatWindow) do
			if ChatManager.SystemMessageTimePassed[id] and (ChatManager.SystemMessageTimePassed[id] < ChatManager.SystemMessageAlive) and
				not ChatManager.IsMouseOverWindow("SystemMessageFrame"..id) and ChatManager.IsEnteringChat == false then
				ChatManager.SystemMessageTimePassed[id] = ChatManager.SystemMessageTimePassed[id] + updateTimePassed
				if ChatManager.SystemMessageTimePassed[id] > ChatManager.SystemMessageAlive then
--					WindowSetShowing("SystemMessageFrame"..id, false)
					WindowSetShowing("SystemMessageFrame"..id.."Background", false)
					WindowSetShowing("SystemMessageFrame"..id.."Background2", false)
					WindowSetShowing("SystemMessageFrame"..id.."ResizeButton", false)
					WindowSetShowing("SystemMessageFrame"..id.."HelpButton", false)
					TextLogDisplayShowScrollbar("SystemMessageFrame"..id.."LogDisplay", false)
					--WindowSetAlpha("SystemMessageFrame"..id, 0.5)
					for tab, notused in pairs(win.Tabs) do
--						ButtonSetDisabledFlag("ChatTab"..tab, true)
--						WindowSetAlpha("ChatTab"..tab, 0.5)
						WindowSetShowing("ChatTab"..tab, false)
					end
				end
			end
		end	
	end

	--timer for chat text
	if WindowData.ChatWindow ~= nil then
		for id, win in pairs(WindowData.ChatWindow) do
			if ChatManager.ChatTextTimePassed[id] and (ChatManager.ChatTextTimePassed[id] < ChatManager.ChatTextAlive) and
				not ChatManager.IsMouseOverWindow("SystemMessageFrame"..id) and ChatManager.IsEnteringChat == false then
				ChatManager.ChatTextTimePassed[id] = ChatManager.ChatTextTimePassed[id] + updateTimePassed
				if ChatManager.ChatTextTimePassed[id] > ChatManager.ChatTextAlive then
					WindowSetShowing("SystemMessageFrame"..id.."LogDisplay", false)
				end
			end
		end	
	end
	
	--resizing
	if ChatManager.Resizing then
		local x, y = WindowGetDimensions( ChatManager.ResizingWindow )
		
		local minX = ChatManager.MinX
		local f1, f2 = string.find(ChatManager.ResizingWindow, "SystemMessageFrame", 1, true)
		if f1 ~= nil then
			local winId = tonumber(string.sub(ChatManager.ResizingWindow, f2+1))
			minX = WindowData.ChatWindow[winId].TabCount * ChatManager.TabWidth + ChatManager.HelpButtonWidth
		end
		if( x < minX  ) then
			WindowSetDimensions( ChatManager.ResizingWindow, minX, y )
		end
		if( y < ChatManager.MinY ) then
			WindowSetDimensions( ChatManager.ResizingWindow, x, ChatManager.MinY )
		end
	end
end

function ChatManager.IsMouseOverWindow(windowName)
	local mousex = SystemData.MousePosition.x
	local mousey = SystemData.MousePosition.y
	local leftx, topy = WindowGetScreenPosition(windowName)
	local width, height = WindowGetDimensions(windowName)
	local rightx = leftx + width
	local bottomy = topy + height
	if mousex > leftx and mousex < rightx and mousey > topy and mousey < bottomy then
		return true
	end
	return false
end

function ChatManager.GetDelaysFromSettings()
	if (SystemData.Settings.Interface.ChatWindowFadeDelay) then
		ChatManager.SystemMessageAlive = ChatManager.DelayValueToSeconds[SystemData.Settings.Interface.ChatWindowFadeDelay]
	else
		ChatManager.SystemMessageAlive = 10
	end
	local oldDelay = ChatManager.OverheadAlive
	if (SystemData.Settings.Interface.OverheadChatFadeDelay) then
		ChatManager.OverheadAlive = ChatManager.DelayValueToSeconds[SystemData.Settings.Interface.OverheadChatFadeDelay]
	else
		ChatManager.OverheadAlive = 10
	end
	if ChatManager.OverheadAlive ~= oldDelay then
        for k,v in pairs( ChatManager.OverheadWindowTimeAlive ) do
            if v > ChatManager.OverheadAlive then
                ChatManager.OverheadWindowTimeAlive = Chatmanager.OverheadAlive
            end
        end
	end
	if (SystemData.Settings.Interface.ChatTextFadeDelay) then
		ChatManager.ChatTextAlive = ChatManager.DelayValueToSeconds[SystemData.Settings.Interface.ChatTextFadeDelay]
	else
		ChatManager.ChatTextAlive = 60
	end
end

function ChatManager.GetDraggingWindowName()
	for id, win in pairs(WindowData.ChatWindow) do
		local chatWindowName = "SystemMessageFrame"..id
		if WindowGetMoving(chatWindowName) then
			return chatWindowName
		end
	end

	return nil
end

function ChatManager.TextEntryUnicodeArrived()
--	Debug.PrintToDebugConsole(L"text entry unicode arrived")

	ChatManager.TextEntryUnicodeCode = SystemData.TextEntryUnicodeCode
	ChatManager.TextEntryUnicodeSender = SystemData.TextEntryUnicodeSender
	ChatManager.TextEntryUnicodeId = SystemData.TextEntryUnicodeId
	ChatManager.BeginChatInput()
end

function ChatManager.GetActiveTabId()
	local f1, f2 = string.find(SystemData.ActiveWindow.name, "Tab", 1, true)
	local TabId = 0
	if f1 ~= nil then
		TabId = tonumber(string.sub(SystemData.ActiveWindow.name, f2+1))
	end
	
--	Debug.PrintToDebugConsole(L"TabId is "..TabId)
	
	return TabId
end

function ChatManager.TabClicked()
--	Debug.PrintToDebugConsole(L"TabClicked")
	
	local tabId = ChatManager.GetActiveTabId()
	ButtonSetText("ChatTab"..tabId, WindowData.TabName[tabId]) -- This resets the name if alert of new text option changed tab name
	ChatManager.ShowTab(tabId)
end

function ChatManager.OnTabLButtonDown()
--	Debug.PrintToDebugConsole(L"LButtonDown")
	
	local cursorData
	cursorData = { Type = Cursor.TYPE_CHATTAB, ItemId = ChatManager.GetActiveTabId() }
	Cursor.Pickup(cursorData)
end

function ChatManager.DragStart(tabId)
--	Debug.PrintToDebugConsole(L"DragStart("..tabId..L")")
	
	local currentWindowId = ChatManager.GetWindowIdByTab(tabId)
	local windowName = "SystemMessageFrame"..currentWindowId
	local currentChatWindow = WindowData.ChatWindow[currentWindowId]

	--don't let player drag this tab if it's locked
	if currentChatWindow.Locked then
		return
	end

	if currentChatWindow.TabCount > 1 then
		--remove this tab from the current window
		currentChatWindow.TabCount = currentChatWindow.TabCount - 1
		currentChatWindow.Tabs[tabId] = nil
		ChatManager.RearrangeTabButton(currentWindowId)
		--if we are dragging out the current active tab, set the active tab to something else
		if currentChatWindow.ActiveTab == tabId then
			for i, j in pairs(currentChatWindow.Tabs) do
				ChatManager.ShowTab(i)
				break
			end
		end
		--create a new window with just this tab
--		WindowData.ChatWindowCount = WindowData.ChatWindowCount + 1
		currentWindowId = ChatManager.GetNextAvailableChatWindowId()
		local x, y = WindowGetDimensions( windowName )
		windowName = "SystemMessageFrame"..currentWindowId
		WindowData.ChatWindow[currentWindowId] = {TabCount=1, ActiveTab=tabId, Locked=false, Tabs={[tabId]=true}}
--		Debug.PrintToDebugConsole(L"create chatwindow[]"..currentWindowId..L" tabid "..tabId)
		ChatManager.CreateChatWindow(currentWindowId)
		WindowClearAnchors( windowName )
		WindowAddAnchor( windowName, "topleft", "Root", "topleft", SystemData.MousePosition.x, SystemData.MousePosition.y+150)
		WindowSetDimensions( windowName, x, y )
	end
	WindowSetShowing(windowName, true)
	WindowSetMoving(windowName, true)
	WindowAssignFocus(windowName, true)
	
	ChatManager.IsDragging = true
	ChatManager.DraggingTabId = tabId
end

function ChatManager.GetNextAvailableChatWindowId()
--	Debug.PrintToDebugConsole("GetNextAvailableChatWindowId")

	for id = 1, 9999 do
		if WindowData.ChatWindow[id] == nil then
--			Debug.PrintToDebugConsole("next id: "..id)
			return id
		end
	end
	return 0
end

function ChatManager.GetWindowIdByTab(tabId)
--	Debug.PrintToDebugConsole(L"GetWindowByTab("..tabId..L")")
	
	for id, win in pairs(WindowData.ChatWindow) do
--		Debug.PrintToDebugConsole(L"win id "..id)
		for j, k in pairs(win.Tabs) do
--			Debug.PrintToDebugConsole(L"tab id "..j)
			if j == tabId then
--				Debug.PrintToDebugConsole(L"windowId "..id)
				return id
			end
		end
	end
	
--	Debug.PrintToDebugConsole(L"windowId "..0)
	return 0
end

function ChatManager.GetNextAvailableTabId()
	local tabs = {}
	for id, win in pairs(WindowData.ChatWindow) do
		for tab, na in pairs(win.Tabs) do
			tabs[tab] = true
		end
	end
	
	--start from 3, tab1,2 is currently reserved for system and chat
	for i = 3, 999 do
		if tabs[i] == nil then
			return i
		end
	end
	
	return 0
end

function ChatManager.ChannelColorPicked()
	local huePicked = ColorPickerWindow.colorSelected["ChannelColorPicker"]
	WindowData.ChannelColor[ChatManager.ColorPickingChannelId] = huePicked
	SetChatChannelColor(ChatManager.ColorPickingChannelId, huePicked)
end

function ChatManager.BackgroundColorPicked()
	local huePicked = ColorPickerWindow.colorSelected["ChannelColorPicker"]
	WindowData.ChatWindow[ChatManager.WindowId].BackgroundColor = huePicked
	SetChatBackgroundColor(ChatManager.WindowId, huePicked)
	hueR,hueG,hueB,hueA = HueRGBAValue(WindowData.ChatWindow[ChatManager.WindowId].BackgroundColor)
	WindowSetTintColor("SystemMessageFrame"..ChatManager.WindowId.."Background2", hueR, hueG, hueB)
end

function ChatManager.OverheadColorPicked()
	local huePicked = ColorPickerWindow.colorSelected["ChannelColorPicker"]
	WindowData.OverheadColor = huePicked
	SetChatOverheadColor(huePicked)
end

function ChatManager.ContextMenuCallback(returnCode,param)
	if returnCode == "CustomColor" then
		ChatManager.ColorPickingChannelId = param
		ColorPickerWindow.SetAfterColorSelectionFunction(ChatManager.ChannelColorPicked)
		ColorPickerWindow.SelectColor("ChannelColorPicker", WindowData.ChannelColor[param])
		WindowSetShowing("ChannelColorPicker", true)
		return
	end

	if returnCode == "Lock" then
		WindowSetMovable("SystemMessageFrame"..param, false)
		WindowData.ChatWindow[param].Locked = true
		return
	end

	if returnCode == "Unlock" then
		WindowSetMovable("SystemMessageFrame"..param, true)
		WindowData.ChatWindow[param].Locked = false
		return
	end

	if( returnCode == "NewTab") then
		--create new tab
		local x, y = WindowGetDimensions( "SystemMessageFrame"..param )
		if (WindowData.ChatWindow[param].TabCount+1) * ChatManager.TabWidth + ChatManager.HelpButtonWidth > x then
			return
		end
		local newTab = ChatManager.GetNextAvailableTabId()
		WindowData.ChatWindow[param].TabCount = WindowData.ChatWindow[param].TabCount + 1
		WindowData.ChatWindow[param].Tabs[newTab] = true
		WindowData.TabName[newTab] = L"Tab"..newTab
		ChatManager.CreateTab(newTab)
		ChatManager.RearrangeTabButton(param)
		
--		Debug.PrintToDebugConsole(L"-----------------------------------------------")
--		for i, win in pairs(WindowData.ChatWindow) do
--			Debug.PrintToDebugConsole(L"--win "..i..L" tab count "..win.TabCount)
--			for tab, na in pairs(win.Tabs) do
--				Debug.PrintToDebugConsole(L"----tab "..tab)	
--			end
--		end
--		Debug.PrintToDebugConsole(L"-----------------------------------------------")

		return
	end
	
	if( returnCode == "RenameTab") then
		--rename the tab
		ButtonSetText("ChatTab"..param, L"")
		WindowClearAnchors( "TabRename" )
		WindowAddAnchor( "TabRename", "topleft", "ChatTab"..param, "topleft", 10, 5)
		WindowSetShowing("TabRename", true)
		WindowAssignFocus( "TabRename", true )
		TextEditBoxSetText("TabRename", WindowData.TabName[param])
		ChatManager.RenameTabId = param

		return
	end
	
	if( returnCode == "DeleteTab") then
		local tab = param[1]
		local winId = param[2]
--		Debug.PrintToDebugConsole(L"delete tab"..tab..L" win"..winId)
	
		if tab == 1 then
			--don't delete the first tab
			return
		end
		
		local currentChatWindow = WindowData.ChatWindow[winId]

		DestroyWindow("ChatTab"..tab)
        if WindowData.ChannelsOnTab[tab][ChatManager.CombatChannelId] then
            ChatManager.CombatChannelActive = false
        end
		WindowData.ChannelsOnTab[tab] = nil
		
		--if we are deleting the last tab of a window, delete the whole window
		if currentChatWindow.TabCount == 1 then
			ChatManager.SystemMessageTimePassed[winId] = 0
			ChatManager.ChatTextTimePassed[winId] = 0
			LogDisplayRemoveLog("SystemMessageFrame"..winId.."LogDisplay", "SystemMessageLog"..tab)
			WindowData.ChatWindow[winId] = nil
			DestroyWindow("SystemMessageFrame"..winId)
			
--			Debug.PrintToDebugConsole(L"-----------------------------------------------")
--			for i, win in pairs(WindowData.ChatWindow) do
--				Debug.PrintToDebugConsole(L"--win "..i..L" tab count "..win.TabCount)
--				for tab, na in pairs(win.Tabs) do
--					Debug.PrintToDebugConsole(L"----tab "..tab)	
--				end
--			end
--			Debug.PrintToDebugConsole(L"-----------------------------------------------")

			return
		end
		
		--if we are deleting the active tab, set the active tab to something else
		if currentChatWindow.ActiveTab == tab then
			for i, j in pairs(currentChatWindow.Tabs) do
				ChatManager.ShowTab(i)
				break
			end
		end
		
		currentChatWindow.Tabs[tab] = nil
		WindowData.ChatWindow[winId].TabCount = WindowData.ChatWindow[winId].TabCount - 1

		ChatManager.RearrangeTabButton(winId)		

--		Debug.PrintToDebugConsole(L"-----------------------------------------------")
--		for i, win in pairs(WindowData.ChatWindow) do
--			Debug.PrintToDebugConsole(L"--win "..i..L" tab count "..win.TabCount)
--			for tab, na in pairs(win.Tabs) do
--				Debug.PrintToDebugConsole(L"----tab "..tab)	
--			end
--		end
--		Debug.PrintToDebugConsole(L"-----------------------------------------------")

		return
	end

	if returnCode == "BGColor" then
		ChatManager.WindowId = param
		ColorPickerWindow.SetAfterColorSelectionFunction(ChatManager.BackgroundColorPicked)
		ColorPickerWindow.SelectColor("ChannelColorPicker", WindowData.ChatWindow[param].BackgroundColor)
		WindowSetShowing("ChannelColorPicker", true)
		return
	end

	if returnCode == "OHColor" then
		ChatManager.WindowId = param
		ColorPickerWindow.SetAfterColorSelectionFunction(ChatManager.OverheadColorPicked)
		ColorPickerWindow.SelectColor("ChannelColorPicker", WindowData.OverheadColor)
		WindowSetShowing("ChannelColorPicker", true)
		return
	end

	if( param ~= nil ) then
		if (WindowData.ChannelsOnTab[param.TabIndex] and WindowData.ChannelsOnTab[param.TabIndex][returnCode]) then
--			Debug.Print("tab "..param.TabIndex.." is no longer getting messages from channel "..returnCode)
			WindowData.ChannelsOnTab[param.TabIndex][returnCode] = nil
			if returnCode == ChatManager.CombatChannelId then
                ChatManager.CombatChannelActive = false
			end
		else
--			Debug.Print("tab "..param.TabIndex.." is now getting messages from channel "..returnCode)
			
-- Custom setting to allow channels to be assigned to multiple tabs, note use caution
	if CustomSettings.LoadBooleanValue( { settingName="AllowTextMultiTab", defaultValue=false } ) == false then
			--don't allow assigning one channle to multiple tabs for now, which will fix the crash
			for tab, ch in pairs(WindowData.ChannelsOnTab) do
				for i, na in pairs(ch) do
					if i == returnCode then
						WindowData.ChannelsOnTab[tab][returnCode] = nil
					end
				end
			end
	end

			WindowData.ChannelsOnTab[param.TabIndex][returnCode] = true
			if returnCode == ChatManager.CombatChannelId then
                ChatManager.CombatChannelActive = true
			end
		end
	end

end

function ChatManager.ItemRButtonUp()
	local tabIndex = ChatManager.GetActiveTabId()
	local param = {TabIndex=tabIndex}
	local win = ChatManager.GetWindowIdByTab(tabIndex)

	ContextMenu.CreateLuaContextMenuItem(1079310,ContextMenu.GREYEDOUT)

	-- lock/unlock toggle
	if WindowData.ChatWindow[win].Locked then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Unlock",0,"Unlock", win)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Lock",0,"Lock", win)
	end

	if tabIndex ~= 1 then
		--add a delete command to custom tabs
		ContextMenu.CreateLuaContextMenuItemWithString(L"Delete Tab",0,"DeleteTab",{tabIndex, win})
		--add a rename command to custom tabs
		ContextMenu.CreateLuaContextMenuItemWithString(L"Rename Tab",0,"RenameTab", tabIndex)
	end
	local x, y = WindowGetDimensions( "SystemMessageFrame"..win )
	if (WindowData.ChatWindow[win].TabCount+1) * ChatManager.TabWidth + ChatManager.HelpButtonWidth <= x then
		--add a new tab command
		ContextMenu.CreateLuaContextMenuItemWithString(L"New Tab",0,"NewTab",win)
	end

	--add a menu item to re-color the chat log window background:
	ContextMenu.CreateLuaContextMenuItemWithString(L"Background Color", 0, "BGColor", win)

	--add a menu item to change the color of overhead chat text:
	ContextMenu.CreateLuaContextMenuItemWithString(L"Overhead Text Color", 0, "OHColor", win)

--	Debug.PrintToDebugConsole(L"active tab id is "..tabIndex)

	ContextMenu.CreateLuaContextMenuItem(1079311,ContextMenu.GREYEDOUT)
	
	for i=1, WindowData.ChatChannelCount do
		if (ChatManager.ChannelNames[i]) then
			local text = L""
			if (WindowData.ChannelsOnTab[tabIndex] and WindowData.ChannelsOnTab[tabIndex][i]) then
				text = L"*"
			else
				text = L"  "
			end
			text = text..ChatManager.ChannelNames[i]
			local subMenu = {{ tid=1079312, flags=0, returnCode="CustomColor", param=i},}
			ContextMenu.CreateLuaContextMenuItemWithString(text,0,i,param, nil, subMenu, nil, WindowData.ChannelColor[i])
		end
	end
	
	ContextMenu.ActivateLuaContextMenu(ChatManager.ContextMenuCallback)
end

function ChatManager.MouseOver()
--	local tabIndex = ChatManager.GetActiveTabId()
--	local windowId = ChatManager.GetWindowIdByTab(tabIndex)
--	Debug.Print("ChatManager.MouseOver, tab="..tabIndex)
--	ChatManager.MouseOverOn[windowId] = true
--	ChatManager.ShowTab(WindowData.ChatWindow[windowId].MostRecentTab)

	for i, win in pairs(WindowData.ChatWindow) do
		if ChatManager.IsMouseOverWindow("SystemMessageFrame"..i) then
			WindowSetShowing("SystemMessageFrame"..i.."Background", true)
			WindowSetShowing("SystemMessageFrame"..i.."Background2", true)
			WindowSetShowing("SystemMessageFrame"..i.."ResizeButton", true)
			WindowSetShowing("SystemMessageFrame"..i.."HelpButton", true)
			TextLogDisplayShowScrollbar("SystemMessageFrame"..i.."LogDisplay", true)
			WindowSetShowing("SystemMessageFrame"..i.."LogDisplay", true)
			for tab, notused in pairs(win.Tabs) do
				WindowSetShowing("ChatTab"..tab, true)
			end
			ChatManager.SystemMessageTimePassed[i] = 0
			ChatManager.ChatTextTimePassed[i] = 0
			break
		end
	end
end

--function ChatManager.MouseOverEnd()
--	local tabIndex = ChatManager.GetActiveTabId()
--	local windowId = ChatManager.GetWindowIdByTab(tabIndex)
--	Debug.Print("ChatManager.MouseOverEnd, tab="..tabIndex)
--	ChatManager.SystemMessageTimePassed[tabIndex] = 0
--	ChatManager.MouseOverOn[windowId] = false
--end

function ChatManager.Shutdown()
end

function ChatManager.Save()
	ClearChatWindowData()
	for id, win in pairs(WindowData.ChatWindow) do
		local windowName = "SystemMessageFrame"..id
		WindowUtils.SaveWindowPosition(windowName, false)
--		local x, y = WindowGetOffsetFromParent(windowName)
--		local x, y = WindowGetScreenPosition(windowName)
		AddChatWindowData(id, win.ActiveTab, win.Locked)
		SetChatBackgroundColor(id, WindowData.ChatWindow[id].BackgroundColor)
		for tab, notused in pairs(win.Tabs) do
			AddTabToChatWindowData(id, tab, WindowData.TabName[tab])
			
			for ch, na in pairs(WindowData.ChannelsOnTab[tab]) do
				AddChannelToTab(tab, ch)
			end
		end
	end
	WindowUtils.SaveWindowPosition("ChatInputBackground", false)

--	SaveChatWindowData()
end

function ChatManager.OnAddFriends()
	StartFriendsListAdd()
end

function ChatManager.FriendsListUpdated()
--	Debug.PrintToDebugConsole(L"friends list update")
	ChatManager.PopulateFriendsList()
end

function ChatManager.OnFriendsListItemClicked()
	Debug.PrintToDebugConsole(L"friends list item clicked")
	for i=1, WindowData.FriendsListCount do
		local color = ChatManager.FriendsListItemColorOffline
		if WindowData.FriendsOnline and WindowData.FriendsOnline[WindowData.FriendsIdList[i]] then
			color = ChatManager.FriendsListItemColorOnline
		end
		LabelSetTextColor( "FriendsListItem"..i.."Name", color.r, color.g, color.b )
		if ChatManager.ENABLE_UNIQUE_ID_COLUMN then
			LabelSetTextColor( "FriendsListItem"..i.."Id", color.r, color.g, color.b )
		end
		LabelSetTextColor( "FriendsListItem"..i.."Online", color.r, color.g, color.b )
		if( SystemData.ActiveWindow.name == "FriendsListItem"..i ) then
			ChatManager.CurFriendsListIdx = i
		end
	end

	local color = ChatManager.FriendsListItemColorSelected
	LabelSetTextColor( SystemData.ActiveWindow.name.."Name", color.r, color.g, color.b )
	if ChatManager.ENABLE_UNIQUE_ID_COLUMN then
		LabelSetTextColor( SystemData.ActiveWindow.name.."Id", color.r, color.g, color.b )
	end
	LabelSetTextColor( SystemData.ActiveWindow.name.."Online", color.r, color.g, color.b )
end

function ChatManager.OnDeleteFriend()
	if ChatManager.CurFriendsListIdx == -1 then
		return
	end

	local idx = ChatManager.CurFriendsListIdx
	local id = WindowData.FriendsIdList[idx]
--	Debug.PrintToDebugConsole(L"delete idx "..idx..L", id "..id)
	DeleteFromFriendsList(id)
	ChatManager.CurFriendsListIdx = -1
--	ChatManager.PopulateFriendsList()
end

function ChatManager.OnTellFriend()
	if ChatManager.CurFriendsListIdx == -1 then
		return
	end

--	Debug.PrintToDebugConsole(L"tell to "..WindowData.FriendsIdList[ChatManager.CurFriendsListIdx])
	
	local tellString = L"/tell "..WindowData.FriendsIdList[ChatManager.CurFriendsListIdx]..L","
	TextEditBoxSetText("ChatInput", tellString)
	ChatManager.BeginChatInput()
end

function ChatManager.OnAddFriendsById()
	AddToFriendsListById(FriendsListId.Text)
	TextEditBoxSetText("FriendsListId", L"")
end

function ChatManager.OnTabRename()
	if ChatManager.RenameTabId == -1 then
		return
	end
	
	WindowData.TabName[ChatManager.RenameTabId] = TabRename.Text
	ButtonSetText("ChatTab"..ChatManager.RenameTabId, TabRename.Text)

	WindowAssignFocus( "TabRename", false )
	WindowSetShowing("TabRename", false)

	ChatManager.RenameTabId = -1	
end

function ChatManager.OnResizeBegin()
	local f1, f2 = string.find(SystemData.ActiveWindow.name, "ResizeButton", 1, true)
	if f1 == nil then
		return
	end
	
	local winName = string.sub(SystemData.ActiveWindow.name, 1, f1-1)
--	Debug.PrintToDebugConsole(L"Resizing "..StringToWString(winName))
	WindowSetResizing( winName, true, "topleft", false );
	
	ChatManager.Resizing = true
	ChatManager.ResizingWindow = winName
end

function ChatManager.OnResizeEnd()
	ChatManager.Resizing = false
	ChatManager.ResizingWindow = ""
end

function ChatManager.HelpContextMenuCallback(returnCode ,param)
	if returnCode == L"/help" then
		ChatManager.PrintHelpText()
	else
		TextEditBoxSetText("ChatInput", returnCode..L" ")
		ChatManager.BeginChatInput()
	end
end

function ChatManager.ShowHelp()
	ContextMenu.CreateLuaContextMenuItemWithString(L"/say", 0, L"/say", nil)
	ContextMenu.CreateLuaContextMenuItemWithString(L"/whisper", 0, L"/whisper", nil)
	ContextMenu.CreateLuaContextMenuItemWithString(L"/party", 0, L"/party", nil)
	ContextMenu.CreateLuaContextMenuItemWithString(L"/guild", 0, L"/guild", nil)
	ContextMenu.CreateLuaContextMenuItemWithString(L"/alliance", 0, L"/alliance", nil)
--	ContextMenu.CreateLuaContextMenuItemWithString(L"/factoin", 0, L"/faction", nil)
--	ContextMenu.CreateLuaContextMenuItemWithString(L"/general", 0, L"/general", nil)
--	ContextMenu.CreateLuaContextMenuItemWithString(L"/trade", 0, L"/trade", nil)
	ContextMenu.CreateLuaContextMenuItemWithString(L"/emote", 0, L"/emote", nil)
--	ContextMenu.CreateLuaContextMenuItemWithString(L"/reply", 0, L"/reply", nil)
	ContextMenu.CreateLuaContextMenuItemWithString(L"/yell", 0, L"/yell", nil)
	ContextMenu.CreateLuaContextMenuItemWithString(L"/help", 0, L"/help", nil)

	ContextMenu.ActivateLuaContextMenu(ChatManager.HelpContextMenuCallback)
end

function ChatManager.PrintHelpText()
	PrintTidToChatWindow(1078605, WindowData.ChannelColor[1])
end

function ChatManager.SetInputPrefix(newChannelName, newHue)
	local hueR,hueG,hueB,hueA
	hueR,hueG,hueB,hueA = HueRGBAValue(newHue)

	LabelSetTextColor("InputPrefixLabel", hueR, hueG, hueB)
	TextEditBoxSetTextColor("ChatInput", hueR, hueG, hueB)

	if (newChannelName == L"") then
		LabelSetText("InputPrefixLabel", L"")
	else
		LabelSetText("InputPrefixLabel", newChannelName..L":  ")
	end
	
	local prefixX, prefixY = WindowGetDimensions("InputPrefixLabel")
	local inputX, inputY = WindowGetDimensions("ChatInput")
	WindowSetDimensions("ChatInput", 640 - prefixX, inputY)
end

function ChatManager.OnFriendsListShown()
	ButtonSetPressedFlag("MenuBarWindowStatusBarToggleFriendsList",true)
	ChatManager.PopulateFriendsList()
end

function ChatManager.OnFriendsListHidden()
	ButtonSetPressedFlag("MenuBarWindowStatusBarToggleFriendsList",false)
end
