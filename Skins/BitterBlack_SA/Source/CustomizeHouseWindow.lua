
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------


----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------


-- *** TODO - OPTIMIZATION - could pool the CustomizeHouseIcon objects and just reset their icons instead of destroying them


CustomizeHouseWindow = 
{
	-- CustomizeHouseWindow.windowName = "CustomizeHouseWindow",   -- CustomizeHouseWindow.windowName is set by Initialize()
	
	currentWindowNum = 0,  -- used for dynamic window names for icons

	currentStory = 1,

	-- just listing names to be used later
	doors = nil,
	floors = nil,
	misc = nil,
	roofs = nil,
	stairs = nil,
	walls = nil,
	teleporters = nil,
	
	-- list of tiles that are multis, key is the tileID, value is a tile art ID to be displayed instead
	multiID = {},
	entitlements = {},

	-- not sure why default is 2 but previous client defaulted to roof height = 2
	roofZOffset = 2,
}

CustomizeHouseWindow.MIN_NUM_OF_STORIES		= 3 -- or should this be 2?
CustomizeHouseWindow.MAX_NUM_OF_STORIES		= 4

CustomizeHouseWindow.MIN_ROOF_Z_OFFSET = 1
CustomizeHouseWindow.MAX_ROOF_Z_OFFSET = 6


-- HousingMode
CustomizeHouseWindow.TILE_PLACEMENT_MODE		= 1
CustomizeHouseWindow.ERASE_MODE					= 2
CustomizeHouseWindow.EYE_DROPPER_MODE			= 3

-- HousingTileType
-- *** IMPORTANT *** these have to match the enums in HousingTypeDefs.h
CustomizeHouseWindow.TILE_TYPE_NONE			= 0
CustomizeHouseWindow.TILE_TYPE_STAIRS		= 1
CustomizeHouseWindow.TILE_TYPE_ROOF			= 2
CustomizeHouseWindow.TILE_TYPE_DOOR			= 3
CustomizeHouseWindow.TILE_TYPE_FLOOR		= 4
CustomizeHouseWindow.TILE_TYPE_WALL			= 5
CustomizeHouseWindow.TILE_TYPE_TELEPORTERS	= 6
CustomizeHouseWindow.TILE_TYPE_MISC			= 7
--CustomizeHouseWindow.TILE_TYPE_MAGIC_FLOOR	= 9
--CustomizeHouseWindow.TILE_TYPE_MULTI		= 8
CustomizeHouseWindow.NUM_OF_TILE_TYPE		= 7


-- System Messages
CustomizeHouseWindow.SYS_MSG_BACKUP		= 0
CustomizeHouseWindow.SYS_MSG_RESTORE	= 1
CustomizeHouseWindow.SYS_MSG_SYNC		= 2
CustomizeHouseWindow.SYS_MSG_CLEAR		= 3
CustomizeHouseWindow.SYS_MSG_COMMIT		= 4
CustomizeHouseWindow.SYS_MSG_REVERT		= 5

-- System Butons text:
CustomizeHouseWindow.BUTTON_TID_BACKUP		= 1079174 --	BACKUP  (1062143 doesn't display corretly) 
CustomizeHouseWindow.BUTTON_TID_COMMIT		= 1062147 --	COMMIT
CustomizeHouseWindow.BUTTON_TID_RESTORE		= 1062145 --	RESTORE
CustomizeHouseWindow.BUTTON_TID_SYNCH		= 1062139 --	SYNCH
CustomizeHouseWindow.BUTTON_TID_CLEAR		= 1062141 --	CLEAR
CustomizeHouseWindow.BUTTON_TID_REVERT		= 1062149 --	REVERT

CustomizeHouseWindow.DOOR_SWING_DIRECTION_ICONS =
{
	"Housing_Right_Up_Arrow",
	"Housing_Up_Right_Arrow",
	"Housing_Down_Left_Arrow",
	"Housing_Left_Down_Arrow",
	"Housing_Right_Down_Arrow",
	"Housing_Down_Right_Arrow",
	"Housing_Up_Left_Arrow",
	"Housing_Left_Up_Arrow",
}

--Tooltips:
CustomizeHouseWindow.TOOLTIP_TID_WALLS			= 1061016
CustomizeHouseWindow.TOOLTIP_TID_DOORS			= 1061017
CustomizeHouseWindow.TOOLTIP_TID_FLOORS			= 1061018
CustomizeHouseWindow.TOOLTIP_TID_STAIRS			= 1061019
CustomizeHouseWindow.TOOLTIP_TID_TELEPORTERS	= 1061020
CustomizeHouseWindow.TOOLTIP_TID_ROOFS			= 1063364
CustomizeHouseWindow.TOOLTIP_TID_MISC			= 1061021
CustomizeHouseWindow.TOOLTIP_TID_ERASE			= 1061022
CustomizeHouseWindow.TOOLTIP_TID_EYEDROP		= 1061023
CustomizeHouseWindow.TOOLTIP_TID_SYSTEM			= 1061024
CustomizeHouseWindow.TOOLTIP_TID_CATEGORY		= 1061025
CustomizeHouseWindow.TOOLTIP_TID_WINDOWS		= 1061026
--CustomizeHouseWindow.TOOLTIP_TID_PAGE_RIGHT			= 1061027
--CustomizeHouseWindow.TOOLTIP_TID_PAGE_LEFT			= 1061028
CustomizeHouseWindow.TOOLTIP_TID_VISIBILITY			= 1079204
CustomizeHouseWindow.TOOLTIP_TID_STORY_VIS1		= 1061029
CustomizeHouseWindow.TOOLTIP_TID_STORY_VIS2		= 1061030
CustomizeHouseWindow.TOOLTIP_TID_STORY_VIS3		= 1061031
CustomizeHouseWindow.TOOLTIP_TID_STORY_VIS4		= 1061032
CustomizeHouseWindow.TOOLTIP_TID_STORY1			= 1061033
CustomizeHouseWindow.TOOLTIP_TID_STORY2			= 1061034
CustomizeHouseWindow.TOOLTIP_TID_STORY3			= 1061035
CustomizeHouseWindow.TOOLTIP_TID_STORY4			= 1061036
--CustomizeHouseWindow.TOOLTIP_TID_STORY_UP		NO_TOOLTIPID
--CustomizeHouseWindow.TOOLTIP_TID_STORY_DOWN		NO_TOOLTIPID
CustomizeHouseWindow.TOOLTIP_TID_HELP			= 1061037
CustomizeHouseWindow.TOOLTIP_TID_PRICE			= 1061038
--CustomizeHouseWindow.TOOLTIP_TID_COMPONENTS	= 1061039 -- old components/fixtures tooltip
CustomizeHouseWindow.TOOLTIP_TID_COMPONENTS		= 1011155
CustomizeHouseWindow.TOOLTIP_TID_FIXTURES		= 1079274
CustomizeHouseWindow.TOOLTIP_TID_ROOF_LEVEL		= 1070759
CustomizeHouseWindow.TOOLTIP_TID_BACKUP			= 1061041
CustomizeHouseWindow.TOOLTIP_TID_COMMIT			= 1061042
CustomizeHouseWindow.TOOLTIP_TID_RESTORE		= 1061043
CustomizeHouseWindow.TOOLTIP_TID_SYNCH			= 1061044
CustomizeHouseWindow.TOOLTIP_TID_CLEAR			= 1061045
--CustomizeHouseWindow.TOOLTIP_TID_CLOSE				= 1061046
CustomizeHouseWindow.TOOLTIP_TID_REVERT			= 1061047
--CustomizeHouseWindow.TOOLTIP_TID_CUR_FLOOR		NO_TOOLTIPID
CustomizeHouseWindow.TOOLTIP_TID_ROOF			= 1061018
CustomizeHouseWindow.TOOLTIP_TID_RAISE_ROOF_LEVEL = 1063392
CustomizeHouseWindow.TOOLTIP_TID_LOWER_ROOF_LEVEL = 1063393

CustomizeHouseWindow.NOT_ENTITLED = {R=255, G=64, B=64,}


-- CustomizeHouseVisibility
--
-- Stores visibility gump data
--
-- Data is contained in CustomizeHouseVisibility.story
-- which basically acts like a 2 dimensional array, where each story has a set of tile types that can be visible 
-- (visiblity tile types is a subset of CustomizeHouseWindow tile types, so note that it is not guaranteed to be consecutive indexes)
--
-- each visiblity option is represented in XML by a set of radio buttons, named below as OPTIONS
--
CustomizeHouseVisibility = {}


-- visibility choices
--
-- Need to keep updated with HousingSystem.h  ViewMode enum
-- Note: Lua is off by 1 from C++ enum
--
CustomizeHouseVisibility.SHOWING			= 1
CustomizeHouseVisibility.TRANSLUCENT		= 2
CustomizeHouseVisibility.HIDDEN				= 3
--CustomizeHouseVisibility.INVALIDONLY		= 4
--CustomizeHouseVisibility.NUM_OF_VISIBILITY_OPTIONS = 4
CustomizeHouseVisibility.NUM_OF_VISIBILITY_OPTIONS = 3


CustomizeHouseVisibility.TILE_TYPE_NAMES = 
{
	[CustomizeHouseWindow.TILE_TYPE_WALL]		= "Walls", 
	[CustomizeHouseWindow.TILE_TYPE_FLOOR]		= "Floors", 
	[CustomizeHouseWindow.TILE_TYPE_ROOF]		= "Roofs", 
}

CustomizeHouseVisibility.TILE_TYPE_TIDS = 
{
	[CustomizeHouseWindow.TILE_TYPE_WALL]		= CustomizeHouseWindow.TOOLTIP_TID_WALLS, 
	[CustomizeHouseWindow.TILE_TYPE_FLOOR]		= CustomizeHouseWindow.TOOLTIP_TID_FLOORS, 
	[CustomizeHouseWindow.TILE_TYPE_ROOF]		= CustomizeHouseWindow.TOOLTIP_TID_ROOFS, 
}


CustomizeHouseVisibility.OPTION_NAMES = 
{
	[CustomizeHouseVisibility.SHOWING]			= "Show",
	[CustomizeHouseVisibility.TRANSLUCENT]		= "Transparent",
	[CustomizeHouseVisibility.HIDDEN]			= "Hide",
	--[CustomizeHouseVisibility.INVALIDONLY]		= "InvalidOnly" ,
}

CustomizeHouseVisibility.OPTION_TIDS = 
{
	[CustomizeHouseVisibility.SHOWING]			= 1078518, -- "Show"
	[CustomizeHouseVisibility.TRANSLUCENT]		= 1078520, --"Transparent"
	[CustomizeHouseVisibility.HIDDEN]			= 1078519, -- "Hide"
	--[CustomizeHouseVisibility.INVALIDONLY]		= 1078521, -- "Show Invalid" 
}

CustomizeHouseVisibility.STORY_TID =
{
	1061029, -- Story 1 Visibility
	1061030, -- Story 2 Visibility
	1061031, -- Story 3 Visibility
	1061032, -- Story 4 Visibility
}
			
----------------------------------------------------------------
-- CustomizeHouseVisibility Functions
----------------------------------------------------------------



function CustomizeHouseVisibility.Initialize()
	--Debug.PrintToDebugConsole(L"CustomizeHouseVisibility.Initialize called. ")

	CustomizeHouseVisibility.windowName = SystemData.ActiveWindow.name

	WindowUtils.SetActiveDialogTitle( GetStringFromTid(3000500) ) --Toggle Visibility

	CustomizeHouseVisibility.numOfStories = 0
	
	-- see if data exist
	if CustomizeHouseVisibility.story == nil then
		--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.Initialize Creating data structure=")
		CustomizeHouseVisibility.story = {}
	else
		--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.Initialize using existing data")
	end


	local numOfStories = WindowData.CustomHouseInfo.NumberOfStories 
	if not numOfStories or numOfStories < CustomizeHouseWindow.MIN_NUM_OF_STORIES or numOfStories > CustomizeHouseWindow.MAX_NUM_OF_STORIES then
	
		--Debug.PrintToDebugConsole(L"CustomizeHouseVisibility.Initialize receiving bad data: WindowData.CustomHouseInfo.NumberOfStories ")
		numOfStories = CustomizeHouseWindow.MIN_NUM_OF_STORIES 
	end

	-- SetNumOfStories will create data  for any stories that don't already exist in CustomizeHouseVisibility.story
	CustomizeHouseVisibility.SetNumOfStories( numOfStories )
	

	-- now Create all of the UI Elements
	
	local rowName, optionName = "", ""
	local lRowName, lOptionName = L"", L""
	
	-- set all visibility option labels
	for tileType, tileTypeTID in pairs(CustomizeHouseVisibility.TILE_TYPE_TIDS)  do
		lRowName = GetStringFromTid( tileTypeTID )
		rowName = CustomizeHouseVisibility.TILE_TYPE_NAMES[tileType]
		
		LabelSetText( CustomizeHouseVisibility.windowName..rowName.."Row".."SectionName",  lRowName..L":" )
		WindowSetId( CustomizeHouseVisibility.windowName..rowName.."Row", tileType)
		
		for optionIndex, optionTID in pairs(CustomizeHouseVisibility.OPTION_TIDS) do
			lOptionName = GetStringFromTid( optionTID )
			optionName = CustomizeHouseVisibility.OPTION_NAMES[optionIndex]
	
			LabelSetText( CustomizeHouseVisibility.windowName..rowName.."Row"..optionName.."Label", lOptionName )
			WindowSetId( CustomizeHouseVisibility.windowName..rowName.."Row"..optionName.."Button", optionIndex )
		end
		
	end
	
	-- update the UI to reflect currentStory 
	-- (can't use CustomizeHouseWindow.currentStory because CustomizeHouseWindow may not have finished init yet)
	-- CustomizeHouseVisibility.SetCurrentStory( CustomizeHouseWindow.currentStory )
	CustomizeHouseVisibility.SetCurrentStory( 1 )
	
	HorizontalScrollWindowSetOffset(CustomizeHouseWindow.windowName.."Scroll", 0)
	HorizontalScrollWindowUpdateScrollRect(CustomizeHouseWindow.windowName.."Scroll")
	
	--Debug.PrintToDebugConsole(L"finished Initialize with CustomizeHouseVisibility.story: ")
end



function CustomizeHouseVisibility.SetNumOfStories( numOfStories )
	--Debug.PrintToDebugConsole(L"CustomizeHouseVisibility.SetNumOfStories called. ")
	--Debug.PrintToDebugConsole(L"    numOfStories = "..StringToWString( tostring( numOfStories ) ) )

	
	if numOfStories > CustomizeHouseVisibility.numOfStories then
		-- add visibility settings for any stories we haven't previously accounted for

		for storynum=CustomizeHouseVisibility.numOfStories+1, numOfStories do
			if CustomizeHouseVisibility.story[storynum] == nil then
				CustomizeHouseVisibility.story[storynum] = {}
			
				-- add it to the drop down box
				
				ComboBoxAddMenuItem( CustomizeHouseVisibility.windowName.."StoryChooser", GetStringFromTid(CustomizeHouseVisibility.STORY_TID[storynum]) )	
		
				-- for each story, default each tile type's visibility to SHOWING
				CustomizeHouseVisibility.story[storynum].type = {}	
				for tileType in pairs(CustomizeHouseVisibility.TILE_TYPE_NAMES) do		
	
					CustomizeHouseVisibility.story[storynum].type[tileType] = CustomizeHouseVisibility.SHOWING	
				end		
			end
		end
	
	else	-- remove visibility settings if we defaulted to MAX_NUM_OF_STORIES before we knew real number
	
		for storynum=numOfStories+1, CustomizeHouseVisibility.numOfStories  do
			if CustomizeHouseVisibility.story[storynum] then
				CustomizeHouseVisibility.story[storynum] = nil
				
				-- can't remove from drop down box, so just disable it
				-- could instead do a ComboBoxClearMenuItems and re-add all choices and set current
				--ComboBoxSetDisabledFlag( CustomizeHouseVisibility.windowName.."StoryChooser", GetStringFromTid(CustomizeHouseVisibility.STORY_TID[storynum]) )
			end
		end
	end
	
	CustomizeHouseVisibility.numOfStories = numOfStories	
end


function CustomizeHouseVisibility.SetCurrentStory( storyNum )
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.SetCurrentStory")
	--Debug.PrintToDebugConsole(L"	storyNum = "..StringToWString( tostring(storyNum) ) )
	
	--Debug.PrintToDebugConsole( L" setting current ComboBoxSetSelectedMenuItem to storyNum = "..StringToWString( tostring(storyNum) )  )	
	ComboBoxSetSelectedMenuItem( CustomizeHouseVisibility.windowName.."StoryChooser", storyNum )
	CustomizeHouseVisibility.displayedStory = storyNum
	
	-- need to change visibility buttons to be displaying that floor
	for tileType in pairs(CustomizeHouseVisibility.TILE_TYPE_NAMES) do
		
		local visibilityChoice = CustomizeHouseVisibility.story[storyNum].type[tileType]
		CustomizeHouseVisibility.SetVisibility( storyNum, tileType, visibilityChoice )
	end
end


function CustomizeHouseVisibility.SetVisibility( storyNum, tileType, visibilityChoice )
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.SetVisibility")
	--Debug.PrintToDebugConsole( L"	storyNum = "..storyNum..L"	tileType = "..tileType ..L"	visibilityChoice = "..visibilityChoice  )

	local previousChoice = CustomizeHouseVisibility.story[storyNum].type[tileType]
	
	CustomizeHouseVisibility.story[storyNum].type[tileType] = visibilityChoice	
	
	-- if value is different then notify C++
	if previousChoice == nil or (visibilityChoice ~= previousChoice)  then
		-- Send change to C++
		SetFloorVisibility( storyNum, tileType, visibilityChoice )
	end
	
			
	-- if we're changing the currently displayed story then update the window 
	if storyNum == CustomizeHouseVisibility.displayedStory then
		
		for optionIndex, optionName in pairs(CustomizeHouseVisibility.OPTION_NAMES) do
			local choiceName = CustomizeHouseVisibility.windowName..CustomizeHouseVisibility.TILE_TYPE_NAMES[tileType].."Row"..optionName.."Button"			
  			
  			ButtonSetStayDownFlag( choiceName, (optionIndex == visibilityChoice) )
			ButtonSetPressedFlag( choiceName, (optionIndex == visibilityChoice) )
		end

	end

end


function CustomizeHouseVisibility.HandleStoryChanged()
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.HandleVisibilityChange")
	
	local storyNum = ComboBoxGetSelectedMenuItem( CustomizeHouseVisibility.windowName.."StoryChooser" )
	CustomizeHouseVisibility.SetCurrentStory( storyNum )
end


function CustomizeHouseVisibility.HandleVisibilityChange()
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.HandleVisibilityChange")

	local storyNum = ComboBoxGetSelectedMenuItem( CustomizeHouseVisibility.windowName.."StoryChooser" )
	local tileType = WindowGetId( WindowGetParent( SystemData.ActiveWindow.name ) )
	local visibilityChoice = WindowGetId( SystemData.ActiveWindow.name )
	
	CustomizeHouseVisibility.SetVisibility( storyNum, tileType, visibilityChoice )
end


function CustomizeHouseVisibility.Shutdown()

	CustomizeHouseVisibility.windowName = nil
	CustomizeHouseVisibility.numOfStories = 0
	CustomizeHouseVisibility.story = nil
	
	--Debug.PrintToDebugConsole(L"finished CustomizeHouseVisibility.Shutdown")
end

----------------------------------------------------------------
-- CustomizeHouseWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler
function CustomizeHouseWindow.Initialize()
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.Initialize called")
	
	CustomizeHouseWindow.windowName = SystemData.ActiveWindow.name
	--Interface.DestroyWindowOnClose[CustomizeHouseWindow.windowName] = true
	Interface.OnCloseCallBack[CustomizeHouseWindow.windowName] = CustomizeHouseWindow.OnCloseWindow

	local scale = WindowGetScale(CustomizeHouseWindow.windowName)
	WindowSetScale(CustomizeHouseWindow.windowName, scale * 1.15)

	CustomizeHouseWindow.tileType = CustomizeHouseWindow.TILE_TYPE_NONE

	CustomizeHouseWindow.Tooltips =
	{
		[CustomizeHouseWindow.windowName.."WallsButton"]		= CustomizeHouseWindow.TOOLTIP_TID_WALLS,
		[CustomizeHouseWindow.windowName.."DoorsButton"]		= CustomizeHouseWindow.TOOLTIP_TID_DOORS,
		[CustomizeHouseWindow.windowName.."FloorsButton"]		= CustomizeHouseWindow.TOOLTIP_TID_FLOORS,
		[CustomizeHouseWindow.windowName.."StairsButton"]		= CustomizeHouseWindow.TOOLTIP_TID_STAIRS,
		[CustomizeHouseWindow.windowName.."TeleportersButton"]	= CustomizeHouseWindow.TOOLTIP_TID_TELEPORTERS,
		[CustomizeHouseWindow.windowName.."RoofsButton"]		= CustomizeHouseWindow.TOOLTIP_TID_ROOFS,
		[CustomizeHouseWindow.windowName.."MiscButton"]			= CustomizeHouseWindow.TOOLTIP_TID_MISC,
		[CustomizeHouseWindow.windowName.."EraseButton"]		= CustomizeHouseWindow.TOOLTIP_TID_ERASE,
		[CustomizeHouseWindow.windowName.."EyeDropperButton"]	= CustomizeHouseWindow.TOOLTIP_TID_EYEDROP,
		---[[
		[CustomizeHouseWindow.windowName..""]	= CustomizeHouseWindow.TOOLTIP_TID_SYSTEM,
		[CustomizeHouseWindow.windowName.."PreviousCategoryButton"]	= CustomizeHouseWindow.TOOLTIP_TID_CATEGORY,
		[CustomizeHouseWindow.windowName..""]	= CustomizeHouseWindow.TOOLTIP_TID_WINDOWS,
		--[CustomizeHouseWindow.windowName..""]	= CustomizeHouseWindow.TOOLTIP_TID_PAGE_RIGHT,
		--[CustomizeHouseWindow.windowName..""]	= CustomizeHouseWindow.TOOLTIP_TID_PAGE_LEFT,
		[CustomizeHouseWindow.windowName.."VisibilityButton"]	= CustomizeHouseWindow.TOOLTIP_TID_VISIBILITY,
		[CustomizeHouseWindow.windowName..""]	= CustomizeHouseWindow.TOOLTIP_TID_STORY_VIS1,
		[CustomizeHouseWindow.windowName..""]	= CustomizeHouseWindow.TOOLTIP_TID_STORY_VIS2,
		[CustomizeHouseWindow.windowName..""]	= CustomizeHouseWindow.TOOLTIP_TID_STORY_VIS3,
		[CustomizeHouseWindow.windowName..""]	= CustomizeHouseWindow.TOOLTIP_TID_STORY_VIS4,
		[CustomizeHouseWindow.windowName.."Story1Button"]	= CustomizeHouseWindow.TOOLTIP_TID_STORY1,
		[CustomizeHouseWindow.windowName.."Story2Button"]	= CustomizeHouseWindow.TOOLTIP_TID_STORY2,
		[CustomizeHouseWindow.windowName.."Story3Of3Button"]	= CustomizeHouseWindow.TOOLTIP_TID_STORY3,
		[CustomizeHouseWindow.windowName.."Story3Of4Button"]	= CustomizeHouseWindow.TOOLTIP_TID_STORY3,
		[CustomizeHouseWindow.windowName.."Story4Of4Button"]	= CustomizeHouseWindow.TOOLTIP_TID_STORY4,
		--[CustomizeHouseWindow.windowName..""]	= CustomizeHouseWindow.TOOLTIP_TID_STORY_UP,
		--[CustomizeHouseWindow.windowName..""]	= CustomizeHouseWindow.TOOLTIP_TID_STORY_DOWN,
		[CustomizeHouseWindow.windowName..""]	= CustomizeHouseWindow.TOOLTIP_TID_HELP,
		[CustomizeHouseWindow.windowName.."HouseCostText"]	= CustomizeHouseWindow.TOOLTIP_TID_PRICE,
		[CustomizeHouseWindow.windowName.."HouseCostIcon"]	= CustomizeHouseWindow.TOOLTIP_TID_PRICE,
		[CustomizeHouseWindow.windowName.."ComponentsUsedText"]	= CustomizeHouseWindow.TOOLTIP_TID_COMPONENTS,
		[CustomizeHouseWindow.windowName.."ComponentsUsedIcon"]	= CustomizeHouseWindow.TOOLTIP_TID_COMPONENTS,
		[CustomizeHouseWindow.windowName.."FixturesUsedText"]	= CustomizeHouseWindow.TOOLTIP_TID_FIXTURES,
		[CustomizeHouseWindow.windowName.."FixturesUsedIcon"]	= CustomizeHouseWindow.TOOLTIP_TID_FIXTURES,
		[CustomizeHouseWindow.windowName..""]	= CustomizeHouseWindow.TOOLTIP_TID_ROOF_LEVEL,
		[CustomizeHouseWindow.windowName.."BackupButton"]	= CustomizeHouseWindow.TOOLTIP_TID_BACKUP,
		[CustomizeHouseWindow.windowName.."CommitButton"]	= CustomizeHouseWindow.TOOLTIP_TID_COMMIT,
		[CustomizeHouseWindow.windowName.."RestoreButton"]	= CustomizeHouseWindow.TOOLTIP_TID_RESTORE,
		[CustomizeHouseWindow.windowName.."SynchButton"]	= CustomizeHouseWindow.TOOLTIP_TID_SYNCH,
		[CustomizeHouseWindow.windowName.."ClearButton"]	= CustomizeHouseWindow.TOOLTIP_TID_CLEAR,
		--[CustomizeHouseWindow.windowName..""]	= CustomizeHouseWindow.TOOLTIP_TID_CLOSE,
		[CustomizeHouseWindow.windowName.."RevertButton"]	= CustomizeHouseWindow.TOOLTIP_TID_REVERT,
		--[CustomizeHouseWindow.windowName..""]	= CustomizeHouseWindow.TOOLTIP_TID_CUR_FLOOR,
		[CustomizeHouseWindow.windowName.."RoofHeightText"]	= CustomizeHouseWindow.TOOLTIP_TID_ROOF,
		[CustomizeHouseWindow.windowName.."RoofUpButton"]	= CustomizeHouseWindow.TOOLTIP_TID_RAISE_ROOF_LEVEL,
		[CustomizeHouseWindow.windowName.."RoofDownButton"]	= CustomizeHouseWindow.TOOLTIP_TID_LOWER_ROOF_LEVEL,
		--]]
	}
	
	local visibilityWindowName = CustomizeHouseWindow.windowName.."VisibilityWindow"
	CreateWindowFromTemplate( visibilityWindowName, "CustomizeHouseVisibility", "Root" )
	WindowSetShowing( visibilityWindowName, false )
	
	ButtonSetText (CustomizeHouseWindow.windowName.."BackupButton", GetStringFromTid(CustomizeHouseWindow.BUTTON_TID_BACKUP) )
	ButtonSetText (CustomizeHouseWindow.windowName.."RestoreButton", GetStringFromTid(CustomizeHouseWindow.BUTTON_TID_RESTORE) )
	ButtonSetText (CustomizeHouseWindow.windowName.."SynchButton", GetStringFromTid(CustomizeHouseWindow.BUTTON_TID_SYNCH) )
	ButtonSetText (CustomizeHouseWindow.windowName.."ClearButton", GetStringFromTid(CustomizeHouseWindow.BUTTON_TID_CLEAR))
	ButtonSetText (CustomizeHouseWindow.windowName.."CommitButton", GetStringFromTid(CustomizeHouseWindow.BUTTON_TID_COMMIT))
	ButtonSetText (CustomizeHouseWindow.windowName.."RevertButton", GetStringFromTid(CustomizeHouseWindow.BUTTON_TID_REVERT))
				
	-- initialize C++ with default roof height
	HousingSetRoofZOffset( CustomizeHouseWindow.roofZOffset )
	LabelSetText( CustomizeHouseWindow.windowName.."RoofHeightText", StringToWString( tostring(CustomizeHouseWindow.roofZOffset) ) )
	CustomizeHouseWindow.displayRoofButtons( false )
	
	WindowSetShowing( CustomizeHouseWindow.windowName.."PreviousCategoryButton", false )
	
	-- initialize lables needed for stairs
	LabelSetText( CustomizeHouseWindow.windowName.."ScrollChildExteriorStepsLabel", GetStringFromTid(1062114))	 -- "Exterior Steps:"
	WindowSetShowing( CustomizeHouseWindow.windowName.."ScrollChildExteriorStepsLabel", false )
	LabelSetText( CustomizeHouseWindow.windowName.."ScrollChildInteriorStairsLabel", GetStringFromTid(1062113)) -- "Interior Staircases:"
	WindowSetShowing( CustomizeHouseWindow.windowName.."ScrollChildInteriorStairsLabel", false )
	
	WindowSetId( CustomizeHouseWindow.windowName.."Story1Button", 1)
	WindowSetId( CustomizeHouseWindow.windowName.."Story2Button", 2)
	WindowSetId( CustomizeHouseWindow.windowName.."Story3Of4Button", 3)
	WindowSetId( CustomizeHouseWindow.windowName.."Story4Of4Button", 4)
	WindowSetId( CustomizeHouseWindow.windowName.."Story3Of3Button", 3)

	CustomizeHouseWindow.currentStory = 1
	CustomizeHouseWindow.SetStoryButtonPressed( CustomizeHouseWindow.currentStory, true )
	
	CustomizeHouseWindow.readAllTileData()
	CustomizeHouseWindow.currentlyDisplaying = L" "
		
		
	RegisterWindowData(WindowData.CustomHouseInfo.Type, 0)
	RegisterWindowData(WindowData.CustomHouseEyedropper.Type, 0)
	WindowRegisterEventHandler( CustomizeHouseWindow.windowName, WindowData.CustomHouseInfo.Event, "CustomizeHouseWindow.Update")
	WindowRegisterEventHandler( CustomizeHouseWindow.windowName, WindowData.CustomHouseEyedropper.Event, "CustomizeHouseWindow.ForceTileSelection")
	
	-- this call is probaly unnecessary - it will be called from C++ when this info is ready
	-- however it is a good check in case the update event came through before we were ready to recieve it
	CustomizeHouseWindow.Update()

	--Debug.PrintToDebugConsole(L"Initialize CustomizeHouseWindow")
end

-- *** KLUDGE - TODO - This data should really come in from the C++
-- instead of hardcoding specific data in here
--
-- returns:
--	iconTemplate - XML window name to use as icon (string)
--	position - "top" or "bottom" anchor (string)
--  yOffset - pixels from edge when anchoring (int)
--
function CustomizeHouseWindow.getDoorSwingDirectionIcon( categoryID, iconIndex )

	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.getDoorSwingDirectionIcon")
	--Debug.PrintToDebugConsole(L"   categoryID="..categoryID..L", iconIndex="..iconIndex)
	local direction = 1
	local position = "top"
	local yOffset = 10
	
	if categoryID == 9251 then
	
		position = "bottom"
		yOffset = -10
	
		if iconIndex == 1 then
			direction = 3
		elseif iconIndex == 2 then
			direction = 6
		end	
		
	elseif categoryID == 10767 or categoryID == 10759 or categoryID == 10775  then
		
		-- special case for sliders
		
		if iconIndex == 1 then
			direction = 6
		elseif iconIndex == 2 then
			direction = 1
		elseif iconIndex == 3 then
			direction = 8
		elseif iconIndex == 4 then
			direction = 3
		end
			
	elseif categoryID == 12718 or categoryID == 11621 or categoryID == 11625 or categoryID == 11629 or categoryID == 12260 then

		if iconIndex == 1 then
			direction = 1
		elseif iconIndex == 2 then
			direction = 7
		elseif iconIndex == 3 then
			direction = 2
		elseif iconIndex == 4 then
			direction = 8
		end
		
	else
		if iconIndex >= 3 and iconIndex <= 6 then
			position = "bottom"
			yOffset = -10
		end

		direction = iconIndex
	end
	
	--Debug.PrintToDebugConsole(StringToWString("   returning icon="..CustomizeHouseWindow.DOOR_SWING_DIRECTION_ICONS[direction]..", position="..position..", yOffset="..yOffset) )
	
	--local position = "top"
	--local yOffset = 40
	
	return CustomizeHouseWindow.DOOR_SWING_DIRECTION_ICONS[direction], position, yOffset
end


function CustomizeHouseWindow.displayRoofButtons( shouldDisplay )
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.displayRoofButtons set to "..StringToWString( tostring( shouldDisplay ) ) )

	WindowSetShowing( CustomizeHouseWindow.windowName.."RoofUpButton", shouldDisplay )
	WindowSetShowing( CustomizeHouseWindow.windowName.."RoofHeightText", shouldDisplay )
	WindowSetShowing( CustomizeHouseWindow.windowName.."RoofDownButton", shouldDisplay )
end


--[[
function CustomizeHouseWindow.displayCurrentStory()

	local numOfStories =WindowData.CustomHouseInfo.NumberOfStories

	WindowSetShowing( CustomizeHouseWindow.windowName.."Story"..i.."Button", i == CustomizeHouseWindow.currentStory )
	WindowSetShowing( CustomizeHouseWindow.windowName.."Story"..i.."Button", i == CustomizeHouseWindow.currentStory )
	for i = 3, numOfStories do
		WindowSetShowing( CustomizeHouseWindow.windowName.."Story"..i.."Of"..numOfStories.."Button", i == CustomizeHouseWindow.currentStory )
	end
end

--]]

-- OnUpdate Handler
function CustomizeHouseWindow.Update()
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.Update")
	
	local numOfComponents = WindowData.CustomHouseInfo.NumOfComponents or 0
	local numOfFixtures = WindowData.CustomHouseInfo.NumOfFixtures or 0
	local maxComponents = WindowData.CustomHouseInfo.MaxComponents or 0
	local maxFixtures = WindowData.CustomHouseInfo.MaxFixtures or 0
	local cost = StringToWString( tostring( WindowData.CustomHouseInfo.Cost or 0 ) )
	
	--local entitlements = WindowData.CustomHouseInfo.Entitlement or 0
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.Update retrieved entitlements = "..entitlements)
	
	LabelSetText (CustomizeHouseWindow.windowName.."HouseCostText", L""..WindowUtils.AddCommasToNumber (cost) )	
	LabelSetText (CustomizeHouseWindow.windowName.."ComponentsUsedText", L""..numOfComponents..L"/"..maxComponents)
	if numOfComponents >= maxComponents then
		LabelSetTextColor (CustomizeHouseWindow.windowName.."ComponentsUsedText", 255, 0, 0)
	else
		LabelSetTextColor (CustomizeHouseWindow.windowName.."ComponentsUsedText", 242, 212, 167)
	end
	LabelSetText (CustomizeHouseWindow.windowName.."FixturesUsedText", L""..numOfFixtures..L" / "..maxFixtures)
	if numOfFixtures >= maxFixtures then
		LabelSetTextColor (CustomizeHouseWindow.windowName.."FixturesUsedText", 255, 0, 0)
	else
		LabelSetTextColor (CustomizeHouseWindow.windowName.."FixturesUsedText", 242, 212, 167)
	end
	
	local numOfStories = WindowData.CustomHouseInfo.NumberOfStories 
	if (numOfStories == nil) or (numOfStories < CustomizeHouseWindow.MIN_NUM_OF_STORIES) or (numOfStories > CustomizeHouseWindow.MAX_NUM_OF_STORIES) then
	
		--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.Update receiving bad data: WindowData.CustomHouseInfo.NumberOfStories ")
		numOfStories = CustomizeHouseWindow.MIN_NUM_OF_STORIES 
	end
	
	if numOfStories == 3 then
		WindowSetShowing( CustomizeHouseWindow.windowName.."Story3Of4Button", false )
		WindowSetShowing( CustomizeHouseWindow.windowName.."Story4Of4Button", false )
		WindowSetShowing( CustomizeHouseWindow.windowName.."Story3Of3Button", true )

	else
		WindowSetShowing( CustomizeHouseWindow.windowName.."Story3Of3Button", false )
		WindowSetShowing( CustomizeHouseWindow.windowName.."Story3Of4Button", true )
		WindowSetShowing( CustomizeHouseWindow.windowName.."Story4Of4Button", true )
	end
	
	CustomizeHouseVisibility.SetNumOfStories( numOfStories )

end

function CustomizeHouseWindow.ForceTileSelection()

	if not WindowData.CustomHouseEyedropper or not WindowData.CustomHouseEyedropper.IsValid then
		--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.ForceTileSelection IsValid = false or nil")
		return
	end
 
	local tileType = WindowData.CustomHouseEyedropper.TileType
	local categoryIndex = WindowData.CustomHouseEyedropper.TileCategory
	local categoryID = WindowData.CustomizedHousing.Type[tileType].Category[categoryIndex].previewTile
	local tileID = WindowData.CustomHouseEyedropper.TileId

	if not WindowData.CustomHouseEyedropper.TileType or not WindowData.CustomHouseEyedropper.TileCategory or not WindowData.CustomHouseEyedropper.TileId then
		--Debug.PrintToDebugConsole(L"***ERROR CustomizeHouseWindow.ForceTileSelection required WindowData.CustomHouseEyedropper data is not set")
		return
	end
	
	WindowData.CustomHouseEyedropper.TileType = nil
	WindowData.CustomHouseEyedropper.TileCategory = nil
	WindowData.CustomHouseEyedropper.TileId = nil
	
	CustomizeHouseWindow.tileType = tileType
	CustomizeHouseWindow.currentCategories = CustomizeHouseWindow.type[tileType]
			
	CustomizeHouseWindow.displayCategory( categoryID )
	
	CustomizeHouseWindow.placeTile( tileID )
	CustomizeHouseWindow.ScrollToIconInHorizontalScrollWindow( tileID )
	
end


function CustomizeHouseWindow.readAllTileData()

	CustomizeHouseWindow.type = {}
	for tileType = 1, CustomizeHouseWindow.NUM_OF_TILE_TYPE do
		CustomizeHouseWindow.type[tileType] = CustomizeHouseWindow.createTileStruct( tileType )
	end
	
end


-- used by CustomizeHouseWindow.insertIcon to avoid repeated iconIDs
CustomizeHouseWindow.lastIconID = -1  

function CustomizeHouseWindow.insertIcon( tileTable, iconID )
	if iconID ~= 0 and iconID ~= CustomizeHouseWindow.lastIconID then
		table.insert( tileTable, iconID ) 
		CustomizeHouseWindow.lastIconID = iconID
	end		
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.lastIconID added ID = "..iconID)
end




function CustomizeHouseWindow.createTileStruct( tileType )
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.createTileStruct adding tileType = "..tileType)

	if CustomizeHouseWindow.type[tileType] then
		return CustomizeHouseWindow.type[tileType]
	end
	
	local categories = {}
	categories.icons = {}
	
	local tileID, appearanceID
	
	for categoryIndex in pairs( WindowData.CustomizedHousing.Type[tileType].Category ) do
	
		local categoryTile = WindowData.CustomizedHousing.Type[tileType].Category[categoryIndex].previewTile
		local entitlement = WindowData.CustomizedHousing.Type[tileType].Category[categoryIndex].entitlement
		local tooltip = GetStringFromTid( WindowData.CustomizedHousing.Type[tileType].Category[categoryIndex].tooltip )
		local categoryID = categoryTile
		
		table.insert( categories.icons, categoryTile )
		CustomizeHouseWindow.entitlements[categoryID] = entitlement
		
		categories[categoryID] = {}	
		categories[categoryID].name = tooltip
		categories[categoryID].entitlement = entitlement
		categories[categoryID].icons = {} 	
				
		
	  if WindowData.CustomizedHousing.Type[tileType].Category[categoryIndex].Group ~= nil then

		for groupIndex in pairs( WindowData.CustomizedHousing.Type[tileType].Category[categoryIndex].Group ) do	
			
			-- add solid tiles
			for solidIndex in pairs( WindowData.CustomizedHousing.Type[tileType].Category[categoryIndex].Group[groupIndex].Solid ) do
				tileID = WindowData.CustomizedHousing.Type[tileType].Category[categoryIndex].Group[groupIndex].Solid[solidIndex].id
				CustomizeHouseWindow.insertIcon( categories[categoryID].icons, tileID )
			end
			
			-- add windowed tiles 
			if WindowData.CustomizedHousing.Type[tileType].Category[categoryIndex].Group[groupIndex].Window ~= nil then
				for windowIndex in pairs( WindowData.CustomizedHousing.Type[tileType].Category[categoryIndex].Group[groupIndex].Window ) do	
					tileID = WindowData.CustomizedHousing.Type[tileType].Category[categoryIndex].Group[groupIndex].Window[windowIndex].id
					CustomizeHouseWindow.insertIcon( categories[categoryID].icons, tileID )
				end
			end
			
			-- add multi tiles 
			if WindowData.CustomizedHousing.Type[tileType].Category[categoryIndex].Group[groupIndex].Multi ~= nil then
				for multiIndex in pairs( WindowData.CustomizedHousing.Type[tileType].Category[categoryIndex].Group[groupIndex].Multi ) do	
					tileID = WindowData.CustomizedHousing.Type[tileType].Category[categoryIndex].Group[groupIndex].Multi[multiIndex].id	
					appearanceID = WindowData.CustomizedHousing.Type[tileType].Category[categoryIndex].Group[groupIndex].Multi[multiIndex].appearance 	
					CustomizeHouseWindow.insertIcon( categories[categoryID].icons, tileID )
					
					-- set special tile art ID to be used for multis
					CustomizeHouseWindow.multiID[tileID] = appearanceID
				end
			end
			
		end
	  end	
		
	end
	
	
	return categories
end




-- called for category or tile icons
function CustomizeHouseWindow.OnIconSelected()
	
	local iconID = WindowGetId( SystemData.ActiveWindow.name )
	--Debug.PrintToDebugConsole( L"ustomizeHouseWindow.OnIconSelected ID = "..StringToWString( tostring(iconID) ) )
	
	-- Removed category checking for entitlement checks so users can now see what tiles they can buy
	-- 
	--if (CustomizeHouseWindow.entitlements[iconID] == false) or 
	--   ( CustomizeHouseWindow.currentCategoryID ~= nil and CustomizeHouseWindow.entitlements[CustomizeHouseWindow.currentCategoryID] == false ) then
	if ( CustomizeHouseWindow.currentCategoryID ~= nil and CustomizeHouseWindow.entitlements[CustomizeHouseWindow.currentCategoryID] == false ) then
				
		local okayButton = { textTid=UO_StandardDialog.TID_OKAY }
		local windowData = 
		{
			body = WindowUtils.translateMarkup( GetStringFromTid(1062930) ), -- You must upgrade ...
			buttons = { okayButton },
			windowName = "CustomizeHouseWindowEntitlementWarning",
		}
		if DoesWindowNameExist(windowData.windowName.."Dialog") then
			DestroyWindow(windowData.windowName.."Dialog")
		else
			UO_StandardDialog.CreateDialog( windowData )
		end
		

	else	
		
		CustomizeHouseWindow.turnOnFrameAroundWindow( SystemData.ActiveWindow.name )
		CustomizeHouseWindow.iconSelectedFunction( iconID )
	end
	
end


function CustomizeHouseWindow.displayCategory( categoryID )
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.displayCategory, with categoryID = "..categoryID)
	--Debug.DumpToConsole( "CustomizeHouseWindow.Category["..categoryID.."]", CustomizeHouseWindow.currentCategories[categoryID] )
	
	CustomizeHouseWindow.currentlyDisplaying = L"Tiles"
	CustomizeHouseWindow.currentCategoryID = categoryID
	CustomizeHouseWindow.iconSelectedFunction = CustomizeHouseWindow.placeTile	-- function to call when tile icon is selected

	WindowSetShowing( CustomizeHouseWindow.windowName.."PreviousCategoryButton", CustomizeHouseWindow.tileType ~= CustomizeHouseWindow.TILE_TYPE_TELEPORTERS )

	CustomizeHouseWindow.deleteIcons( CustomizeHouseWindow.currentIconWindows )
	CustomizeHouseWindow.currentIconWindows = CustomizeHouseWindow.displayIcons( CustomizeHouseWindow.currentCategories[categoryID] )

	-- TODO set the name into the tooltip
	--LabelSetText( CustomizeHouseWindow.windowName.."CategoryText", L"Category: "..CustomizeHouseWindow.currentCategories[categoryID].name )
end


function CustomizeHouseWindow.placeTile( tileID )
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.placeTile with tileID = "..tileID )

	SetHousingMode( CustomizeHouseWindow.TILE_PLACEMENT_MODE )
	
	-- check if tile is a multi to use different function
	-- Note subtypes are now read in directly by the C++, so we just use 0
	--
	if CustomizeHouseWindow.multiID[tileID] then 
		SetHousingMultiSelected( tileID )
	else
		SetHousingTileSelected( tileID, CustomizeHouseWindow.tileType, 0 )
	end
end


function CustomizeHouseWindow.HandlePreviousButton()
	local currentCategoryID = CustomizeHouseWindow.currentCategoryID
	CustomizeHouseWindow.HandleTileTypeButton( CustomizeHouseWindow.tileType )
	CustomizeHouseWindow.ScrollToIconInHorizontalScrollWindow(currentCategoryID)
end


-- The 6 Tile Type Buttons


function CustomizeHouseWindow.HandleTileTypeButton( tileType )
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.HandleTileTypeButton, tileType = "..tileType )
	
	CustomizeHouseWindow.currentlyDisplaying = L"Categories"
	CustomizeHouseWindow.iconSelectedFunction = CustomizeHouseWindow.displayCategory	-- function to call when category icon is selected
	
	WindowSetShowing( CustomizeHouseWindow.windowName.."PreviousCategoryButton", false )
	--SetHousingMode( CustomizeHouseWindow.TILE_PLACEMENT_MODE )
	CustomizeHouseWindow.tileType = tileType
	CustomizeHouseWindow.currentCategories = CustomizeHouseWindow.type[tileType]
	
	CustomizeHouseWindow.deleteIcons( CustomizeHouseWindow.currentIconWindows )
	CustomizeHouseWindow.currentIconWindows = CustomizeHouseWindow.displayIcons( CustomizeHouseWindow.currentCategories  )
	CustomizeHouseWindow.currentCategoryID = nil
end


function CustomizeHouseWindow.HandleWallsButton()
	CustomizeHouseWindow.HandleTileTypeButton( CustomizeHouseWindow.TILE_TYPE_WALL )
end

function CustomizeHouseWindow.HandleDoorsButton()
	CustomizeHouseWindow.HandleTileTypeButton( CustomizeHouseWindow.TILE_TYPE_DOOR )
end

function CustomizeHouseWindow.HandleFloorsButton()
	CustomizeHouseWindow.HandleTileTypeButton( CustomizeHouseWindow.TILE_TYPE_FLOOR )
end

function CustomizeHouseWindow.HandleStairsButton()
	CustomizeHouseWindow.HandleTileTypeButton( CustomizeHouseWindow.TILE_TYPE_STAIRS )
end

function CustomizeHouseWindow.HandleRoofsButton()
	CustomizeHouseWindow.HandleTileTypeButton( CustomizeHouseWindow.TILE_TYPE_ROOF )
end

function CustomizeHouseWindow.HandleMiscButton()
	CustomizeHouseWindow.HandleTileTypeButton( CustomizeHouseWindow.TILE_TYPE_MISC )
end

function CustomizeHouseWindow.HandleTeleportersButton()
	--CustomizeHouseWindow.HandleTileTypeButton( CustomizeHouseWindow.TILE_TYPE_TELEPORTERS )
	
	-- for now there's only 1 teleporters category, so automatically jump into that category
	
	--SetHousingMode( CustomizeHouseWindow.TILE_PLACEMENT_MODE )
	CustomizeHouseWindow.tileType = CustomizeHouseWindow.TILE_TYPE_TELEPORTERS 
	CustomizeHouseWindow.currentCategories = CustomizeHouseWindow.type[CustomizeHouseWindow.TILE_TYPE_TELEPORTERS]
	CustomizeHouseWindow.displayCategory( CustomizeHouseWindow.currentCategories.icons[1] )
end



-- 2 Special Buttons

function CustomizeHouseWindow.HandleEraseButton()
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.HandleEraseButton")
	--CustomizeHouseWindow.tileType = CustomizeHouseWindow.TILE_TYPE_NONE	
	SetHousingMode( CustomizeHouseWindow.ERASE_MODE )

end

function CustomizeHouseWindow.HandleEyeDropperButton()
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.HandleEyeDropperButton")
	--CustomizeHouseWindow.tileType = CustomizeHouseWindow.TILE_TYPE_NONE	
	SetHousingMode( CustomizeHouseWindow.EYE_DROPPER_MODE )

end


-- 6 System Messages

function CustomizeHouseWindow.HandleBackupButton()
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.HandleBackupButton")
	SendHousingSystemMsg( CustomizeHouseWindow.SYS_MSG_BACKUP )
end

function CustomizeHouseWindow.HandleRestoreButton()
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.HandleRestoreButton")
	SendHousingSystemMsg( CustomizeHouseWindow.SYS_MSG_RESTORE )
end

function CustomizeHouseWindow.HandleSynchButton()
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.HandleSynchButton")
	SendHousingSystemMsg( CustomizeHouseWindow.SYS_MSG_SYNC )
end

function CustomizeHouseWindow.HandleClearButton()
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.HandleClearButton")
	SendHousingSystemMsg( CustomizeHouseWindow.SYS_MSG_CLEAR )
end

function CustomizeHouseWindow.HandleCommitButton()
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.HandleCommitButton")
	local successful = SendHousingSystemMsg( CustomizeHouseWindow.SYS_MSG_COMMIT )
		
	if not successful then
		local okayButton = { textTid=UO_StandardDialog.TID_OKAY }
		local windowData = 
		{
			body = WindowUtils.translateMarkup( GetStringFromTid(1062063) ), -- You cannot commit this house design ...
			buttons = { okayButton },
			windowName = "CustomizeHouseWindowCommitFailed",
		}
		if DoesWindowNameExist(windowData.windowName.."Dialog") then
			DestroyWindow(windowData.windowName.."Dialog")
		else	
			UO_StandardDialog.CreateDialog( windowData )
		end
		
	end
end

function CustomizeHouseWindow.HandleRevertButton()
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.HandleRevertButton")
	SendHousingSystemMsg( CustomizeHouseWindow.SYS_MSG_REVERT )
end



function CustomizeHouseWindow.SetStoryButtonPressed( storyNum, isPressed )

	local buttonName = ""
	if storyNum < 3 then
		buttonName = CustomizeHouseWindow.windowName.."Story"..storyNum.."Button"
	else
		buttonName = CustomizeHouseWindow.windowName.."Story"..storyNum.."Of"..CustomizeHouseVisibility.numOfStories.."Button"
	end
  	
  	ButtonSetStayDownFlag( buttonName, isPressed )
	ButtonSetPressedFlag( buttonName, isPressed )

end

function CustomizeHouseWindow.HandleChangeStoryButton()
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.HandleChangeStoryButton")
	
	local storyNum = WindowGetId( SystemData.ActiveWindow.name )
	SetCurrentHouseFloorView( storyNum )
	
	CustomizeHouseWindow.SetStoryButtonPressed( CustomizeHouseWindow.currentStory , false )
	CustomizeHouseWindow.SetStoryButtonPressed( storyNum, true )

	CustomizeHouseWindow.currentStory = storyNum
	CustomizeHouseVisibility.SetCurrentStory( storyNum )
end


function CustomizeHouseWindow.ToggleVisibilityWindow()
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.ToggleVisibilityWindow")

	WindowSetShowing( CustomizeHouseWindow.windowName.."VisibilityWindow", not WindowGetShowing( CustomizeHouseWindow.windowName.."VisibilityWindow" ) )
end


function CustomizeHouseWindow.HandleRoofUpButton()
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.HandleRoofUpButton")

	if CustomizeHouseWindow.roofZOffset < CustomizeHouseWindow.MAX_ROOF_Z_OFFSET then
		CustomizeHouseWindow.roofZOffset = CustomizeHouseWindow.roofZOffset + 1
		LabelSetText( CustomizeHouseWindow.windowName.."RoofHeightText", StringToWString( tostring(CustomizeHouseWindow.roofZOffset) ) )
	
		HousingSetRoofZOffset( CustomizeHouseWindow.roofZOffset )
	end
end

function CustomizeHouseWindow.HandleRoofDownButton()
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.HandleRoofDownButton")


	if CustomizeHouseWindow.roofZOffset > CustomizeHouseWindow.MIN_ROOF_Z_OFFSET then
		CustomizeHouseWindow.roofZOffset = CustomizeHouseWindow.roofZOffset - 1
		LabelSetText( CustomizeHouseWindow.windowName.."RoofHeightText", StringToWString( tostring(CustomizeHouseWindow.roofZOffset) ) )
		
		HousingSetRoofZOffset( CustomizeHouseWindow.roofZOffset )
	end
end


-- dynamicImage is the entire window that the icon is placed in
-- the local variable icon is just the image in that window
--
function CustomizeHouseWindow.insertDynamicImage( dynamicImage, portraitNum, forceScale )
	--Debug.Print("dynamicImage: "..dynamicImage.." portraitNum: "..portraitNum.." forceScale: "..forceScale)
	local width
	local icon = dynamicImage.."Image"
	
	-- if we have a forceScale then grab tileart and max size and we'll resize it later
	--   however floor tile tileart sizes are not comparable to each other so ignore forceScale for those
	--
	if forceScale ~= nil and CustomizeHouseWindow.tileType ~= CustomizeHouseWindow.TILE_TYPE_FLOOR then
		width, height = 1024,1024
	else
		width, height = WindowGetDimensions( dynamicImage )
	end
	
	texture, x, y, scale, newWidth, newHeight = RequestLegacyTileArt(portraitNum, width, height)
	
	if not texture then
		texture, x, y = GetIconData(0) -- icon name="No Icon Set"
	end
	
	--Debug.Print("texture: "..texture)
	
	if forceScale ~= nil and CustomizeHouseWindow.tileType ~= CustomizeHouseWindow.TILE_TYPE_FLOOR then
		newWidth = newWidth * forceScale
		newHeight = newHeight * forceScale
		scale = forceScale
	end
	
	-- *** KLUDGE - the texture returned is 256x256 set of tiles instead of our standard
	-- 64x64 single tile, so we simply zoom in the topleft 64x64 portion of it
	if CustomizeHouseWindow.tileType == CustomizeHouseWindow.TILE_TYPE_FLOOR and scale < 0.25 then
		scale = scale * 4
	end
	
	DynamicImageSetTextureDimensions(icon, newWidth, newHeight)
	WindowSetDimensions(icon, newWidth, newHeight)
	DynamicImageSetTexture(icon, texture, x, y )
	DynamicImageSetTextureScale(icon, scale)
	
	-- posts are very thin so we actually want to give their window a little extra space so their easier to click on
	--   add 10 to the width and height either way to make room for a frame
	if newWidth < 20 then
		WindowSetDimensions(dynamicImage, 30, newHeight+10) 
	else
		WindowSetDimensions(dynamicImage, newWidth+10, newHeight+10)
	end
		
	return texture, x, y
end



-- Instead of having icons all scale individually. Figure out the maximum scale for this particular category 
--     so that they all scale the same amount to keep their relative size 
--
function CustomizeHouseWindow.findMaxScale( icons )

	local maxScale = 1.0
	local texture, x, y, scale, newWidth, newHeight
	local smallestTile = 0
	
	-- *** TODO: make this grab a real window size instead of hardcoding size
	--local width, height = WindowGetDimensions( "CustomizeHouseIcon" )
	local width, height = 50, 90
	
	for iconIndex, iconID in pairs( icons ) do
		texture, x, y, scale, newWidth, newHeight = RequestLegacyTileArt(iconID, width, height)
		ReleaseLegacyTileArt( iconID )
	
		if scale < maxScale then
			maxScale = scale
			smallestTile = iconID
		end
	end

	return maxScale
end


function CustomizeHouseWindow.displayIcons( category )

	local icons = category.icons
	local maxScale = CustomizeHouseWindow.findMaxScale( icons )
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.displayIcons")
		
	local shouldDisplayRoofButtons = CustomizeHouseWindow.tileType == CustomizeHouseWindow.TILE_TYPE_ROOF and CustomizeHouseWindow.currentlyDisplaying == L"Tiles"
	CustomizeHouseWindow.displayRoofButtons( shouldDisplayRoofButtons )
	
	if category.icons == nil then
		return
	end
	
	local windowsCreated = {}
	
	local parentWindow = CustomizeHouseWindow.windowName.."ScrollChild"
	
	local anchorToPoistion = "bottomleft"
	local anchorToWindow = parentWindow
	local anchorPoistion = "bottomleft"
	
	local shouldDisplayDoorSwingIcon = CustomizeHouseWindow.tileType == CustomizeHouseWindow.TILE_TYPE_DOOR and CustomizeHouseWindow.currentlyDisplaying == L"Tiles"

	local shouldDisplayStairLabels = CustomizeHouseWindow.tileType == CustomizeHouseWindow.TILE_TYPE_STAIRS and CustomizeHouseWindow.currentlyDisplaying == L"Tiles"
	
	-- *** ASSUMPTION - this assumes all Exterior Steps occur before the Interior Stairs
	WindowSetShowing( parentWindow.."ExteriorStepsLabel", shouldDisplayStairLabels )
	WindowSetShowing( parentWindow.."InteriorStairsLabel", shouldDisplayStairLabels )
	if shouldDisplayStairLabels  then	
		anchorToWindow = parentWindow.."ExteriorStepsLabel"
		anchorToPoistion = "bottomright"
		WindowClearAnchors( parentWindow.."InteriorStairsLabel" )
	end
	
	for iconIndex, iconID in ipairs( category.icons ) do
		--Debug.Print("iconIndex: "..iconIndex.." iconID: "..iconID)
		
		-- Do not show 2nd, 3rd, 4th Exterior Step
		if(CustomizeHouseWindow.tileType == CustomizeHouseWindow.TILE_TYPE_STAIRS and CustomizeHouseWindow.currentlyDisplaying == L"Tiles") then
			if(iconIndex >= 2 and iconIndex <= 4) then
				continue
			end
		end
		
		CustomizeHouseWindow.currentWindowNum = CustomizeHouseWindow.currentWindowNum + 1
		local name = "CustomizeHouseIcon"..CustomizeHouseWindow.currentWindowNum
	    
		CreateWindowFromTemplate( name, "CustomizeHouseIcon", parentWindow )
		table.insert( windowsCreated, name )
		WindowSetId( name, iconID )	
	
		-- replace the tile art ID used for multis	
		if CustomizeHouseWindow.multiID[iconID] then
		
			-- for stairs, we need to display the Interior Stairs Label before the stairs
			-- *** ASSUMPTION - this assumes all interior stairs will be in our list of multis and are grouped after the Exterior Steps
			if shouldDisplayStairLabels then
				
				WindowAddAnchor( parentWindow.."InteriorStairsLabel", anchorToPoistion, anchorToWindow, anchorPoistion, 50, 0 )
				anchorToWindow = parentWindow.."InteriorStairsLabel"
				anchorToPoistion = "bottomright"
				shouldDisplayStairLabels = false -- we've finished adding the labels
			end
			
			iconID = CustomizeHouseWindow.multiID[iconID]
		end
		CustomizeHouseWindow.insertDynamicImage( name, iconID, maxScale ) 
		--CustomizeHouseWindow.turnOffFrameAroundWindow( name )
		 
	
		--WindowAddAnchor( name, anchorToPoistion, anchorToWindow, anchorPoistion, 10, 0 )
		WindowAddAnchor( name, anchorToPoistion, anchorToWindow, anchorPoistion, 0, 0 )
		anchorToWindow = name
		anchorToPoistion = "bottomright" -- after first, anchor to right of previous window
		
		if shouldDisplayDoorSwingIcon then
			local iconTemplate, position, yOffset = CustomizeHouseWindow.getDoorSwingDirectionIcon( CustomizeHouseWindow.currentCategoryID, iconIndex )
			
			local iconName = name..iconTemplate
			CreateWindowFromTemplate( iconName, iconTemplate, anchorToWindow )
			WindowAddAnchor( iconName, position, anchorToWindow, position, 0, yOffset )

		end


		-- Removed tinting of tiles in a non-entitled category so users can see what the tiles look like if they buy them
		-- 		
		--if category.entitlement == false or CustomizeHouseWindow.entitlements[iconID] == false then
		if CustomizeHouseWindow.currentlyDisplaying == L"Categories" and CustomizeHouseWindow.entitlements[iconID] == false then
			WindowSetTintColor( name, CustomizeHouseWindow.NOT_ENTITLED.R, CustomizeHouseWindow.NOT_ENTITLED.G, CustomizeHouseWindow.NOT_ENTITLED.B )
		end
	end
		
	
	
	HorizontalScrollWindowSetOffset(CustomizeHouseWindow.windowName.."Scroll", 0)
	HorizontalScrollWindowUpdateScrollRect(CustomizeHouseWindow.windowName.."Scroll")	
	
	--Debug.PrintToDebugConsole(L"finished CustomizeHouseWindow.displayIcons, with HorizontalScrollWindowSetOffset")
	return windowsCreated
end


function CustomizeHouseWindow.ScrollToIconInHorizontalScrollWindow(iconID)

	local scrollWindow = CustomizeHouseWindow.windowName.."Scroll"
	local scrollChild = scrollWindow.."Child"
	local id = nil
		
	for iconIndex, element in pairs(CustomizeHouseWindow.currentIconWindows) do
		id = WindowGetId( element )

		if id ~= nil and id == iconID then
			WindowUtils.ScrollToElementInHorizontalScrollWindow( element, scrollWindow, scrollChild )
			CustomizeHouseWindow.turnOnFrameAroundWindow( element )
		end
	end
	
end

function CustomizeHouseWindow.turnOnFrameAroundWindow( icon )
	
	-- turn off previous frame
	CustomizeHouseWindow.turnOffFrameAroundWindow( CustomizeHouseWindow.currentlyFramedWindow  )
	
	ButtonSetStayDownFlag( icon.."Highlight", true )
	ButtonSetPressedFlag( icon.."Highlight", true )
	--UO_Default_Selection_Highlight.select( icon.."Highlight" )
	
	-- ideally we would dynamically create an inner frame to show the selected icon
	--   but there is currently a bug that keeps it from being hidden when it scrolls outside the ScrollWindow
	--
	--CreateWindowFromTemplate( icon.."Frame", "CustomizeHouseFrame", icon.."Highlight" )
	
	CustomizeHouseWindow.currentlyFramedWindow = icon
end

function CustomizeHouseWindow.turnOffFrameAroundWindow( icon )
	
	if icon ~= nil and DoesWindowNameExist( icon ) then
		ButtonSetStayDownFlag( icon.."Highlight", false )
		ButtonSetPressedFlag( icon.."Highlight", false )
		--UO_Default_Selection_Highlight.unselect( icon.."Highlight" )
		--DestroyWindow( icon.."Frame" )
	end
end


function CustomizeHouseWindow.OnMouseOver()
	local self = CustomizeHouseWindow
	local name = SystemData.ActiveWindow.name
	
	if  self				~= nil
	and self.Tooltips		~= nil
	and self.Tooltips[name]	~= nil
	then
		Tooltips.CreateTextOnlyTooltip( name, WindowUtils.translateMarkup( GetStringFromTid( self.Tooltips[name] ) ) )
		Tooltips.Finalize()
		Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	end 
end


-- TODO: Rather than creating and deleting windows over and over again, we could optimize this
--   by reusing the windows and just changing the icons and IDs
function CustomizeHouseWindow.deleteIcons( windowNames )

	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.deleteIcons")
	
	if windowNames == nil then
		return
	end

	for i, name in ipairs( windowNames ) do
		local tileID = WindowGetId( name )
		ReleaseLegacyTileArt( tileID )
		WindowClearAnchors( name )
		DestroyWindow( name )
	end
	
	HorizontalScrollWindowSetOffset(CustomizeHouseWindow.windowName.."Scroll", 0)
	HorizontalScrollWindowUpdateScrollRect(CustomizeHouseWindow.windowName.."Scroll")	
	
	windowNames = nil
end
	
function CustomizeHouseWindow.OnCloseWindow()
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.OnCloseWindow")

	DestroyWindow( CustomizeHouseWindow.windowName )
	
end

function CustomizeHouseWindow.Shutdown()
	--Debug.PrintToDebugConsole(L"CustomizeHouseWindow.Shutdown")
	
	SetIsCustomizingHouse( false )
	
	CustomizeHouseWindow.deleteIcons( CustomizeHouseWindow.currentIconWindows )
	
	CustomizeHouseWindow.doors = nil
	CustomizeHouseWindow.floors = nil
	CustomizeHouseWindow.misc = nil
	CustomizeHouseWindow.roofs = nil
	CustomizeHouseWindow.stairs = nil
	CustomizeHouseWindow.walls = nil
	CustomizeHouseWindow.teleporters = nil
	
	CustomizeHouseWindow.currentCategories = nil
	CustomizeHouseWindow.currentIconWindows = nil
	CustomizeHouseWindow.Tooltips			= nil

	
	UnregisterWindowData(WindowData.CustomHouseInfo.Type, 0)
	UnregisterWindowData(WindowData.CustomHouseEyedropper.Type, 0)
	
	DestroyWindow( CustomizeHouseVisibility.windowName )
	
	--Debug.PrintToDebugConsole(L"finished CustomizeHouseWindow.Shutdown")
end


