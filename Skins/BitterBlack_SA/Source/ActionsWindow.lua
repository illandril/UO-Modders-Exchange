
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ActionsWindow = {}

ActionsWindow.ActionData = {}
ActionsWindow.ActionData[1]  = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=625, nameTid=1078184, detailTid=0, editWindow="Equip", paramInfoTid=1078184}
ActionsWindow.ActionData[2]  = { type=SystemData.UserAction.TYPE_UNEQUIP_ITEMS,					inActionWindow=true, iconId=637, nameTid=1078185, detailTid=0, editWindow="UnEquip", paramInfoTid=1078185}
ActionsWindow.ActionData[3]  = { type=SystemData.UserAction.TYPE_TOGGLE_WAR_MODE,				inActionWindow=true, iconId=635, nameTid=3002081, detailTid=0 }
ActionsWindow.ActionData[4]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=632, nameTid=3002076, detailTid=0, editWindow="Text", paramInfoTid=3002006 }
ActionsWindow.ActionData[5]  = { type=SystemData.UserAction.TYPE_SPEECH_EMOTE,					inActionWindow=true, iconId=624, nameTid=3002077, detailTid=0, editWindow="Text", paramInfoTid=3002007 }
ActionsWindow.ActionData[6]  = { type=SystemData.UserAction.TYPE_SPEECH_WHISPER,				inActionWindow=true, iconId=638, nameTid=3002078, detailTid=0, editWindow="Text", paramInfoTid=3002009 }
ActionsWindow.ActionData[7]  = { type=SystemData.UserAction.TYPE_SPEECH_YELL,					inActionWindow=true, iconId=639, nameTid=3002079, detailTid=0, editWindow="Text", paramInfoTid=3002010 }
ActionsWindow.ActionData[8]  = { type=SystemData.UserAction.TYPE_LAST_SKILL,					inActionWindow=true, iconId=617, nameTid=3002089, detailTid=0 }
ActionsWindow.ActionData[9]  = { type=SystemData.UserAction.TYPE_LAST_SPELL,					inActionWindow=true, iconId=640, nameTid=3002091, detailTid=0 }
ActionsWindow.ActionData[10] = { type=SystemData.UserAction.TYPE_LAST_OBJECT,					inActionWindow=true, iconId=629, nameTid=3002092, detailTid=0 }
ActionsWindow.ActionData[11] = { type=SystemData.UserAction.TYPE_USE_TARGETED_OBJECT,			inActionWindow=true, iconId=646, nameTid=1079159, detailTid=0 }
ActionsWindow.ActionData[12] = { type=SystemData.UserAction.TYPE_BOW,							inActionWindow=true, iconId=622, nameTid=3002093, detailTid=0 }
ActionsWindow.ActionData[13] = { type=SystemData.UserAction.TYPE_SALUTE,						inActionWindow=true, iconId=631, nameTid=3002094, detailTid=0 }
ActionsWindow.ActionData[14] = { type=SystemData.UserAction.TYPE_OPEN_DOOR,						inActionWindow=true, iconId=641, nameTid=3002087, detailTid=0 }
ActionsWindow.ActionData[15] = { type=SystemData.UserAction.TYPE_ALL_NAMES,						inActionWindow=true, iconId=619, nameTid=3002096, detailTid=0 }
ActionsWindow.ActionData[16] = { type=SystemData.UserAction.TYPE_DELAY,							inActionWindow=true, iconId=623, nameTid=3002103, detailTid=0, editWindow="Slider", paramInfoTid=3002103, sliderMin=0.0, sliderMax=10.0 }
ActionsWindow.ActionData[17] = { type=SystemData.UserAction.TYPE_WAIT_FOR_TARGET,				inActionWindow=true, iconId=618, nameTid=3002100, detailTid=0 }
ActionsWindow.ActionData[18] = { type=SystemData.UserAction.TYPE_MACRO,							inActionWindow=false,			 nameTid=3000394, editWindow="Macro" }
ActionsWindow.ActionData[19] = { type=SystemData.UserAction.TYPE_CURSOR_TARGET_LAST,			inActionWindow=true, iconId=644, nameTid=1079156, detailTid=0 }
ActionsWindow.ActionData[20] = { type=SystemData.UserAction.TYPE_CURSOR_TARGET_CURRENT,			inActionWindow=true, iconId=643, nameTid=1079157, detailTid=0 }
ActionsWindow.ActionData[21] = { type=SystemData.UserAction.TYPE_CURSOR_TARGET_SELF,			inActionWindow=true, iconId=645, nameTid=1079158, detailTid=0 }
ActionsWindow.ActionData[22] = { type=SystemData.UserAction.TYPE_TARGET_NEXT_FRIENDLY,			inActionWindow=true, iconId=647, nameTid=1079177, detailTid=0 }
ActionsWindow.ActionData[23] = { type=SystemData.UserAction.TYPE_TARGET_NEXT_ENEMY,				inActionWindow=true, iconId=648, nameTid=1079178, detailTid=0 }
ActionsWindow.ActionData[24] = { type=SystemData.UserAction.TYPE_TARGET_NEXT_GROUPMEMBER,		inActionWindow=true, iconId=649, nameTid=1079179, detailTid=0 }
ActionsWindow.ActionData[25] = { type=SystemData.UserAction.TYPE_TARGET_NEXT,					inActionWindow=true, iconId=708, nameTid=1094824, detailTid=0 }
ActionsWindow.ActionData[26] = { type=SystemData.UserAction.TYPE_ARM_DISARM,					inActionWindow=true, iconId=677, nameTid=3002099, detailTid=0, editWindow="ArmDisarm", paramInfoTid=1079292 }
ActionsWindow.ActionData[27] = { type=SystemData.UserAction.TYPE_WAR_MODE,						inActionWindow=true, iconId=675, nameTid=3000086, detailTid=0 }
ActionsWindow.ActionData[28] = { type=SystemData.UserAction.TYPE_PEACE_MODE, 					inActionWindow=true, iconId=676, nameTid=3000085, detailTid=0 }
ActionsWindow.ActionData[29] = { type=SystemData.UserAction.TYPE_PET_COMMAND_ALLKILL,			inActionWindow=true, iconId=650, nameTid=1079300, detailTid=0 }
ActionsWindow.ActionData[30] = { type=SystemData.UserAction.TYPE_PET_COMMAND_COME,				inActionWindow=true, iconId=651, nameTid=1079301, detailTid=0 }
ActionsWindow.ActionData[31] = { type=SystemData.UserAction.TYPE_PET_COMMAND_FOLLOW,			inActionWindow=true, iconId=655, nameTid=1079302, detailTid=0 }
ActionsWindow.ActionData[32] = { type=SystemData.UserAction.TYPE_PET_COMMAND_FOLLOWME,			inActionWindow=true, iconId=656, nameTid=1079303, detailTid=0 }
ActionsWindow.ActionData[33] = { type=SystemData.UserAction.TYPE_PET_COMMAND_GUARD,				inActionWindow=true, iconId=657, nameTid=1079304, detailTid=0 }
ActionsWindow.ActionData[34] = { type=SystemData.UserAction.TYPE_PET_COMMAND_GUARDME,			inActionWindow=true, iconId=658, nameTid=1079305, detailTid=0 }
ActionsWindow.ActionData[35] = { type=SystemData.UserAction.TYPE_PET_COMMAND_STAY,				inActionWindow=true, iconId=660, nameTid=1079306, detailTid=0 }
ActionsWindow.ActionData[36] = { type=SystemData.UserAction.TYPE_PET_COMMAND_STOP,				inActionWindow=true, iconId=661, nameTid=1079307, detailTid=0 }
ActionsWindow.ActionData[37] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_FORWARD_LEFT,		inActionWindow=true, iconId=668, nameTid=1079313, detailTid=0 }
ActionsWindow.ActionData[38] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_FORWARD_RIGHT,	inActionWindow=true, iconId=669, nameTid=1079314, detailTid=0 }
ActionsWindow.ActionData[39] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_FORWARD,			inActionWindow=true, iconId=667, nameTid=1079325, detailTid=0 }
ActionsWindow.ActionData[40] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_BACKWARD_LEFT,	inActionWindow=true, iconId=653, nameTid=1079315, detailTid=0 }
ActionsWindow.ActionData[41] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_BACKWARD_RIGHT,	inActionWindow=true, iconId=654, nameTid=1079316, detailTid=0 }
ActionsWindow.ActionData[42] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_BACKWARDS,		inActionWindow=true, iconId=652, nameTid=1079317, detailTid=0 }
ActionsWindow.ActionData[43] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_LEFT,				inActionWindow=true, iconId=664, nameTid=1079318, detailTid=0 }
ActionsWindow.ActionData[44] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_RIGHT,			inActionWindow=true, iconId=665, nameTid=1079319, detailTid=0 }
ActionsWindow.ActionData[45] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_TURN_LEFT,		inActionWindow=true, iconId=670, nameTid=1079320, detailTid=0 }
ActionsWindow.ActionData[46] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_TURN_RIGHT,		inActionWindow=true, iconId=672, nameTid=1079321, detailTid=0 }
ActionsWindow.ActionData[47] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_TURN_AROUND,		inActionWindow=true, iconId=662, nameTid=1079322, detailTid=0 }
ActionsWindow.ActionData[48] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_DORACRON,			inActionWindow=true, iconId=663, nameTid=1079323, detailTid=0 }
ActionsWindow.ActionData[49] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_SUEACRON,			inActionWindow=true, iconId=674, nameTid=1079324, detailTid=0 }
ActionsWindow.ActionData[50] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_STOP,				inActionWindow=true, iconId=673, nameTid=1052073, detailTid=0 }
ActionsWindow.ActionData[51] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_DROP_ANCHOR,		inActionWindow=true, iconId=666, nameTid=1079333, detailTid=0 }
ActionsWindow.ActionData[52] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_RAISE_ANCHOR,		inActionWindow=true, iconId=671, nameTid=1079334, detailTid=0 }
ActionsWindow.ActionData[53] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_START,			inActionWindow=true, iconId=694, nameTid=3005113, detailTid=0 }
ActionsWindow.ActionData[54] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_CONTINUE,			inActionWindow=true, iconId=695, nameTid=1052072, detailTid=0 }
ActionsWindow.ActionData[55] = { type=SystemData.UserAction.TYPE_TARGET_BY_RESOURCE,			inActionWindow=true, iconId=770, nameTid=1079430, detailTid=0, editWindow="TargetByResource", paramInfoTid=1079430 }
ActionsWindow.ActionData[56] = { type=SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow=true, iconId=771, nameTid=1094786, detailTid=0, editWindow="TargetByObjectId", paramInfoTid=1094788, hideOK=true }
ActionsWindow.ActionData[57] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=790, nameTid=3002105, detailTid=0, editWindow="Text", paramInfoTid=3002105 }
ActionsWindow.ActionData[58] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=701, nameTid=1051005, detailTid=0, invokeId=1 } -- Honor
ActionsWindow.ActionData[59] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=706, nameTid=1051001, detailTid=0, invokeId=2 } -- Sacrifice
ActionsWindow.ActionData[60] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=700, nameTid=1051004, detailTid=0, invokeId=3 } -- Valor
ActionsWindow.ActionData[61] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=702, nameTid=1051002, detailTid=0, invokeId=4 } -- Compassion
ActionsWindow.ActionData[62] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=704, nameTid=1051007, detailTid=0, invokeId=5 } -- Honesty
ActionsWindow.ActionData[63] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=707, nameTid=1051000, detailTid=0, invokeId=6 } -- Humility
ActionsWindow.ActionData[64] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=703, nameTid=1051006, detailTid=0, invokeId=7 } -- Justice
ActionsWindow.ActionData[65] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=705, nameTid=1051003, detailTid=0, invokeId=8 } -- Spirituality
ActionsWindow.ActionData[66] = { type=SystemData.UserAction.TYPE_CYCLE_CURSOR_TARGET,			inActionWindow=true, iconId=772, nameTid=1112413, detailTid=0 }
ActionsWindow.ActionData[67] = { type=SystemData.UserAction.TYPE_ATTACK_CURRENT_TARGET,			inActionWindow=true, iconId=773, nameTid=1112414, detailTid=0 }
ActionsWindow.ActionData[68] = { type=SystemData.UserAction.TYPE_ATTACK_LAST_CURSOR_TARGET,		inActionWindow=true, iconId=774, nameTid=1112415, detailTid=0 }
ActionsWindow.ActionData[69] = { type=SystemData.UserAction.TYPE_TARGET_NEXT_FOLLOWER,			inActionWindow=true, iconId=775, nameTid=1112416, detailTid=0 }
ActionsWindow.ActionData[70] = { type=SystemData.UserAction.TYPE_TARGET_NEXT_OBJECT,			inActionWindow=true, iconId=776, nameTid=1112420, detailTid=0 }
ActionsWindow.ActionData[71] = { type=SystemData.UserAction.TYPE_TARGET_PREVIOUS_FRIENDLY,		inActionWindow=true, iconId=777, nameTid=1112431, detailTid=0 }
ActionsWindow.ActionData[72] = { type=SystemData.UserAction.TYPE_TARGET_PREVIOUS_ENEMY,			inActionWindow=true, iconId=778, nameTid=1112432, detailTid=0 }
ActionsWindow.ActionData[73] = { type=SystemData.UserAction.TYPE_TARGET_PREVIOUS_GROUPMEMBER,	inActionWindow=true, iconId=779, nameTid=1112433, detailTid=0 }
ActionsWindow.ActionData[74] = { type=SystemData.UserAction.TYPE_TARGET_PREVIOUS_FOLLOWER,		inActionWindow=true, iconId=780, nameTid=1112434, detailTid=0 }
ActionsWindow.ActionData[75] = { type=SystemData.UserAction.TYPE_TARGET_PREVIOUS_OBJECT,		inActionWindow=true, iconId=781, nameTid=1112435, detailTid=0 }
ActionsWindow.ActionData[76] = { type=SystemData.UserAction.TYPE_TARGET_PREVIOUS,				inActionWindow=true, iconId=782, nameTid=1112436, detailTid=0 }
ActionsWindow.ActionData[77] = { type=SystemData.UserAction.TYPE_TARGET_NEAREST_FRIENDLY,		inActionWindow=true, iconId=783, nameTid=1112437, detailTid=0 }
ActionsWindow.ActionData[78] = { type=SystemData.UserAction.TYPE_TARGET_NEAREST_ENEMY,			inActionWindow=true, iconId=784, nameTid=1112438, detailTid=0 }
ActionsWindow.ActionData[79] = { type=SystemData.UserAction.TYPE_TARGET_NEAREST_GROUPMEMBER,	inActionWindow=true, iconId=785, nameTid=1112439, detailTid=0 }
ActionsWindow.ActionData[80] = { type=SystemData.UserAction.TYPE_TARGET_NEAREST_FOLLOWER,		inActionWindow=true, iconId=786, nameTid=1112440, detailTid=0 }
ActionsWindow.ActionData[81] = { type=SystemData.UserAction.TYPE_TARGET_NEAREST_OBJECT,			inActionWindow=true, iconId=787, nameTid=1112441, detailTid=0 }
ActionsWindow.ActionData[82] = { type=SystemData.UserAction.TYPE_TARGET_NEAREST,				inActionWindow=true, iconId=788, nameTid=1112442, detailTid=0 }
ActionsWindow.ActionData[83] = { type=SystemData.UserAction.TYPE_TOGGLE_ALWAYS_RUN,				inActionWindow=true, iconId=723, nameTid=1113150, detailTid=0 }
ActionsWindow.ActionData[84] = { type=SystemData.UserAction.TYPE_TOGGLE_CIRCLE_OF_TRANSPARENCY,	inActionWindow=true, iconId=721, nameTid=1079818, detailTid=0 }

-- This table is used to define the different catagories of actions, so they don't have to all show up in one list
-- nameString can be removed once you localize them all - it was just for testing that the strings will fit
-- nameTid will overpower nameString
-- I'm not going to bother to localize them until I get offical groups from design
ActionsWindow.Groups = {}
ActionsWindow.Groups[1] = { nameString=L"Items/Abilities",		nameTid=1079384, index={ 8, 9, 10, 26, 1, 2, 55 } }
ActionsWindow.Groups[2] = { nameString=L"Combat",				nameTid=1077417, index={ 3, 27, 28, 67, 68 } }
ActionsWindow.Groups[3] = { nameString=L"Virtues",				nameTid=1077439, index={ 58, 59, 60, 61, 62, 63, 64, 65 } }
ActionsWindow.Groups[4] = { nameString=L"Cursor Targeting",		nameTid=1094876, index={ 17, 19, 20, 21, 56, 66 } }
ActionsWindow.Groups[5] = { nameString=L"Targeting",			nameTid=1079383, index={ 22, 71, 77, 23, 72, 78, 24, 73, 79, 69, 74, 80, 70, 75, 81, 25, 76, 82, 11 } }
ActionsWindow.Groups[6] = { nameString=L"Pet Commands",			nameTid=1079385, index={ 29, 30, 31, 32, 34, 35, 36 } }
ActionsWindow.Groups[7] = { nameString=L"Boat Commands",		nameTid=1079386, index={ 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54 } }
ActionsWindow.Groups[8] = { nameString=L"Communication",		nameTid=1094744, index={ 4, 5, 6, 7, 12, 13 } }
ActionsWindow.Groups[9] = { nameString=L"Other",				nameTid=1044294, index={ 15, 14, 16, 83, 84, 57 } }

ActionsWindow.OFFSET_FROM_TOP = 50
ActionsWindow.OFFSET_FROM_BOTTOM = 10
ActionsWindow.SIDE_OFFSET = 10
ActionsWindow.ITEM_WIDTH = 50
ActionsWindow.ITEM_HEIGHT = 50

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function ActionsWindow.Initialize()
    Interface.OnCloseCallBack["ActionsWindow"] = ActionsWindow.OnClose

	ActionsWindow.CurrentGroup = 1
	local groupItr
	local group
	local itemItr
	local actionIndex
	local actionData
	for groupItr, group in pairs(ActionsWindow.Groups) do
		local rowIndex = 1
		for itemItr, actionIndex in pairs(group.index) do	
			actionData = ActionsWindow.ActionData[actionIndex]		
			if( actionData.inActionWindow == true ) then
				local scrollChild = "ActionsWindowListScrollChild"
				local windowName = scrollChild.."Group"..groupItr.."Row"..rowIndex			
				CreateWindowFromTemplate(windowName, "ActionItemDef", scrollChild)
				WindowSetId(windowName.."Button", actionIndex )
				local texture, x, y = GetIconData( actionData.iconId )
				DynamicImageSetTexture( windowName.."ButtonSquareIcon", texture, x, y )
				
				if( UserActionIsActionTypeTargetModeCompat(actionData.type) ) then
					WindowSetShowing(windowName.."ButtonDisabled", false)
					LabelSetTextColor( windowName.."Name", 255, 255, 255 )
				else
					WindowSetShowing(windowName.."ButtonDisabled", true)
					LabelSetTextColor( windowName.."Name", 128, 128, 128 )
				end
				LabelSetText( windowName.."Name", GetStringFromTid(actionData.nameTid) )
				if( rowIndex == 1 ) then
					WindowAddAnchor(windowName,"topleft",scrollChild,"topleft",0,0)
				else
					local relativeTo = scrollChild.."Group"..groupItr.."Row"..(rowIndex-1)
					WindowAddAnchor(windowName,"bottomleft",relativeTo,"topleft",0,0)
				end
				rowIndex = rowIndex + 1
			end
		end	
	end
	ActionsWindow.RefreshList(0)	
	WindowUtils.SetWindowTitle("ActionsWindow",GetStringFromTid(1079812))
	WindowUtils.RestoreWindowPosition("ActionsWindow")	
end

function ActionsWindow.Shutdown()
	WindowUtils.SaveWindowPosition("ActionsWindow")
end

function ActionsWindow.OnClose()
    ButtonSetPressedFlag("MenuBarWindowToggleActions",false)
end

function ActionsWindow.RefreshList(modifier)
	ActionsWindow.UpdateCurrentGroup(modifier)
	ActionsWindow.SetGroupLabel()
	ActionsWindow.HideAllGroups()
	ActionsWindow.ShowActiveGroup()
	ScrollWindowSetOffset( "ActionsWindowList", 0 )
	ScrollWindowUpdateScrollRect("ActionsWindowList")
end

function ActionsWindow.SetGroupLabel()
	if ActionsWindow.Groups[ActionsWindow.CurrentGroup].nameTid
	and ActionsWindow.Groups[ActionsWindow.CurrentGroup].nameTid ~= 0
	then
		LabelSetText( "ActionsWindowTopArrowsText", GetStringFromTid( ActionsWindow.Groups[ActionsWindow.CurrentGroup].nameTid ) )
	else
		if ActionsWindow.Groups[ActionsWindow.CurrentGroup].nameString
		then
			LabelSetText( "ActionsWindowTopArrowsText", ActionsWindow.Groups[ActionsWindow.CurrentGroup].nameString )
		else
			LabelSetText( "ActionsWindowTopArrowsText", L""..ActionsWindow.CurrentGroup )
		end
	end
end

function ActionsWindow.ItemLButtonDown()
	local index = WindowGetId(SystemData.ActiveWindow.name)	
	local actionData = ActionsWindow.ActionData[index]
	local actionId = 0

	if (actionData.type == SystemData.UserAction.TYPE_INVOKE_VIRTUE) then
		actionId = actionData.invokeId
	end

	DragSlotSetActionMouseClickData(actionData.type, actionId, actionData.iconId)
end

function ActionsWindow.ItemMouseOver()
	local index = WindowGetId(SystemData.ActiveWindow.name)
	local actionData = ActionsWindow.ActionData[index]
	
	if(actionData.type == SystemData.UserAction.TYPE_INVOKE_VIRTUE) then
		index = actionData.invokeId
	end
	
	local itemData =
	{
		windowName = "ActionsWindow",
		itemId = index,
		actionType = actionData.type,
		itemType = WindowData.ItemProperties.TYPE_ACTION,
		title =	GetStringFromTid(actionData.nameTid),
		body = L""
	}					
	ItemProperties.SetActiveItem(itemData)	
end

function ActionsWindow.GetActionDataForType(actionType)
	for index, actionData in pairs(ActionsWindow.ActionData) do
		if( actionData.type == actionType ) then
			return actionData
		end
	end
end

function ActionsWindow.LeftArrowPressed()
	ActionsWindow.RefreshList(-1)
end

function ActionsWindow.RightArrowPressed()
	ActionsWindow.RefreshList(1)
end

function ActionsWindow.UpdateCurrentGroup(modifier)
	ActionsWindow.CurrentGroup = ActionsWindow.CurrentGroup + modifier
	
	if ( not ActionsWindow.CurrentGroup ) or ( ActionsWindow.CurrentGroup > #ActionsWindow.Groups ) then
		ActionsWindow.CurrentGroup = 1
	end
	
	if ( ActionsWindow.CurrentGroup < 1 ) then
		ActionsWindow.CurrentGroup = #ActionsWindow.Groups
	end
end

function ActionsWindow.HideAllGroups()
	local groupItr
	local group
	local itemItr
	local actionIndex
	local actionData
	for groupItr, group in pairs(ActionsWindow.Groups) do
		local rowIndex = 1
		for itemItr, actionIndex in pairs(group.index) do	
			actionData = ActionsWindow.ActionData[actionIndex]		
			if( actionData.inActionWindow == true ) then
				local windowName = "ActionsWindowListScrollChildGroup"..groupItr.."Row"..rowIndex			
				WindowSetShowing( windowName, false )
				WindowClearAnchors( windowName )
				rowIndex = rowIndex + 1
			end
		end	
	end
end

function ActionsWindow.ShowActiveGroup()
	local itemItr
	local actionIndex
	local actionData
	local rowIndex = 1
	for itemItr, actionIndex in pairs(ActionsWindow.Groups[ActionsWindow.CurrentGroup].index) do	
		actionData = ActionsWindow.ActionData[actionIndex]		
		if( actionData.inActionWindow == true ) then
			local windowName = "ActionsWindowListScrollChildGroup"..ActionsWindow.CurrentGroup.."Row"..rowIndex			
			WindowSetShowing( windowName, true )
			WindowClearAnchors( windowName )
			if itemItr == 1 then
				WindowAddAnchor( windowName, "topleft", "ActionsWindowListScrollChild", "topleft", 0, 0 ) 
			else
				WindowAddAnchor( windowName, "bottomleft", "ActionsWindowListScrollChildGroup"..ActionsWindow.CurrentGroup.."Row"..(rowIndex-1), "topleft", 0, 0 )
			end
			rowIndex = rowIndex + 1
		end
	end
end
