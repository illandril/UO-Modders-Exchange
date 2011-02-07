----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

UO_DefaultWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

UO_DefaultWindow.WindowDestroyQueue = {}

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------


-- OnInitialize Handler
function UO_DefaultWindow.Initialize()
	--Debug.Print(SystemData.ActiveWindow.name)
	if SystemData.ActiveWindow.name == "DebugWindowChrome" then
		WindowSetAlpha(SystemData.ActiveWindow.name.."_UO_DefaultWindowBackground", 1)
	else
		WindowSetAlpha(SystemData.ActiveWindow.name.."_UO_DefaultWindowBackground", 0.8)
	end	
end

function UO_DefaultWindow.CloseDialog()
	local activeDialog = WindowUtils.GetActiveDialog()	
	--If the On Close Callback is not nil that means the window has a call back function they want to run before
	--the window closes
	if( Interface.OnCloseCallBack[activeDialog] ~= nil) then
		Interface.OnCloseCallBack[activeDialog]()
	end
	
	if DoesWindowNameExist( activeDialog ) then
		--ButtonSetPressedFlag(activeDialog.."_UO_WindowCloseButton", false)	
		if( Interface.DestroyWindowOnClose[activeDialog] ~= nil ) then
			DestroyWindow(activeDialog)
		else
			WindowSetShowing(activeDialog, false)
		end

	end
end

function UO_DefaultWindow.CloseTooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1052061))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function UO_DefaultWindow.CloseParent()
    WindowSetShowing(WindowGetParent(SystemData.ActiveWindow.name), false)
end
