
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

SettingsWindow = {}

SettingsWindow.Modes = {}
SettingsWindow.Modes.Graphics = 1 
SettingsWindow.Modes.KeyBindings = 2 
SettingsWindow.Modes.Options = 5
SettingsWindow.Modes.NUM_MODES = 7

SettingsWindow.Modes.windows = { "SettingsGraphicsWindow", 
								"SettingsKeyBindingsWindow", 
								"SettingsSoundWindow", 
								"SettingsOptionsWindow", 
								"SettingsLegacyWindow", 
								"SettingsProfanityWindow", 
								"SettingsKeyDefaultWindow"}

SettingsWindow.FontSizes = {}
SettingsWindow.FontSizes[1] = 12
SettingsWindow.FontSizes[2] = 14
SettingsWindow.FontSizes[3] = 16
SettingsWindow.FontSizes[4] = 18
SettingsWindow.FontSizes[5] = 20
SettingsWindow.FontSizes[6] = 22
SettingsWindow.FontSizes[7] = 24
SettingsWindow.NUM_FONT_SIZES = 7

SettingsWindow.ChatFadeTime = {}
SettingsWindow.ChatFadeTime[1] = 1
SettingsWindow.ChatFadeTime[2] = 2
SettingsWindow.ChatFadeTime[3] = 3
SettingsWindow.ChatFadeTime[4] = 4
SettingsWindow.ChatFadeTime[5] = 5
SettingsWindow.NUM_FADE_TIMES = 5

SettingsWindow.Languages = {}
SettingsWindow.Languages[1] = {tid = 1077459, id = SystemData.Settings.Language.LANGUAGE_ENU}
SettingsWindow.Languages[2] = {tid = 1077460, id = SystemData.Settings.Language.LANGUAGE_JPN}
SettingsWindow.Languages[3] = {tid = 1078516, id = SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL}
SettingsWindow.NUM_LANGUAGES = 3

SettingsWindow.ShowNames = {}
SettingsWindow.ShowNames[1] = {tid = 1011051, id = SystemData.Settings.GameOptions.SHOWNAMES_NONE}
SettingsWindow.ShowNames[2] = {tid = 1078090, id = SystemData.Settings.GameOptions.SHOWNAMES_APPROACHING}
SettingsWindow.ShowNames[3] = {tid = 1078091, id = SystemData.Settings.GameOptions.SHOWNAMES_ALL}
SettingsWindow.NUM_SHOWNAMES = 3

SettingsWindow.ScrollWheelBehaviors = {}
SettingsWindow.ScrollWheelBehaviors[1] = {tid = 1079288, id = SystemData.Settings.GameOptions.MOUSESCROLL_ZOOM_IN_CAMERA }
SettingsWindow.ScrollWheelBehaviors[2] = {tid = 1079289, id = SystemData.Settings.GameOptions.MOUSESCROLL_ZOOM_OUT_CAMERA }
SettingsWindow.ScrollWheelBehaviors[3] = {tid = 1079177, id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_NEXT_FRIENDLY }
SettingsWindow.ScrollWheelBehaviors[4] = {tid = 1111940, id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_LAST_FRIENDLY }
SettingsWindow.ScrollWheelBehaviors[5] = {tid = 1079178, id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_NEXT_ENEMY }
SettingsWindow.ScrollWheelBehaviors[6] = {tid = 1111941, id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_LAST_ENEMY }
SettingsWindow.ScrollWheelBehaviors[7] = {tid = 1094824, id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_NEXT_ANY }
SettingsWindow.ScrollWheelBehaviors[8] = {tid = 1111942, id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_LAST_ANY }
SettingsWindow.ScrollWheelBehaviors[9] = {tid = 1079156, id = SystemData.Settings.GameOptions.MOUSESCROLL_CURSOR_TARGET_LAST }
SettingsWindow.ScrollWheelBehaviors[10] = {tid = 1079158, id = SystemData.Settings.GameOptions.MOUSESCROLL_CURSOR_TARGET_SELF }
SettingsWindow.ScrollWheelBehaviors[11] = {tid = 1079157, id = SystemData.Settings.GameOptions.MOUSESCROLL_CURSOR_TARGET_CURRENT }
SettingsWindow.ScrollWheelBehaviors[12] = {tid = 1112413, id = SystemData.Settings.GameOptions.MOUSESCROLL_CYCLE_CURSOR_TARGET }
SettingsWindow.ScrollWheelBehaviors[13] = {tid = 1011051, id = SystemData.Settings.GameOptions.MOUSESCROLL_NONE }
SettingsWindow.NUM_SCROLLWHEELBEHAVIORS = 13

SettingsWindow.ScrollWheelBehaviors_Legacy = {}
SettingsWindow.ScrollWheelBehaviors_Legacy[1] = {tid = 1079288, id = SystemData.Settings.GameOptions.MOUSESCROLL_ZOOM_IN_CAMERA }
SettingsWindow.ScrollWheelBehaviors_Legacy[2] = {tid = 1079289, id = SystemData.Settings.GameOptions.MOUSESCROLL_ZOOM_OUT_CAMERA }
SettingsWindow.ScrollWheelBehaviors_Legacy[3] = {tid = 1079156, id = SystemData.Settings.GameOptions.MOUSESCROLL_CURSOR_TARGET_LAST }
SettingsWindow.ScrollWheelBehaviors_Legacy[4] = {tid = 1079158, id = SystemData.Settings.GameOptions.MOUSESCROLL_CURSOR_TARGET_SELF }
SettingsWindow.ScrollWheelBehaviors_Legacy[5] = {tid = 1112413, id = SystemData.Settings.GameOptions.MOUSESCROLL_CYCLE_CURSOR_TARGET }
SettingsWindow.ScrollWheelBehaviors_Legacy[6] = {tid = 1011051, id = SystemData.Settings.GameOptions.MOUSESCROLL_NONE }
SettingsWindow.NUM_SCROLLWHEELBEHAVIORS_LEGACY = 6

SettingsWindow.DelayValues = {}
SettingsWindow.DelayValues[1] = 1078334
SettingsWindow.DelayValues[2] = 1078336
SettingsWindow.DelayValues[3] = 1078337
SettingsWindow.DelayValues[4] = 1078338
SettingsWindow.DelayValues[5] = 1078339
SettingsWindow.DelayValues[6] = 1078340
SettingsWindow.NUM_DELAY_VALUES = 6

SettingsWindow.ContainerViewOptions = {}
SettingsWindow.ContainerViewOptions[1] = {name="List", tid=1079824}
SettingsWindow.ContainerViewOptions[2] = {name="Grid", tid=1079825}

SettingsWindow.ObjectHandles = {}
SettingsWindow.ObjectHandles[1] = { id = SystemData.Settings.ObjectHandleFilter.eDynamicFilter, tid = 1079457}
SettingsWindow.ObjectHandles[2] = { id = SystemData.Settings.ObjectHandleFilter.eCorpseFilter, tid = 1078368}
SettingsWindow.ObjectHandles[3] = { id = SystemData.Settings.ObjectHandleFilter.eNPCFilter, tid = 1079458}
SettingsWindow.ObjectHandles[4] = { id = SystemData.Settings.ObjectHandleFilter.eNPCVendorFilter, tid = 1079459}
SettingsWindow.ObjectHandles[5] = { id = SystemData.Settings.ObjectHandleFilter.eMobileFilter, tid = 1075672}
SettingsWindow.NUM_OBJHANDLE_FILTERS = 5

SettingsWindow.ObjectHandleSizes = {50, 100, 200, 300, -1}

-- NOTE_KEYBIND: Make sure the order of these match with the order of other keybinding symbol lists in code
SettingsWindow.Keybindings = {}
SettingsWindow.Keybindings[1] = { name = "MoveUp", tid = 1077791, type = "FORWARD" }
SettingsWindow.Keybindings[2] = { name = "MoveDown", tid = 1077792, type = "BACKWARD" }
SettingsWindow.Keybindings[3] = { name = "MoveLeft", tid = 1077793, type = "LEFT" }
SettingsWindow.Keybindings[4] = { name = "MoveRight", tid = 1077794, type = "RIGHT" }

SettingsWindow.Keybindings[5] = { name = "AttackMode", tid = 1077813, type = "MELEE_ATTACK" }
SettingsWindow.Keybindings[6] = { name = "PrimaryAttack", tid = 1079153, type = "USE_PRIMARY_ATTACK" }
SettingsWindow.Keybindings[7] = { name = "SecondaryAttack", tid = 1079154, type = "USE_SECONDARY_ATTACK" }

SettingsWindow.Keybindings[8] = { name = "NextGroupTarget", tid = 1079155, type = "NEXT_GROUP_TARGET" }
SettingsWindow.Keybindings[9] = { name = "NextEnemy", tid = 1077807, type = "NEXT_ENEMY_TARGET" }
SettingsWindow.Keybindings[10] = { name = "NextFriend", tid = 1077809, type = "NEXT_FRIENDLY_TARGET" }
SettingsWindow.Keybindings[11] = { name = "NextFollower", tid = 1112417, type = "NEXT_FOLLOWER_TARGET" }
SettingsWindow.Keybindings[12] = { name = "NextObject", tid = 1112424, type = "NEXT_OBJECT_TARGET" }
SettingsWindow.Keybindings[13] = { name = "NextTarget", tid = 1094822, type = "NEXT_TARGET" }

SettingsWindow.Keybindings[14] = { name = "PreviousGroupTarget", tid = 1112425, type = "PREVIOUS_GROUP_TARGET" }
SettingsWindow.Keybindings[15] = { name = "PreviousEnemy", tid = 1112426, type = "PREVIOUS_ENEMY_TARGET" }
SettingsWindow.Keybindings[16] = { name = "PreviousFriend", tid = 1112427, type = "PREVIOUS_FRIENDLY_TARGET" }
SettingsWindow.Keybindings[17] = { name = "PreviousFollower", tid = 1112428, type = "PREVIOUS_FOLLOWER_TARGET" }
SettingsWindow.Keybindings[18] = { name = "PreviousObject", tid = 1112429, type = "PREVIOUS_OBJECT_TARGET" }
SettingsWindow.Keybindings[19] = { name = "PreviousTarget", tid = 1112430, type = "PREVIOUS_TARGET" }

SettingsWindow.Keybindings[20] = { name = "NearestGroup", tid = 1112418, type = "NEAREST_GROUP_TARGET" }
SettingsWindow.Keybindings[21] = { name = "NearestEnemy", tid = 1077811, type = "NEAREST_ENEMY_TARGET" }
SettingsWindow.Keybindings[22] = { name = "NearestFriend", tid = 1077812, type = "NEAREST_FRIENDLY_TARGET" }
SettingsWindow.Keybindings[23] = { name = "NearestFollower", tid = 1112419, type = "NEAREST_FOLLOWER_TARGET" }
SettingsWindow.Keybindings[24] = { name = "NearestObject", tid = 1112423, type = "NEAREST_OBJECT_TARGET" }
SettingsWindow.Keybindings[25] = { name = "NearestTarget", tid = 1094823, type = "NEAREST_TARGET" }

SettingsWindow.Keybindings[26] = { name = "TargetSelf", tid = 1077801, type = "TARGET_SELF" }
SettingsWindow.Keybindings[27] = { name = "TargetG1", tid = 1077802, type = "TARGET_GROUP_MEMBER_1" }
SettingsWindow.Keybindings[28] = { name = "TargetG2", tid = 1077803, type = "TARGET_GROUP_MEMBER_2" }
SettingsWindow.Keybindings[29] = { name = "TargetG3", tid = 1077804, type = "TARGET_GROUP_MEMBER_3" }
SettingsWindow.Keybindings[30] = { name = "TargetG4", tid = 1077805, type = "TARGET_GROUP_MEMBER_4" }
SettingsWindow.Keybindings[31] = { name = "TargetG5", tid = 1077806, type = "TARGET_GROUP_MEMBER_5" }
SettingsWindow.Keybindings[32] = { name = "TargetG6", tid = 1079147, type = "TARGET_GROUP_MEMBER_6" }
SettingsWindow.Keybindings[33] = { name = "TargetG7", tid = 1079148, type = "TARGET_GROUP_MEMBER_7" }
SettingsWindow.Keybindings[34] = { name = "TargetG8", tid = 1079149, type = "TARGET_GROUP_MEMBER_8" }
SettingsWindow.Keybindings[35] = { name = "TargetG9", tid = 1079150, type = "TARGET_GROUP_MEMBER_9" }

SettingsWindow.Keybindings[36] = { name = "CharacterWin", tid = 1077795, type = "PAPERDOLL_CHARACTER_WINDOW" }
SettingsWindow.Keybindings[37] = { name = "BackpackWin", tid = 1077796, type = "BACKPACK_WINDOW" }
SettingsWindow.Keybindings[38] = { name = "SkillsWin", tid = 1078992, type = "SKILLS_WINDOW" }
SettingsWindow.Keybindings[39] = { name = "ToggleMap", tid = 1078993, type = "WORLD_MAP_WINDOW" }
SettingsWindow.Keybindings[40] = { name = "QuestLogWin", tid = 1077799, type = "QUEST_LOG_WINDOW" }

SettingsWindow.Keybindings[41] = { name = "ToggleAlwaysRun", tid = 1113150, type = "TOGGLE_ALWAYS_RUN" }

SettingsWindow.Keybindings[42] = { name = "ZoomIn", tid = 1079288, type = "ZOOM_IN" }
SettingsWindow.Keybindings[43] = { name = "ZoomOut", tid = 1079289, type = "ZOOM_OUT" }
SettingsWindow.Keybindings[44] = { name = "ZoomReset", tid = 1079290, type = "ZOOM_RESET" }

SettingsWindow.Keybindings[45] = { name = "Screenshot", tid = 1079819, type = "SCREENSHOT" }
SettingsWindow.Keybindings[46] = { name = "ToggleInterface", tid = 1079817, type = "TOGGLE_UI" }
SettingsWindow.Keybindings[47] = { name = "ReloadInterface", tid = 1079820, type = "RELOAD_UI" }
SettingsWindow.Keybindings[48] = { name = "ToggleCoT", tid = 1079818, type = "TOGGLE_CIRCLE_OF_TRANSPARENCY" }

SettingsWindow.NON_LEGACY_BINDING_MIN = 8
SettingsWindow.NON_LEGACY_BINDING_MAX = 35

SettingsWindow.TID = {UserSetting = 1077814, Graphics = 1077815, KeyBindings = 1077816, Options = 1015326, Resolution = 1077817, 
					 WindowRes = 1077818, MaxFramerate = 1112340, FullRes = 1077819, ShowFrame = 1077820, UseFull = 1077821, EnableSound = 1077823, SoundVol = 1094691, 
					 Language = 1077824, Okay = 3000093, Apply = 3000090, Reset = 1077825, Cancel = 1006045, Quarter = 1078023, Full = 1074240, 
					 Sound = 3000390, Interface = 3000395, PlayFootsteps = 1078077, CircleOfTransparency = 1078079, 
					 Pathfinding = 3000064, AlwaysRun = 1078078, Movie = 3000190, ObjectHandles = 1062947, ObjectHandleFilter = 1079461, ObjectHandleQuantity = 1094696,
					 QueryBeforeCriminalActions = 1078080, HoldShiftToUnstack = 1112076, FilterObscenity = 3000460, OverheadChatFadeDelay = 1078084, 
					 OverheadChat = 1078083, Tooltips = 1078085, TooltipDelay = 1078086, PlayerNameColors = 1078087, ShowNames = 1078093, Filter = 3000173, IgnorePlayers = 3000462,
					 MusicVolume = 1078578, EnableMusic = 1078577, Animation = 1079368, EffectsVolume = 1078576, EnableEffects = 1078575, AlwaysAttack = 1078858, ShowStrLabel = 1079171,
					 LegacyChat = 1079172, PlayIdleAnimation = 1094692, GameOptions = 1094695, System = 1078905, Chat = 3000131, Legacy = 1094697,
					 UiScale = 1079205, EnableUiScale = 1079206, Gamma = 3000166, ParticleLOD = 1079213, ParticleFilter = 1112330, Input = 1094693, Mouse = 1094694, NotAvailable = 1094717,
					 ShowShadows = 1079286, EnableVsync = 1112689, ShowChatWindow = 1079299, Bindings = 1079337, UseLegacyContainers = 1094708, ShowFoliage = 1079814, LegacyTargeting = 1094710,
					 ScrollWheelUp = 1111944, ScrollWheelDown = 1111945, DefaultContainerView = 1079827, DefaultCorpseView = 1079828, TipoftheDay = 1094689, Display = 3000396, Environment = 1077415}

SettingsWindow.TID_BINDING_CONFLICT_TITLE = 1079169
SettingsWindow.TID_BINDING_CONFLICT_BODY = 1079170
SettingsWindow.TID_BINDING_CONFLICT_QUESTION = 1094839
SettingsWindow.TID_YES = 1049717
SettingsWindow.TID_NO = 1049718
SettingsWindow.TID_INFO = 1011233
SettingsWindow.TID_RESETLEGACYBINDINGS_CHAT = 1079400
SettingsWindow.TID_RESETDEFAULTBINDINGS = 1094698
SettingsWindow.TID_RESETCHATSETTINGS = 1094699

SettingsWindow.TID_FRAMERATE = { 1112341, 1112342, 1112343, 1112344, 1112345 }

SettingsWindow.TID_DETAILS = { 1079210, 1079211, 1079212 }
SettingsWindow.TID_FILTERS = { 1112331, 1112332, 1112333, 1112334 }

SettingsWindow.TID_ANIMATION = {1079210, 1079211, 1079212}

SettingsWindow.RecordingKey = false

SettingsWindow.PreviousBadWordCount = 0
SettingsWindow.PreviousIgnoreListCount = 0
SettingsWindow.CurIgnoreListIdx = -1

--SettingsWindow.ENABLE_CUSTOM_SKINS = false -- enable this element? search for this tag to find all uses of this element also!
--SettingsWindow.TID_CUSTOM_SKINS_TEXT = 1011012 -- "Cancel"( placeholder )-- Label on the right of the combo box
--SettingsWindow.CustomSkins = {} -- table containing data for the different skins, may need to be initalized before use
--SettingsWindow.CustomSkins[1] = { tid = 3006115, id = 1 } -- "Resign( placeholder )-- Fist listed element in combo box
--SettingsWindow.CustomSkins[2] = { tid = 1078056, id = 2 } -- "MORE"( placeholder )
--SettingsWindow.CustomSkins[3] = { tid = 1011011, id = 3 } -- "CONTINUE"( placeholder )-- Last listed element in combo box

----------------------------------------------------------------
-- LoginWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler()
function SettingsWindow.Initialize()
	
	Interface.OnCloseCallBack["SettingsWindow"] = SettingsWindow.OnCancelButton
	
	WindowRegisterEventHandler( "Root", SystemData.Events.PROFANITYLIST_UPDATED, "SettingsWindow.ProfanityListUpdated" )
	
	WindowUtils.SetWindowTitle( "SettingsWindow", GetStringFromTid( SettingsWindow.TID.UserSetting ) )

	-- Tab Buttons
	ButtonSetText( "SettingsWindowGraphicsTabButton", GetStringFromTid( SettingsWindow.TID.Graphics ) )
	ButtonSetText( "SettingsWindowKeyBindingsTabButton", GetStringFromTid( SettingsWindow.TID.Input ) )
	ButtonSetText( "SettingsWindowOptionsTabButton", GetStringFromTid( SettingsWindow.TID.Options ) )
	ButtonSetText( "SettingsWindowSoundTabButton", GetStringFromTid( SettingsWindow.TID.Sound ) )
	ButtonSetText( "SettingsWindowLegacyTabButton", GetStringFromTid( SettingsWindow.TID.Legacy ) )
	ButtonSetText( "SettingsWindowProfanityTabButton", GetStringFromTid( SettingsWindow.TID.Filter ) )
	
	-- SubSection Labels
	LabelSetText( "SettingsGraphicsDisplaySubSectionLabel", GetStringFromTid( SettingsWindow.TID.Display ) )
	LabelSetText( "SettingsGraphicsEnvironmentSubSectionLabel", GetStringFromTid( SettingsWindow.TID.Environment ) )
	LabelSetText( "SettingsKeyBindingsMouseSubSectionLabel", GetStringFromTid( SettingsWindow.TID.Mouse ) )
	LabelSetText( "SettingsKeyBindingsKeyboardSubSectionLabel", GetStringFromTid( SettingsWindow.TID.KeyBindings ) )
	LabelSetText( "SettingsSoundSoundSubSectionLabel", GetStringFromTid( SettingsWindow.TID.Sound ) )
	LabelSetText( "SettingsOptionsGameOptionsSubSectionLabel", GetStringFromTid( SettingsWindow.TID.GameOptions ) )
	LabelSetText( "SettingsOptionsInterfaceSubSectionLabel", GetStringFromTid( SettingsWindow.TID.Interface ) )
	LabelSetText( "SettingsOptionsSystemSubSectionLabel", GetStringFromTid( SettingsWindow.TID.System ) )
	LabelSetText( "SettingsOptionsChatSubSectionLabel", GetStringFromTid( SettingsWindow.TID.Chat ) )
	LabelSetText( "SettingsLegacyLegacySubSectionLabel", GetStringFromTid( SettingsWindow.TID.Legacy ) )
	LabelSetText( "SettingsBadWordFilterFilterSubSectionLabel", GetStringFromTid( SettingsWindow.TID.Filter ) )
	
	-- Buttons
	ButtonSetText( "SettingsWindowOkayButton", GetStringFromTid( SettingsWindow.TID.Okay ) )
	ButtonSetText( "SettingsWindowApplyButton", GetStringFromTid( SettingsWindow.TID.Apply ) )
	ButtonSetText( "SettingsWindowResetButton", GetStringFromTid( SettingsWindow.TID.Reset ) )
	ButtonSetText( "SettingsWindowCancelButton", GetStringFromTid( SettingsWindow.TID.Cancel ) )
	
	--[[ this no longer seems to be necessary
	ButtonSetStayDownFlag( "SettingsWindowGraphicsTabButton", true )
	ButtonSetStayDownFlag( "SettingsWindowKeyBindingsTabButton", true )
	ButtonSetStayDownFlag( "SettingsWindowOptionsTabButton", true )
	--]]
	
	-- Start with graphics window open
	SettingsWindow.OpenGraphicsTab()
	
	-- Graphics --
	
	-- Use Fullscreen
	LabelSetText( "SettingsGraphicsUseFullscreenLabel", GetStringFromTid( SettingsWindow.TID.UseFull ) )
	ButtonSetCheckButtonFlag( "SettingsGraphicsUseFullscreenButton", true )
	
	-- Fullscreen Resolution
	LabelSetText( "SettingsGraphicsFullScreenResLabel", GetStringFromTid( SettingsWindow.TID.FullRes ) )
	for res = 1, table.getn( SystemData.AvailableResolutions.widths )do
		ComboBoxAddMenuItem( "SettingsGraphicsFullScreenResCombo", L""..SystemData.AvailableResolutions.widths[res]..L" x "..SystemData.AvailableResolutions.heights[res] )
	end
	
	-- Framerate Max
	LabelSetText( "SettingsGraphicsFramerateMaxLabel", GetStringFromTid( SettingsWindow.TID.MaxFramerate ) )
	for index, tid in ipairs( SettingsWindow.TID_FRAMERATE )do
		ComboBoxAddMenuItem( "SettingsGraphicsFramerateMaxCombo", GetStringFromTid( tid ) )
	end
	
	-- Show Frame
	LabelSetText( "SettingsGraphicsShowFrameLabel", GetStringFromTid( SettingsWindow.TID.ShowFrame ) )
	ButtonSetCheckButtonFlag( "SettingsGraphicsShowFrameButton", true )
	
	-- Brightness
	LabelSetText( "GammaText", GetStringFromTid( SettingsWindow.TID.Gamma ) )
	
	-- Show Foliage
	LabelSetText( "SettingsGraphicsShowFoliageLabel", GetStringFromTid( SettingsWindow.TID.ShowFoliage ) )
	ButtonSetStayDownFlag( "SettingsGraphicsShowFoliageButton", true )
	ButtonSetCheckButtonFlag( "SettingsGraphicsShowFoliageButton", true )
	
	-- Show Shadows
	LabelSetText( "SettingsGraphicsShowShadowsLabel", GetStringFromTid( SettingsWindow.TID.ShowShadows ) )
	ButtonSetCheckButtonFlag( "SettingsGraphicsShowShadowsButton", true )

	-- Enable Vsync
	LabelSetText( "SettingsGraphicsEnableVSyncLabel", GetStringFromTid( SettingsWindow.TID.EnableVsync ) )
	ButtonSetCheckButtonFlag( "SettingsGraphicsEnableVSyncButton", true )
	
	-- Use Circle of Transparency
	LabelSetText( "SettingsGraphicsCircleOfTransparencyLabel", GetStringFromTid( SettingsWindow.TID.CircleOfTransparency ) )
	ButtonSetCheckButtonFlag( "SettingsGraphicsCircleOfTransparencyButton", true )
	
	-- Particle Detail
	LabelSetText( "SettingsGraphicsParticleLODLabel", GetStringFromTid( SettingsWindow.TID.ParticleLOD )..L":" )
	for index, tid in ipairs( SettingsWindow.TID_DETAILS )do
		ComboBoxAddMenuItem( "SettingsGraphicsParticleLODCombo", GetStringFromTid( tid ) )
	end
	
	-- Particle Filter
	LabelSetText( "SettingsGraphicsParticleFilterLabel", GetStringFromTid( SettingsWindow.TID.ParticleFilter )..L":" )
	for index, tid in ipairs( SettingsWindow.TID_FILTERS )do
		ComboBoxAddMenuItem( "SettingsGraphicsParticleFilterCombo", GetStringFromTid( tid ) )
	end

	-- Idle Animation (Restart Required)
	LabelSetText( "SettingsGraphicsPlayIdleAnimationLabel", GetStringFromTid( SettingsWindow.TID.PlayIdleAnimation ) )
	ButtonSetCheckButtonFlag( "SettingsGraphicsPlayIdleAnimationButton", true )
	
	-- Animation (Restart Required)
	LabelSetText( "SettingsGraphicsAnimationLabel", GetStringFromTid( SettingsWindow.TID.Animation )..L":" )
	for index, tid in ipairs( SettingsWindow.TID_ANIMATION )do
		ComboBoxAddMenuItem( "SettingsGraphicsAnimationCombo", GetStringFromTid( tid ) )
	end

	-- Input --
	
	-- Scroll Wheel Behavior
	LabelSetText( "SettingsKeyBindingsScrollWheelUpLabel", GetStringFromTid( SettingsWindow.TID.ScrollWheelUp ) )
	LabelSetText( "SettingsKeyBindingsScrollWheelDownLabel", GetStringFromTid( SettingsWindow.TID.ScrollWheelDown ) )
	SettingsWindow.RefreshScrollWheelComboBoxes()
	
	-- Legacy default
	LabelSetText( "SettingsKeyDefaultWindowLegacyKeysName", GetStringFromTid( 1079163 ) )
	-- MMO default
	LabelSetText( "SettingsKeyDefaultWindowMMOKeysName", GetStringFromTid( 1111866 ) )
	
	-- Key Bindings
	for key = 1, table.getn( SettingsWindow.Keybindings )do
		LabelSetText( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name.."Action", GetStringFromTid( SettingsWindow.Keybindings[key].tid ) )
	end	

	-- Sound --
	
	-- Master Volume
	ButtonSetStayDownFlag( "MasterVolumeToggleButton", true )
	ButtonSetCheckButtonFlag( "MasterVolumeToggleButton", true )
		
	LabelSetText( "MasterVolumeText", GetStringFromTid( SettingsWindow.TID.SoundVol ) )
	LabelSetText( "MasterVolumeVal", L""..( math.floor( SystemData.Settings.Sound.master.volume*100 ) ) )
	LabelSetText( "MasterVolumeToggleLabel", GetStringFromTid( SettingsWindow.TID.EnableSound ) )
	
	-- Effects Volume
	ButtonSetStayDownFlag( "EffectsVolumeToggleButton", true )
	ButtonSetCheckButtonFlag( "EffectsVolumeToggleButton", true )
	
	LabelSetText( "EffectsVolumeText", GetStringFromTid( SettingsWindow.TID.EffectsVolume ) )
	LabelSetText( "EffectsVolumeVal", L""..( math.floor( SystemData.Settings.Sound.effects.volume*100 ) ) )
	LabelSetText( "EffectsVolumeToggleLabel", GetStringFromTid( SettingsWindow.TID.EnableEffects ) )
	
	-- Music Volume
	ButtonSetStayDownFlag( "MusicVolumeToggleButton", true )
	ButtonSetCheckButtonFlag( "MusicVolumeToggleButton", true )
	
	LabelSetText( "MusicVolumeText", GetStringFromTid( SettingsWindow.TID.MusicVolume ) )
	LabelSetText( "MusicVolumeVal", L""..( math.floor( SystemData.Settings.Sound.music.volume*100 ) ) )
	LabelSetText( "MusicVolumeToggleLabel", GetStringFromTid( SettingsWindow.TID.EnableMusic ) )

	-- Play Footsteps
	ButtonSetStayDownFlag( "PlayFootstepsToggleButton", true )
	ButtonSetCheckButtonFlag( "PlayFootstepsToggleButton", true )
	LabelSetText( "PlayFootstepsToggleLabel", GetStringFromTid( SettingsWindow.TID.PlayFootsteps ) )
	
	-- Options --
	
	-- Always Run
	LabelSetText( "AlwaysRunLabel", GetStringFromTid( SettingsWindow.TID.AlwaysRun ) )
	ButtonSetCheckButtonFlag( "AlwaysRunButton", true )
	
	-- Always Attack
	LabelSetText( "AlwaysAttackLabel", GetStringFromTid( SettingsWindow.TID.AlwaysAttack ) )
	ButtonSetCheckButtonFlag( "AlwaysAttackButton", true )
	
	-- Query Before Criminal Actions
	LabelSetText( "QueryBeforeCriminalActionsLabel", GetStringFromTid( SettingsWindow.TID.QueryBeforeCriminalActions ) )
	ButtonSetCheckButtonFlag( "QueryBeforeCriminalActionsButton", true )
	
	-- Query Before Criminal Actions
	LabelSetText( "HoldShiftToUnstackLabel", GetStringFromTid( SettingsWindow.TID.HoldShiftToUnstack ) )
	ButtonSetCheckButtonFlag( "HoldShiftToUnstackButton", true )
	
	-- Use Custom UI
	LabelSetText( "CustomSkinsLabel", GetStringFromTid( 1079523 )..L":" )
	for skinItr = 1, #SystemData.CustomUIList do
		local text = SystemData.CustomUIList[skinItr]
		if text == "" then
			ComboBoxAddMenuItem( "CustomSkinsCombo", GetStringFromTid( 3000094 ) )-- "Default"
		else
			ComboBoxAddMenuItem( "CustomSkinsCombo", StringToWString( text ) )
		end
	end
	
	-- Enable UI Scale
	LabelSetText( "UiScaleToggleLabel", GetStringFromTid( SettingsWindow.TID.EnableUiScale ) )
	ButtonSetCheckButtonFlag( "UiScaleToggleButton", true )
	
	-- UI Scale
	LabelSetText( "UiScaleText", GetStringFromTid( SettingsWindow.TID.UiScale ) )
	LabelSetText( "UiScalePDText", L"Paperdoll Scale")
	
	-- Default Container View
	-- Default Corpse View
	LabelSetText( "ContainerViewLabel", GetStringFromTid( SettingsWindow.TID.DefaultContainerView )..L":" )
	LabelSetText( "CorpseViewLabel", GetStringFromTid( SettingsWindow.TID.DefaultCorpseView )..L":" )
	for id, data in ipairs(SettingsWindow.ContainerViewOptions) do
	    ComboBoxAddMenuItem( "ContainerViewCombo", GetStringFromTid(data.tid) )
	    ComboBoxAddMenuItem( "CorpseViewCombo", GetStringFromTid(data.tid) )
	end
	
	-- Always show Health, Mana, and Stamina
	LabelSetText( "ShowStrLabelLabel", GetStringFromTid( SettingsWindow.TID.ShowStrLabel ) )
	ButtonSetCheckButtonFlag( "ShowStrLabelButton", true )
	
	-- Tooltips
	LabelSetText( "TooltipsLabel", GetStringFromTid( SettingsWindow.TID.Tooltips ) )
	ButtonSetCheckButtonFlag( "TooltipsButton", true )
	
	-- Tip of the Day
	LabelSetText( "TipoftheDayLabel", GetStringFromTid( SettingsWindow.TID.TipoftheDay) )
	ButtonSetCheckButtonFlag( "TipoftheDayButton", true )
	
	-- Language
	LabelSetText( "SettingsOptionsLanguageLabel", GetStringFromTid( SettingsWindow.TID.Language ) )
	
	for lan = 1, SettingsWindow.NUM_LANGUAGES do
		local text = GetStringFromTid( SettingsWindow.Languages[lan].tid )
		ComboBoxAddMenuItem( "SettingsOptionsLanguageCombo", L""..text )
	end
	
	-- Show Names
	LabelSetText( "SettingsOptionsShowNamesLabel", GetStringFromTid( SettingsWindow.TID.ShowNames )..L":" )
	for sn = 1, SettingsWindow.NUM_SHOWNAMES do
		local text = GetStringFromTid( SettingsWindow.ShowNames[sn].tid )
		ComboBoxAddMenuItem( "SettingsOptionsShowNamesCombo", L""..text )
	end
	
	-- Object Handle Filter
	LabelSetText( "SettingsOptionsObjHandleFilterLabel", L""..GetStringFromTid( SettingsWindow.TID.ObjectHandleFilter )..L":" )
	for filter = 1, SettingsWindow.NUM_OBJHANDLE_FILTERS do
		local text = GetStringFromTid( SettingsWindow.ObjectHandles[filter].tid )
		ComboBoxAddMenuItem( "SettingsOptionsObjHandleFilterCombo", L""..text )
	end
	
	-- Object Handle Quantity
	LabelSetText( "SettingsOptionsObjHandleSizeLabel", L""..GetStringFromTid( SettingsWindow.TID.ObjectHandleQuantity )..L":" )
	for indexSize, objHandleSize in pairs( SettingsWindow.ObjectHandleSizes )do
		--( -1 )is considered max size
		local text = SettingsWindow.ObjectHandleSizes[indexSize]
		if( objHandleSize == -1 )then
			text = GetStringFromTid( 1077866 )-- "All"
		end
		ComboBoxAddMenuItem( "SettingsOptionsObjHandleSizeCombo", L""..text )
	end
	
	-- Show Chat Windows
	LabelSetText( "ShowChatWindowLabel", GetStringFromTid( SettingsWindow.TID.ShowChatWindow ) )
	ButtonSetCheckButtonFlag( "ShowChatWindowButton", true )
		
	-- Overhead Chat
	LabelSetText( "OverheadChatLabel", GetStringFromTid( SettingsWindow.TID.OverheadChat ) )
	ButtonSetCheckButtonFlag( "OverheadChatButton", true )
	
	-- Overhead Chat Fade Delay
	LabelSetText( "OverheadChatFadeDelayLabel", GetStringFromTid( SettingsWindow.TID.OverheadChatFadeDelay )..L":" )
	for delay = 1, SettingsWindow.NUM_DELAY_VALUES do
		local text = GetStringFromTid( SettingsWindow.DelayValues[delay] )
		ComboBoxAddMenuItem( "OverheadChatFadeDelayCombo", L""..text )
	end
	
	-- Legacy --
		
	-- Legacy Chat
	LabelSetText( "LegacyChatLabel", GetStringFromTid( SettingsWindow.TID.LegacyChat ) )
	ButtonSetCheckButtonFlag( "LegacyChatButton", true )
	
	-- Use Legacy Container Art
	LabelSetText( "SettingsLegacyUseLegacyContainersLabel", GetStringFromTid( SettingsWindow.TID.UseLegacyContainers ) )
	ButtonSetCheckButtonFlag( "SettingsLegacyUseLegacyContainersButton", true )
	
	LabelSetText( "SettingsLegacyLegacyTargetingLabel", GetStringFromTid( SettingsWindow.TID.LegacyTargeting ) )
	ButtonSetCheckButtonFlag( "SettingsLegacyLegacyTargetingButton", true )
	
	-- Update the settings
	SettingsWindow.UpdateSettings()
			
	-- Update the scroll window
	ScrollWindowSetOffset( "SettingsGraphicsWindow", 0 )
	ScrollWindowUpdateScrollRect( "SettingsGraphicsWindow" )
	ScrollWindowSetOffset( "SettingsKeyBindingsWindow", 0 )
	ScrollWindowUpdateScrollRect( "SettingsKeyBindingsWindow" )
	ScrollWindowSetOffset( "SettingsSoundWindow", 0 )
	ScrollWindowUpdateScrollRect( "SettingsSoundWindow" )
	ScrollWindowSetOffset( "SettingsOptionsWindow", 0 )
	ScrollWindowUpdateScrollRect( "SettingsOptionsWindow" )
	ScrollWindowSetOffset( "SettingsLegacyWindow", 0 )
	ScrollWindowUpdateScrollRect( "SettingsLegacyWindow" )
	
	-- Call backs
	WindowRegisterEventHandler( "SettingsWindow", SystemData.Events.USER_SETTINGS_UPDATED, "SettingsWindow.UpdateSettings" )
	WindowRegisterEventHandler( "SettingsWindow", SystemData.Events.INTERFACE_KEY_RECORDED, "SettingsWindow.KeyRecorded" )
	WindowRegisterEventHandler( "SettingsWindow", SystemData.Events.INTERFACE_KEY_CANCEL_RECORD, "SettingsWindow.KeyCancelRecord" )
	WindowRegisterEventHandler( "SettingsWindow", SystemData.Events.TOGGLE_USER_PREFERENCE, "SettingsWindow.ToggleSettingsWindow" )
	
	-- Profanity --
	LabelSetText( "BadWordFilterOptionLabel", GetStringFromTid( SettingsWindow.TID.FilterObscenity ) )
	ButtonSetStayDownFlag( "BadWordFilterOptionButton", true )
	ButtonSetCheckButtonFlag( "BadWordFilterOptionButton", true )

	LabelSetText( "IgnoreListOptionLabel", GetStringFromTid( SettingsWindow.TID.IgnorePlayers ) )
	ButtonSetStayDownFlag( "IgnoreListOptionButton", true )
	ButtonSetCheckButtonFlag( "IgnoreListOptionButton", true )

	ButtonSetText( "IgnoreListAddButton", L"Add" )
	ButtonSetText( "IgnoreListDeleteButton", L"Delete" )

	SettingsWindow.PopulateProfanityList()

	-- THESE ELEMENTS ARE NOT READY FOR THIS MILESTONE 3/23/2007. RESTORE THE FOLLOWING LINES AS THEY BECOME AVAILABLE!
	-- YOU WILL ALSO HAVE TO UNCOMMENT AND RE-ANCHOR THINGS IN THE XML!
	-- And you'll also need to restore the commented out LabelSetText functions for them
	-- WindowSetShowing( "Pathfinding", false )
	-- WindowSetShowing( "Movie", false )
	-- WindowSetShowing( "ObjectHandles", false )
	-- WindowSetShowing( "ChatWindowFadeDelaySliderBar", false )
	-- WindowSetShowing( "OverheadChatFadeDelaySliderBar", false )
	-- WindowSetShowing( "TooltipDelayLabel", false )
	-- WindowSetShowing( "TooltipDelayDelaySliderBar", false )

end

function SettingsWindow.ResetScrollWheelOptions()
	SettingsWindow.RefreshScrollWheelComboBoxes()
	
	ComboBoxSetSelectedMenuItem( "SettingsKeyBindingsScrollWheelUpCombo", 1 ) -- Default case
	ComboBoxSetSelectedMenuItem( "SettingsKeyBindingsScrollWheelDownCombo", 2 ) -- Default case
end

function SettingsWindow.RefreshScrollWheelComboBoxes()
	local scrollWheelBehaviors = SettingsWindow.ScrollWheelBehaviors
	local numScrollWheelBehaviors = SettingsWindow.NUM_SCROLLWHEELBEHAVIORS
	if ( ButtonGetPressedFlag( "SettingsLegacyLegacyTargetingButton" ) == true) then
		scrollWheelBehaviors = SettingsWindow.ScrollWheelBehaviors_Legacy
		numScrollWheelBehaviors = SettingsWindow.NUM_SCROLLWHEELBEHAVIORS_LEGACY
	end
	
	ComboBoxClearMenuItems( "SettingsKeyBindingsScrollWheelUpCombo" )
	for behavior = 1, numScrollWheelBehaviors do
		ComboBoxAddMenuItem( "SettingsKeyBindingsScrollWheelUpCombo", L""..GetStringFromTid( scrollWheelBehaviors[behavior].tid ) )
	end
		
	ComboBoxClearMenuItems( "SettingsKeyBindingsScrollWheelDownCombo" )
	for behavior = 1, numScrollWheelBehaviors do
		ComboBoxAddMenuItem( "SettingsKeyBindingsScrollWheelDownCombo", L""..GetStringFromTid( scrollWheelBehaviors[behavior].tid ) )
	end
end

function SettingsWindow.ToggleSettingsWindow()	
	ToggleWindowByName( "SettingsWindow", "", MainMenuWindow.ToggleSettingsWindow )	
end

function SettingsWindow.UpdateSoundSettings()
	--Debug.PrintToDebugConsole( L"SettingsWindow.UpdateSoundSettings()!" )
	local masterVolume = math.floor( 100 * SliderBarGetCurrentPosition( "MasterVolumeSliderBar" ) )
	local effectsVolume = math.floor( 100 * SliderBarGetCurrentPosition( "EffectsVolumeSliderBar" ) )
	local musicVolume = math.floor( 100 * SliderBarGetCurrentPosition( "MusicVolumeSliderBar" ) )

	LabelSetText( "MasterVolumeVal", L""..masterVolume )
	LabelSetText( "EffectsVolumeVal", L""..effectsVolume )
	LabelSetText( "MusicVolumeVal", L""..musicVolume )
	
	-- using the same template for ui scale so update it in here
	local uiScale =( SliderBarGetCurrentPosition( "UiScaleSliderBar" )/2 )+ 0.5
	LabelSetText( "UiScaleVal", wstring.format( L"%2.2f", uiScale ) )
	local pdScale =( SliderBarGetCurrentPosition( "UiScalePDSliderBar" )/2 )+ 0.5
	LabelSetText( "UiScalePDVal", wstring.format( L"%2.2f", pdScale ) )
end

function SettingsWindow.UpdateSettings()

	SettingsWindow.PDScale = CustomSettings.LoadNumberValue( { settingName="PDScale", defaultValue=1.0 } )

	--Debug.Print( "SettingsWindow.UpdateSettings" )
	
	local text
	
	-- Resolution
	
	for res = 1, table.getn( SystemData.AvailableResolutions.widths )do 
		if( SystemData.Settings.Resolution.fullScreen.width == SystemData.AvailableResolutions.widths[res] and 
			SystemData.Settings.Resolution.fullScreen.height == SystemData.AvailableResolutions.heights[res] )then
			ComboBoxSetSelectedMenuItem( "SettingsGraphicsFullScreenResCombo", res )
		end 
	end
	
	ComboBoxSetSelectedMenuItem( "SettingsGraphicsFramerateMaxCombo", (SystemData.Settings.Resolution.framerateMax / 10) - 1 )
	
	ComboBoxSetSelectedMenuItem( "SettingsGraphicsParticleLODCombo", SystemData.Settings.Resolution.particleLOD )
	ComboBoxSetSelectedMenuItem( "SettingsGraphicsParticleFilterCombo", SystemData.Settings.Resolution.particleFilter+1 )
	ComboBoxSetSelectedMenuItem( "SettingsGraphicsAnimationCombo", SystemData.Settings.Optimization.frameSetRestriction+1 )
	
	ButtonSetPressedFlag( "SettingsGraphicsShowFrameButton", SystemData.Settings.Resolution.showWindowFrame )
	ButtonSetPressedFlag( "SettingsGraphicsShowShadowsButton", SystemData.Settings.Resolution.showShadows )
	ButtonSetPressedFlag( "SettingsGraphicsEnableVSyncButton", SystemData.Settings.Resolution.enableVSync )
	ButtonSetPressedFlag( "SettingsGraphicsCircleOfTransparencyButton", SystemData.Settings.GameOptions.circleOfTransEnabled )
	ButtonSetPressedFlag( "SettingsGraphicsUseFullscreenButton", SystemData.Settings.Resolution.useFullScreen )
	ButtonSetPressedFlag( "SettingsGraphicsPlayIdleAnimationButton", SystemData.Settings.Optimization.idleAnimation )
	ButtonSetPressedFlag( "SettingsGraphicsShowFoliageButton", SystemData.Settings.Resolution.displayFoliage )
	
	-- Legacy
	ButtonSetPressedFlag( "SettingsLegacyUseLegacyContainersButton", SystemData.Settings.Interface.LegacyContainers )
	ButtonSetPressedFlag( "LegacyChatButton", SystemData.Settings.Interface.LegacyChat )
	ButtonSetPressedFlag( "SettingsLegacyLegacyTargetingButton", SystemData.Settings.GameOptions.legacyTargeting )
	
	SliderBarSetCurrentPosition( "GammaSliderBar", SystemData.Settings.Resolution.gamma )
	LabelSetText( "GammaVal", wstring.format( L"%2.2f", SystemData.Settings.Resolution.gamma ) )
 
	--Language
	for lan = 1, SettingsWindow.NUM_LANGUAGES do 
		if( SystemData.Settings.Language.type == SettingsWindow.Languages[lan].id )then
			ComboBoxSetSelectedMenuItem( "SettingsOptionsLanguageCombo", lan )
		end
	end
	
	for sn = 1, SettingsWindow.NUM_SHOWNAMES do 
		if( SystemData.Settings.GameOptions.showNames == SettingsWindow.ShowNames[sn].id )then
			ComboBoxSetSelectedMenuItem( "SettingsOptionsShowNamesCombo", sn )
		end
	end

	local filter
	for filter = 1, SettingsWindow.NUM_OBJHANDLE_FILTERS do
		if( SystemData.Settings.GameOptions.objectHandleFilter == SettingsWindow.ObjectHandles[filter].id )then
			ComboBoxSetSelectedMenuItem( "SettingsOptionsObjHandleFilterCombo", filter )
		end
	end

	local skinItr
	for skinItr = 1, #SystemData.CustomUIList do
		if( SystemData.Settings.Interface.customUiName == SystemData.CustomUIList[skinItr] )then
			ComboBoxSetSelectedMenuItem( "CustomSkinsCombo", skinItr )
		end
	end
	
	local indexSize
	local objHandleSize
	for indexSize, objHandleSize in pairs( SettingsWindow.ObjectHandleSizes )do
		if( SystemData.Settings.GameOptions.objectHandleSize == objHandleSize )then
			ComboBoxSetSelectedMenuItem( "SettingsOptionsObjHandleSizeCombo", indexSize )
		end
	end
	
	if( SystemData.Settings.Interface.OverheadChatFadeDelay ~= nil )then
		ComboBoxSetSelectedMenuItem( "OverheadChatFadeDelayCombo", SystemData.Settings.Interface.OverheadChatFadeDelay )
	end
	
	-- Scroll Wheel Behavior
	SettingsWindow.RefreshScrollWheelComboBoxes()
	local scrollWheelBehaviors = SettingsWindow.ScrollWheelBehaviors
	local numScrollWheelBehaviors = SettingsWindow.NUM_SCROLLWHEELBEHAVIORS
	if ( ButtonGetPressedFlag( "SettingsLegacyLegacyTargetingButton" ) == true) then
		scrollWheelBehaviors = SettingsWindow.ScrollWheelBehaviors_Legacy
		numScrollWheelBehaviors = SettingsWindow.NUM_SCROLLWHEELBEHAVIORS_LEGACY
	end
	
	ComboBoxSetSelectedMenuItem( "SettingsKeyBindingsScrollWheelUpCombo", 1 ) -- Default case
	for behavior = 1, numScrollWheelBehaviors do
		if( SystemData.Settings.GameOptions.mouseScrollUpAction == scrollWheelBehaviors[behavior].id )then
			ComboBoxSetSelectedMenuItem( "SettingsKeyBindingsScrollWheelUpCombo", behavior )
		end
	end
	ComboBoxSetSelectedMenuItem( "SettingsKeyBindingsScrollWheelDownCombo", 1 ) -- Default case
	for behavior = 1, numScrollWheelBehaviors do
		if( SystemData.Settings.GameOptions.mouseScrollDownAction == scrollWheelBehaviors[behavior].id )then
			ComboBoxSetSelectedMenuItem( "SettingsKeyBindingsScrollWheelDownCombo", behavior )
		end
	end
	
    ComboBoxSetSelectedMenuItem( "ContainerViewCombo", 1)
	local containerMode = SystemData.Settings.Interface.defaultContainerMode
	for id, data in ipairs(SettingsWindow.ContainerViewOptions) do
	    if( data.name == containerMode ) then
	        ComboBoxSetSelectedMenuItem( "ContainerViewCombo", id)
	        break
	    end
	end
    
    ComboBoxSetSelectedMenuItem( "CorpseViewCombo", 1)
	local corpseMode = SystemData.Settings.Interface.defaultCorpseMode
	for id, data in ipairs(SettingsWindow.ContainerViewOptions) do
	    if( data.name == corpseMode ) then
	        ComboBoxSetSelectedMenuItem( "CorpseViewCombo", id)
	        break
	    end
	end	
	
	ButtonSetPressedFlag( "UiScaleToggleButton", SystemData.Settings.Interface.customUiScaleEnabled )
	SliderBarSetCurrentPosition( "UiScaleSliderBar", ( ( SystemData.Settings.Interface.customUiScale - 0.5 )*2 ) )
	LabelSetText( "UiScaleVal", wstring.format( L"%2.2f", SystemData.Settings.Interface.customUiScale ) )
	
	SliderBarSetCurrentPosition( "UiScalePDSliderBar", ( ( SettingsWindow.PDScale - 0.5 )*2 ) )
	LabelSetText( "UiScalePDVal", wstring.format( L"%2.2f", SettingsWindow.PDScale ) )

	ButtonSetPressedFlag( "BadWordFilterOptionButton", SystemData.Settings.Profanity.BadWordFilter )
	ButtonSetPressedFlag( "IgnoreListOptionButton", SystemData.Settings.Profanity.IgnoreListFilter )
	
	ButtonSetPressedFlag( "AlwaysRunButton", SystemData.Settings.GameOptions.alwaysRun )	
	ButtonSetPressedFlag( "QueryBeforeCriminalActionsButton", SystemData.Settings.GameOptions.queryBeforeCriminalAction )
	ButtonSetPressedFlag( "HoldShiftToUnstackButton", SystemData.Settings.GameOptions.holdShiftToUnstack )
	ButtonSetPressedFlag( "AlwaysAttackButton", SystemData.Settings.GameOptions.alwaysAttack )
	ButtonSetPressedFlag( "TooltipsButton", SystemData.Settings.Interface.showTooltips )
	ButtonSetPressedFlag( "TipoftheDayButton", SystemData.Settings.Interface.showTipoftheDay )
	ButtonSetPressedFlag( "ShowStrLabelButton", SystemData.Settings.GameOptions.showStrLabel )
	ButtonSetPressedFlag( "OverheadChatButton", SystemData.Settings.Interface.OverheadChat )
	ButtonSetPressedFlag( "ShowChatWindowButton", SystemData.Settings.Interface.ShowChatWindow )
	
	ButtonSetPressedFlag( "MasterVolumeToggleButton", SystemData.Settings.Sound.master.enabled )
	ButtonSetPressedFlag( "EffectsVolumeToggleButton", SystemData.Settings.Sound.effects.enabled )
	ButtonSetPressedFlag( "MusicVolumeToggleButton", SystemData.Settings.Sound.music.enabled )
	ButtonSetPressedFlag( "PlayFootstepsToggleButton", SystemData.Settings.Sound.footsteps.enabled )
	SliderBarSetCurrentPosition( "MasterVolumeSliderBar", SystemData.Settings.Sound.master.volume )
	SliderBarSetCurrentPosition( "EffectsVolumeSliderBar", SystemData.Settings.Sound.effects.volume )
	SliderBarSetCurrentPosition( "MusicVolumeSliderBar", SystemData.Settings.Sound.music.volume )
	
	SettingsWindow.UpdateKeyBindings()
	--SettingsWindow.OnApplyButton()
end

function SettingsWindow.UpdateKeyBindings()
	for key = 1, table.getn( SettingsWindow.Keybindings )do
		if( SettingsWindow.Keybindings[key].type ~= nil )then
			if( SettingsWindow.Keybindings[key].newValue ~= nil )then
				SystemData.Settings.Keybindings[SettingsWindow.Keybindings[key].type] = SettingsWindow.Keybindings[key].newValue
				SettingsWindow.Keybindings[key].newValue = nil
			end
			
			LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name .. "ActionValue", 255, 255, 255 )
			LabelSetText( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name.."ActionValue", SystemData.Settings.Keybindings[SettingsWindow.Keybindings[key].type] )
		end
	end	

	SettingsWindow.UpdateLegacyTargetBindingsText()
end

--When the Legacy or MMO Key Binding button has been selected, update the key binding to reflect the change
function SettingsWindow.OnDefaultKeyPressed()
	local buttonId = WindowGetId( WindowGetParent( SystemData.ActiveWindow.name ) )
	--Legacy Key Bindings have been selected
	if( buttonId == 1 )then
		local yesButton = { textTid = SettingsWindow.TID_YES, callback = function()SettingsWindow.ResetLegacyKeyBindings()end }
		local noButton = { textTid = SettingsWindow.TID_NO }
		local windowData = 
		{
			windowName = "Root", 
			titleTid = SettingsWindow.TID_INFO, 
			bodyTid = SettingsWindow.TID_RESETDEFAULTBINDINGS, 
			buttons = { yesButton, noButton }
		}
		UO_StandardDialog.CreateDialog( windowData )
		return
	end
	--MMO Key Bindings have been selected
	if( buttonId == 2 )then
		local yesButton = { textTid = SettingsWindow.TID_YES, callback = function()SettingsWindow.ResetMMOKeyBindings()end }
		local noButton = { textTid = SettingsWindow.TID_NO }
		local windowData = 
		{
			windowName = "Root", 
			titleTid = SettingsWindow.TID_INFO, 
			bodyTid = SettingsWindow.TID_RESETDEFAULTBINDINGS, 
			buttons = { yesButton, noButton }
		}
		UO_StandardDialog.CreateDialog( windowData )
		return
	end
	
end

--Set the key bindings to Legacy default
function SettingsWindow.ResetLegacyKeyBindings()
	ResetLegacyKeyBinding()
	
	for key = 1, table.getn( SettingsWindow.Keybindings )do
		if( SettingsWindow.Keybindings[key].type ~= nil )then
			local value = SystemData.Settings.DefaultKeybindings[SettingsWindow.Keybindings[key].type]
			if( value ~= nil )then
				SettingsWindow.Keybindings[key].newValue = value
				LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name .. "ActionValue", 255, 255, 255 )
				LabelSetText( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name.."ActionValue", value )
			end
		end
	end
	
	SettingsWindow.UpdateLegacyTargetBindingsText()
end

--Set the key bindings to MMO default
function SettingsWindow.ResetMMOKeyBindings()
	ResetMMOKeyBinding()
	
	for key = 1, table.getn( SettingsWindow.Keybindings )do
		if( SettingsWindow.Keybindings[key].type ~= nil )then
			local value = SystemData.Settings.DefaultKeybindings[SettingsWindow.Keybindings[key].type]
			if( value ~= nil )then
				SettingsWindow.Keybindings[key].newValue = value
				LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name .. "ActionValue", 255, 255, 255 )
				LabelSetText( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name.."ActionValue", value )
			end
		end
	end
	
	SettingsWindow.UpdateLegacyTargetBindingsText()
end

function SettingsWindow.UpdateLegacyTargetBindingsText()
	if( SystemData.Settings.GameOptions.legacyTargeting ) then
		for key = SettingsWindow.NON_LEGACY_BINDING_MIN, SettingsWindow.NON_LEGACY_BINDING_MAX do
			LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name .. "ActionValue", 128, 128, 128 )
			LabelSetText( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name.."ActionValue", GetStringFromTid(SettingsWindow.TID.NotAvailable) )
		end
	end
end

function SettingsWindow.OnOkayButton()
	SettingsWindow.OnApplyButton()

	-- Close the window		
	ToggleWindowByName( "SettingsWindow", "", nil )
end

function SettingsWindow.OnApplyButton()

	-- Set the Options
		
	local fullScreenRes = ComboBoxGetSelectedMenuItem( "SettingsGraphicsFullScreenResCombo" )
	SystemData.Settings.Resolution.fullScreen.width = SystemData.AvailableResolutions.widths[fullScreenRes]
	SystemData.Settings.Resolution.fullScreen.height = SystemData.AvailableResolutions.heights[fullScreenRes]
	
	SystemData.Settings.Resolution.framerateMax = ( ComboBoxGetSelectedMenuItem( "SettingsGraphicsFramerateMaxCombo" ) + 1 ) * 10
	
	SystemData.Settings.Resolution.showWindowFrame = ButtonGetPressedFlag( "SettingsGraphicsShowFrameButton" )
	SystemData.Settings.Resolution.showShadows = ButtonGetPressedFlag( "SettingsGraphicsShowShadowsButton" )
	SystemData.Settings.Resolution.enableVSync = ButtonGetPressedFlag( "SettingsGraphicsEnableVSyncButton" )
	SystemData.Settings.GameOptions.circleOfTransEnabled = ButtonGetPressedFlag( "SettingsGraphicsCircleOfTransparencyButton" )
	SystemData.Settings.Resolution.useFullScreen = ButtonGetPressedFlag( "SettingsGraphicsUseFullscreenButton" )
	SystemData.Settings.Optimization.idleAnimation = ButtonGetPressedFlag( "SettingsGraphicsPlayIdleAnimationButton" )
	SystemData.Settings.Resolution.displayFoliage = ButtonGetPressedFlag( "SettingsGraphicsShowFoliageButton" )

	SystemData.Settings.Resolution.gamma = SliderBarGetCurrentPosition( "GammaSliderBar" )
	
	SystemData.Settings.Resolution.particleLOD = ComboBoxGetSelectedMenuItem( "SettingsGraphicsParticleLODCombo" )
	SystemData.Settings.Resolution.particleFilter = ComboBoxGetSelectedMenuItem( "SettingsGraphicsParticleFilterCombo" )-1

	SystemData.Settings.Optimization.frameSetRestriction = ComboBoxGetSelectedMenuItem( "SettingsGraphicsAnimationCombo" )-1

	-- Language
	local languageIndex = ComboBoxGetSelectedMenuItem( "SettingsOptionsLanguageCombo" )
	SystemData.Settings.Language.type = SettingsWindow.Languages[languageIndex].id
	
	-- Show Names
	local showNamesIndex = ComboBoxGetSelectedMenuItem( "SettingsOptionsShowNamesCombo" )
	SystemData.Settings.GameOptions.showNames = SettingsWindow.ShowNames[showNamesIndex].id
	
	-- Sound 
	SystemData.Settings.Sound.master.enabled = ButtonGetPressedFlag( "MasterVolumeToggleButton" )
	SystemData.Settings.Sound.master.volume = SliderBarGetCurrentPosition( "MasterVolumeSliderBar" )
	
	SystemData.Settings.Sound.effects.enabled = ButtonGetPressedFlag( "EffectsVolumeToggleButton" )
	SystemData.Settings.Sound.effects.volume = SliderBarGetCurrentPosition( "EffectsVolumeSliderBar" )
	
	SystemData.Settings.Sound.music.enabled = ButtonGetPressedFlag( "MusicVolumeToggleButton" )
	SystemData.Settings.Sound.music.volume = SliderBarGetCurrentPosition( "MusicVolumeSliderBar" )

	SystemData.Settings.Sound.footsteps.enabled = ButtonGetPressedFlag( "PlayFootstepsToggleButton" )
	
	-- Options
	SystemData.Settings.GameOptions.alwaysRun = ButtonGetPressedFlag( "AlwaysRunButton" )
	SystemData.Settings.GameOptions.queryBeforeCriminalAction = ButtonGetPressedFlag( "QueryBeforeCriminalActionsButton" )
	SystemData.Settings.GameOptions.holdShiftToUnstack = ButtonGetPressedFlag( "HoldShiftToUnstackButton" )
	SystemData.Settings.GameOptions.alwaysAttack = ButtonGetPressedFlag( "AlwaysAttackButton" )
	SystemData.Settings.GameOptions.showStrLabel = ButtonGetPressedFlag( "ShowStrLabelButton" )
	
	-- Object Handle Filter
	local filterIndex = ComboBoxGetSelectedMenuItem( "SettingsOptionsObjHandleFilterCombo" )
	SystemData.Settings.GameOptions.objectHandleFilter = SettingsWindow.ObjectHandles[filterIndex].id
	
	local skinIndex = ComboBoxGetSelectedMenuItem( "CustomSkinsCombo" )
	SystemData.Settings.Interface.customUiName = SystemData.CustomUIList[skinIndex]
	
	local objHandleSize = ComboBoxGetSelectedMenuItem( "SettingsOptionsObjHandleSizeCombo" )
	SystemData.Settings.GameOptions.objectHandleSize = SettingsWindow.ObjectHandleSizes[objHandleSize]
	
	-- Interface
	SystemData.Settings.Interface.showTooltips = ButtonGetPressedFlag( "TooltipsButton" )
	SystemData.Settings.Interface.showTipoftheDay = ButtonGetPressedFlag( "TipoftheDayButton" )
	SystemData.Settings.Interface.ShowChatWindow = ButtonGetPressedFlag( "ShowChatWindowButton" )

	SystemData.Settings.Interface.OverheadChat = ButtonGetPressedFlag( "OverheadChatButton" )
	SystemData.Settings.Interface.OverheadChatFadeDelay = ComboBoxGetSelectedMenuItem( "OverheadChatFadeDelayCombo" )

	-- only update the scale if necesary
	local uiScale =( SliderBarGetCurrentPosition( "UiScaleSliderBar" )/2 )+ 0.5
	local scaleEnabled = ButtonGetPressedFlag( "UiScaleToggleButton" )
	local pdScale2 =( SliderBarGetCurrentPosition( "UiScalePDSliderBar" )/2 )+ 0.5
	SystemData.Settings.Interface.customUiScaleEnabled = scaleEnabled
	SystemData.Settings.Interface.customUiScale = uiScale
	SettingsWindow.PDScale = pdScale2
	CustomSettings.SaveNumberValue( { settingName="PDScale", settingValue=pdScale2 } )
	
    local selectedId = ComboBoxGetSelectedMenuItem( "ContainerViewCombo" )
    SystemData.Settings.Interface.defaultContainerMode = SettingsWindow.ContainerViewOptions[selectedId].name

    selectedId = ComboBoxGetSelectedMenuItem( "CorpseViewCombo" )
    SystemData.Settings.Interface.defaultCorpseMode = SettingsWindow.ContainerViewOptions[selectedId].name
    
    -- Legacy
    SystemData.Settings.Interface.LegacyChat = ButtonGetPressedFlag( "LegacyChatButton" )
    SystemData.Settings.Interface.LegacyContainers = ButtonGetPressedFlag( "SettingsLegacyUseLegacyContainersButton" )
    SystemData.Settings.GameOptions.legacyTargeting = ButtonGetPressedFlag( "SettingsLegacyLegacyTargetingButton" )

	-- Profanity
	SystemData.Settings.Profanity.BadWordFilter = ButtonGetPressedFlag( "BadWordFilterOptionButton" )
	SystemData.Settings.Profanity.IgnoreListFilter = ButtonGetPressedFlag( "IgnoreListOptionButton" )
	
	-- Key Bindings
	SettingsWindow.UpdateKeyBindings()
	
	-- Scroll Wheel Behavior
	local scrollWheelBehaviors = SettingsWindow.ScrollWheelBehaviors
	if ( ButtonGetPressedFlag( "SettingsLegacyLegacyTargetingButton" ) == true) then
		scrollWheelBehaviors = SettingsWindow.ScrollWheelBehaviors_Legacy
	end
	
	SystemData.Settings.GameOptions.mouseScrollUpAction = scrollWheelBehaviors[ComboBoxGetSelectedMenuItem( "SettingsKeyBindingsScrollWheelUpCombo" )].id
	SystemData.Settings.GameOptions.mouseScrollDownAction = scrollWheelBehaviors[ComboBoxGetSelectedMenuItem( "SettingsKeyBindingsScrollWheelDownCombo" )].id

	StatusWindow.ToggleStrLabel()
	
	-- push the new values to c++
	needsReload = UserSettingsChanged()
	
	if ( needsReload == true ) then
		InterfaceCore.ReloadUI()
	end
	
end

function SettingsWindow.ClearTempKeybindings()
	for key = 1, table.getn( SettingsWindow.Keybindings )do
		SettingsWindow.Keybindings[key].newValue = nil
	end
end

function SettingsWindow.OnResetButton()
	local okayButton = { textTid = UO_StandardDialog.TID_OKAY, callback = function()SettingsWindow.ClearTempKeybindings(); BroadcastEvent( SystemData.Events.RESET_SETTINGS_TO_DEFAULT ); end }
	local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL }
	local ResetConfirmWindow = 
	{
		windowName = "SettingsWindow", 
		titleTid = 1078994, 
		bodyTid = 1078995, 
		buttons = { okayButton, cancelButton }
	}
			
	UO_StandardDialog.CreateDialog( ResetConfirmWindow )
end

function SettingsWindow.OnCancelButton()

	-- Reload the current settings
	SettingsWindow.ClearTempKeybindings()
	SettingsWindow.UpdateSettings()
	
	-- Close the window		
	ToggleWindowByName( "SettingsWindow", "", nil )
end

function SettingsWindow.ClearTabStates()
	-- The pressed flag isn't being used for these tabs to decide color anymore
	ButtonSetPressedFlag( "SettingsWindowGraphicsTabButton", false )
	ButtonSetPressedFlag( "SettingsWindowKeyBindingsTabButton", false )
	ButtonSetPressedFlag( "SettingsWindowSoundTabButton", false )
	ButtonSetPressedFlag( "SettingsWindowOptionsTabButton", false )
	ButtonSetPressedFlag( "SettingsWindowLegacyTabButton", false )
	ButtonSetPressedFlag( "SettingsWindowProfanityTabButton", false )
	
	ButtonSetDisabledFlag( "SettingsWindowGraphicsTabButton", false )
	ButtonSetDisabledFlag( "SettingsWindowKeyBindingsTabButton", false )
	ButtonSetDisabledFlag( "SettingsWindowSoundTabButton", false )
	ButtonSetDisabledFlag( "SettingsWindowOptionsTabButton", false )
	ButtonSetDisabledFlag( "SettingsWindowLegacyTabButton", false )
	ButtonSetDisabledFlag( "SettingsWindowProfanityTabButton", false )
	
	WindowSetShowing( "SettingsWindowGraphicsTabButtonTab", true )
	WindowSetShowing( "SettingsWindowKeyBindingsTabButtonTab", true )
	WindowSetShowing( "SettingsWindowSoundTabButtonTab", true )
	WindowSetShowing( "SettingsWindowOptionsTabButtonTab", true )
	WindowSetShowing( "SettingsWindowLegacyTabButtonTab", true )
	WindowSetShowing( "SettingsWindowProfanityTabButtonTab", true )
	
	for index = 1, SettingsWindow.Modes.NUM_MODES do
		WindowSetShowing( SettingsWindow.Modes.windows[index], false )
	end	
end

function SettingsWindow.OpenGraphicsTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowGraphicsTabButton", true )
	WindowSetShowing( "SettingsWindowGraphicsTabButtonTab", false )
	WindowSetShowing( "SettingsGraphicsWindow", true )
end

function SettingsWindow.OpenKeyBindingsTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowKeyBindingsTabButton", true )
	WindowSetShowing( "SettingsWindowKeyBindingsTabButtonTab", false )
	WindowSetShowing( "SettingsKeyBindingsWindow", true )
	WindowSetShowing( "SettingsKeyDefaultWindow", true )
end

function SettingsWindow.OpenSoundTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowSoundTabButton", true )
	WindowSetShowing( "SettingsWindowSoundTabButtonTab", false )
	WindowSetShowing( "SettingsSoundWindow", true )
end

function SettingsWindow.OpenOptionsTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowOptionsTabButton", true )
	WindowSetShowing( "SettingsWindowOptionsTabButtonTab", false )
	WindowSetShowing( "SettingsOptionsWindow", true )
end

function SettingsWindow.OpenLegacyTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowLegacyTabButton", true )
	WindowSetShowing( "SettingsWindowLegacyTabButtonTab", false )
	WindowSetShowing( "SettingsLegacyWindow", true )
end

function SettingsWindow.OpenProfanityTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowProfanityTabButton", true )
	WindowSetShowing( "SettingsWindowProfanityTabButtonTab", false )
	WindowSetShowing( "SettingsProfanityWindow", true )
end

function SettingsWindow.OnKeyPicked()
	for key = 1, table.getn( SettingsWindow.Keybindings )do
		if( SystemData.ActiveWindow.name == "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name )then
			SettingsWindow.CurKeyIndex = key
		elseif( SystemData.Settings.GameOptions.legacyTargeting == true and key >= SettingsWindow.NON_LEGACY_BINDING_MIN and key <= SettingsWindow.NON_LEGACY_BINDING_MAX ) then
			LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name .. "Action", 255, 255, 255 )
			LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name .. "ActionValue", 128, 128, 128 )
		else
			LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name .. "Action", 255, 255, 255 )
			LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name .. "ActionValue", 255, 255, 255 )
		end
	end
		
	if ( SystemData.Settings.GameOptions.legacyTargeting == false or
	( SystemData.Settings.GameOptions.legacyTargeting == true and ( SettingsWindow.CurKeyIndex < SettingsWindow.NON_LEGACY_BINDING_MIN or SettingsWindow.CurKeyIndex > SettingsWindow.NON_LEGACY_BINDING_MAX) ) ) then
		--Debug.PrintToDebugConsole( L"Active Window: ".. StringToWString( SystemData.ActiveWindow.name ) )
		LabelSetTextColor( SystemData.ActiveWindow.name .. "Action", 250, 250, 0 )
		LabelSetTextColor( SystemData.ActiveWindow.name .. "ActionValue", 250, 250, 0 )
		
		WindowClearAnchors( "AssignHotkeyInfo" )
		WindowAddAnchor( "AssignHotkeyInfo", "topleft", SystemData.ActiveWindow.name.."ActionValue", "bottomleft", 0, -6 )
		WindowSetShowing( "AssignHotkeyInfo", true )	
		
		SettingsWindow.RecordingKey = true
		
		SystemData.IsRecordingSettings = true
		BroadcastEvent( SystemData.Events.INTERFACE_RECORD_KEY )
	end
end

function SettingsWindow.KeyRecorded()	
	if( SettingsWindow.RecordingKey == true )then
		local keyIndex = SettingsWindow.CurKeyIndex
		
		WindowSetShowing( "AssignHotkeyInfo", false )
		
		LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[keyIndex].name .. "Action", 255, 255, 255 )
		LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[keyIndex].name .. "ActionValue", 255, 255, 255 )
	
		if( SystemData.RecordedKey ~= L"" )then
			for index = 1, table.getn( SettingsWindow.Keybindings )do
				if( SettingsWindow.Keybindings[keyIndex].type ~= nil )then
					local value = SystemData.Settings.Keybindings[SettingsWindow.Keybindings[index].type]
					if( SettingsWindow.Keybindings[index].newValue ~= nil )then
						value = SettingsWindow.Keybindings[index].newValue
					end
					
					if( value == SystemData.RecordedKey )then
						SystemData.BindingConflictItemIndex = index
						SystemData.BindingConflictType = SystemData.BindType.BINDTYPE_SETTINGS
						break
					end
				end
			end
		end
		
		if( SystemData.BindingConflictType ~= SystemData.BindType.BINDTYPE_NONE )then
			body = GetStringFromTid( SettingsWindow.TID_BINDING_CONFLICT_BODY )..L"\n\n"..HotbarSystem.GetKeyName(SystemData.BindingConflictHotbarId, SystemData.BindingConflictItemIndex, SystemData.BindingConflictType)..L"\n\n"..GetStringFromTid( SettingsWindow.TID_BINDING_CONFLICT_QUESTION )
			
			local yesButton = { textTid = SettingsWindow.TID_YES,
								callback =	function()
											HotbarSystem.ReplaceKey(
												SystemData.BindingConflictHotbarId, SystemData.BindingConflictItemIndex, SystemData.BindingConflictType,
												0, keyIndex, SystemData.BindType.BINDTYPE_SETTINGS,
												SystemData.RecordedKey, L"")
											end
							  }
			local noButton = { textTid = SettingsWindow.TID_NO }
			local windowData = 
			{
				windowName = "SettingsWindow", 
				titleTid = SettingsWindow.TID_BINDING_CONFLICT_TITLE, 
				body = body, 
				buttons = { yesButton, noButton }
			}
			UO_StandardDialog.CreateDialog( windowData )
		else	
			SettingsWindow.Keybindings[keyIndex].newValue = SystemData.RecordedKey
			SettingsWindow.UpdateKeyBindings()
			
			BroadcastEvent( SystemData.Events.KEYBINDINGS_UPDATED )
		end
		
		SystemData.IsRecordingSettings = false
		SettingsWindow.RecordingKey = false
	end
end

function SettingsWindow.KeyCancelRecord()
	if( SettingsWindow.RecordingKey == true )then
		WindowSetShowing( "AssignHotkeyInfo", false )
		
		local keyIndex = SettingsWindow.CurKeyIndex
		LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[keyIndex].name .. "Action", 255, 255, 255 )
		LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[keyIndex].name .. "ActionValue", 255, 255, 255 )
		
		SystemData.IsRecordingSettings = false
		SettingsWindow.RecordingKey = false
	end
end

function SettingsWindow.OnIgnoreListAddButton()
	StartIgnoreListAdd()

	--hide the settings window and main menu window so player can pick something on screen	
	WindowSetShowing( "SettingsWindow", false )
	WindowSetShowing( "MainMenuWindow", false )
end

function SettingsWindow.ProfanityListUpdated()
	--the player has picked something, show the main menu and settings window
--	WindowSetShowing( "MainMenuWindow", true )
	WindowSetShowing( "SettingsWindow", true )

	SettingsWindow.PopulateProfanityList()
end

function SettingsWindow.PopulateProfanityList()
	-- local previousListItem -- Is there a reason this isn't in here?

	-- don't show the bad words for now
	local b = false -- NOTE: Due to layout changes on this gump, the bad words list will need re-anchoring if you set it to display!
	if b then
		-- clear bad words
			for i = 1, SettingsWindow.PreviousBadWordCount do
	--	 Debug.PrintToDebugConsole( L"destroy BadWord"..i )
			--hide instead of destroy because destroyWindow dosen't actually destroy it, it just puts it into the destroy queue
				WindowSetShowing( "BadWord"..i, false )
		end
		
		-- list all bad words
			local first = true
			SettingsWindow.PreviousBadWordCount = WindowData.BadWordListCount
			for i = 1, WindowData.BadWordListCount do
	--	 Debug.PrintToDebugConsole( L"create BadWord"..i )
				CreateWindowFromTemplate( "BadWord"..i, "BadWord", "SettingsBadWordFilter" )
				WindowSetShowing( "BadWord"..i, true )
				LabelSetText( "BadWord"..i, L"- "..WindowData.BadWordList[i] )
				if( first )then
					first = false
					WindowAddAnchor( "BadWord"..i, "topleft", "SettingsBadWordFilter", "topleft", 80, 110 )
				else
					WindowAddAnchor( "BadWord"..i, "bottomleft", previousListItem, "topleft", 0, 0 )
				end
	
				previousListItem = "BadWord"..i
			end
	end
	
	-- clear ignore list
		for i = 1, SettingsWindow.PreviousIgnoreListCount do
--	 Debug.PrintToDebugConsole( L"destroy IgnoreListItem"..i )
--	 Debug.PrintToDebugConsole( LabelGetText( "IgnoreListItem"..i ) )
		--hide instead of destroy because destroyWindow dosen't actually destroy it, it just puts it into the destroy queue
			WindowSetShowing( "IgnoreListItem"..i, false )
	end
	
	-- list all player in the ignore list
		first = true
		for i = 1, WindowData.IgnoreListCount do
--	 Debug.PrintToDebugConsole( L"create IgnoreListItem"..i )
--	 Debug.PrintToDebugConsole( L""..WindowData.IgnoreIdList[i]..L" "..WindowData.IgnoreNameList[i] )
			if i > SettingsWindow.PreviousIgnoreListCount then
			CreateWindowFromTemplate( "IgnoreListItem"..i, "IgnoreListItem", "SettingsBadWordFilter" )
		else
			WindowClearAnchors( "IgnoreListItem"..i )
		end
			WindowSetShowing( "IgnoreListItem"..i, true )
			LabelSetText( "IgnoreListItem"..i, L"- "..WindowData.IgnoreNameList[i] )
			if( first )then
				first = false
				WindowAddAnchor( "IgnoreListItem"..i, "bottomleft", "IgnoreListAddButton", "topleft", 0, 10 )
			else
				WindowAddAnchor( "IgnoreListItem"..i, "bottomleft", previousListItem, "topleft", 0, 0 )
			end

			previousListItem = "IgnoreListItem"..i
		end
		SettingsWindow.PreviousIgnoreListCount = WindowData.IgnoreListCount

		ScrollWindowUpdateScrollRect( "SettingsProfanityWindow" )	
end

function SettingsWindow.OnIgnoreListDeleteButton()
	if SettingsWindow.CurIgnoreListIdx == -1 then
		return
	end

	local idx = SettingsWindow.CurIgnoreListIdx
	Debug.PrintToDebugConsole( L"current idx "..idx )
	local id = WindowData.IgnoreIdList[idx]
	Debug.PrintToDebugConsole( L"id at idx "..id )
	DeleteFromIgnoreList( id )
	SettingsWindow.CurIgnoreListIdx = -1
	SettingsWindow.PopulateProfanityList()
end

function SettingsWindow.OnIgnoreListItemClicked()
	for i = 1, WindowData.IgnoreListCount do
		LabelSetTextColor( "IgnoreListItem"..i, 255, 255, 255 )
		if( SystemData.ActiveWindow.name == "IgnoreListItem"..i )then
			SettingsWindow.CurIgnoreListIdx = i
		end
	end

	LabelSetTextColor( SystemData.ActiveWindow.name, 250, 250, 0 )
end

function SettingsWindow.UpdateGammaVal()
	local gamma = SliderBarGetCurrentPosition( "GammaSliderBar" )
	LabelSetText( "GammaVal", wstring.format( L"%2.2f", gamma ) )
	
	Debug.Print("Framerate max: "..SystemData.Settings.Resolution.framerateMax)
end

function SettingsWindow.OnShowResetLegacyDialog()
	if( ButtonGetPressedFlag( "LegacyChatButton" )== true )then
		local yesButton = { textTid = SettingsWindow.TID_YES, callback = function()SettingsWindow.ResetLegacyKeyBindings()end }
		local noButton = { textTid = SettingsWindow.TID_NO }
		local windowData = 
		{
			windowName = "Root", 
			titleTid = SettingsWindow.TID_INFO, 
			bodyTid = SettingsWindow.TID_RESETLEGACYBINDINGS_CHAT, 
			buttons = { yesButton, noButton }
		}
		UO_StandardDialog.CreateDialog( windowData )	 
	end
end

function SettingsWindow.LegacyTargetingButtonOnLButtonUp()
	SettingsWindow.ResetScrollWheelOptions()
end