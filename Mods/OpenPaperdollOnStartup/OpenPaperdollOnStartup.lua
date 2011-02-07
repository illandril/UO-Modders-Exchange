OpenPaperdollOnStartup = {}
function OpenPaperdollOnStartup.Initialize()
    local playerId = WindowData.PlayerStatus.PlayerId
    local windowName = "PaperdollWindow"..playerId
    SystemData.Paperdoll.Id = playerId
    
    if not DoesWindowNameExist( windowName ) then
        CreateWindowFromTemplate( windowName, "PaperdollWindow", "Root" )
    end
end

OpenPaperdollOnStartup.cnt = 0
OpenPaperdollOnStartup.initialized = false
function OpenPaperdollOnStartup.Update()
    if not OpenPaperdollOnStartup.initialized then
        OpenPaperdollOnStartup.cnt = OpenPaperdollOnStartup.cnt + 1
        if OpenPaperdollOnStartup.cnt > 10 then
            OpenPaperdollOnStartup.initialized = true
            MenuBarWindow.TogglePaperdollWindow()
        end
    end
end
