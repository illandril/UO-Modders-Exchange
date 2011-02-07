----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

StatusWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

StatusWindow.CurPlayerId = 0

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function StatusWindow.Initialize()
	RegisterWindowData(WindowData.PlayerStatus.Type,0)
	WindowRegisterEventHandler( "StatusWindow", WindowData.PlayerStatus.Event, "StatusWindow.UpdateStatus")
	StatusWindow.UpdateStatus()
	StatusWindow.ToggleStrLabel()
	-- TODO: Once someone fixes the baseline alignment of the various fonts (so that English isn't 3 pixels above every other language), remove this hack.
	-- START HACK
	if GetStringFromTid( 1011036 ) ~= L"OKAY" then -- assume not English
		local healthLabelName = "StatusWindowHealthTooltip"
		local manaLabelName = "StatusWindowManaTooltip"
		local staminaLabelName = "StatusWindowStaminaTooltip"
		local healthBarName = "StatusWindowHealthBar"
		local manaBarName = "StatusWindowManaBar"
		local staminaBarName = "StatusWindowStaminaBar"
		WindowClearAnchors( healthLabelName )
		WindowClearAnchors( manaLabelName )
		WindowClearAnchors( staminaLabelName )
		WindowAddAnchor( healthLabelName, "right", healthBarName, "left", -4, -3 )
		WindowAddAnchor( manaLabelName, "right", manaBarName, "left", -4, 2 )
		WindowAddAnchor( staminaLabelName, "right", staminaBarName, "left", -4, 7 )
	end	
	-- END HACK
	WindowUtils.RestoreWindowPosition("StatusWindow")
end

function StatusWindow.Shutdown()
	UnregisterWindowData(WindowData.PlayerStatus.Type,0)
	WindowUtils.SaveWindowPosition("StatusWindow")
end

function StatusWindow.UpdateStatus()
	--Debug.PrintToDebugConsole(L"UPDATING STATUS")

	StatusBarSetMaximumValue( "StatusWindowHealthBar", WindowData.PlayerStatus.MaxHealth )
	StatusBarSetMaximumValue( "StatusWindowManaBar", WindowData.PlayerStatus.MaxMana )
	StatusBarSetMaximumValue( "StatusWindowStaminaBar", WindowData.PlayerStatus.MaxStamina )	
	StatusBarSetCurrentValue( "StatusWindowHealthBar", WindowData.PlayerStatus.CurrentHealth )
	StatusBarSetCurrentValue( "StatusWindowManaBar", WindowData.PlayerStatus.CurrentMana )
	StatusBarSetCurrentValue( "StatusWindowStaminaBar", WindowData.PlayerStatus.CurrentStamina )
	
	--Colors the health bar to the correct color
	HealthBarColor.UpdateHealthBarColor("StatusWindowHealthBar", WindowData.PlayerStatus.VisualStateId)
	--Update label tooltip health, mana, and stamina
	StatusWindow.UpdateLabelContent()
	
	if( WindowData.PlayerStatus.InWarMode ) then
		WindowSetTintColor("StatusWindowPortraitBg",255,0,0);
	else
		WindowSetTintColor("StatusWindowPortraitBg",255,255,255);
	end
	
	if( SystemData.PaperdollTexture[WindowData.PlayerStatus.PlayerId] ~= nil) then
		local textureData = SystemData.PaperdollTexture[WindowData.PlayerStatus.PlayerId]	
		
		CircleImageSetTexture("StatusWindowPortrait","paperdoll_texture"..WindowData.PlayerStatus.PlayerId,-textureData.xOffset-11,-textureData.yOffset-191);
		StatusWindow.CurPlayerId = WindowData.PlayerStatus.PlayerId
	end
end

function StatusWindow.OnLButtonUp()
	WindowSetMoving("StatusWindow",false)
	HandleSingleLeftClkTarget(WindowData.PlayerStatus.PlayerId)
end

function StatusWindow.OnLButtonDown()
	WindowSetMoving("StatusWindow",true)
end

function StatusWindow.OnRButtonUp()
	RequestContextMenu(WindowData.PlayerStatus.PlayerId)
end

function StatusWindow.UpdateLabelContent()
	local healthLabelName = "StatusWindowHealthTooltip"
	local manaLabelName = "StatusWindowManaTooltip"
	local staminaLabelName = "StatusWindowStaminaTooltip"
	local healthStr = L""..WindowData.PlayerStatus.CurrentHealth..L"/"..WindowData.PlayerStatus.MaxHealth
	local manaStr = WindowData.PlayerStatus.CurrentMana..L"/"..WindowData.PlayerStatus.MaxMana
	local staminaStr = WindowData.PlayerStatus.CurrentStamina..L"/"..WindowData.PlayerStatus.MaxStamina
	--local statStr = healthStr..L"<BR>"..manaStr..L"<BR>"..staminaStr
	LabelSetText(healthLabelName, WindowUtils.translateMarkup(healthStr))
	LabelSetText(manaLabelName, WindowUtils.translateMarkup(manaStr))
	LabelSetText(staminaLabelName, WindowUtils.translateMarkup(staminaStr))
end

function StatusWindow.OnMouseOver()
	if(SystemData.Settings.GameOptions.showStrLabel == false) then
		WindowSetShowing("StatusWindowHealthTooltip", true)
		WindowSetShowing("StatusWindowManaTooltip", true)
		WindowSetShowing("StatusWindowStaminaTooltip", true)
	end
end

function StatusWindow.OnMouseOverEnd()
	if(SystemData.Settings.GameOptions.showStrLabel == false) then
		WindowSetShowing("StatusWindowHealthTooltip", false)
		WindowSetShowing("StatusWindowManaTooltip", false)
		WindowSetShowing("StatusWindowStaminaTooltip", false)
	end
end

function StatusWindow.ToggleStrLabel()
	local healthLabelName = "StatusWindowHealthTooltip"
	local manaLabelName = "StatusWindowManaTooltip"
	local staminaLabelName = "StatusWindowStaminaTooltip"
	if(SystemData.Settings.GameOptions.showStrLabel == false) then
		WindowSetShowing(healthLabelName, false)
		WindowSetShowing(manaLabelName, false)
		WindowSetShowing(staminaLabelName, false)
	else
		WindowSetShowing(healthLabelName, true)
		WindowSetShowing(manaLabelName, true)
		WindowSetShowing(staminaLabelName, true)
	end
end

function StatusWindow.OnMouseDlbClk()
    local showing = WindowGetShowing("CharacterSheet")
    WindowSetShowing("CharacterSheet",not showing)
end