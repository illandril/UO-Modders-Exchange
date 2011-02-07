----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

GenericGump = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
 
----------------------------------------------------------------
-- GenericGump Functions
----------------------------------------------------------------

function GenericGump.OnClicked()
    local gumpId = WindowGetId(SystemData.ActiveWindow.name)
    local windowName = SystemData.ActiveWindow.name
    
    GenericGumpOnClicked(gumpId, windowName)
end

function GenericGump.OnDoubleClicked()
    local gumpId = WindowGetId(SystemData.ActiveWindow.name)
    local windowName = SystemData.ActiveWindow.name
    
    GenericGumpOnDoubleClicked(gumpId, windowName)
end

function GenericGump.OnRClicked()
    local gumpId = WindowGetId(SystemData.ActiveWindow.name)
    
    GenericGumpOnRClicked(gumpId)    
end

function GenericGump.OnMouseOver()
	local gumpId = WindowGetId(SystemData.ActiveWindow.name)
    local windowName = SystemData.ActiveWindow.name
    
    tooltipId = GenericGumpGetToolTipId(gumpId, windowName)
    
    if( tooltipId ~= nil and tooltipId ~= 0 ) then
		text = GetStringFromTid(tooltipId)
		Tooltips.CreateTextOnlyTooltip(windowName, text)
		Tooltips.Finalize()
		Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	else
		--Debug.Print(L"Tooltip data was nil")
    end
end

function GenericGump.OnHyperLinkClicked(link)
    OpenWebBrowser(WStringToString(link))
end