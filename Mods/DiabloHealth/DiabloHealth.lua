DiabloHealth = {}
DiabloHealth.HPWidth = 0
DiabloHealth.HPHeight = 0
DiabloHealth.LastHPHeight = 0

function DiabloHealth.Initialize()
    local width,height = WindowGetDimensions( "DiabloHealthFill" )
    DiabloHealth.HPHeight = height
    DiabloHealth.HPWidth = width
    DiabloHealth.LastHPHeight = -1
    
    width,height = WindowGetDimensions( "DiabloManaFill" )
    DiabloHealth.MPHeight = height
    DiabloHealth.MPWidth = width
    DiabloHealth.LastMPHeight = -1
    
    DiabloHealth.OriginalUpdateStatus = StatusWindow.UpdateStatus
    StatusWindow.UpdateStatus = DiabloHealth.UpdateStatus
    DiabloHealth.UpdateStatus()
    
    WindowSetTintColor( "DiabloManaFill", 0, 0, 255 )
    WindowSetDimensions( "DiabloManaFill", DiabloHealth.HPWidth, DiabloHealth.LastMPHeight+1 )
    WindowSetDimensions( "DiabloManaFill", DiabloHealth.HPWidth, DiabloHealth.LastMPHeight )
end

function DiabloHealth.UpdateStatus()
    DiabloHealth.SetHealth( WindowData.PlayerStatus.CurrentHealth, WindowData.PlayerStatus.MaxHealth )
    DiabloHealth.SetMana( WindowData.PlayerStatus.CurrentMana, WindowData.PlayerStatus.MaxMana )
    HealthBarColor.UpdateHealthBarColor("DiabloHealthFill", WindowData.PlayerStatus.VisualStateId)
    DiabloHealth.OriginalUpdateStatus()
    -- Why set and reset the dimensions? No clue. Window tinting doesn't seem to want to work if I don't do this.
    WindowSetDimensions( "DiabloHealthFill", DiabloHealth.HPWidth, DiabloHealth.LastHPHeight+1 )
    WindowSetDimensions( "DiabloHealthFill", DiabloHealth.HPWidth, DiabloHealth.LastHPHeight )
end

function DiabloHealth.SetHealth( current, maximum )
    local height = math.ceil( ( DiabloHealth.HPHeight * current ) / maximum )
    if height ~= DiabloHealth.LastHPHeight then
        DiabloHealth.LastHPHeight = height
        WindowSetDimensions( "DiabloHealthFill", DiabloHealth.HPWidth, height )
    end
end

function DiabloHealth.SetMana( current, maximum )
    local height = math.ceil( ( DiabloHealth.MPHeight * current ) / maximum )
    if height ~= DiabloHealth.LastMPHeight then
        DiabloHealth.LastMPHeight = height
        WindowSetDimensions( "DiabloManaFill", DiabloHealth.MPWidth, height )
    end
end
