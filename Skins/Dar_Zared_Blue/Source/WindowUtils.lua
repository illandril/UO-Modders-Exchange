----------------------------------------------------------------
-- WindowUtil Global Variables
----------------------------------------------------------------
WindowUtils = {}


WindowUtils.resizing = false
WindowUtils.resizeWindow = nil
WindowUtils.resizeAnchor = ""
WindowUtils.resizeEndCallback = nil
WindowUtils.resizeMin = { x=0, y=0 }

WindowUtils.DRAG_PICKUP_TIME = 3 -- 3 Seconds
WindowUtils.DRAG_DISTANCE = 5 -- 5 Pixels
WindowUtils.dragging = false
WindowUtils.dragCallback = nil
WindowUtils.dragData = nil
WindowUtils.dragTime = 0
WindowUtils.dragX = nil
WindowUtils.dragY = nil

WindowUtils.openWindows = {}
WindowUtils.trackSize = {}

WindowUtils.FONT_DEFAULT_TEXT_LINESPACING = 20
WindowUtils.FONT_DEFAULT_SUB_HEADING_LINESPACING = 22

----------------------------------------------------------------
-- WindowUtil Functions
----------------------------------------------------------------


function WindowUtils.Initialize()

	-- Create the Util Windows
	
	CreateWindow( "ResizingWindowFrame", false )
	
	WindowRegisterEventHandler( "ResizingWindowFrame", SystemData.Events.L_BUTTON_UP_PROCESSED, "WindowUtils.OnLButtonUp")	
end


function WindowUtils.Update( timePassed )

	-- Update the resize frame
	if( WindowUtils.resizing ) then
		local x, y = WindowGetDimensions( "ResizingWindowFrame" )
		local resize = false;
		
		if( x < WindowUtils.resizeMin.x  ) then
			x = WindowUtils.resizeMin.x
			resize = true
		end
		if( y < WindowUtils.resizeMin.y ) then
			y = WindowUtils.resizeMin.y
			resize = true
		end
		
		if( resize ) then
			--Debug.PrintToDebugConsole(L"Resizing: "..x..L", "..y )
			WindowSetDimensions( "ResizingWindowFrame", x, y )
		end
    elseif( WindowUtils.dragging ) then
        WindowUtils.dragTime = WindowUtils.dragTime - timePassed
			
		local mouseDistanceX = math.abs(WindowUtils.dragX - SystemData.MousePosition.x)
		local mouseDistanceY = math.abs(WindowUtils.dragY - SystemData.MousePosition.y)
		if( WindowUtils.dragTime <= 0 or mouseDistanceX > WindowUtils.DRAG_DISTANCE or mouseDistanceY > WindowUtils.DRAG_DISTANCE ) then        
            WindowUtils.dragCallback(WindowUtils.dragData)
            WindowUtils.dragging = false
        end
	end
	
	SnapUtils.SnapUpdate(timePassed)
end

function WindowUtils.BeginResize( windowName, anchorCorner, minX, minY, lockRatio, endCallback )
    --Debug.Print("WindowUtils.BeginResize: "..tostring(windowName)..", "..tostring(anchorCorner)..", "..tostring(minX)..", "..tostring(minY)..", "..tostring(lockRatio)..", "..tostring(endCallback) )
    if ( WindowUtils.resizing ) then
        return
    end

    -- Anchor the resizing frame to the window
    local width, height = WindowGetDimensions( windowName )
    
    WindowSetDimensions( "ResizingWindowFrame", width, height )
    
    WindowAddAnchor( "ResizingWindowFrame", anchorCorner, windowName, anchorCorner, 0, 0 )

    WindowSetResizing( "ResizingWindowFrame", true, anchorCorner, lockRatio );
    WindowSetShowing( "ResizingWindowFrame", true )
    
    WindowUtils.resizing = true
    WindowUtils.resizeWindow = windowName
    WindowUtils.resizeAnchor = anchorCorner
    WindowUtils.resizeMin.x = minX
    WindowUtils.resizeMin.y = minY
    WindowUtils.resizeEndCallback = endCallback
	--Debug.PrintToDebugConsole(L"BeginResize: "..minX..L", "..minY )
end 

function WindowUtils.BeginDrag( callback, data )
    WindowUtils.dragging = true
    WindowUtils.dragCallback = callback
    WindowUtils.dragData = data
    WindowUtils.dragTime = WindowUtils.DRAG_PICKUP_TIME
    WindowUtils.dragX = SystemData.MousePosition.x
    WindowUtils.dragY = SystemData.MousePosition.y
end

function WindowUtils.EndDrag( )
	WindowUtils.dragging = false
end

function WindowUtils.OnLButtonUp( flags, x, y )

	-- End the resize
	if( WindowUtils.resizing ) then
        if ( not WindowUtils.resizing ) then
            return
        end

        local width, height = WindowGetDimensions( "ResizingWindowFrame" )
        local posX, posY = WindowGetScreenPosition( "ResizingWindowFrame"  )
        local scale      = WindowGetScale( WindowUtils.resizeWindow )
          
        -- Detatch and Hide the Resizing Frame  
        WindowSetResizing( "ResizingWindowFrame", false, "", false );
        WindowClearAnchors( "ResizingWindowFrame" )
        WindowSetShowing( "ResizingWindowFrame", false )    
         
        -- Assign the settings to the new window
        WindowSetDimensions( WindowUtils.resizeWindow, width, height )      
        
        WindowClearAnchors( WindowUtils.resizeWindow )
        WindowAddAnchor( WindowUtils.resizeWindow, "topleft", "Root", "topleft", posX/scale, posY/scale )            
        
        if( WindowUtils.resizeEndCallback ~= nil ) then
            WindowUtils.resizeEndCallback(WindowUtils.resizeWindow)
            WindowUtils.resizeEndCallback = nil
        end
        
        -- Clear the Resizing Data
        WindowUtils.resizing = false
        WindowUtils.resizeWindow = nil
        WindowUtils.resizeAnchor = nil        
    elseif( WindowUtils.dragging ) then
        WindowUtils.dragging = false
	end
end

function WindowUtils.GetTopmostDialog(wndName)
	if( wndName == nil ) or (wndName == "") then 
		Debug.Print("WindowUtils.GetTopmostDialog: Active dialog is nil or empty!") 
        return 
    end
	parent = wndName
	repeat
		wnd = parent
		parent = WindowGetParent(wnd)
		if( parent == nil ) then
		    Debug.Print("WindowUtils.GetTopmostDialog: someone's parent is nil or empty!") 
		    return
		end
	until (parent == "Root") 
	
    return wnd
end

function WindowUtils.GetActiveDialog()
	return WindowUtils.GetTopmostDialog(SystemData.ActiveWindow.name)
end

function WindowUtils.SetActiveDialogTitle(title)
	if( WindowUtils.GetActiveDialog() == nil ) then
		Debug.Print("WindowUtils.SetActiveDialogTitle: Active dialog is nil!")
		return
	end

	WindowUtils.SetWindowTitle(WindowUtils.GetActiveDialog(),title)
end

function WindowUtils.SetWindowTitle(window,title)
    --Debug.Print("WindowUtils.SetWindowTitle: "..tostring(window).." title: "..tostring(title))
    
	if not title or not window  or title == "" then
		return
	end

	--title = wstring.upper(title)
	

	-- *** TESTING
	if type(title) ~= "wstring" then
		Debug.Print("*** ERROR: window title is of type " .. type(title))
	end
	-- *** END TESTING
	
	if type(title) == "string" then
	    title = StringToWString(title)	
	end	
	
	
	--local label = window.."Chrome_UO_TitleBar_WindowTitle"
	--LabelSetText(label, title)
	WindowUtils.FitTextToLabel(window, title, true)
end

function WindowUtils.RetrieveWindowSettings()
	-- update the positions for any window thats currently open
	for window, type in pairs(WindowUtils.openWindows) do
		WindowUtils.RestoreWindowPosition(window, false)
	end
end

function WindowUtils.SendWindowSettings()
	-- save the positions for any window thats currently open
	for window, type in pairs(WindowUtils.openWindows) do
		WindowUtils.SaveWindowPosition(window, false) 
	end
end

function WindowUtils.RestoreWindowPosition(window, trackSize, alias)
	local windowPositions = SystemData.Settings.Interface.WindowPositions
	local index = nil

	--if no explicit alias, then use actual window name:
	if not alias then
		alias = window
	end
	
	for i, windowName in pairs(SystemData.Settings.Interface.WindowPositions.Names) do
		if( alias == windowName ) then
			index = i
			break
		end
	end
	
	if( index ~= nil ) then
		local x = SystemData.Settings.Interface.WindowPositions.WindowPosX[index]
		local y = SystemData.Settings.Interface.WindowPositions.WindowPosY[index]
		
		-- make sure this window is on screen!
	    local winWidth, winHeight = WindowGetDimensions(window)
	    local resy = SystemData.screenResolution.y / InterfaceCore.scale
	    local resx = SystemData.screenResolution.x / InterfaceCore.scale
	    if( x + winWidth < 0 ) then
	        x = 0
	    elseif( x > resx ) then
	        x = resx - winWidth
	    end
	    
	    if( y + winHeight < 0 ) then
	        y = 0
	    elseif( y > resy ) then
	        y = resy - winHeight
	    end
	    
		if( x ~= nil and y ~= nil ) then
			--Debug.Print("RestoreWindowPosition: " .. alias)
			WindowClearAnchors(window)
			WindowAddAnchor(window, "topleft","Root" , "topleft", x, y)	
		end
		
		if( trackSize == true ) then
			local width = SystemData.Settings.Interface.WindowPositions.WindowWidth[index]
			local height = SystemData.Settings.Interface.WindowPositions.WindowHeight[index]
			if( width ~= nil and height ~= nil and width ~= 0 and height ~= 0 ) then
				WindowSetDimensions(window,width,height)
			end
		end
	end		
	WindowUtils.openWindows[alias] = true
	WindowUtils.trackSize[alias] = trackSize
end

function WindowUtils.SaveWindowPosition(window, closing, alias)

	--if no explicit alias, then use actual window name:
	if not alias then
		alias = window
	end
	
	-- always save the position if its in the list
	if( WindowUtils.openWindows[alias] == true) then
		local x, y = WindowGetScreenPosition(window)
        x = math.floor( x/InterfaceCore.scale + 0.5 )
        y = math.floor( y/InterfaceCore.scale + 0.5 )
        
		local width, height = WindowGetDimensions(window)
		local windowPositions = SystemData.Settings.Interface.WindowPositions
		
		local index = nil
		for i, windowName in pairs(windowPositions.Names) do
			if( alias == windowName ) then
				index = i
				break
			end
		end
		
		-- if it doesnt exist yet then add it
		if( index == nil ) then
			index = table.getn(windowPositions.Names) + 1
			windowPositions.Names[index] = alias
		end	
		
		windowPositions.WindowPosX[index] = x
		windowPositions.WindowPosY[index] = y
		
		if( WindowUtils.trackSize[alias] == true ) then
			windowPositions.WindowWidth[index] = width
			windowPositions.WindowHeight[index] = height
		else
			windowPositions.WindowWidth[index] = 0
			windowPositions.WindowHeight[index] = 0
		end
		
		--Debug.Print("SAVING POSITION: x="..x.." y="..y)
		
		-- the closing bool is true by default
		if( closing == true or closing == nil ) then
			WindowUtils.openWindows[alias] = nil
			WindowUtils.trackSize[alias] = true
		end
	end
end

function WindowUtils.ClearWindowPosition(window)
	local windowPositions = SystemData.Settings.Interface.WindowPositions

	local index = nil
	for i, windowName in pairs(windowPositions.Names) do
		if( window == windowName ) then
			index = i
			break
		end
	end	
	
	if( index ~= nil ) then
		-- shift all the elements up
		local lastElement = table.getn(windowPositions.Names)
		for index2 = index + 1, lastElement do
			local previous = index2 - 1
			windowPositions.Names[previous] = windowPositions.Names[index2]
			windowPositions.WindowWidth[previous] = windowPositions.WindowWidth[index2]
			windowPositions.WindowHeight[previous] = windowPositions.WindowHeight[index2]
			windowPositions.WindowWidth[previous] = windowPositions.WindowWidth[index2]
			windowPositions.WindowHeight[previous] = windowPositions.WindowHeight[index2]
		end
		windowPositions.Names[lastElement] = nil
		windowPositions.WindowWidth[lastElement] = nil
		windowPositions.WindowHeight[lastElement] = nil
		windowPositions.WindowWidth[lastElement] = nil
		windowPositions.WindowHeight[lastElement] = nil		
	end
	
	WindowUtils.openWindows[window] = nil
	WindowUtils.trackSize[window] = nil
end

-- replaces HTML markup tags where possible
--   and strips out all others
-- 
-- str is  of type wstring
--
-- Current substitutions are:
--   <BR>  -->  single carriage return
--   <P>  -->  double carriage return
--   <center>-----</center>  -->  deleted 
--   anything else between < >  -->  deleted 
--
-- NOTE: LuaPlus has some bugginess with wstring routines, e.g. gsub returning
--    the string as ASCII instead of unicode, particularly if the return string is empty
--
function WindowUtils.translateMarkup(str)

	--gsub function doesn't work on empty source strings.
	if(str == L"" or str == "") then 
		return L""
	end	
	str = wstring.gsub(str, L"<[Bb][Rr]>", L"\n")
	if str == L"" or str == "" then 
		return L""
	end	
	str = wstring.gsub(str, L"<[Pp]>", L"\n\n")
	if str == L"" or str == "" then 
		return L""
	end	
	str = wstring.gsub(str, L"<center>-----</center>", L"\n\n")
--	str = wstring.gsub(str, L"<center>-----</center>", L"\n     ___________________\n")
	if str == L"" or str == "" then 
		return L""
	end	
	
	str = WindowUtils.translateLinkTag(str)
	
	str = wstring.gsub(str, L"<.->", L"")

	if str == L"" or str == "" then 
		return L""
	end	

	-- *** NOTE: this is the correct replaced of the above line once wstring.gsub works with captures. 
	--   For now we use KLUDGE2a and KLUDGE2b
	--[[
	str = wstring.gsub(str, L"<(.-)>", function(tag) 
											if wstring.sub(tag,1,4) == L"LINK" then 
												return  L"<"..tag..L">"
											else
												return  L""
											end
										end
						)
	--]]
	
	-- *** KLUDGE2b - because the above gsub isn't properly returning any value other than ""
	-- we used KLUDGE2a in translateLinkTag to surrounded the LINK tag with {}.  So here we change it back
	--
	local KLUDGED_LINK_TAG = L"{LINK(.-)}"
	
	local linkBody = wstring.match(str, KLUDGED_LINK_TAG)
	if type(linkBody) == "wstring" then
		str = wstring.gsub(str, KLUDGED_LINK_TAG, L"<LINK"..linkBody..L">" )
	end
	-- END KLUDGE2b
	
	if str == "" then 
		return L""
	end	
	
	return str 
end


-- WindowUtils.translateLinkTag
--   Translates our legacy code link tag to the KR link tag
--
-- the legacy client uses something like <A HREF="some url">text</A> for it's link tag 
--
-- our new style of link tags is currently NEW_LINK_TAG = L"<LINK=%1,%2>", but
-- in the future it may change to L"<LINK data=\"%1\" text=\"%2\" />"
--
function WindowUtils.translateLinkTag(str)

	local LEGACY_LINK_TAG = L"<[Aa]%s+[Hh][Rr][Ee][Ff]%s*=%s*\"(.-)\">(.-)</[Aa]>"
	
	-- *** KLUDGE - wstring.gsub is not setting the captures corrrectly, so I'm extracting the captures
	--  with  wstring.match and manually inserting them into NEW_LINK_TAG
	--
	local dataCapture, textCapture = wstring.match(str, LEGACY_LINK_TAG)
	if type(dataCapture) ~= "wstring" or type(textCapture) ~= "wstring" then
		return str
	end

	-- *** KLUDGE2a - because we do a final wstring.gsub(str, L"<.->", L"") and using a function as the
	-- third argument isn't working, we use {} instead of <> to surroudn the link tag and change them later
	--local NEW_LINK_TAG = L"{LINK data=\""..dataCapture..L"\" text=\""..textCapture..L"\" /}"
	local NEW_LINK_TAG = L"{LINK="..dataCapture..L","..textCapture..L"}"
	-- END KLUDGE2a
	
	-- END KLUDGE
	
	str = wstring.gsub(str, LEGACY_LINK_TAG, NEW_LINK_TAG)
	if str == "" then 
		return L""
	end	
	
	return str 
end



-- Add commas to a number : i.e. 1000000 becomes 1,000,000
--
-- str needs to be a wstring 
-- returns a wstring
-- 
function WindowUtils.AddCommasToNumber (str)
  local str2 = tostring(tonumber(str))
  local formatted = str2
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return (StringToWString(formatted))
end


-- currently only handles the case of http links bringing up the web browser but
--	 we could add other generic cases, e.g. opening a help gump or a generic gump or whatever
--
-- linkParam is of type wstring
--
function WindowUtils.ProcessLink( linkParam )
	
    if( wstring.sub(linkParam, 1, 4) == L"http" ) then
       local url = WStringToString( linkParam )
       OpenWebBrowser( url)
    else
		Debug.PrintToDebugConsole(L"WindowUtils.ProcessLink: Link type not known for "..linkParam )
    end
    
end

-- Note that if you are dynamically adding elements to the ScrollWindow, you should be done adding elements and have 
-- called ScrollWindowUpdateScrollRect before using this function
--
function WindowUtils.ScrollToElementInScrollWindow( element, scrollWindow, scrollChild )

	if (not DoesWindowNameExist(element)) or (not DoesWindowNameExist(scrollChild)) then
		Debug.Print("WindowUtils.GotoElementInScrollChild: Window does not exist!")
		return
	end
	
	local elementX,elementY = WindowGetScreenPosition(element)
	local parentX,parentY = WindowGetScreenPosition(scrollChild)
	local dontCare, maxOffset = WindowGetDimensions(scrollChild)
	local scrollOffset = elementY - parentY
	
	-- sanity checks
	if( scrollOffset < 0 ) then
	    scrollOffset = 0
	end
	if( scrollOffset > maxOffset ) then
	    scrollOffset = maxOffset
	end
	
	ScrollWindowSetOffset(scrollWindow, scrollOffset)
end

-- Note that if you are dynamically adding elements to the ScrollWindow, you should be done adding elements and have 
-- called HorizontalScrollWindowUpdateScrollRect before using this function
--
function WindowUtils.ScrollToElementInHorizontalScrollWindow( element, scrollWindow, scrollChild )

	if (not DoesWindowNameExist(element)) or (not DoesWindowNameExist(scrollChild)) then
		Debug.Print("WindowUtils.GotoElementInScrollChild: Window does not exist!")
		return
	end
	
	local elementX,elementY = WindowGetScreenPosition(element)
	local parentX,parentY = WindowGetScreenPosition(scrollChild)
	local maxOffset = WindowGetDimensions(scrollChild)
	local scrollOffset = elementX - parentX
	
	-- sanity checks
	if( scrollOffset < 0 ) then
	    scrollOffset = 0
	end
	if( scrollOffset > maxOffset ) then
	    scrollOffset = maxOffset
	end
	
	HorizontalScrollWindowSetOffset(scrollWindow, scrollOffset)
end

-- Append label text with ellipsis (...) if label text width exceeds label width
-- Used by the function that sets window titles too, so that all titles don't extend beyond the window that contains them
function WindowUtils.FitTextToLabel(labelName, labelText, isTitle )
	
local DEBUG = false -- enable for verbose debugging of this function

	local labelWindowName = labelName
	if isTitle then
		labelText = wstring.upper(labelText)
		labelWindowName = labelName.."Chrome_UO_TitleBar_WindowTitle"	
if DEBUG then Debug.Print( L"Called WindowUtils.FitTextToLabel() to set the title for window ''"..StringToWString(labelName)..L"'' to ''"..labelText..L"''" ) end
	else
if DEBUG then Debug.Print( L"Called WindowUtils.FitTextToLabel( "..StringToWString(labelWindowName)..L", "..labelText..L" )" ) end
	end

	if labelWindowName == nil or labelText == nil or labelWindowName == "" or labelText == "" or labelText == L"" then
	   Debug.Print("ERROR in WindowUtils.FitTextToLabel()! Window name or text is bad")
	   return 0
	end

    LabelSetWordWrap(labelWindowName, false)
	local labelX, labelY = WindowGetDimensions(labelName)
	if isTitle then
		labelX = labelX - 55 -- The window has about 55 pixels of spacing on both ends total that the title shouldn't use.
	end
	LabelSetText( labelWindowName, labelText )
	local textX, textY = LabelGetTextDimensions(labelWindowName)
	
if DEBUG then Debug.Print( L"The space allowed for this label is "..labelX..L" pixels." ) end
if DEBUG then Debug.Print( L"The current text size is "..textX..L" pixels." ) end

    local text = labelText

	while (textX  > labelX) and (text:len() > 1) do
		text = wstring.sub(text, 1, -2)
if DEBUG then Debug.Print( L"The text width ("..textX..L") is still greater than the label width ("..labelX..L"), so we're changing the text to ''"..text..L"...''" ) end		
		LabelSetText(labelWindowName, text..L"...")
		textX, textY = LabelGetTextDimensions(labelWindowName)
if DEBUG then Debug.Print( L"The new text size is width="..textX..L" height="..textY ) end
	end
if DEBUG then Debug.Print( L"The text width ("..textX..L") is less than the label width ("..labelX..L"), so we are done." ) end		
end

-- Local Functions
function WindowUtils.CopyAnchors( sourceWindow, destWindow, xOffset, yOffset )

    WindowClearAnchors( destWindow )

    local numAnchors = WindowGetAnchorCount( sourceWindow )
    for index = 1, numAnchors
    do
        local point, relativePoint, relativeTo, xoffs, yoffs = WindowGetAnchor( sourceWindow, index )           
        WindowAddAnchor( destWindow , point, relativeTo, relativePoint, xoffs+xOffset, yoffs+yOffset )
    end
end

function WindowUtils.CopyScreenPosition( sourceWindow, destWindow, xOffset, yOffset )
    local uiScale = InterfaceCore.scale
    local screenX, screenY = WindowGetScreenPosition( sourceWindow )        
    
    local xPos = math.floor( (screenX + xOffset)/uiScale + 0.5 )
    local yPos = math.floor( (screenY + yOffset)/uiScale + 0.5 )
    
    --Debug.Print("CopyScreenPosition "..destWindow..": "..xPos..", "..yPos)
    
    WindowClearAnchors( destWindow )
    WindowAddAnchor(destWindow,"topleft","Root","topleft",xPos,yPos)
end

function WindowUtils.CopySize( sourceWindow, destWindow, xOffset, yOffset, offsetInDestCoords )
        
    local width, height = WindowGetDimensions( sourceWindow )
           
    local sourceScale = WindowGetScale( sourceWindow )
    local destScale   = WindowGetScale( destWindow )
    local scaleConvert = destScale / sourceScale
    
    if( offsetInDestCoords ) 
    then
        width  = width*scaleConvert + xOffset
        height = height*scaleConvert + yOffset
    else
        width  = (width + xOffset) * scaleConvert
        height = (height + yOffset)* scaleConvert
    end
    
    WindowSetDimensions( destWindow, width, height ) 
end

function WindowUtils.GetScaledScreenPosition( sourceWindow )
    local uiScale = InterfaceCore.scale
    local screenX, screenY = WindowGetScreenPosition( sourceWindow )        
    
    local xPos = math.floor( screenX/uiScale + 0.5 )
    local yPos = math.floor( screenY/uiScale + 0.5 )
    
    --Debug.Print("GetScaledScreenPosition "..destWindow..": "..xPos..", "..yPos)
    
    return xPos, yPos
end

-- Debugging purposes. Used for creating visible outlines of windows passed into this function.
-- Make sure to use DestroyWindowOutline during window destruction as well.
function WindowUtils.CreateWindowOutline(windowName)
	local debugWindow = "DebugWindowOutline_"..windowName
	
	if(DoesWindowNameExist(debugWindow) == false) then
		CreateWindowFromTemplate(debugWindow, "SnapWindowTemplate", "Root")
		WindowUtils.CopySize( windowName, debugWindow, 0, 0 )
	    
		WindowClearAnchors(debugWindow)
		WindowAddAnchor(debugWindow, "topleft", windowName, "topleft", 0, 0)
	    
		WindowSetShowing(debugWindow, true)
	end
end

function WindowUtils.DestroyWindowOutline(windowName)
	local debugWindow = "DebugWindowOutline_"..windowName
	if(DoesWindowNameExist(debugWindow) == true) then
		DestroyWindow(debugWindow)
	end
end

----------------------------
-- Snapping functionality
----------------------------

SnapUtils = {}
SnapUtils.SnappableWindows = {}

SnapUtils.CurWindow = nil
SnapUtils.SnapWindow = nil
SnapUtils.SnapIndex = nil

SnapUtils.ANCHOR_POINT_TOP_LEFT       = 1
SnapUtils.ANCHOR_POINT_TOP            = 2
SnapUtils.ANCHOR_POINT_TOP_RIGHT      = 3
SnapUtils.ANCHOR_POINT_LEFT           = 4
SnapUtils.ANCHOR_POINT_CENTER         = 5
SnapUtils.ANCHOR_POINT_RIGHT          = 6
SnapUtils.ANCHOR_POINT_BOTTOM_LEFT    = 7
SnapUtils.ANCHOR_POINT_BOTTOM         = 8
SnapUtils.ANCHOR_POINT_BOTTOM_RIGHT   = 9

SnapUtils.ANCHOR_POINTS =
{ 
    [SnapUtils.ANCHOR_POINT_TOP_LEFT      ] = { name="topleft",       widthMultipler=0.0,  heightMultiplier=0.0 },
    [SnapUtils.ANCHOR_POINT_TOP           ] = { name="top",           widthMultipler=0.5,  heightMultiplier=0.0 },
    [SnapUtils.ANCHOR_POINT_TOP_RIGHT     ] = { name="topright",      widthMultipler=1.0,  heightMultiplier=0.0 },
    [SnapUtils.ANCHOR_POINT_LEFT          ] = { name="left",          widthMultipler=0.0,  heightMultiplier=0.5 },
    [SnapUtils.ANCHOR_POINT_CENTER        ] = { name="center",        widthMultipler=0.5,  heightMultiplier=0.5 },
    [SnapUtils.ANCHOR_POINT_RIGHT         ] = { name="right",         widthMultipler=1.0,  heightMultiplier=0.5 },
    [SnapUtils.ANCHOR_POINT_BOTTOM_LEFT   ] = { name="bottomleft",    widthMultipler=0.0,  heightMultiplier=1.0 },
    [SnapUtils.ANCHOR_POINT_BOTTOM        ] = { name="bottom",        widthMultipler=0.5,  heightMultiplier=1.0 },
    [SnapUtils.ANCHOR_POINT_BOTTOM_RIGHT  ] = { name="bottomright",   widthMultipler=1.0,  heightMultiplier=1.0 },
}

SnapUtils.SNAP_PAIRS =
{ 
    -- Window 1                                 -- Window 2
    {SnapUtils.ANCHOR_POINT_TOP_LEFT,         SnapUtils.ANCHOR_POINT_BOTTOM_LEFT },
    {SnapUtils.ANCHOR_POINT_TOP_LEFT,         SnapUtils.ANCHOR_POINT_TOP_RIGHT },
    {SnapUtils.ANCHOR_POINT_TOP,              SnapUtils.ANCHOR_POINT_BOTTOM },
    {SnapUtils.ANCHOR_POINT_TOP_RIGHT,        SnapUtils.ANCHOR_POINT_BOTTOM_RIGHT },
    {SnapUtils.ANCHOR_POINT_TOP_RIGHT,        SnapUtils.ANCHOR_POINT_TOP_LEFT },
    {SnapUtils.ANCHOR_POINT_LEFT,             SnapUtils.ANCHOR_POINT_RIGHT },
    {SnapUtils.ANCHOR_POINT_RIGHT,            SnapUtils.ANCHOR_POINT_LEFT },
    {SnapUtils.ANCHOR_POINT_RIGHT,            SnapUtils.ANCHOR_POINT_LEFT },
    {SnapUtils.ANCHOR_POINT_BOTTOM_LEFT,      SnapUtils.ANCHOR_POINT_BOTTOM_RIGHT },
    {SnapUtils.ANCHOR_POINT_BOTTOM_LEFT,      SnapUtils.ANCHOR_POINT_TOP_LEFT },
    {SnapUtils.ANCHOR_POINT_BOTTOM,           SnapUtils.ANCHOR_POINT_TOP },    
    {SnapUtils.ANCHOR_POINT_BOTTOM_RIGHT,     SnapUtils.ANCHOR_POINT_TOP_RIGHT },
    {SnapUtils.ANCHOR_POINT_BOTTOM_RIGHT,     SnapUtils.ANCHOR_POINT_BOTTOM_LEFT },
}

function SnapUtils.GetAnchorDistance( anchorsList1, anchor1, anchorsList2, anchor2 )

    local xDistance = anchorsList1[anchor1].x - anchorsList2[anchor2].x 
    local yDistance = anchorsList1[anchor1].y - anchorsList2[anchor2].y 

    return math.sqrt( xDistance*xDistance + yDistance*yDistance )
end

function SnapUtils.ComputeAnchorScreenPositions( windowName )

    local uiScale = InterfaceCore.scale
    local screenX, screenY = WindowGetScreenPosition( windowName ) 
    
    local width, height = WindowGetDimensions( windowName ) 
    local scale = WindowGetScale( windowName ) 
        
    width   = width*scale
    height  = height*scale
    
    -- Compute the XY coordates for each anchor point
        
    local positions = {}    
    for index, anchorPoint in ipairs( SnapUtils.ANCHOR_POINTS )
    do    
        positions[index] = { 
                             x=screenX + width*anchorPoint.widthMultipler,
                             y=screenY + height*anchorPoint.heightMultiplier
                           }
    end   
    
    return positions

end

function SnapUtils.StartWindowSnap( windowName )
    --Debug.Print("SnapUtils.StartWindowSnap: "..tostring(windowName))
    CreateWindowFromTemplate("SnapWindow", "SnapWindowTemplate", "Root")
    WindowUtils.CopySize( windowName, "SnapWindow", 0, 0 )
    WindowSetShowing("SnapWindow",false)
    
	local x,y = WindowGetScreenPosition("SnapWindow")
	local w,h = WindowGetDimensions("SnapWindow")
    
	SnapUtils.CurWindow = windowName
	WindowSetMoving(windowName,true)
end

function SnapUtils.EndWindowSnap( windowName )
    --Debug.Print("SnapUtils.EndWindowSnap: "..tostring(windowName))
    
    if( SnapUtils.SnapWindow and DoesWindowNameExist(SnapUtils.CurWindow) ) then
        WindowUtils.CopyScreenPosition( "SnapWindow", SnapUtils.CurWindow, 0, 0)
    end
    
    DestroyWindow("SnapWindow")
end

function SnapUtils.SnapUpdate( timePassed )
    if( SnapUtils.CurWindow ) then
		if( WindowGetMoving(SnapUtils.CurWindow) == false or DoesWindowNameExist(SnapUtils.CurWindow) == false ) then
		    SnapUtils.EndWindowSnap( SnapUtils.CurWindow )
			SnapUtils.CurWindow = nil
		else
		    SnapUtils.FindSnap()
	    end
    end 
end

function SnapUtils.FindSnap()
    local maxSnapDistance = 20
    local anchorPositions = SnapUtils.ComputeAnchorScreenPositions(SnapUtils.CurWindow)
    local distance = maxSnapDistance + 1
    SnapUtils.SnapWindow = nil
    SnapUtils.SnapIndex = nil
    
    for windowName,_ in pairs(SnapUtils.SnappableWindows) do
        if( windowName ~= SnapUtils.CurWindow )
        then          
            local comparePositions = SnapUtils.ComputeAnchorScreenPositions(windowName)            
            
            for index, snapPair in ipairs( SnapUtils.SNAP_PAIRS )
            do
                local dist = SnapUtils.GetAnchorDistance( anchorPositions, snapPair[1], comparePositions, snapPair[2] )
                
                -- If the distance between the anchors is within the snap threshold, save the value
                if( (dist <= maxSnapDistance) and (dist < distance) and WindowGetShowing(windowName) )
                then
                    distance = dist
                    SnapUtils.SnapWindow = windowName
                    SnapUtils.SnapIndex = index
                end
           end
        end
    end
    
    if( SnapUtils.SnapWindow ) then
        WindowSetShowing("SnapWindow", true)
        
        local anchorPt   = SnapUtils.SNAP_PAIRS[ SnapUtils.SnapIndex][2]
        local anchorToPt = SnapUtils.SNAP_PAIRS[ SnapUtils.SnapIndex][1]

        -- Anchor the SnapFrame to it's anchor point.
        WindowClearAnchors("SnapWindow")
        WindowAddAnchor( "SnapWindow", SnapUtils.ANCHOR_POINTS[anchorPt].name, SnapUtils.SnapWindow, SnapUtils.ANCHOR_POINTS[anchorToPt].name, 0, 0 )
        
        return true
    else
        WindowSetShowing("SnapWindow", false)
    end
    
    return false
end

function WindowUtils.TrapClick()
end