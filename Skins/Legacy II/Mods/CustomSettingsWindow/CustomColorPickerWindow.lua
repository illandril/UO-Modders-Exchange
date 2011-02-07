----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

CustomColorPickerWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

CustomColorPickerWindow.numColorsPerRow = 5
CustomColorPickerWindow.swatchSize = 47
CustomColorPickerWindow.colorTables = {}
CustomColorPickerWindow.colorSelected = {}
CustomColorPickerWindow.frameEnabled = true
CustomColorPickerWindow.closeButtonEnabled = true
CustomColorPickerWindow.xPadding = 10
CustomColorPickerWindow.yPadding = 15

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler
function CustomColorPickerWindow.Initialize()
	local this = SystemData.ActiveWindow.name
	local id = SystemData.DynamicWindowId
	WindowSetId(this, id)
	
	CustomColorPickerWindow[id] = {}
	
	Interface.DestroyWindowOnClose[this] = true
end

function CustomColorPickerWindow.SetColorTable(colorTable, parent)
	CustomColorPickerWindow.colorTables[parent] = colorTable        
end

function CustomColorPickerWindow.SetNumColorsPerRow(numColorsPerRow)
	CustomColorPickerWindow.numColorsPerRow = numColorsPerRow        
end

function CustomColorPickerWindow.SetSwatchSize(newSize)
    CustomColorPickerWindow.swatchSize = newSize
end

function CustomColorPickerWindow.SetWindowPadding(x,y)
    CustomColorPickerWindow.xPadding = x
    CustomColorPickerWindow.yPadding = y
end

function CustomColorPickerWindow.SetFrameEnabled(enabled)
    CustomColorPickerWindow.frameEnabled = enabled
end

function CustomColorPickerWindow.SetCloseButtonEnabled(enabled)
    CustomColorPickerWindow.closeButtonEnabled = enabled
end

function CustomColorPickerWindow.DrawColorTable(parent)
    local numInRow = 0
    local firstRowWindow = nil
    local currentColorWindowName = nil
    local relativeAnchorColorWindowName = nil
    local first = true
    local red, green, blue, alpha = nil

    local windowWidth = (CustomColorPickerWindow.numColorsPerRow * CustomColorPickerWindow.swatchSize) + CustomColorPickerWindow.xPadding
    local windowHeight = ( math.ceil((table.getn(CustomColorPickerWindow.colorTables[parent])/CustomColorPickerWindow.numColorsPerRow)) * CustomColorPickerWindow.swatchSize) + CustomColorPickerWindow.yPadding
    WindowSetDimensions(parent, windowWidth, windowHeight)

    for key, hueNumber in pairs(CustomColorPickerWindow.colorTables[parent])  do
        currentColorWindowName = parent..tostring(hueNumber)
        CreateWindowFromTemplate( currentColorWindowName, "CustomColorPickerWindowColorItemTemplate", parent )
        
        red, green, blue, alpha  = HueRGBAValue(hueNumber)
		--Debug.Print("hueNumber "..hueNumber.." = ".." red = "..red..", green = "..green..", blue = "..blue)
		WindowSetDimensions(currentColorWindowName,CustomColorPickerWindow.swatchSize,CustomColorPickerWindow.swatchSize)
		WindowSetScale(currentColorWindowName.."Frame",CustomColorPickerWindow.swatchSize/30)
        WindowSetTintColor(currentColorWindowName.."Color", red, green, blue)
		WindowSetId(currentColorWindowName, hueNumber)
        WindowSetShowing(currentColorWindowName.."Frame", false)
        WindowClearAnchors(currentColorWindowName)
        if (first) then 
            WindowAddAnchor( currentColorWindowName, "topleft", parent, "topleft", 0, 0)
            relativeAnchorColorWindowName = currentColorWindowName
            firstRowWindow = currentColorWindowName
            if CustomColorPickerWindow.colorSelected[parent] == nil then
                CustomColorPickerWindow.colorSelected[parent] = hueNumber
            end
            first = false
        elseif (numInRow < CustomColorPickerWindow.numColorsPerRow-1) then
            WindowAddAnchor( currentColorWindowName, "topright", relativeAnchorColorWindowName, "topleft", 0, 0)
            numInRow = numInRow + 1
            relativeAnchorColorWindowName = currentColorWindowName
        elseif (numInRow == CustomColorPickerWindow.numColorsPerRow-1) then
            WindowAddAnchor( currentColorWindowName, "bottomleft", firstRowWindow, "topleft", 0, 0)
            numInRow = 0
            relativeAnchorColorWindowName = currentColorWindowName
            firstRowWindow =  currentColorWindowName                     
        end                
        if( CustomColorPickerWindow.frameEnabled and CustomColorPickerWindow.colorSelected[parent] == hueNumber) then
            WindowSetShowing(currentColorWindowName.."Frame", true)
        end
    end
	
	-- hide close button if its not enabled
	if( CustomColorPickerWindow.closeButtonEnabled == false ) then
	    WindowSetShowing( parent.."CloseButton", false )
	end
end

function CustomColorPickerWindow.SelectColor(win, hue)
	WindowSetShowing(win..CustomColorPickerWindow.colorSelected[win].."Frame", false)	
	CustomColorPickerWindow.colorSelected[win]= hue
	if CustomColorPickerWindow.frameEnabled then
		WindowSetShowing(win..CustomColorPickerWindow.colorSelected[win].."Frame", true)
	end
end

function CustomColorPickerWindow.SetColor()
    local parent = WindowGetParent(SystemData.ActiveWindow.name)
    
	if (CustomColorPickerWindow.colorSelected[parent] and CustomColorPickerWindow.frameEnabled == true) then
    	WindowSetShowing(parent..CustomColorPickerWindow.colorSelected[parent].."Frame", false)
	end
    
	CustomColorPickerWindow.colorSelected[parent] = WindowGetId(SystemData.ActiveWindow.name)
	if( CustomColorPickerWindow.frameEnabled == true ) then
        WindowSetShowing(parent..CustomColorPickerWindow.colorSelected[parent].."Frame", true)
    end
    WindowSetShowing(parent, false)
        
    CustomColorPickerWindow.AfterColorSelectionFunction(parent)
end

function CustomColorPickerWindow.AfterColorSelectionFunction(parent)
	return
end

function CustomColorPickerWindow.SetAfterColorSelectionFunction(funcCall)
	CustomColorPickerWindow.AfterColorSelectionFunction = funcCall        
end

-- BE CAREFUL IF YOU REINITIALIZE THE CustomColorPickerWindow WITH SAME COLOR TABLE, IT WILL BE WHONKY!
function CustomColorPickerWindow.ClearWindow(parent)
	for key, hueNumber in pairs(CustomColorPickerWindow.colorTables[parent])  do
		DestroyWindow(parent..tostring(hueNumber))	
	end
end

function CustomColorPickerWindow.SetHue(hueNumber, parent)
	--Debug.Print("CustomColorPickerWindow.SetHue() hueNumber = "..tostring(hueNumber).." parent = "..parent)
    
	if (CustomColorPickerWindow.colorSelected[parent] and CustomColorPickerWindow.frameEnabled == true) then
    	WindowSetShowing(parent..CustomColorPickerWindow.colorSelected[parent].."Frame", false)
	end
    
	CustomColorPickerWindow.colorSelected[parent] = hueNumber
	if (CustomColorPickerWindow.frameEnabled == true) then
        WindowSetShowing(parent..CustomColorPickerWindow.colorSelected[parent].."Frame", true)
    end
    WindowSetShowing(parent, false)
end
