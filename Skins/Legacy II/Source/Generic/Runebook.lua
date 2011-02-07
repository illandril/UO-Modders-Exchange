
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------


----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
Runebook ={}
Runebook.knownWindows = {}
Runebook.selectRuneType = {}
Runebook.NumActiveRunes = {}

Runebook.NUM_DEFAULT_LABELS = 7
Runebook.CHARGE_LABEL = 8
Runebook.KeymapTID = { 1011299, 1011298, 1077594, 1077595, 1062723, 1062724, 1011300, 1011296, }
Runebook.TID_RUNEBOOK = 1028901
Runebook.KeymapLabel = { "RenameBook", "DropRune", "Recall", "RecallSpell", "GateTravel", "Sacred", "SetDefault", "Charges",}

Runebook.ButtonIdLoc = {9, 199, 9, 49, 99, 74, 299}
Runebook.Hues = { malas = 1102, trammel = 10, tokuno = 1154, felucca = 81 }
Runebook.RuneColor = {purple = "PurpleRuneTemplate", torquoise = "TorquoiseRuneTemplate", gray = "GrayRuneTemplate", green = "GreenRuneTemplate", brown = "BrownRuneTemplate"}
Runebook.LegacyLabelColors= { malas={ r=75, g=75, b=75 }, trammel={ r=60, g=0, b=160 }, tokuno={ r=0, g=50, b=0 }, felucca={ r=10, g=90, b=90 } }

Runebook.DefaultNum = {}
Runebook.DefaultNum.RENAME_BOOK		= 1
Runebook.DefaultNum.DROP_RUNE		= 2
Runebook.DefaultNum.RECALL			= 3
Runebook.DefaultNum.GATE_TRAVEL		= 4
Runebook.DefaultNum.SACRED			= 5
Runebook.DefaultNum.SET_DEFAULT		= 6

-- Local Defaults for button matching to data from server
local NUM_RUNEBOOK_PAGE_END = 16
local NUM_ADD_STRING = 2
local COORDS_START_STRING = 24
local COORDS_ADD_DIFF		=2

Runebook.CHARGES_STRING = 19
Runebook.MAXCHARGES_STRING = 20

Runebook.SelectItemLabel = { r=200, g=0, b=0, a=255} -- Orange (Selected rune)
Runebook.DefaultItemLabel = { r=50, g=50, b=0, a=255} -- bottom label color
Runebook.BlackItemLabel = { r=25, g=25, b=0, a=255} --Black (rune coords color)
Runebook.DisabledAlpha = 0.5
Runebook.EnableAlpha = 1

----------------------------------------------------------------
-- Runebook Functions
----------------------------------------------------------------
function Runebook.CreateRuneButton(parent, number, color)
	local index = number
	local runeButtonName = parent.."RuneButton"..tostring(index)
	local buttonName = parent.."RuneButton"..tostring(index).."Icon"
	local colorTemplate
	
	if( color == Runebook.Hues.trammel) then
		colorTemplate = Runebook.RuneColor.purple
	elseif( color == Runebook.Hues.felucca) then
		colorTemplate = Runebook.RuneColor.torquoise
	elseif( color == Runebook.Hues.malas) then
		colorTemplate = Runebook.RuneColor.gray
	elseif (color == Runebook.Hues.tokuno) then
		colorTemplate = Runebook.RuneColor.green
	else
		colorTemplate = Runebook.RuneColor.brown
	end
	
	CreateWindowFromTemplate(runeButtonName, colorTemplate, parent)
	ButtonSetStayDownFlag(buttonName,true)
	WindowSetId(buttonName, index)
	WindowSetId(runeButtonName, index)
	
	if ( index == 1 ) then
		WindowAddAnchor(runeButtonName, "topleft", parent.."First", "topleft", 15, 20)
	elseif ( index == 9 )then
		WindowAddAnchor(runeButtonName, "topleft", parent.."Second", "topleft", 15, 20)
	else
		WindowAddAnchor(runeButtonName, "bottomleft", parent.."RuneButton"..index-1, "topleft", 0, 0)
	end
end

function Runebook.CreateRuneWindows(data)
	self = {}
	self = data
	local color = 0
	local windowName = self.windowName
	local flagEmptyStart = false
	for index = 1, Runebook.NumActiveRunes[windowName] do
		local buttonName = windowName.."RuneButton"..tostring(index).."Icon"
		local labelName = windowName.."RuneButton"..tostring(index).."Name"
		local textString = self.stringData[NUM_ADD_STRING+index]
		color = self.textHueData[index]
		Runebook.CreateRuneButton(windowName, index, color)
		
		local labelColor = Runebook.DefaultItemLabel
        if( color == Runebook.Hues.trammel) then
            labelColor = Runebook.LegacyLabelColors.trammel
        elseif( color == Runebook.Hues.felucca) then
            labelColor = Runebook.LegacyLabelColors.felucca
        elseif( color == Runebook.Hues.malas) then
            labelColor = Runebook.LegacyLabelColors.malas
        elseif (color == Runebook.Hues.tokuno) then
            labelColor = Runebook.LegacyLabelColors.tokuno
        end
		
		LabelSetText( labelName, L""..textString)
		LabelSetTextColor( labelName, labelColor.r, labelColor.g, labelColor.b )

		
		local text = WStringToString(textString)
		if(text == "Empty") then
			ButtonSetDisabledFlag( buttonName, true )
			if(flagEmptyStart == false) then
				Runebook.NumActiveRunes[windowName] = index - 1
			end
			flagEmptyStart = true
		end
		color = 2
	end	
end

function Runebook.ResetRuneDefaultIconText(data)
	self = {}
	self = data
	
	local windowName = self.windowName
	for index = 1, Runebook.NumActiveRunes[windowName] do
		local labelName = windowName.."RuneButton"..tostring(index).."Name"

        color = self.textHueData[index]
		local labelColor = Runebook.DefaultItemLabel
        if( color == Runebook.Hues.trammel) then
            labelColor = Runebook.LegacyLabelColors.trammel
        elseif( color == Runebook.Hues.felucca) then
            labelColor = Runebook.LegacyLabelColors.felucca
        elseif( color == Runebook.Hues.malas) then
            labelColor = Runebook.LegacyLabelColors.malas
        elseif (color == Runebook.Hues.tokuno) then
            labelColor = Runebook.LegacyLabelColors.tokuno
        end
		LabelSetTextColor( labelName, labelColor.r, labelColor.g, labelColor.b )
	end
end

function Runebook.EnableDefaultButtons(windowName)
	buttonName = windowName.."CoordsIcon"
	ButtonSetDisabledFlag( buttonName, false )
	
	for i = 2, Runebook.NUM_DEFAULT_LABELS do
		buttonName = windowName..Runebook.KeymapLabel[i].."Icon"
		labelName = windowName..Runebook.KeymapLabel[i]
		ButtonSetDisabledFlag( buttonName, false )
		WindowSetFontAlpha( labelName, Runebook.EnableAlpha )
	end
end

function Runebook.DisableDefaultButtons(windowName)
	buttonName = windowName..Runebook.KeymapLabel[Runebook.DefaultNum.RENAME_BOOK].."Icon"
	ButtonSetPressedFlag( buttonName, false )
	
	--Set the Coords Texture to the disabled texture
	buttonName = windowName.."CoordsIcon"
	ButtonSetDisabledFlag( buttonName, true )
	
	for i = 2, Runebook.NUM_DEFAULT_LABELS do
		buttonName = windowName..Runebook.KeymapLabel[i].."Icon"
		labelName = windowName..Runebook.KeymapLabel[i]
		ButtonSetDisabledFlag( buttonName, true )
		ButtonSetPressedFlag( buttonName, false )
		WindowSetFontAlpha( labelName, Runebook.DisabledAlpha )
	end
end

function Runebook.SelectedRuneLocation(windowData, runeNum)
	self = {}
	self = windowData
	local windowName = self.windowName
	
	Runebook.selectRuneType[windowName] = runeNum
			
    for index = 1, NUM_RUNEBOOK_PAGE_END do
		local buttonName = windowName.."RuneButton"..tostring(index).."Icon"
        ButtonSetPressedFlag( buttonName, Runebook.selectRuneType[windowName] == index )
    end
end

-- labels for bottom menu and rename runebook
function Runebook.ResetDefaultIconText(data)
	--Debug.Print("In Runebook Reset Default Icon")
	
	self = {}
	self = data
	local windowName = self.windowName

	--Name is called differently for charges
	local labelName = windowName..Runebook.KeymapLabel[Runebook.CHARGE_LABEL]
	local numCharges = self.stringData[Runebook.CHARGES_STRING]
	local maxCharges = self.stringData[Runebook.MAXCHARGES_STRING]
	LabelSetText( labelName, L""..GetStringFromTid(Runebook.KeymapTID[Runebook.CHARGE_LABEL])..numCharges..L"/"..maxCharges)
	LabelSetTextColor( labelName, Runebook.DefaultItemLabel.r, Runebook.DefaultItemLabel.g, Runebook.DefaultItemLabel.b )
	
	for i = 1, Runebook.NUM_DEFAULT_LABELS do
		local currButtonName = windowName..Runebook.KeymapLabel[i]
		buttonName = windowName..Runebook.KeymapLabel[i].."Icon"
		labelName = windowName..Runebook.KeymapLabel[i].."Name"
		WindowSetId(currButtonName, i)
		WindowSetId(buttonName, i)
		LabelSetText( labelName, L""..GetStringFromTid(Runebook.KeymapTID[i]))
		LabelSetTextColor( labelName, Runebook.DefaultItemLabel.r, Runebook.DefaultItemLabel.g, Runebook.DefaultItemLabel.b )
		Runebook.DisableDefaultButtons(windowName)
	end
end

-- OnInitialize Handler
function Runebook.Initialize()
	self = {}
	if(UO_GenericGump.retrieveWindowData( self )) then	
		--Set my runebook data to use later
		Runebook.knownWindows[self.windowName] = self
		local windowName = self.windowName
		Runebook.NumActiveRunes[windowName] = NUM_RUNEBOOK_PAGE_END
		Runebook.ResetDefaultIconText(self)
		Runebook.CreateRuneWindows(self)
		
		local locWindowName = windowName.."Location"
		WindowSetShowing(locWindowName, false)
		
		WindowUtils.SetWindowTitle(WindowUtils.GetActiveDialog(), GetStringFromTid(Runebook.TID_RUNEBOOK))
		
		Interface.OnCloseCallBack[self.windowName] = GGManager.destroyActiveWindow
		
		GGManager.registerWindow(self.windowName, self)
		self.broadcastHasBeenSent = false 
	end
end

function Runebook.ResetData(windowName)
	Runebook.knownWindows[windowName] = nil
	Runebook.selectRuneType[windowName] = nil
	Runebook.NumActiveRunes[windowName] = nil
end

function Runebook.DestroyWindow(myWindowName)
	Runebook.ResetData(myWindowName)
	GGManager.destroyWindow( myWindowName, GGManager.DONT_DELETE_DATA_YET )
end
	
function Runebook.Shutdown()
	local windowName = SystemData.ActiveWindow.name
	local self = Runebook.knownWindows[windowName]
	
	if self ~= nil and self.broadcastHasBeenSent == false then
		--Returns 0 to close the window and do nothing
		UO_GenericGump.broadcastButtonPress( 0, self )
		self.broadcastHasBeenSent = true
	end
	
	Runebook.ResetData(windowName)
	
	GGManager.unregisterActiveWindow()
end

function Runebook.UpdateCoordTextandLoc(runeData)
	local self = {}
	self = runeData

	local windowName = self.windowName
	local selectedRune = Runebook.selectRuneType[windowName]
	local coordName = windowName.."CoordsName"
	local coordsNum 
	-- If selected Rune is the first rune, do not add two to get the coord data
	if(selectedRune == 1) then
		coordsNum = COORDS_START_STRING 
	else
		coordsNum = selectedRune + COORDS_START_STRING + COORDS_ADD_DIFF
	end
	local secondCoordNum = coordsNum+1
	local coordText = self.stringData[coordsNum]..L"\n"..self.stringData[secondCoordNum]
	LabelSetText(coordName, coordText)
	LabelSetTextColor( coordName, Runebook.BlackItemLabel.r, Runebook.BlackItemLabel.g, Runebook.BlackItemLabel.b )
	
	--Show the text of the selected rune location
	local locWindowName = windowName.."Location"
	local locName = locWindowName.."Name"
	local labelName = windowName.."RuneButton"..tostring(selectedRune).."Name"
	local locText = LabelGetText(labelName)
	LabelSetText(locName, locText)
	LabelSetTextColor( locName, 10, 10, 0)  -- color for selected rune text
	WindowSetShowing(locWindowName, true)

end

function Runebook.OnRuneClicked()
	local windowName = WindowUtils.GetActiveDialog()
	local buttonNum = WindowGetId(SystemData.ActiveWindow.name)
	local self = Runebook.knownWindows[windowName]
	
	if(self) then
		
		local windowName = self.windowName
		if( buttonNum <= Runebook.NumActiveRunes[windowName] )then
			Runebook.ResetRuneDefaultIconText(self)
			Runebook.SelectedRuneLocation(self, buttonNum)
			
			Runebook.UpdateCoordTextandLoc(self)
			Runebook.EnableDefaultButtons(windowName)
			local labelName = windowName.."RuneButton"..tostring(buttonNum).."Name"
			LabelSetTextColor( labelName, Runebook.SelectItemLabel.r, Runebook.SelectItemLabel.g, Runebook.SelectItemLabel.b )
		end
	end
end

function Runebook.SendServerButtonInfo(buttonNumber, runeData)
	--set default buttonId to zero
	local runebookButtonId = 0
	
	if( buttonNumber == Runebook.DefaultNum.RENAME_BOOK ) then
		if (Runebook.ButtonIdLoc[buttonNumber] < runeData.buttonCount ) then
			runebookButtonId =runeData.buttonIDs[Runebook.ButtonIdLoc[buttonNumber]]
		end  
	else
		runebookButtonId = Runebook.ButtonIdLoc[buttonNumber] + Runebook.selectRuneType[runeData.windowName]
	end
	
	local windowName = runeData.windowName
	UO_GenericGump.broadcastButtonPress( runebookButtonId, runeData )
	self.broadcastHasBeenSent = true
	
	Runebook.DestroyWindow(windowName)
end

function Runebook.OnDefaultClicked()
	local currWindow = WindowUtils.GetActiveDialog()
	local buttonNum = WindowGetId(SystemData.ActiveWindow.name)
	local self = Runebook.knownWindows[currWindow]
	
	if(self) then
		local windowName = self.windowName
		if((Runebook.selectRuneType[windowName] ~= nil) or (buttonNum == Runebook.DefaultNum.RENAME_BOOK)) then
			Runebook.ResetDefaultIconText(self)
			
			local buttonName = windowName..Runebook.KeymapLabel[buttonNum].."Icon"
			local labelName = windowName..Runebook.KeymapLabel[buttonNum].."Name"
			ButtonSetPressedFlag( buttonName, true )
			LabelSetTextColor( labelName, Runebook.SelectItemLabel.r, Runebook.SelectItemLabel.g, Runebook.SelectItemLabel.b )
			
			Runebook.SendServerButtonInfo(buttonNum, self)
		end
	end
	
end
