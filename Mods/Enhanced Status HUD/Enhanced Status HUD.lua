EnhancedStatusHUD = {}

EnhancedStatusHUD.Types = { "Health", "Mana", "Stamina" }

-- Order matters! Changing this will break saved settings
EnhancedStatusHUD.HealthIconOptions = { "Skull", "Bandaid" }
EnhancedStatusHUD.Health = {
    icon = "",
    fadeDown = true,
    lastHeight = -1, -- unscaled
    width = 60, -- unscaled, maximum
    height = 60, -- unscaled, maximum
    }

EnhancedStatusHUD.ManaIconOptions = { "Wisdom" }
EnhancedStatusHUD.Mana = {
    icon = "",
    fadeDown = true,
    lastHeight = -1, -- unscaled
    width = 60, -- unscaled, maximum
    height = 60, -- unscaled, maximum
    }

EnhancedStatusHUD.StaminaIconOptions = { "Footsteps" }
EnhancedStatusHUD.Stamina = {
    icon = "",
    fadeDown = true,
    lastHeight = -1, -- unscaled
    width = 60, -- unscaled, maximum
    height = 60, -- unscaled, maximum
    }

function EnhancedStatusHUD.Initialize()
    Debug.Print("ESH START")
    Debug.Print("ESH START")
    Debug.Print("ESH START")

    for i,type in ipairs( EnhancedStatusHUD.Types ) do
        EnhancedStatusHUD.AddSettings( type )
    end
    
    CustomSettings.RegisterUpdateSettingsListener( EnhancedStatusHUD.UpdateSettings )
    EnhancedStatusHUD.UpdateSettings()
    
    EnhancedStatusHUD.OriginalUpdateStatus = StatusWindow.UpdateStatus
    StatusWindow.UpdateStatus = EnhancedStatusHUD.UpdateStatus
    EnhancedStatusHUD.UpdateStatus()
end

function EnhancedStatusHUD.AddSettings( type )
    CustomSettingsWindow.AddComboSetting( "ESH_Settings", "ESH_"..type.."Icon", "ESH_"..type.."Icon", 1, EnhancedStatusHUD[type.."IconOptions"] )
    CustomSettingsWindow.AddSliderSetting( "ESH_Settings", "ESH_"..type.."Scale", "ESH_"..type.."Scale", 100, 50, 250, 100 )
    CustomSettingsWindow.AddBooleanSetting( "ESH_Settings", "ESH_"..type.."FadeDown", "ESH_"..type.."FadeDown", true )
    CustomSettingsWindow.AddBooleanSetting( "ESH_Settings", "ESH_"..type.."Mobile", "ESH_"..type.."Mobile", true )
    CustomSettingsWindow.AddBooleanSetting( "ESH_Settings", "ESH_"..type.."TopLeft", "ESH_"..type.."TopLeft", false )
    CustomSettingsWindow.AddBooleanSetting( "ESH_Settings", "ESH_"..type.."TopRight", "ESH_"..type.."TopRight", false )
    CustomSettingsWindow.AddBooleanSetting( "ESH_Settings", "ESH_"..type.."BottomLeft", "ESH_"..type.."BottomLeft", false )
    CustomSettingsWindow.AddBooleanSetting( "ESH_Settings", "ESH_"..type.."BottomRight", "ESH_"..type.."BottomRight", false )
end

function EnhancedStatusHUD.Shutdown()
    Debug.Print( "Shutdown" )
    for i,type in ipairs( EnhancedStatusHUD.Types ) do
        -- We check to make sure it still exists, because it might be one of the old ones going away
        local window, icon = EnhancedStatusHUD.GetWindowName( EnhancedStatusHUD[type] )
        if DoesWindowExist( window ) then
            WindowUtils.SaveWindowPosition( window, true, "ESH_"..type )
        end
    end
end

function EnhancedStatusHUD.UpdateSettings()
    for i,type in ipairs( EnhancedStatusHUD.Types ) do
        EnhancedStatusHUD.ResetWindow( type )
    end
    EnhancedStatusHUD.UpdateStatus()
end

function EnhancedStatusHUD.ResetWindow( type )
    local oldWindowName, oldIconName = EnhancedStatusHUD.GetWindowName( EnhancedStatusHUD[type] )
    
    EnhancedStatusHUD[type].icon = EnhancedStatusHUD[type.."IconOptions"][ CustomSettings.LoadNumberValue( { settingName="ESH_"..type.."Icon", defaultValue=1 } ) ]
    EnhancedStatusHUD[type].fadeDown = CustomSettings.LoadBooleanValue( { settingName="ESH_"..type.."FadeDown", defaultValue=true } )
    
    local newWindowName, newIconName = EnhancedStatusHUD.GetWindowName( EnhancedStatusHUD[type] )
    if oldWindowName ~= newWindowName then
        if DoesWindowExist( oldWindowName ) then
            WindowUtils.SaveWindowPosition( oldWindowName, false, "ESH_"..type )
            WindowSetShowing( oldWindowName, false )
        end
        
        if DoesWindowExist( newWindowName ) then
            WindowSetShowing( newWindowName, true )
        else
            CreateWindow( newWindowName, true )
            WindowSetShowing( newWindowName.."Bottom", false )
            WindowSetShowing( newWindowName.."Top", false )
            WindowSetShowing( newWindowName.."TL", false )
            WindowSetShowing( newWindowName.."TR", false )
            WindowSetShowing( newWindowName.."BL", false )
            WindowSetShowing( newWindowName.."BR", false )
        end
        WindowUtils.RestoreWindowPosition( newWindowName, false, "ESH_"..type )
    end
    if oldIconName ~= newIconName then
        if DoesWindowExist( oldIconName ) then
            WindowSetShowing( oldIconName, false )
        end
        WindowSetShowing( newIconName, true )
    end
    
    local scale = CustomSettings.LoadNumberValue( { settingName="ESH_"..type.."Scale", defaultValue=100 } ) / 100.0
    local mobile = CustomSettings.LoadBooleanValue( { settingName="ESH_"..type.."Mobile", defaultValue=true } )
    WindowSetScale( newWindowName, scale )
    WindowSetMovable( newWindowName, mobile )
    
    local tl = CustomSettings.LoadBooleanValue( { settingName="ESH_"..type.."TopLeft", defaultValue=false } )
    local tr = CustomSettings.LoadBooleanValue( { settingName="ESH_"..type.."TopRight", defaultValue=false } )
    local bl = CustomSettings.LoadBooleanValue( { settingName="ESH_"..type.."BottomLeft", defaultValue=false } )
    local br = CustomSettings.LoadBooleanValue( { settingName="ESH_"..type.."BottomRight", defaultValue=false } )
    WindowSetShowing( newWindowName.."TL", tl )
    WindowSetShowing( newWindowName.."TR", tr )
    WindowSetShowing( newWindowName.."BL", bl )
    WindowSetShowing( newWindowName.."BR", br )
end

function EnhancedStatusHUD.GetWindowName( window )
    local name = "ESH_"..window.icon
    local direction = "Top"
    if window.fadeDown then
        direction = "Bottom"
    end
    return name, name..direction
end

function EnhancedStatusHUD.UpdateStatus()
    if EnhancedStatusHUD.OriginalUpdateStatus == nil then
        return -- Called before initialization was finished
    end
    EnhancedStatusHUD.OriginalUpdateStatus()
    
    EnhancedStatusHUD.SetTypeDisplay( "Health", WindowData.PlayerStatus.CurrentHealth, WindowData.PlayerStatus.MaxHealth )
    local healthWindow, healthIcon = EnhancedStatusHUD.GetWindowName( EnhancedStatusHUD.Health )
    HealthBarColor.UpdateHealthBarColor( healthIcon, WindowData.PlayerStatus.VisualStateId )
    -- Why set and reset the dimensions? No clue. Window tinting doesn't seem to want to work if I don't do this.
    WindowSetDimensions( healthIcon, EnhancedStatusHUD.Health.width, EnhancedStatusHUD.Health.lastHeight + 1 )
    WindowSetDimensions( healthIcon, EnhancedStatusHUD.Health.width, EnhancedStatusHUD.Health.lastHeight )
    
    EnhancedStatusHUD.SetTypeDisplay( "Mana", WindowData.PlayerStatus.CurrentMana, WindowData.PlayerStatus.MaxMana )
    EnhancedStatusHUD.SetTypeDisplay( "Stamina", WindowData.PlayerStatus.CurrentStamina, WindowData.PlayerStatus.MaxStamina )
end

function EnhancedStatusHUD.SetTypeDisplay( type, current, maximum )
    local height = math.ceil( ( EnhancedStatusHUD[type].height * current ) / maximum )
    if height ~= EnhancedStatusHUD[type].lastHeight then
        local window, icon = EnhancedStatusHUD.GetWindowName( EnhancedStatusHUD[type] )
        EnhancedStatusHUD[type].lastHeight = height
        WindowSetDimensions( icon, EnhancedStatusHUD[type].width, height )
    end
end
