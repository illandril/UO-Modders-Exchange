----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

RadarWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

RadarWindow.Rotation = 45
RadarWindow.Size = 0

-----------------------------------------------------------------
-- MapCommon Helper Functions
-----------------------------------------------------------------

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function RadarWindow.Initialize()
	WindowUtils.RestoreWindowPosition("RadarWindow")
	
	RadarWindow.Size = WindowGetDimensions("RadarWindowMap")

    -- Update registration
    RegisterWindowData(WindowData.Radar.Type,0)
    RegisterWindowData(WindowData.WaypointList.Type,0)
    
    WindowRegisterEventHandler("RadarWindow", WindowData.Radar.Event, "RadarWindow.UpdateRadar")	
    WindowRegisterEventHandler("RadarWindow", WindowData.WaypointList.Event, "RadarWindow.UpdateWaypoints")
end

function RadarWindow.Shutdown()
	WindowUtils.SaveWindowPosition("RadarWindow")
	
	UnregisterWindowData(WindowData.Radar.Type,0)
	UnregisterWindowData(WindowData.WaypointList.Type,0)
end

function RadarWindow.UpdateRadar() 
    if( MapCommon.ActiveView == MapCommon.RADAR_MODE_NAME ) then   
        local xOffset = RadarWindow.Size / 2
        local yOffset = RadarWindow.Size / 2
        
        CircleImageSetTexture("RadarWindowMap","radar_texture", WindowData.Radar.TexCoordX + xOffset, WindowData.Radar.TexCoordY + yOffset)
        CircleImageSetTextureScale("RadarWindowMap", WindowData.Radar.TexScale * 2.0)
        CircleImageSetRotation("RadarWindowMap", RadarWindow.Rotation)
        
        MapCommon.WaypointsDirty = true
    end
end

function RadarWindow.UpdateWaypoints()
    if( MapCommon.ActiveView == MapCommon.RADAR_MODE_NAME ) then
        MapCommon.WaypointsDirty = true
    end    
end

function RadarWindow.ActivateRadar()
    if( MapCommon.ActiveView ~= MapCommon.RADAR_MODE_NAME ) then
	    UORadarSetWindowSize(RadarWindow.Size, RadarWindow.Size, true, true)
	    UOSetRadarRotation(RadarWindow.Rotation)
	    UORadarSetWindowOffset(0, 0)
    	
	    WindowSetShowing("MapWindow", false)
	    WindowSetShowing("RadarWindow", true)
	    
	    MapCommon.ActiveView = MapCommon.RADAR_MODE_NAME
	    UOSetWaypointDisplayMode(MapCommon.RADAR_MODE_NAME)
	    
	    MapCommon.AdjustZoom(0)
	    
	    RadarWindow.UpdateRadar()
	end
end

function RadarWindow.ToggleMap()
	MapWindow.ActivateMap()
end

function RadarWindow.ToggleMapOnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.ShowAtlas))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_BOTTOM )
end

function RadarWindow.CloseMap()
	WindowSetShowing("MapWindow", false)
	WindowSetShowing("RadarWindow", false) 	
	MapCommon.ActiveView = nil
end

function RadarWindow.CloseMapOnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.Close))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_BOTTOM )
end

function RadarWindow.ZoomOutOnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.ZoomOut))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_BOTTOM )
end

function RadarWindow.ZoomInOnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.ZoomIn))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_BOTTOM )
end

function RadarWindow.RadarOnMouseWheel(x, y, delta)
    MapCommon.AdjustZoom(-delta)
end

function RadarWindow.RadarOnLButtonDblClk(flags,x,y)
	local useScale = true
    local worldX, worldY = UOGetRadarPosToWorld(x, y, useScale)
	local facet = UOGetRadarFacet()
	local area = UOGetRadarArea()
	
	if( UORadarIsLocationInArea(worldX, worldY, facet, area) ) then
		UOCenterRadarOnLocation(worldX, worldY, facet, area)
	end
end