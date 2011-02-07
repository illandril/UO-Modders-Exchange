----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MapWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

MapWindow.Rotation = 45
MapWindow.ZoomScale = 0.1
MapWindow.IsDragging = false
MapWindow.IsMouseOver = false
MapWindow.TypeEnabled = {}
MapWindow.LegendVisible = false
MapWindow.CenterOnPlayer = true
MapWindow.OldFacet = -1
MapWindow.ShowFacetInfo = false

MapWindow.LegendItemTextColors = { normal={r=255,g=255,b=255}, disabled={r=80,g=80,b=80} }
-----------------------------------------------------------------
-- MapCommon Helper Functions
-----------------------------------------------------------------

----------------------------------------------------------------
-- Event Functions
----------------------------------------------------------------

function MapWindow.Initialize()
    -- Static text initialization
    
    WindowUtils.RestoreWindowPosition("MapWindow", true)    
    --WindowUtils.RestoreWindowPosition("Map", true)  
    WindowUtils.SetWindowTitle("MapWindow",GetStringFromTid(MapCommon.TID.Atlas))

    -- Update registration
    RegisterWindowData(WindowData.Radar.Type,0)
    RegisterWindowData(WindowData.WaypointDisplay.Type,0)
    RegisterWindowData(WindowData.WaypointList.Type,0)

    WindowRegisterEventHandler("MapWindow", WindowData.Radar.Event, "MapWindow.UpdateMap")
    WindowRegisterEventHandler("MapWindow", WindowData.WaypointList.Event, "MapWindow.UpdateWaypoints")

    local isVisible = WindowGetShowing("MapWindow")
    CreateWindow("LegendWindow",isVisible)

    ComboBoxClearMenuItems( "MapWindowFacetCombo" )
    for facet = 0, (MapCommon.NumFacets - 1) do
		--Debug.Print("Adding: "..tostring(GetStringFromTid(UORadarGetFacetLabel(facet))))
        ComboBoxAddMenuItem( "MapWindowFacetCombo", GetStringFromTid(UORadarGetFacetLabel(facet)) )
    end

    LabelSetText("MapWindowCenterOnPlayerLabel", GetStringFromTid(1112059))
    ButtonSetCheckButtonFlag( "MapWindowCenterOnPlayerButton", true )
    ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )
	
	WindowSetShowing("MapWindowFacetCombo", false)
	WindowSetShowing("MapWindowFacetNextButton", false)
	WindowSetShowing("MapWindowFacetPrevButton", false)
	WindowSetShowing("MapWindowAreaCombo",false)
	WindowSetShowing("MapWindowAreaNextButton", false)
	WindowSetShowing("MapWindowAreaPrevButton", false)
    
    local windowWidth, windowHeight = WindowGetDimensions("MapWindow")
	WindowSetDimensions( "Map", windowWidth - 25, windowHeight - 74)
    --labelSetText("MapWindowCoordsText", 0, 255,255)

    MapWindow.PopulateMapLegend()
end

function MapWindow.Shutdown()
	--Debug.Print(L"MapWindow.Shutdown")
	WindowUtils.SaveWindowPosition("MapWindow", true)
    UnregisterWindowData(WindowData.Radar.Type,0)
    UnregisterWindowData(WindowData.WaypointDisplay.Type,0)
    UnregisterWindowData(WindowData.WaypointList.Type,0)
     --WindowUtils.SaveSetting( "MapWindow" )
end

function MapWindow.ResizeTooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, L"Resize Map")
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_BOTTOM )
end

function MapWindow.FacetTooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, L"Toggle Facet Info")
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end
				
function MapWindow.ToggleFacetInfo()
	if (MapWindow.ShowFacetInfo) then
	MapWindow.ShowFacetInfo = false
	else
		MapWindow.ShowFacetInfo = true
	end
	WindowSetShowing("MapWindowFacetCombo", MapWindow.ShowFacetInfo)
	WindowSetShowing("MapWindowFacetNextButton", MapWindow.ShowFacetInfo)
	WindowSetShowing("MapWindowFacetPrevButton", MapWindow.ShowFacetInfo)
	WindowSetShowing("MapWindowAreaCombo", MapWindow.ShowFacetInfo)
	WindowSetShowing("MapWindowAreaNextButton", MapWindow.ShowFacetInfo)
	WindowSetShowing("MapWindowAreaPrevButton", MapWindow.ShowFacetInfo)
	local width, height = WindowGetDimensions( "MapWindow" )
	if (MapWindow.ShowFacetInfo) then
		WindowClearAnchors("Map")
		WindowAddAnchor("Map", "topleft", "MapWindow", "topleft", 12, 120)
		WindowSetDimensions("MapWindow", width, height + 60)
	else
		WindowClearAnchors("Map")
		WindowAddAnchor("Map", "topleft", "MapWindow", "topleft", 12, 60)
		WindowSetDimensions("MapWindow", width, height - 60)
	end	
end


function MapWindow.UpdateMap()
    if( MapCommon.ActiveView == MapCommon.MAP_MODE_NAME ) then
		local facet = UOGetRadarFacet()
        local area = UOGetRadarArea()
         		
		ComboBoxSetSelectedMenuItem( "MapWindowFacetCombo", (facet + 1) )

		-- Dont Always load Area Combo if we dont need to
        if (MapWindow.OldFacet ~= facet) then
			ComboBoxClearMenuItems( "MapWindowAreaCombo" )
			for areaIndex = 0, (UORadarGetAreaCount(facet) - 1) do
				--Debug.Print(L"Loading Area Combo "..areaIndex )
				ComboBoxAddMenuItem( "MapWindowAreaCombo", GetStringFromTid(UORadarGetAreaLabel(facet, areaIndex)) )
			end
			MapWindow.OldFacet = facet
        end

        local area = UOGetRadarArea()
        ComboBoxSetSelectedMenuItem( "MapWindowAreaCombo", (area + 1) )

        DynamicImageSetTextureScale("MapImage", WindowData.Radar.TexScale)
        DynamicImageSetTexture("MapImage","radar_texture", WindowData.Radar.TexCoordX, WindowData.Radar.TexCoordY)
        DynamicImageSetRotation("MapImage", WindowData.Radar.TexRotation)

        MapCommon.WaypointsDirty = true
    end
end

function MapWindow.UpdateWaypoints()
    if( MapCommon.ActiveView == MapCommon.MAP_MODE_NAME ) then
        MapCommon.WaypointsDirty = true
    end
end

function MapWindow.PopulateMapLegend()
    if( WindowData.WaypointDisplay.displayTypes.ATLAS ~= nil and WindowData.WaypointDisplay.typeNames ~= nil ) then
        local prevWindowName = nil

        for index=1, table.getn(WindowData.WaypointDisplay.typeNames) do
            if WindowData.WaypointDisplay.displayTypes.ATLAS[index].isDisplayed then
                local windowName = "MapLegend"..index

                CreateWindowFromTemplate(windowName,"MapLegendItemTemplate", "LegendWindow" )
                WindowSetId(windowName, index)

                if( prevWindowName == nil ) then
                    WindowAddAnchor(windowName, "top", "LegendWindow", "top", 10, 10)
                else
                    WindowAddAnchor(windowName, "bottom", prevWindowName, "top", 0, 0)
                end
                prevWindowName = windowName

                local waypointName = WindowData.WaypointDisplay.typeNames[index]
                LabelSetText(windowName.."Text", waypointName)

                local iconId = WindowData.WaypointDisplay.displayTypes.ATLAS[index].iconId
                MapCommon.UpdateWaypointIcon(iconId,windowName.."Icon")

                MapWindow.TypeEnabled[index] = true
            end
        end
    end
end

function MapWindow.ActivateMap()
    if( MapCommon.ActiveView ~= MapCommon.MAP_MODE_NAME ) then
		local mapTextureWidth, mapTextureHeight = WindowGetDimensions("MapImage")
     
        UORadarSetWindowSize(mapTextureWidth,  mapTextureHeight, true, MapWindow.CenterOnPlayer)
	    
	    UOSetRadarRotation(MapWindow.Rotation)
	    UORadarSetWindowOffset(0, 0)
	    
	    WindowSetShowing("RadarWindow", false)
	    WindowSetShowing("MapWindow", true)

	    MapCommon.ActiveView = MapCommon.MAP_MODE_NAME
	    UOSetWaypointDisplayMode(MapCommon.MAP_MODE_NAME)
        local facet = UOGetRadarFacet()
	    local area = UOGetRadarArea()
	    MapCommon.UpdateZoomValues(facet, area)
	    
	    if(MapWindow.CenterOnPlayer == true) then
			MapCommon.AdjustZoom(-4)
		else
			MapCommon.AdjustZoom(0)
		end

	    MapWindow.UpdateMap()
	    MapWindow.UpdateWaypoints()
	end
end
-----------------------------------------------------------------
-- Input Event Handlers
-----------------------------------------------------------------

function MapWindow.MapOnMouseWheel(x, y, delta)
   	MapCommon.AdjustZoom(-delta)
end

function MapWindow.ZoomOutOnLButtonUp()
   	MapCommon.AdjustZoom(1)
end

function MapWindow.ZoomOutOnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.ZoomOut))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function MapWindow.ZoomInOnLButtonUp()
    MapCommon.AdjustZoom(-1)
end

function MapWindow.ZoomInOnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.ZoomIn))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function MapWindow.MapMouseDrag(flags,deltaX,deltaY)
    if( MapWindow.IsDragging and (deltaX ~= 0 or deltaY ~= 0) ) then
        MapCommon.SetWaypointsEnabled(MapCommon.ActiveView, false)

        local facet = UOGetRadarFacet()
        local area = UOGetRadarArea()

        local top, bottom, left, right = MapCommon.GetRadarBorders(facet, area)

        if ( (deltaX < 0 and right < MapCommon.MapBorder.RIGHT ) or ( deltaX >= 0 and left > MapCommon.MapBorder.LEFT ) ) then
			deltaX = 0
        end

        if ( ( deltaY < 0 and bottom < MapCommon.MapBorder.BOTTOM ) or ( deltaY >= 0 and top > MapCommon.MapBorder.TOP ) ) then
			deltaY = 0
        end

		local mapCenterX, mapCenterY = UOGetRadarCenter()
		local winCenterX, winCenterY = UOGetWorldPosToRadar(mapCenterX,mapCenterY)

		local offsetX = winCenterX - deltaX
		local offsetY = winCenterY - deltaY
		local useScale = false

		local newCenterX, newCenterY = UOGetRadarPosToWorld(offsetX,offsetY,useScale)

		UOCenterRadarOnLocation(newCenterX, newCenterY, facet, area)

		MapCommon.WaypointsDirty = true
    end
end

function MapWindow.ToggleRadarOnLButtonUp()
    RadarWindow.ActivateRadar()
end

function MapWindow.ToggleRadarOnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.ShowRadar))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function MapWindow.ToggleFacetUpOnLButtonUp()
	local facet = UOGetRadarFacet() + 1

	if (facet >= MapCommon.NumFacets) then
		facet = 0
	end

	MapWindow.CenterOnPlayer = false
    ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )

	MapCommon.ChangeMap(facet, 0)
end

function MapWindow.ToggleFacetDownOnLButtonUp()
	local facet = UOGetRadarFacet() - 1

	if (facet < 0) then
		facet = MapCommon.NumFacets - 1
	end

	MapWindow.CenterOnPlayer = false
    ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )

	MapCommon.ChangeMap(facet,0)
end

function MapWindow.ToggleAreaUpOnLButtonUp()
	local facet = UOGetRadarFacet()
	local area = UOGetRadarArea() + 1

	if (area >= UORadarGetAreaCount(facet)) then
		area = 0
	end

	MapWindow.CenterOnPlayer = false
    ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )

	MapCommon.ChangeMap(facet, area)
end

function MapWindow.ToggleAreaDownOnLButtonUp()
	local facet = UOGetRadarFacet()
	local area = UOGetRadarArea() - 1

	if (area < 0) then
		area = UORadarGetAreaCount(facet) - 1
	end

	MapWindow.CenterOnPlayer = false
    ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )

	MapCommon.ChangeMap(facet, area)
end

function MapWindow.MapOnRButtonUp(flags,x,y)
	local useScale = true
	local waypointX, waypointY = UOGetRadarPosToWorld(x, y, useScale)
	local params = {x=waypointX, y=waypointY, facetId=UOGetRadarFacet()}

	local facet = UOGetRadarFacet()
	local area = UOGetRadarArea()
	local x1, y1, x2, y2 = UORadarGetAreaDimensions(facet, area)

	if (x1 < waypointX and y1 < waypointY and x2 > waypointX and y2 > waypointY) then
		ContextMenu.CreateLuaContextMenuItem(MapCommon.TID.CreateWaypoint,0,MapCommon.ContextReturnCodes.CREATE_WAYPOINT,params)
		ContextMenu.ActivateLuaContextMenu(MapCommon.ContextMenuCallback)
	end
end

function MapWindow.LegendIconOnLButtonUp()
    local windowName = SystemData.ActiveWindow.name
    waypointType = WindowGetId(windowName)

    MapWindow.TypeEnabled[waypointType] = not MapWindow.TypeEnabled[waypointType]

    local alpha = 1.0
    local color = MapWindow.LegendItemTextColors.normal
    if( MapWindow.TypeEnabled[waypointType] == false ) then
		alpha = 0.5
		color = MapWindow.LegendItemTextColors.disabled
	end
    WindowSetAlpha(windowName,alpha)
    LabelSetTextColor(windowName.."Text",color.r,color.g,color.b)

    MapCommon.WaypointsDirty = true
end

function MapWindow.CenterOnPlayerOnLButtonUp()
	MapWindow.CenterOnPlayer = ButtonGetPressedFlag( "MapWindowCenterOnPlayerButton" )
	UORadarSetCenterOnPlayer(MapWindow.CenterOnPlayer)
end

function MapWindow.MapOnLButtonDown()
    MapWindow.IsDragging = true

    MapWindow.CenterOnPlayer = false
    ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )
    UORadarSetCenterOnPlayer(MapWindow.CenterOnPlayer)
end

function MapWindow.MapOnLButtonUp()
    MapWindow.IsDragging = false
    MapCommon.SetWaypointsEnabled(MapCommon.ActiveView, true)
end

function MapWindow.OnMouseOver()
	MapWindow.IsMouseOver = true
end

function MapWindow.OnMouseOverEnd()
    MapWindow.IsDragging = false
    MapWindow.IsMouseOver = false
    MapCommon.SetWaypointsEnabled(MapCommon.ActiveView, true)
end

function MapWindow.SelectArea()
	local facet = UOGetRadarFacet()
    local area = ( ComboBoxGetSelectedMenuItem( "MapWindowAreaCombo" ) - 1 )

    if( area ~= UOGetRadarArea() ) then
		MapWindow.CenterOnPlayer = false
        ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )

        MapCommon.ChangeMap(facet, area )
    end
end

function MapWindow.SelectFacet()
    local facet = ( ComboBoxGetSelectedMenuItem( "MapWindowFacetCombo" ) - 1 )
    local area = UOGetRadarArea()

    if( facet ~= UOGetRadarFacet() ) then
		MapWindow.CenterOnPlayer = false
        ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )

        MapCommon.ChangeMap(facet, 0 )
    end
end

function MapWindow.OnLegendToggle()
	MapWindow.LegendVisible = not MapWindow.LegendVisible
	--Debug.Print("LegendWindow Visible: "..tostring(MapWindow.LegendVisible))
	ButtonSetPressedFlag("MapWindowLegendToggle", MapWindow.LegendVisible)
	WindowSetShowing("LegendWindow",MapWindow.LegendVisible)
end

function MapWindow.OnShown()
	if( MapWindow.LegendVisible == true ) then
		WindowSetShowing("LegendWindow",true)
	end
end

function MapWindow.OnUpdate()
	if( WindowGetShowing("MapWindow") == true and MapWindow.IsMouseOver == true) then
		local windowX, windowY = WindowGetScreenPosition("MapImage")
		local mouseX = SystemData.MousePosition.x - windowX
		local mouseY = SystemData.MousePosition.y - windowY
	    local useScale = true
	    local x, y = UOGetRadarPosToWorld(mouseX, mouseY, useScale)

		local facet = UOGetRadarFacet()
		local area = UOGetRadarArea()
	    local x1, y1, x2, y2 = UORadarGetAreaDimensions(facet, area)
		if (x1 < x and y1 < y and x2 > x and y2 > y) then
			local latStr, longStr, latDir, longDir = MapCommon.GetSextantLocationStrings(x, y, facet)
			LabelSetText("MapWindowCoordsText", latStr..L"'"..latDir..L" "..longStr..L"'"..longDir)
		else
			LabelSetText("MapWindowCoordsText", L"")
		end
	elseif (MapCommon.WaypointIsMouseOver == false) then
	
		local waypointName = GetStringFromTid(MapCommon.TID.YourLocation)
		local waypointX = WindowData.PlayerLocation.x
		local waypointY = WindowData.PlayerLocation.y
		local waypointFacet = WindowData.PlayerLocation.facet
		local latStr, longStr, latDir, longDir = MapCommon.GetSextantLocationStrings(waypointX, waypointY, waypointFacet)
	        
		--LabelSetText("radarSextant", latStr..L"'"..latDir..L" "..longStr..L"'"..longDir)
		if( MapCommon.ActiveView == MapCommon.MAP_MODE_NAME and MapWindow.CenterOnPlayer == true ) then
			LabelSetText("MapWindowCoordsText", latStr..L"'"..latDir..L" "..longStr..L"'"..longDir)
		else
			LabelSetText("MapWindowCoordsText", L"")
	   end			
	end
end

function MapWindow.OnHidden()
	WindowSetShowing("LegendWindow",false)
end

function MapWindow.OnLegendButtonMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.ShowLegend))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function MapWindow.OnResizeBegin( flags, x, y )
  	MapWindow.UpdateCounter = 0
    WindowSetShowing("MapWindow",true)
    WindowUtils.BeginResize( "MapWindow", "topleft", 300, 350, false, MapWindow.OnResizeEnd )
end

function MapWindow.OnResizeEnd()
	local windowWidth, windowHeight = WindowGetDimensions("MapWindow")
	WindowSetShowing("MapWindow",true)

	if (MapWindow.ShowFacetInfo) then
		WindowSetDimensions( "Map", windowWidth - 25, windowHeight - 132)
	else
		WindowSetDimensions( "Map", windowWidth - 25, windowHeight - 74)
	end	
	WindowUtils.SaveWindowPosition("MapWindow", true)
end

function MapWindow.SaveWindowSize( )
	local filename = "MapWindowSize.log"
	TextLogCreate( filename, 2)
    TextLogSetEnabled( filename, true )
    TextLogClear(filename)
    TextLogSetIncrementalSaving( filename, true, "logs/" .. filename )
    TextLogAddEntry( filename, nil, 1 )
    TextLogAddEntry( filename, nil, 2 )
    TextLogDestroy( filename )
end

function RadarWindow.SetRadarCoords()
	local waypointName = GetStringFromTid(MapCommon.TID.YourLocation)
	local waypointX = WindowData.PlayerLocation.x
    local waypointY = WindowData.PlayerLocation.y
    local waypointFacet = WindowData.PlayerLocation.facet
	local latStr, longStr, latDir, longDir = MapCommon.GetSextantLocationStrings(waypointX, waypointY, waypointFacet)
        
	LabelSetText("radarSextant", latStr..L"'"..latDir..L" "..longStr..L"'"..longDir)
    if( MapCommon.ActiveView == MapCommon.MAP_MODE_NAME ) then
		LabelSetText("radarSextant", latStr..L"'"..latDir..L" "..longStr..L"'"..longDir)
   end
end