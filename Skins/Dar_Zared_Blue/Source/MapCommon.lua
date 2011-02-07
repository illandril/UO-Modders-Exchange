----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MapCommon = {}

MapCommon.ActiveView = nil

MapCommon.MAP_MODE_NAME = "ATLAS"
MapCommon.RADAR_MODE_NAME = "RADAR"

MapCommon.TID = {Waypoints=1078474, WorldMap=1077438, YourLocation=1078897,
			     CreateWaypoint=1079482, EditWaypoint=1079483, DeleteWaypoint=1079484, ViewWaypoint=1079571, Close=1052061,
			     Atlas=1111703, ShowLegend=1111706, ZoomOut=1079289, ZoomIn=1079288, ShowRadar=1112106, ShowAtlas=1112107 }

MapCommon.NumFacets = 6

MapCommon.ZoomLevel = {}
MapCommon.ZoomLevel[MapCommon.MAP_MODE_NAME] = {}
MapCommon.ZoomLevel[MapCommon.MAP_MODE_NAME].Step = 0.05
MapCommon.ZoomLevel[MapCommon.MAP_MODE_NAME].Current = 0.05
MapCommon.ZoomLevel[MapCommon.MAP_MODE_NAME].Min = 0.0
MapCommon.ZoomLevel[MapCommon.MAP_MODE_NAME].Max = 1.0
MapCommon.ZoomLevel[MapCommon.MAP_MODE_NAME].IconScale = 1.0
MapCommon.ZoomLevel[MapCommon.RADAR_MODE_NAME] = {}
MapCommon.ZoomLevel[MapCommon.RADAR_MODE_NAME].Step = 0.50
MapCommon.ZoomLevel[MapCommon.RADAR_MODE_NAME].Current= -0.50
MapCommon.ZoomLevel[MapCommon.RADAR_MODE_NAME].Min= -2.0
MapCommon.ZoomLevel[MapCommon.RADAR_MODE_NAME].Max= 0.0
MapCommon.ZoomLevel[MapCommon.RADAR_MODE_NAME].IconScale = 1.0

MapCommon.WaypointViewInfo = {}
MapCommon.WaypointViewInfo[MapCommon.MAP_MODE_NAME] = {}
MapCommon.WaypointViewInfo[MapCommon.MAP_MODE_NAME].Parent = "MapImage"
MapCommon.WaypointViewInfo[MapCommon.MAP_MODE_NAME].Windows = {}
MapCommon.WaypointViewInfo[MapCommon.MAP_MODE_NAME].PlayerVisible = true
MapCommon.WaypointViewInfo[MapCommon.MAP_MODE_NAME].WaypointsEnabled = true

MapCommon.WaypointViewInfo[MapCommon.RADAR_MODE_NAME] = {}
MapCommon.WaypointViewInfo[MapCommon.RADAR_MODE_NAME].Parent = "RadarWindowMap"
MapCommon.WaypointViewInfo[MapCommon.RADAR_MODE_NAME].Windows = {}
MapCommon.WaypointViewInfo[MapCommon.RADAR_MODE_NAME].PlayerVisible = true
MapCommon.WaypointViewInfo[MapCommon.RADAR_MODE_NAME].WaypointsEnabled = true

MapCommon.WaypointMaxId = 0
MapCommon.WaypointsDirty = false
MapCommon.WaypointCustomType = 15
MapCommon.WaypointPlayerVisible = true
MapCommon.WaypointPlayerType = 14
MapCommon.WaypointPlayerId = 10000
MapCommon.WaypointIsMouseOver = false

MapCommon.ContextReturnCodes = {}
MapCommon.ContextReturnCodes.CREATE_WAYPOINT = 0
MapCommon.ContextReturnCodes.DELETE_WAYPOINT = 1
MapCommon.ContextReturnCodes.VIEW_WAYPOINT = 2

MapCommon.MapBorder = {}
MapCommon.MapBorder.TOP = 225
MapCommon.MapBorder.BOTTOM = 880
MapCommon.MapBorder.LEFT = 190
MapCommon.MapBorder.RIGHT = 900

MapCommon.sextantDefaultCenterX=1323
MapCommon.sextantDefaultCenterY=1624
MapCommon.sextantLostLandCenterX=5936
MapCommon.sextantLostLandCenterY=3112
MapCommon.sextantLostLandTopLeftX = 5120
MapCommon.sextantLostLandTopLeftY = 2304
MapCommon.sextantMaximumX = 5120;
MapCommon.sextantMaximumY = 4096;

MapCommon.sextantFeluccaLostLands = 13
MapCommon.sextantTrammelLostLands = 14

MapCommon.SavedZoom = 0

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function MapCommon.WaypointViewInfo.ATLAS.VisibleFunc(wtype,wx,wy)
    if (MapWindow.TypeEnabled[wtype] == true) then
		local facet = UOGetRadarFacet()
		local area = UOGetRadarArea()
		
		return UORadarIsLocationInArea(wx, wy, facet, area)
    end
    
    return false
end

function MapCommon.WaypointViewInfo.RADAR.VisibleFunc(wtype,wx,wy)
    local radius = (RadarWindow.Size/2)
    local waypointX, waypointY = UOGetWorldPosToRadar(wx, wy)
    local WaypointDistanceFromCenter = ( (math.abs(waypointX - radius)) ^ 2 +
	    							     (math.abs(waypointY - radius)) ^ 2) ^ 0.5
	return (WaypointDistanceFromCenter < radius)
end


function MapCommon.Initialize()
    -- create the player waypoints
    local parent = MapCommon.WaypointViewInfo[MapCommon.RADAR_MODE_NAME].Parent
    local windowName = "Waypoint"..MapCommon.WaypointPlayerId..MapCommon.RADAR_MODE_NAME
    CreateWindowFromTemplate(windowName, "WaypointIconTemplate", parent)
    WindowSetId(windowName,MapCommon.WaypointPlayerId)
    parent = MapCommon.WaypointViewInfo[MapCommon.MAP_MODE_NAME].Parent
    windowName = "Waypoint"..MapCommon.WaypointPlayerId..MapCommon.MAP_MODE_NAME
    CreateWindowFromTemplate(windowName, "WaypointIconTemplate", parent)
    WindowSetId(windowName,MapCommon.WaypointPlayerId)
    
    RegisterWindowData(WindowData.PlayerLocation.Type,0)
end

function MapCommon.Shutdown()
    UnregisterWindowData(WindowData.PlayerLocation.Type,0)
end

function MapCommon.Update()
    if( MapCommon.WaypointsDirty == true and
            MapCommon.ActiveView ~= nil and
            MapCommon.WaypointViewInfo[MapCommon.MAP_MODE_NAME].WaypointsEnabled == true ) then
        MapCommon.UpdateWaypoints(MapCommon.ActiveView)
        MapCommon.WaypointsDirty = false
        RadarWindow.SetRadarCoords()
    end
end

function MapCommon.AdjustZoom(zoomDelta)
	if( MapCommon.ActiveView ~= nil) then
		local step = MapCommon.ZoomLevel[MapCommon.ActiveView].Step
		if (MapCommon.ZoomLevel[MapCommon.ActiveView].Current < 0.0) then
			step = 0.5
		end
		MapCommon.ZoomLevel[MapCommon.ActiveView].Current = MapCommon.ZoomLevel[MapCommon.ActiveView].Current + ( zoomDelta * step )
		
		if (MapCommon.ZoomLevel[MapCommon.ActiveView].Current > MapCommon.ZoomLevel[MapCommon.ActiveView].Max) then
			MapCommon.ZoomLevel[MapCommon.ActiveView].Current = MapCommon.ZoomLevel[MapCommon.ActiveView].Max
		end
		if (MapCommon.ZoomLevel[MapCommon.ActiveView].Current < MapCommon.ZoomLevel[MapCommon.ActiveView].Min) then
			MapCommon.ZoomLevel[MapCommon.ActiveView].Current = MapCommon.ZoomLevel[MapCommon.ActiveView].Min
		end
		
		UOSetRadarZoom(MapCommon.ZoomLevel[MapCommon.ActiveView].Current)
		--Debug.Print(L"MapCommon.AdjustZoom "..MapCommon.ZoomLevel[MapCommon.ActiveView].Current)
		MapCommon.SavedZoom = MapCommon.ZoomLevel[MapCommon.ActiveView].Current
	end
end

function MapCommon.ChangeMap(facet, area)
	local x1, y1, x2, y2 = UORadarGetAreaDimensions(facet, area)
	local centerX = ( ( x2 - x1 ) / 2 ) + x1
	local centerY = ( ( y2 - y1 ) / 2 ) + y1
	
	UOCenterRadarOnLocation(centerX, centerY, facet, area)
	
	MapCommon.AdjustZoom(MapCommon.SavedZoom)
	MapCommon.UpdateZoomValues(facet, area)
	
	--Debug.Print(L"MapCommon.ChangeMap "..MapCommon.ZoomLevel[MapCommon.ActiveView].Current)
	
end

function MapCommon.UpdateZoomValues(facet, area)
	if( MapCommon.ActiveView == MapCommon.MAP_MODE_NAME ) then
		local maxZoom = UORadarGetMaxZoomForMap(facet, area)
		
		if( maxZoom > 0 ) then
			MapCommon.ZoomLevel[MapCommon.ActiveView].Current = maxZoom
			MapCommon.ZoomLevel[MapCommon.ActiveView].Min = -2.0
			MapCommon.ZoomLevel[MapCommon.ActiveView].Max = maxZoom
			MapCommon.ZoomLevel[MapCommon.ActiveView].Step = MapCommon.ZoomLevel[MapCommon.ActiveView].Max / 5
		else
			MapCommon.ZoomLevel[MapCommon.ActiveView].Current = 0.0
			MapCommon.ZoomLevel[MapCommon.ActiveView].Min = -2.0
			MapCommon.ZoomLevel[MapCommon.ActiveView].Max = 0.0
			MapCommon.ZoomLevel[MapCommon.ActiveView].Step = 0.50
		end
	end
end

function MapCommon.GetWaypointScale(displayMode)
	local iconScale = 1
	if( displayMode == MapCommon.MAP_MODE_NAME ) then
		local iconSpan = MapCommon.ZoomLevel[MapCommon.MAP_MODE_NAME].Max - MapCommon.ZoomLevel[MapCommon.MAP_MODE_NAME].Min
		iconScale = MapCommon.ZoomLevel[MapCommon.MAP_MODE_NAME].Current - MapCommon.ZoomLevel[MapCommon.MAP_MODE_NAME].Min
		iconScale = 1.0 - (iconScale / iconSpan) * 0.5
	end
	return iconScale;
end

function MapCommon.UpdateWaypointIcon(iconId,windowName,displayMode)
    local iconTexture, x, y = GetIconData(iconId)
    local iconWidth, iconHeight = UOGetTextureSize("icon"..iconId)
		local iconScale = MapCommon.GetWaypointScale(displayMode)
		
    WindowSetDimensions(windowName, iconWidth * iconScale, iconHeight * iconScale)
    DynamicImageSetTextureDimensions(windowName, iconWidth, iconHeight)
    DynamicImageSetTexture(windowName, iconTexture, x, y)
end

function MapCommon.UpdateWaypoints(displayMode)
    local parentWindow = MapCommon.WaypointViewInfo[displayMode].Parent
    local visibleFunc = MapCommon.WaypointViewInfo[displayMode].VisibleFunc

    local facet = UOGetRadarFacet()
    UOSetWaypointMapFacet(facet) 
		
    for waypointId = 1,WindowData.WaypointList.waypointCount do	
        local wtype, wflags, wname, wfacet, wx, wy, wz = UOGetWaypointInfo(waypointId) 
        local windowName = "Waypoint"..waypointId..displayMode
        
        if( visibleFunc(wtype,wx,wy) ) then
            local waypointX, waypointY = UOGetWorldPosToRadar(wx, wy)
        
            if( MapCommon.WaypointViewInfo[displayMode].Windows[waypointId] == nil ) then
                CreateWindowFromTemplate(windowName, "WaypointIconTemplate", parentWindow)
                MapCommon.WaypointViewInfo[displayMode].Windows[waypointId] = windowName
                WindowSetId(windowName,waypointId)
            end

            WindowClearAnchors(windowName)
            WindowAddAnchor(windowName, "topleft", parentWindow, "center", waypointX, waypointY)
        
    	    local iconId = WindowData.WaypointDisplay.displayTypes[displayMode][wtype].iconId
	        MapCommon.UpdateWaypointIcon(iconId,windowName,displayMode)
	    elseif( MapCommon.WaypointViewInfo[displayMode].Windows[waypointId] ~= nil ) then
            DestroyWindow(windowName)
            MapCommon.WaypointViewInfo[displayMode].Windows[waypointId] = nil
	    end
    end
    
    -- delete the rest of the waypoint windows
    for waypointId=WindowData.WaypointList.waypointCount+1, MapCommon.WaypointMaxId do
		modeToDelete = nil
		if( MapCommon.WaypointViewInfo[MapCommon.MAP_MODE_NAME].Windows[waypointId] ~= nil ) then
			modeToDelete = MapCommon.MAP_MODE_NAME
		elseif( MapCommon.WaypointViewInfo[MapCommon.RADAR_MODE_NAME].Windows[waypointId] ~= nil ) then
			modeToDelete = MapCommon.RADAR_MODE_NAME
		end
		
        if( modeToDelete ~= nil and MapCommon.WaypointViewInfo[modeToDelete].Windows[waypointId] ~= nil ) then
            local windowName = "Waypoint"..waypointId..modeToDelete
            DestroyWindow(windowName)
            MapCommon.WaypointViewInfo[modeToDelete].Windows[waypointId] = nil
        end
    end
    MapCommon.WaypointMaxId = WindowData.WaypointList.waypointCount
    
    MapCommon.WaypointMouseOverEnd()
    
    -- do player waypoint  
    windowName = "Waypoint"..MapCommon.WaypointPlayerId..displayMode
    local playerVisible = WindowData.PlayerLocation.facet == facet and visibleFunc(MapCommon.WaypointPlayerType,WindowData.PlayerLocation.x,WindowData.PlayerLocation.y)
    if( playerVisible ~= MapCommon.WaypointViewInfo[displayMode].PlayerVisible ) then
        WindowSetShowing(windowName,playerVisible)
        MapCommon.WaypointViewInfo[displayMode].PlayerVisible = playerVisible
    end
    
    if( playerVisible ) then        
        WindowClearAnchors(windowName)
	    local playerX, playerY = UOGetWorldPosToRadar(WindowData.PlayerLocation.x, WindowData.PlayerLocation.y)
	    WindowAddAnchor(windowName, "topleft", parentWindow, "center", playerX, playerY)

	    local iconId = WindowData.WaypointDisplay.displayTypes[displayMode][MapCommon.WaypointPlayerType].iconId
        MapCommon.UpdateWaypointIcon(iconId,windowName,displayMode)
    end
end

function MapCommon.SetWaypointsEnabled(displayMode,isEnabled)
    if( isEnabled ~= MapCommon.WaypointViewInfo[displayMode].WaypointsEnabled ) then
        for windowId, windowName in pairs(MapCommon.WaypointViewInfo[displayMode].Windows) do
            WindowSetShowing(windowName,isEnabled)
        end
        
        if( MapCommon.WaypointViewInfo[displayMode].PlayerVisible ) then
            windowName = "Waypoint"..MapCommon.WaypointPlayerId..displayMode
            WindowSetShowing(windowName,isEnabled)
        end
        
        MapCommon.WaypointViewInfo[displayMode].WaypointsEnabled = isEnabled
    end
end

function MapCommon.GetSextantCenterByArea(facet, area)
	if( (facet == 0 and area == MapCommon.sextantFeluccaLostLands) or (facet == 1 and area == MapCommon.sextantTrammelLostLands) ) then
		return MapCommon.sextantLostLandCenterX, MapCommon.sextantLostLandCenterY
	else
		return MapCommon.sextantDefaultCenterX, MapCommon.sextantDefaultCenterY
	end
end

function MapCommon.ConvertToXYMinutes(latVal, longVal, latDir, longDir, facet, area)
	local sectCenterX, sectCenterY = MapCommon.GetSextantCenterByArea(facet, area)
	
	local minutesX, minutesY
	if(latDir == L"N") then
		minutesY = -1 * math.ceil(latVal) * 60 + ( (latVal % 1) * 100 )
	else
		minutesY = math.floor(latVal) * 60 + ( (latVal % 1) * 100 )
	end
	if(longDir == L"W") then
		minutesX = -1 * math.ceil(longVal) * 60 + ( (longVal % 1) * 100 )
	else
		minutesX = math.floor(longVal) * 60 + ( (longVal % 1) * 100 )
	end
	
	local x = minutesX / 21600 * MapCommon.sextantMaximumX + sectCenterX
	local y = minutesY / 21600 * MapCommon.sextantMaximumY + sectCenterY
	
	if (x < 0) then
		x = x + MapCommon.sextantMaximumX
	end
	if (x >= MapCommon.sextantMaximumX) then
		x = x - MapCommon.sextantMaximumX
	end
	if (y < 0) then
		y = y + MapCommon.sextantMaximumY
	end
	if (y >= MapCommon.sextantMaximumY) then
		y = y - MapCommon.sextantMaximumY
	end
	
	return x, y
end

function MapCommon.GetSextantCenter(x,y,facet)
	if( (facet == 0 or facet == 1) and (x >= MapCommon.sextantLostLandTopLeftX) and (y >= MapCommon.sextantLostLandTopLeftY)) then
		return MapCommon.sextantLostLandCenterX, MapCommon.sextantLostLandCenterY
	else
		return MapCommon.sextantDefaultCenterX, MapCommon.sextantDefaultCenterY
	end
end

function MapCommon.ConvertToMinutesXY(x,y,facet)
	local sectCenterX, sectCenterY = MapCommon.GetSextantCenter(x,y,facet) 
    
	local minutesX = 21600 * (x - sectCenterX) / MapCommon.sextantMaximumX
	local minutesY = 21600 * (y - sectCenterY) / MapCommon.sextantMaximumY

	if minutesX > 10800 then
		minutesX = minutesX - 21600
	end
	if minutesX <= -10800 then
		minutesX = minutesX + 21600
	end
	if minutesY > 10800 then
		minutesY = minutesY - 21600
	end
	if minutesY <= -10800 then
		minutesY = minutesY + 21600
	end
	
	return minutesX, minutesY
end

function MapCommon.GetSextantLocationStrings(x,y,facet)
    local minutesX, minutesY = MapCommon.ConvertToMinutesXY(x,y,facet)
    
    local latDir = L"S"
    local longDir = L"E"
    
    if minutesY < 0 then
		latDir = L"N"
		minutesY = -minutesY
	end
    if minutesX < 0 then
		longDir = L"W"
		minutesX = -minutesX
    end
    
    local latString = StringToWString( string.format( "%d", (minutesY/60) ) )..L"."..StringToWString( string.format( "%02d", (minutesY%60) ) )
    local longString = StringToWString( string.format( "%d", (minutesX/60) ) )..L"."..StringToWString( string.format( "%02d", (minutesX%60) ) )
    
    return latString, longString, latDir, longDir
end

function MapCommon.WaypointMouseOver()
    if( MapCommon.ActiveView ~= nil ) then
        if( DoesWindowExist("WaypointInfo") ) then
            DestroyWindow("WaypointInfo")
        end
        
        MapCommon.WaypointIsMouseOver = true
        
        local waypointId = WindowGetId(SystemData.ActiveWindow.name)
        local waypointWindow = "Waypoint"..waypointId..MapCommon.ActiveView
        local waypointName = "Invalid Waypoint"
        local waypointX = 0
        local waypointY = 0
        
        if( waypointId ~= MapCommon.WaypointPlayerId ) then
            local wtype, wflags, wname, wfacet, wx, wy, wz = UOGetWaypointInfo(waypointId)	
            waypointName = wname
            waypointX = wx
            waypointY = wy
            waypointFacet = wfacet
        else
            waypointName = GetStringFromTid(MapCommon.TID.YourLocation)
            waypointX = WindowData.PlayerLocation.x
            waypointY = WindowData.PlayerLocation.y
            waypointFacet = WindowData.PlayerLocation.facet
        end
        
        CreateWindowFromTemplate("WaypointInfo","WaypointInfoTemplate", MapCommon.WaypointViewInfo[MapCommon.ActiveView].Parent)
        WindowClearAnchors("WaypointInfo")
        WindowAddAnchor("WaypointInfo","center",waypointWindow,"bottomleft",0,0)
                
        LabelSetText("WaypointInfoDetails",waypointName)
        local latStr, longStr, latDir, longDir = MapCommon.GetSextantLocationStrings(waypointX, waypointY, waypointFacet)
        LabelSetText("WaypointInfoLocation", latStr..L"'"..latDir..L" "..longStr..L"'"..longDir)
        
        if( MapCommon.ActiveView == MapCommon.MAP_MODE_NAME ) then
			LabelSetText("MapWindowCoordsText", latStr..L"'"..latDir..L" "..longStr..L"'"..longDir)
        end
        
        local w1, h1 = LabelGetTextDimensions("WaypointInfoDetails")
        local w2, h2 = LabelGetTextDimensions("WaypointInfoLocation")
        local infoWindowWidth = math.max(w1,w2) + 6
        local infoWindowHeight = h1 + h2 + 9
        
        WindowSetDimensions("WaypointInfo",infoWindowWidth,infoWindowHeight)
    end
end

function MapCommon.WaypointMouseOverEnd()
	MapCommon.WaypointIsMouseOver = false
	
    if( DoesWindowExist("WaypointInfo") ) then
        DestroyWindow("WaypointInfo")
    end    
end

function MapCommon.WaypointOnRButtonUp()
	local waypointWindowName = SystemData.ActiveWindow.name
	local waypointId = WindowGetId(waypointWindowName)
	local params = {id=waypointId, x=nil, y=nil, facetId=UOGetRadarFacet(), type=nil, name=nil}
	
	if (waypointId == MapCommon.WaypointPlayerId) then
		params.x, params.y = WindowData.PlayerLocation.x, WindowData.PlayerLocation.y
		params.type = MapCommon.WaypointPlayerType
		params.name = GetStringFromTid(MapCommon.TID.YourLocation)
	else
		local wtype, wflags, wname, wfacet, wx, wy, wz = UOGetWaypointInfo(waypointId)
		params.x, params.y = wx, wy
		params.type = wtype
		params.name = wname
	end
	
	-- IF CUSTOM WAYPOINT TYPE, SHOW DELETE WAYPOINT
	if (SystemData.Waypoint.TypeIsCustomizable[params.type] == 1) then
		ContextMenu.CreateLuaContextMenuItem(MapCommon.TID.DeleteWaypoint,0,MapCommon.ContextReturnCodes.DELETE_WAYPOINT,params)
	-- IF PLAYER WAYPOINT TYPE, SHOW CREATE WAYPOINT UI	
	elseif (waypointId == MapCommon.WaypointPlayerId) then
		ContextMenu.CreateLuaContextMenuItem(MapCommon.TID.CreateWaypoint,0,MapCommon.ContextReturnCodes.CREATE_WAYPOINT,params)
	-- IF REGULAR WAYPOINT TYPE, SHOW VIEW WAYPOINT UI	
	else
		ContextMenu.CreateLuaContextMenuItem(MapCommon.TID.ViewWaypoint,0,MapCommon.ContextReturnCodes.VIEW_WAYPOINT,params)
	end
	
	ContextMenu.ActivateLuaContextMenu(MapCommon.ContextMenuCallback)
end

function MapCommon.ContextMenuCallback(returnCode, params)
	if( params ~= nil ) then
		if (returnCode == MapCommon.ContextReturnCodes.CREATE_WAYPOINT) then
			UserWaypointWindow.InitializeCreateWaypointData(params)
		elseif(returnCode == MapCommon.ContextReturnCodes.DELETE_WAYPOINT) then
			UODeleteUserWaypoint(params.id)
		elseif(returnCode == MapCommon.ContextReturnCodes.VIEW_WAYPOINT) then
			UserWaypointWindow.InitializeViewWaypointData(params)
		end
	end
end

function MapCommon.GetRadarBorders(facet, area)
	local x1, y1, x2, y2 = UORadarGetAreaDimensions(facet, area)
	
	if( x1 ~= nil and x2 ~= nil and y1 ~= nil and y2 ~= nil ) then
	    local upperLeftX, upperLeftY = UOGetWorldPosToRadar(x1, y1)
	    local upperRightX, upperRightY = UOGetWorldPosToRadar(x2, y1)
	    local lowerLeftX, lowerLeftY = UOGetWorldPosToRadar(x1, y2)
	    local lowerRightX, lowerRightY = UOGetWorldPosToRadar(x2, y2)
    	
	    -- top, bottom, left, right
	    return upperLeftY, lowerRightY, lowerLeftX, upperRightX
	else
	    return 0,0,0,0
	end
end