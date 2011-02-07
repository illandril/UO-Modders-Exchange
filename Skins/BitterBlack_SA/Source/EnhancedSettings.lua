----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------
EnhancedSettings = {}
EnhancedSettings.PDdelayTime = 0
EnhancedSettings.PaperdollLoaded = false

function EnhancedSettings.ToggleRestorePaperdoll( timepassed )
	if CustomSettings.LoadBooleanValue( { settingName="RestorePD", defaultValue=false } ) then
		EnhancedSettings.PDdelayTime = EnhancedSettings.PDdelayTime + timepassed
		if ( EnhancedSettings.PDdelayTime >= 4) then
			if (not EnhancedSettings.PaperdollLoaded) then
				MenuBarWindow.TogglePaperdollWindow()
				EnhancedSettings.PaperdollLoaded = true
			end
			EnhancedSettings.PDdelayTime = 0
		end
	end
end


function EnhancedSettings.RclickDestroy()
	local windowName = "MobileHealthBarWindow"
	if CustomSettings.LoadBooleanValue( { settingName="RestoreBP", defaultValue=false } ) then
	WindowClearAnchors(windowName)
            WindowAddAnchor(windowName, "topleft", parentWindow, "center", waypointX, waypointY)
end