----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

DamageWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
DamageWindow.AttachedId = {}
--Used to shift the Y position to the max before it disappears off the screen
DamageWindow.OverheadAlive = -70
DamageWindow.OverheadMove = 1.5
DamageWindow.FadeStart = -10
DamageWindow.FadeDiff = 0.01
DamageWindow.DefaultAnchorY = 40
DamageWindow.ShiftYAmount = 25
DamageWindow.MaxAnchorYOverlap = 15
DamageWindow.DamageMax = 40
DamageWindow.AnchorY = {}
DamageWindow.FontAlpha = {}
DamageWindow.DeltaTimeMax = 0.05
DamageWindow.CurrentDelta = 0
 
----------------------------------------------------------------
-- DamageWindow Functions
----------------------------------------------------------------
function DamageWindow.Initialize()
--	Debug.PrintToDebugConsole(L"Initialize DAMAGE WINDOW")
	WindowRegisterEventHandler("Root", SystemData.Events.DAMAGE_NUMBER_INIT, "DamageWindow.Init")
end

--Creates a new window for the mobile Id and set the label text of the damage amount
function DamageWindow.Init()
	local numWindow = Damage.numWindow
	CreateWindowFromTemplate("DamageWindow"..numWindow, "DamageWindow", "Root")
	AttachWindowToWorldObject(Damage.mobileId, "DamageWindow"..numWindow )
	
	--Shifts the previous damage numbers up if its too close to the new damage numbers
	--this way the damage numbers would not cover each other up
	DamageWindow.ShiftYWindowUp()
	
	windowName = "DamageWindow"..numWindow
	labelName = windowName.."Text"
	--Set the time pass to 0 
	DamageWindow.AttachedId[numWindow] = Damage.mobileId
	DamageWindow.AnchorY[numWindow] = DamageWindow.DefaultAnchorY
	LabelSetText(labelName, L""..Damage.damageNumber)
	LabelSetTextColor(labelName, Damage.red, Damage.green, Damage.blue)
	
	--Increase font size if damage number greater than
	if(Damage.damageNumber > DamageWindow.DamageMax ) then
		LabelSetFont( labelName, "UO_Chat_Helvetica_21pt", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING )
		LabelSetTextColor( labelName, 100, 175, 255 )	
		DamageWindow.AnchorY[numWindow] = DamageWindow.DefaultAnchorY +10
	end
	
	DamageWindow.FontAlpha[numWindow] = 1
	WindowAddAnchor(labelName, "bottomleft" ,windowName , "bottomleft", 0, DamageWindow.DefaultAnchorY)
	WindowSetFontAlpha( labelName, DamageWindow.FontAlpha[numWindow])
end


-- If the previous Damage Number Y anchor too close to the new damage window, increase all the damage numbers y anchors
function DamageWindow.ShiftYWindowUp()
	if DamageWindow.IsOverlap() then
		for i, id in pairs(DamageWindow.AttachedId) do
			DamageWindow.AnchorY[i] = DamageWindow.AnchorY[i] - DamageWindow.ShiftYAmount
			windowName = "DamageWindow"..i
  			labelName = windowName.."Text"
  			WindowClearAnchors(labelName)
  			WindowAddAnchor(labelName, "bottomleft",windowName , "bottomleft", 0, DamageWindow.AnchorY[i])
		end
	end
end

function DamageWindow.IsOverlap()
	for i, id in pairs(DamageWindow.AttachedId) do
		if (DamageWindow.AnchorY[i] >= DamageWindow.MaxAnchorYOverlap ) then
  			return true
  		end
  	end
  	return false
end

--The damage number moves up and slowly disappears off the screen
function DamageWindow.UpdateTime(UpdateInterfaceTime)
	count = 0
	DamageWindow.CurrentDelta = DamageWindow.CurrentDelta + UpdateInterfaceTime
	if( DamageWindow.CurrentDelta >= DamageWindow.DeltaTimeMax ) then
		for i, id in pairs(DamageWindow.AttachedId) do
  			DamageWindow.AnchorY[i] = DamageWindow.AnchorY[i] - DamageWindow.OverheadMove
	  
  			if (DamageWindow.AnchorY[i] < DamageWindow.OverheadAlive) then
  				DetachWindowFromWorldObject( id, "DamageWindow"..i )
  				DestroyWindow("DamageWindow"..i)
				DamageWindow.AnchorY[i] = 0
				DamageWindow.FontAlpha[i] = 1
				DamageWindow.AttachedId[i] = nil
  			else
  				if(DamageWindow.AnchorY[i] < DamageWindow.FadeStart) then
  					DamageWindow.FontAlpha[i] = DamageWindow.FontAlpha[i] - DamageWindow.FadeDiff
  					WindowSetFontAlpha( labelName, DamageWindow.FontAlpha[i])
  				end
  				windowName = "DamageWindow"..i
  				labelName = windowName.."Text"
  				WindowClearAnchors(labelName)
  				WindowAddAnchor(labelName, "bottomleft",windowName , "bottomleft", 0, DamageWindow.AnchorY[i])
  			end
  			count = count +1
		end

		--If count is zero reset the numWindow to 1
		if( count == 0 ) then
  			Damage.numWindow = 0
		end
		-- Reset time delta time to zero
		DamageWindow.CurrentDelta = 0
	end
end


