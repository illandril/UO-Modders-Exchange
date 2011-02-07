
SmallAtlas = {}

SmallAtlas.AlwaysShowCoordsSettingName = "AlwaysShowCoordsOnAtlas"
SmallAtlas.AlwaysShowCoords = true
SmallAtlas.ShowFacetInfoSettingName = "ShowFacetInfo"
SmallAtlas.ShowFacetInfo = true
SmallAtlas.FirstUpdate = true
SmallAtlas.ShowPlayerHousesSettingName = "ShowPlayerHouses"
SmallAtlas.ShowPlayerHouses = true

function SmallAtlas.Initialize()
    CustomSettingsWindow.AddBooleanSetting( "MiscSettings", "AlwaysShowCoordsOnAtlas", SmallAtlas.AlwaysShowCoordsSettingName, SmallAtlas.AlwaysShowCoords )
    CustomSettingsWindow.AddBooleanSetting( "MiscSettings", "ShowFacetInfo", SmallAtlas.ShowFacetInfoSettingName, SmallAtlas.ShowFacetInfo )
    CustomSettingsWindow.AddBooleanSetting( "MiscSettings", "ShowPlayerHouses", SmallAtlas.ShowPlayerHousesSettingName, SmallAtlas.ShowPlayerHouses )
    
    CustomSettingsWindow.RegisterUpdateSettingsListener( SmallAtlas.UpdateSettings )

    MapWindow.OnResizeBegin = SmallAtlas.OnResizeBegin
    MapWindow.OnUpdate = SmallAtlas.OnUpdate
    
    SmallAtlas.OldUORadarSetWindowSize = UORadarSetWindowSize
    UORadarSetWindowSize = SmallAtlas.UORadarSetWindowSize
    
    SmallAtlas.UpdateSettings()
end

function SmallAtlas.UpdateSettings()
    SmallAtlas.AlwaysShowCoords = CustomSettings.LoadBooleanValue( { settingName=SmallAtlas.AlwaysShowCoordsSettingName, defaultValue=SmallAtlas.AlwaysShowCoords } )
    SmallAtlas.ShowPlayerHouses = CustomSettings.LoadBooleanValue( { settingName=SmallAtlas.ShowPlayerHousesSettingName, defaultValue=SmallAtlas.ShowPlayerHouses } )
    local oldShowFacet = SmallAtlas.ShowFacetInfo
    SmallAtlas.ShowFacetInfo = CustomSettings.LoadBooleanValue( { settingName=SmallAtlas.ShowFacetInfoSettingName, defaultValue=SmallAtlas.ShowFacetInfo } )
    if SmallAtlas.FirstUpdate then
        if not SmallAtlas.ShowFacetInfo then
            local width, height = WindowGetDimensions( "MapWindow" )
            WindowSetDimensions("MapWindow", width, height + 60)
            MapWindow.OnResizeEnd()
        end
    end
    SmallAtlas.FirstUpdate = false
    if oldShowFacet ~= SmallAtlas.ShowFacetInfo then
        SmallAtlas.UpdateFacetDisplay()
    end
    local width = RadarWindow.Size
    local height = RadarWindow.Size
    local centerOnPlayer = true
    if( MapCommon.ActiveView == MapCommon.MAP_MODE_NAME ) then
        width, height = WindowGetDimensions("MapImage")
        centerOnPlayer = MapWindow.CenterOnPlayer
    end
    UORadarSetWindowSize( width, height, SmallAtlas.ShowPlayerHouses, centerOnPlayer )
end

function SmallAtlas.OnResizeBegin()
    local windowName = WindowUtils.GetActiveDialog()
    local widthMin = 300
    local heightMin = 210
    if not SmallAtlas.ShowFacetInfo then
        heightMin = heightMin - 60
    end
    WindowUtils.BeginResize( windowName, "topleft", widthMin, heightMin, false, MapWindow.OnResizeEnd)
end

function SmallAtlas.ToggleFacetDisplay()
    local newVal = not SmallAtlas.ShowFacetInfo
    CustomSettings.SaveBooleanValue( { settingName=SmallAtlas.ShowFacetInfoSettingName, settingValue=newVal } )
    SmallAtlas.UpdateSettings()
end

function SmallAtlas.UpdateFacetDisplay()
    WindowSetShowing("MapWindowFacetCombo", SmallAtlas.ShowFacetInfo)
    WindowSetShowing("MapWindowFacetNextButton", SmallAtlas.ShowFacetInfo)
    WindowSetShowing("MapWindowFacetPrevButton", SmallAtlas.ShowFacetInfo)
    WindowSetShowing("MapWindowAreaCombo", SmallAtlas.ShowFacetInfo)
    WindowSetShowing("MapWindowAreaNextButton", SmallAtlas.ShowFacetInfo)
    WindowSetShowing("MapWindowAreaPrevButton", SmallAtlas.ShowFacetInfo)
    local width, height = WindowGetDimensions( "MapWindow" )
    if (SmallAtlas.ShowFacetInfo) then
        WindowClearAnchors("Map")
        WindowAddAnchor("Map", "topleft", "MapWindow", "topleft", 12, 98)
        WindowSetDimensions("MapWindow", width, height + 60)
        MapWindow.MAP_HEIGHT_DIFFERENCE = MapWindow.MAP_HEIGHT_DIFFERENCE + 60
    else
        WindowClearAnchors("Map")
        WindowAddAnchor("Map", "topleft", "MapWindow", "topleft", 12, 38)
        WindowSetDimensions("MapWindow", width, height - 60)
        MapWindow.MAP_HEIGHT_DIFFERENCE = MapWindow.MAP_HEIGHT_DIFFERENCE - 60
    end
end

function SmallAtlas.OnUpdate()
    if WindowGetShowing("MapWindow") == true then
        if MapWindow.IsMouseOver == true then
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
        elseif SmallAtlas.AlwaysShowCoords then
            local waypointX = WindowData.PlayerLocation.x
            local waypointY = WindowData.PlayerLocation.y
            local waypointFacet = WindowData.PlayerLocation.facet
            local latStr, longStr, latDir, longDir = MapCommon.GetSextantLocationStrings(waypointX, waypointY, waypointFacet)
            LabelSetText("MapWindowCoordsText", latStr..L"'"..latDir..L" "..longStr..L"'"..longDir)
        elseif MapCommon.WaypointIsMouseOver == false then
            LabelSetText("MapWindowCoordsText", L"")
        end
    elseif (MapCommon.WaypointIsMouseOver == false) then
        LabelSetText("MapWindowCoordsText", L"")
    end
end

function SmallAtlas.UORadarSetWindowSize( width, height, showHouses, centerOnPlayer )
    SmallAtlas.OldUORadarSetWindowSize( width,  height, SmallAtlas.ShowPlayerHouses, centerOnPlayer )
end
