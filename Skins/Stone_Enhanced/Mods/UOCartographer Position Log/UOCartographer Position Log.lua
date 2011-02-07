UOCartographerPositionLog = {}
UOCartographerPositionLog.LastX = 0
UOCartographerPositionLog.LastY = 0
UOCartographerPositionLog.LastFacet = 0

function UOCartographerPositionLog.Initialize()
    -- This event only gets sent at the correct times when "Center on player" is checked.
    -- If there is another event that detects when the player moves, that would be better than checking manually
    --   if the player moved or not
    --WindowRegisterEventHandler("Root", SystemData.Events.WindowData.Radar.Event, "UOCartographerPositionLog.UpdateMap")
end

function UOCartographerPositionLog.UpdateMap()
    UOCartographerPositionLog.UpdatePositionFromPlayer()
end

function UOCartographerPositionLog.Update()
    UOCartographerPositionLog.UpdatePositionFromPlayer()
end

function UOCartographerPositionLog.UpdatePositionFromPlayer()
    local waypointX = WindowData.PlayerLocation.x
    local waypointY = WindowData.PlayerLocation.y
    local waypointFacet = WindowData.PlayerLocation.facet
    UOCartographerPositionLog.UpdatePosition( waypointFacet, waypointX, waypointY )
end

function UOCartographerPositionLog.UpdatePosition( facet, x, y )
    if UOCartographerPositionLog.LastX ~= x
            or UOCartographerPositionLog.LastY ~= y
            or UOCartographerPositionLog.LastFacet ~= facet then
        UOCartographerPositionLog.LastX = x
        UOCartographerPositionLog.LastY = y
        UOCartographerPositionLog.LastFacet = facet
        TextLogCreate("pos", 1)
        TextLogSetEnabled("pos", true)
        TextLogClear("pos")
        TextLogSetIncrementalSaving( "pos", true, "logs/pos.log")
        TextLogAddFilterType( "pos", 1, L"XY: " )
        TextLogAddEntry("pos", 1, L" "..facet..L","..x..L","..y..L"!")
        TextLogDestroy("pos")
        Debug.Print( WStringToString( L" "..facet..L","..x..L","..y..L"!" ) )
    end
end
