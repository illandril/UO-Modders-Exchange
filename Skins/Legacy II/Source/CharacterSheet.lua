
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

CharacterSheet = {}
CharacterSheet.StatsSize = 31
CharacterSheet.Stats = { "Health",
                         "Stamina",
                         "Mana",
                         "Strength",
                         "Dexterity",
                         "Intelligence",
                         "StatCap",
                         "Luck",
                         "Weight",
                         "Gold",
                         "Followers",
                         "PhysicalResist",
                         "FireResist",
                         "ColdResist",
                         "PoisonResist",
                         "EnergyResist",
                         "Damage",
                         "HitChanceIncrease",
                         "SwingSpeedIncrease",
                         "DamageChanceIncrease",
                         "LowerReagentCost",
                         "HitPointRegen",
                         "StamRegen",
                         "ManaRegen",
                         "ReflectPhysicalDamage",
                         "EnhancePotions",
                         "DefenseChanceIncrease",
                         "SpellDamageIncrease",
                         "FasterCastRecovery",
                         "FasterCasting",
                         "LowerManaCost",}
                         -- The last 9 of these are treated special, and have been hardcoded into a function below
                         -- The TID numbers for these aren't used.
                         -- These are supposed to be commnted out.
--    					IncreaseStr = 1079401,
--						IncreaseDex = 1079402,
--						IncreaseInt = 1079403,
--						IncreaseHitPoints = 1079404,
--						IncreaseStam = 1079405,
--						IncreaseMana = 1079406,
--						IncreaseHitPointsMax = 1079407,
--						IncreaseStamMax = 1079408,
--						IncreaseManaMax = 1079409 }

CharacterSheet.Groups = {}
CharacterSheet.Groups[1] = { index={1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14} } -- Standard
CharacterSheet.Groups[2] = { nameString=L"Resistances",	nameTid=1061645, index={15, 16, 17, 18, 19} }		-- Resists
CharacterSheet.Groups[3] = { nameString=L"Attack",		nameTid=1011533, index={20, 21, 22, 23} }			-- Attacks
CharacterSheet.Groups[4] = { nameString=L"Magic",		nameTid=1078593, index={24, 29, 31, 32, 33, 34} }	-- Spells
CharacterSheet.Groups[5] = { nameString=L"Defense",		nameTid=1017320, index={25, 26, 27, 28, 30} }		-- Defensive
CharacterSheet.CurrentGroup = 2

CharacterSheet.TID = {CharacterSheet = 1077437}                            

CharacterSheet.Separators = { Health = "/",
                                 Stamina = "/",
                                 Mana = "/",
                                 Weight = "/",
                                 Damage = "-",
                                 Followers = "/" }

CharacterSheet.Attributes = { Strength = 0, Dexterity = 1, Intelligence = 2 }

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function CharacterSheet.Initialize()
	RegisterWindowData(WindowData.PlayerStatus.Type, 0)
	WindowRegisterEventHandler( "CharacterSheet", WindowData.PlayerStatus.Event, "CharacterSheet.UpdateStatus")
	
	EquipmentData.RegisterWeaponAbilitySlot("CharacterSheetPrimaryWeaponAbility",EquipmentData.WEAPONABILITY_PRIMARY)
	EquipmentData.RegisterWeaponAbilitySlot("CharacterSheetSecondaryWeaponAbility",EquipmentData.WEAPONABILITY_SECONDARY)	
	
	WindowSetId("CharacterSheetPrimaryWeaponAbility",EquipmentData.WEAPONABILITY_PRIMARY)
	WindowSetId("CharacterSheetSecondaryWeaponAbility",EquipmentData.WEAPONABILITY_SECONDARY)
	
	WindowUtils.SetWindowTitle("CharacterSheet", GetStringFromTid(CharacterSheet.TID.CharacterSheet) )	
	
-- Added the line below to display a title over the book graphic
	LabelSetText("CharacterSheetLegacyWindowTitle", L"Character Sheet")

	-- Make all label/value components
	local prev = ""
	local xoffset = 0
	local yoffset = 5
	local groupItr, group, itemItr, index, stat, i
	for groupItr, group in pairs(CharacterSheet.Groups) do
		for itemItr, i in pairs(group.index) do	
			stat = WStringToString(WindowData.PlayerStatsDataCSV[i].name)

			if stat == "HR" then
				ruleName = prev.."Rule"
				CreateWindowFromTemplate(ruleName, "CharacterSheetHRDef", prev)
				WindowAddAnchor(ruleName, "bottomleft", prev, "topleft", -5, 2)
				
				xoffset = 5
				yoffset = 2
				prev = ruleName
				continue
			end

			local entry = "CharacterSheet"..stat
			CreateWindowFromTemplate(entry, "AttributeTemplate", "CharacterSheet")
			--Set windowId for the each id
			WindowSetId(entry, i)
			
			local iconId = WindowData.PlayerStatsDataCSV[i].iconId
			CharacterSheet.SetMiniIconStats(entry, iconId)
			
			if prev == "" then
				WindowAddAnchor(entry, "topleft", "CharacterSheet", "topleft", 10, 50)
			else
				WindowAddAnchor(entry, "bottomleft", prev, "topleft", xoffset, yoffset)
				xoffset = 0
				yoffset = 5
			end

			local labelName = entry.."AttributeName"
			local tid = WindowData.PlayerStatsDataCSV[i].tid
			LabelSetText(labelName, GetStringFromTid(tid))
			
			local lockName = entry.."LockButton"
			WindowSetId(lockName, i)

			prev = entry
		end
		if groupItr == 1 then -- Various layout fixes / cleanup after te first group is set
			WindowAddAnchor( "CharacterSheetTopArrows", "topright", "CharacterSheetFollowersRule", "topleft", -125, -257 )  -- Sets position of the paging window
			WindowSetDimensions( "CharacterSheetHealthExtra" , 110, 20)
			WindowClearAnchors( "CharacterSheetHealthExtra" )
			WindowAddAnchor( "CharacterSheetHealthExtra", "left", "CharacterSheetHealthAttributeValue", "right", -5, 0 )
			WindowSetDimensions( "CharacterSheetStaminaExtra" , 110, 20)
			WindowClearAnchors( "CharacterSheetStaminaExtra" )
			WindowAddAnchor( "CharacterSheetStaminaExtra", "left", "CharacterSheetStaminaAttributeValue", "right", -5, 0 )
			WindowSetDimensions( "CharacterSheetManaExtra" , 110, 20)
			WindowClearAnchors( "CharacterSheetManaExtra" )
			WindowAddAnchor( "CharacterSheetManaExtra", "left", "CharacterSheetManaAttributeValue", "right", -5, 0 )
		end
--		Debug.Print( L""..xoffset..L" "..yoffset )
		
		xoffset = 5
		yoffset = 3
		
		prev = "CharacterSheetTopArrows"
	end
	
	CharacterSheet.UpdateSpecialStats()	
	CharacterSheet.HideAllButFirstGroups()
	CharacterSheet.ShowActiveAndFirstGroups()
	CharacterSheet.SetGroupLabel()	
	CharacterSheet.UpdateStatus()
	WindowUtils.RestoreWindowPosition("CharacterSheet")
end

function CharacterSheet.Shutdown()
	UnregisterWindowData(WindowData.PlayerStatus.Type, 0)
	
	EquipmentData.UnregisterWeaponAbilitySlot("CharacterSheetPrimaryWeaponAbility")
	EquipmentData.UnregisterWeaponAbilitySlot("CharacterSheetSecondaryWeaponAbility")		
	
	WindowUtils.SaveWindowPosition("CharacterSheet")
end

function CharacterSheet.SetMiniIconStats(iconWindow, iconId)
	local texture, x, y = GetIconData( iconId )
	--Start position of the texture, need to be offset by x and y to get the stat icon image
	x = 4  
	y = 3
	WindowSetDimensions(iconWindow.."SquareIcon", 20, 20)  --Original size is 27, 27
	DynamicImageSetTexture( iconWindow.."SquareIcon", texture, x, y )	   
	DynamicImageSetTextureScale(iconWindow.."SquareIcon", 1 )
			
end

function CharacterSheet.OnShown()
    if( WindowData.PlayerStatus ~= nil and WindowData.PlayerStatus.PlayerId ~= nil ) then
        local paperdollWindow = "PaperdollWindow"..WindowData.PlayerStatus.PlayerId
        if( DoesWindowNameExist(paperdollWindow) ) then
            ButtonSetPressedFlag(paperdollWindow.."ToggleCharacterSheet",true)
        end
    end
end

function CharacterSheet.OnHidden()
    if( WindowData.PlayerStatus ~= nil and WindowData.PlayerStatus.PlayerId ~= nil ) then
        local paperdollWindow = "PaperdollWindow"..WindowData.PlayerStatus.PlayerId
        if( DoesWindowNameExist(paperdollWindow) ) then
            ButtonSetPressedFlag(paperdollWindow.."ToggleCharacterSheet",false)
        end
    end
end

function CharacterSheet.UpdateStatus()
    local value = nil
    
	for i = 1, CharacterSheet.StatsSize do
		local k = CharacterSheet.Stats[i]
		if CharacterSheet.Separators[k] then
			local sep = CharacterSheet.Separators[k]
			-- hack for health,mana,stamina
			local curVar = k
			if( k == "Health" or k == "Stamina" or k == "Mana" ) then
				curVar = "Current"..k
			end
		        
			value = StringToWString(tostring(WindowData.PlayerStatus[curVar])..sep..tostring(WindowData.PlayerStatus["Max"..k]))
			--Debug.Print( L"Value is "..value..L" and k is "..StringToWString(k) )
		else
			value = StringToWString(tostring(WindowData.PlayerStatus[k]))
		end

		LabelSetText("CharacterSheet"..k.."AttributeValue", value)
		CharacterSheet.SetStatLock(k)
	end
	CharacterSheet.UpdateSpecialStats()
end

function CharacterSheet.SetStatLock(stat)
	local button = "CharacterSheet"..stat.."LockButton"

	-- If the stat isn't Str, Dex or Int, hide the stat lock
	if not CharacterSheet.Attributes[stat] then
		ButtonSetTexture(button, "Normal", "", 0, 0)
		ButtonSetTexture(button, "NormalHighlit", "", 0 , 0)
		WindowSetDimensions( button, 0, 0 )
		return
	end

	local val = WindowData.PlayerStatus.StatLock[CharacterSheet.Attributes[stat]]
	--Debug.Print("Update StatLock["..WStringToString(CharacterSheet.Attributes[stat]).."]="..tostring(val))
	if val == 0 then      -- Up Arrow
	    WindowSetDimensions(button, 22, 15)
		ButtonSetTexture(button, "Normal", "Legacy_Buttons", 455, 310)
		ButtonSetTexture(button, "NormalHighlit", "Legacy_Buttons", 455 , 310)
	elseif val == 1 then  -- Down Arrow
	    WindowSetDimensions(button, 22, 16)
		ButtonSetTexture(button, "Normal", "Legacy_Buttons", 455, 326)
		ButtonSetTexture(button, "NormalHighlit", "Legacy_Buttons", 455 , 326)
	elseif val == 2 then  -- Lock Button
	    WindowSetDimensions(button, 22, 15)
		ButtonSetTexture(button, "Normal", "Legacy_Buttons", 455, 345)
		ButtonSetTexture(button, "NormalHighlit", "Legacy_Buttons", 455, 345) 
	end
end

function CharacterSheet.ClickStatLock()
	--Debug.Dump('StatLock', WindowData.PlayerStatus.StatLock) 
	local this = SystemData.ActiveWindow.name
	local id = WindowGetId(this) - 1
	--Debug.Print("Button id is "..id)

	-- only pay attention to buttons 4-6 which are the stat lock buttons
	if (id >= 4) and (id <= 6) then
		-- CJT: originally the stat locks were buttons 1-3
		id = id - 4
		local lock = WindowData.PlayerStatus.StatLock[id]

		lock = lock + 1
		if lock > 2 then 
			lock = 0
		end

		--Debug.Print("setting statlock "..id.." to "..lock)
		WindowData.PlayerStatus.StatLock[id] = lock
		--Debug.Dump('StatLock', WindowData.PlayerStatus.StatLock) 
		UpdateStatLock(id)
		
		CharacterSheet.UpdateStatus()
	end
end

function CharacterSheet.StatLButtonDown()
	local parent = WindowGetParent(SystemData.ActiveWindow.name)
	local id = WindowGetId(parent)
	local iconId = WindowData.PlayerStatsDataCSV[id].iconId
	
	local cursorData = 
	{
		Type = Cursor.TYPE_ACTION,
		ActionType = SystemData.UserAction.TYPE_PLAYER_STATS,
		ItemId = id,
		IconId = iconId
	}
	Cursor.Pickup( cursorData )
end

function CharacterSheet.ItemLButtonDown()
	local id = WindowGetId(SystemData.ActiveWindow.name)
	local iconId = EquipmentData.CurrentWeaponAbilities[id] + 1000
	
	--Debug.Print("CharacterSheet.ItemLButtonDown:iconId - "..iconId)
	
	local cursorData = 
	{
		Type = Cursor.TYPE_ACTION,
		ActionType = SystemData.UserAction.TYPE_WEAPON_ABILITY,
		ItemId = id,
		IconId = iconId
	}
	Cursor.Pickup( cursorData )
end

function CharacterSheet.ItemMouseOver()
	local id = WindowGetId(SystemData.ActiveWindow.name)
	
	local itemData = { windowName = "CharacterSheet",
						itemId = id,
						itemType = ItemProperties.type.TYPE_ACTION,
						actionType = SystemData.UserAction.TYPE_WEAPON_ABILITY,
						detail = ItemProperties.DETAIL_LONG }
	ItemProperties.SetActiveItem(itemData)		
end


function CharacterSheet.UpdateSpecialStats() -- This deals with the "Increase..." things
	local str = L""
	str = CharacterSheet.StrDexIntBonus( "IncreaseStr" )
	LabelSetText( "CharacterSheetStrengthExtra", str )
	str = CharacterSheet.StrDexIntBonus( "IncreaseDex" )
	LabelSetText( "CharacterSheetDexterityExtra", str )
	str = CharacterSheet.StrDexIntBonus( "IncreaseInt" )
	LabelSetText( "CharacterSheetIntelligenceExtra", str )
	str = CharacterSheet.HealthStaminaManaBonus( "IncreaseHitPoints" )
	LabelSetText( "CharacterSheetHealthExtra", str )
	str = CharacterSheet.HealthStaminaManaBonus( "IncreaseStam" )
	LabelSetText( "CharacterSheetStaminaExtra", str )
	str = CharacterSheet.HealthStaminaManaBonus( "IncreaseMana" )
	LabelSetText( "CharacterSheetManaExtra", str )
end

function CharacterSheet.HealthStaminaManaBonus( which )
	local heal = L""
	local val, max
	if WindowData and WindowData.PlayerStatus and WindowData.PlayerStatus[which] and WindowData.PlayerStatus[which.."Max"] then
		val = WindowData.PlayerStatus[which]
		max = WindowData.PlayerStatus[which.."Max"]
		if max > 0 then
			heal = L"/+"..StringToWString(tostring(max))..L")"
		elseif max < 0 then
			heal = L"/"..StringToWString(tostring(max))..L")"
		end
		if heal == L"" then
			if val > 0 then
				heal = L"(+"..StringToWString(tostring(val))..L")"
			elseif val < 0 then
				heal = L"("..StringToWString(tostring(val))..L")"
			end
		else
			if val > 0 then
				heal = L"(+"..StringToWString(tostring(val))..heal				
			elseif val < 0 then
				heal = L"("..StringToWString(tostring(val))..heal
			else
				heal = L"(+0"..heal
			end
		end
	end
	return heal
end

function CharacterSheet.StrDexIntBonus( which )
	local str = L""
	local val 
	if WindowData and WindowData.PlayerStatus and WindowData.PlayerStatus[which] then
		val = WindowData.PlayerStatus[which]
		if val > 0 then
			str = L"(+"..StringToWString(tostring(val))..L")" 
		elseif val < 0 then
			str = L"("..StringToWString(tostring(val))..L")"
		end
	end
	return str
end

-- Remaining functions deal with groups
-- "Action" names are remnants from code copied from ActionsWindow
function CharacterSheet.HideAllButFirstGroups()
	local groupItr, group, itemItr, actionIndex
	for groupItr, group in pairs(CharacterSheet.Groups) do
		if groupItr ~= 1 then
			for itemItr, actionIndex in pairs(group.index) do
				WindowSetShowing( "CharacterSheet"..WStringToString(WindowData.PlayerStatsDataCSV[actionIndex].name), false )
			end	
		end
	end
end
function CharacterSheet.ShowActiveAndFirstGroups()
	local itemItr, actionIndex
	for itemItr, actionIndex in pairs(CharacterSheet.Groups[CharacterSheet.CurrentGroup].index) do
		WindowSetShowing( "CharacterSheet"..WStringToString(WindowData.PlayerStatsDataCSV[actionIndex].name), true )
	end
end
function CharacterSheet.LeftArrowPressed()
	CharacterSheet.CurrentGroup = CharacterSheet.CurrentGroup - 1
	CharacterSheet.ValidateGroup()
	CharacterSheet.SetGroupLabel()
	CharacterSheet.HideAllButFirstGroups()
	CharacterSheet.ShowActiveAndFirstGroups()
end
function CharacterSheet.RightArrowPressed()
	CharacterSheet.CurrentGroup = CharacterSheet.CurrentGroup + 1
	CharacterSheet.ValidateGroup()
	CharacterSheet.SetGroupLabel()
	CharacterSheet.HideAllButFirstGroups()
	CharacterSheet.ShowActiveAndFirstGroups()
end
function CharacterSheet.SetGroupLabel()
	if CharacterSheet.Groups[CharacterSheet.CurrentGroup].nameTid
	and CharacterSheet.Groups[CharacterSheet.CurrentGroup].nameTid ~= 0
	then
		LabelSetText( "CharacterSheetTopArrowsText", GetStringFromTid( CharacterSheet.Groups[CharacterSheet.CurrentGroup].nameTid ) )
	else
		if CharacterSheet.Groups[CharacterSheet.CurrentGroup].nameString
		then
			LabelSetText( "CharacterSheetTopArrowsText", CharacterSheet.Groups[CharacterSheet.CurrentGroup].nameString )
		else
			LabelSetText( "CharacterSheetTopArrowsText", L""..CharacterSheet.CurrentGroup )
		end
	end
end
function CharacterSheet.ValidateGroup()
	if ( not CharacterSheet.CurrentGroup ) or ( CharacterSheet.CurrentGroup > #CharacterSheet.Groups ) then
		CharacterSheet.CurrentGroup = 2
	end
	if ( CharacterSheet.CurrentGroup < 2 ) then
		CharacterSheet.CurrentGroup = #CharacterSheet.Groups
	end
end
