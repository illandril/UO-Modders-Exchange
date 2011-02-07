----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MacroPickerWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

MacroPickerWindow.numMacrosPerRow = 5
MacroPickerWindow.MacroSelected = nil

MacroPickerWindow.MacroIcons = 
{ 617,618,619,620,621,622,623,624,625,626,627,628,629,630,631,
  632,633,634,635,636,637,638,639,640,641,721,723,647,648,649,650,651,
  655,656,657,658,659,660,661,652,653,654,662,663,664,665,666,
  667,668,669,670,671,672,673,674,675,676,677,694,695,696,700,701,702,703,704,705,
  706,707,708,709,710,711,712,713,714,715,2,3,4,5,6,7,8,9,10,11,12,13,14,15,
  16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,
  36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,
  56,57,58,59,60,61,62,63,64,101,102,103,104,105,106,107,108,
  109,110,111,112,113,114,115,116,117,201,202,203,204,205,206,
  207,208,209,210,401,402,403,404,405,406,501,502,503,504,505,
  506,507,508,601,602,603,604,605,606,607,608,609,610,611,612,
  613,614,615,616,1001,1002,1003,1004,1005,1006,1007,1008,1009,
  1010,1011,1012,1013,1014,1015,1016,1017,1018,1019,1020,1021,
  1022,1023,1024,1025,1026,1027,1028,1029,2001,2002,2003,2004,
  2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,
  2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,
  2029,2030,2031,2032,2033,2034,2035,2036,2037,2038,2039,2040,
  2041,2042,2043,2044,2045,2046,2047,2048,2049,2050,2051,2052,
  2053,2054,2055 }

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler
function MacroPickerWindow.Initialize()
	--Debug.Print("MacroPickerWindow.Initialize()")
	local this = SystemData.ActiveWindow.name
	local id = SystemData.DynamicWindowId
	WindowSetId(this, id)
	
	MacroPickerWindow[id] = {}
	
	Interface.DestroyWindowOnClose[this] = true
end

function MacroPickerWindow.SetNumMacrosPerRow(numMacrosPerRow)
	MacroPickerWindow.numMacrosPerRow = numMacrosPerRow        
end

function MacroPickerWindow.DrawMacroTable(parent)
	--Debug.Print("MacroPickerWindow.DrawMacroTable()")
	local numInRow = 0
    local firstRowWindow = nil
    local currentMacroWindowName = nil
    local relativeAnchorMacroWindowName = nil
    local iconTexture, x, y = nil

	local scrollChild = parent.."ViewScrollChild"

    for index, iconId in ipairs(MacroPickerWindow.MacroIcons) do
        currentMacroWindowName = scrollChild..tostring(iconId)
        CreateWindowFromTemplate( currentMacroWindowName, "MacroPickerItemTemplate", scrollChild )
        iconTexture, x, y = GetIconData(iconId)
        DynamicImageSetTexture(currentMacroWindowName, iconTexture, x, y)
        
		WindowSetId(currentMacroWindowName, iconId)
		
        if (index == 1) then 
            WindowAddAnchor( currentMacroWindowName, "topleft", scrollChild, "topleft", 0, 0)
            relativeAnchorMacroWindowName = currentMacroWindowName
            firstRowWindow = currentMacroWindowName
        elseif (numInRow < MacroPickerWindow.numMacrosPerRow-1) then
            WindowAddAnchor( currentMacroWindowName, "topright", relativeAnchorMacroWindowName, "topleft", 0, 0)
            numInRow = numInRow + 1
            relativeAnchorMacroWindowName = currentMacroWindowName
        elseif (numInRow == MacroPickerWindow.numMacrosPerRow-1) then
            WindowAddAnchor( currentMacroWindowName, "bottomleft", firstRowWindow, "topleft", 0, 0)
            numInRow = 0
            relativeAnchorMacroWindowName = currentMacroWindowName
            firstRowWindow =  currentMacroWindowName                     
        end                
    end
   
   ScrollWindowUpdateScrollRect(parent.."View")
end

function MacroPickerWindow.SetMacro()
    local parent = WindowGetParent(WindowGetParent(WindowGetParent(SystemData.ActiveWindow.name)))
    
	MacroPickerWindow.MacroSelected = WindowGetId(SystemData.ActiveWindow.name)
    WindowSetShowing(parent, false)
        
    MacroPickerWindow.AfterMacroSelectionFunction()
end

function MacroPickerWindow.AfterMacroSelectionFunction()
	return
end

function MacroPickerWindow.SetAfterMacroSelectionFunction(funcCall)
	MacroPickerWindow.AfterMacroSelectionFunction = funcCall        
end

function MacroPickerWindow.SetMacroId(macroId, parent)
	MacroPickerWindow.MacroSelected= macroId
    WindowSetShowing(parent, false)
end
