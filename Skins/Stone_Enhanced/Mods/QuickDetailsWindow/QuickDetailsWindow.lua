----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

QuickDetailsWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

QuickDetailsWindow.CurPlayerId = 0

QuickDetailsWindow.DetailLabelsCreated = false
QuickDetailsWindow.DetailLabels = { 
    {
        name="Tithing",
        --tid=1078097,
        ctid="TithingPointsShort",
        getValue=function() return WindowUtils.AddCommasToNumber(StringToWString(tostring(WindowData.PlayerStatus.TithingPoints))) end,
    },
    {
        name="Gold",
        tid=1061156,
        getValue=function() return WindowUtils.AddCommasToNumber(StringToWString(tostring(WindowData.PlayerStatus.Gold))) end,
    },
    {
        name="Luck",
        tid=1061153,
        getValue=function() return WindowUtils.AddCommasToNumber(StringToWString(tostring(WindowData.PlayerStatus.Luck))) end,
    },
    {
        name="Weight",
        tid=1061154,
        getValue=function() return WindowUtils.AddCommasToNumber(StringToWString(tostring(WindowData.PlayerStatus.Weight)))..L"/"..WindowUtils.AddCommasToNumber(StringToWString(tostring(WindowData.PlayerStatus.MaxWeight))) end,
    },
    {
        name="Followers",
        tid=1078830,
        getValue=function() return StringToWString(tostring(WindowData.PlayerStatus.Followers).."/"..tostring(WindowData.PlayerStatus.MaxFollowers)) end,
    },
    {
        name="Timer",
        ctid="TimePlayed",
        getValue=function() return QuickDetailsWindow.TimerToHMS() end,
    },
    --[[ Relies on some chat enhancements
    {
        name="UOTime",
        ctid="UOTime",
        getValue=function() return QuickDetailsWindow.TimerToUOTime() end,
    },
    ]]--
}

function QuickDetailsWindow.AddLabel( name, ctid, getValue, tid )
    if ctid ~= nil then
        table.insert( QuickDetailsWindow.DetailLabels, { name=name, ctid=ctid, getValue=getValue } )
    else
        table.insert( QuickDetailsWindow.DetailLabels, { name=name, tid=tid, getValue=getValue } )
    end
end
-- Added here instead of above for sample usage only
QuickDetailsWindow.AddLabel( "RealTime", "RealTime", function() return QuickDetailsWindow.GetRealTime() end )

QuickDetailsWindow.DetailLabelsFontSetting = "QuickDetailLabelsFont"
QuickDetailsWindow.DetailLabelsLabelColorSetting = "QuickDetailLabelsLabelColor"
QuickDetailsWindow.DetailLabelsValueColorSetting = "QuickDetailLabelsValueColor"
QuickDetailsWindow.RealTimeOffsetSetting = "QuickDetailsRealTimeOffset"
QuickDetailsWindow.Use24HourTimeSetting = "QuickDetailsUse24HourTime"
QuickDetailsWindow.LastKnownUOTimeInMinutes = nil
QuickDetailsWindow.LastKnownUOTimer = nil
QuickDetailsWindow.UONightStart = 24
QuickDetailsWindow.UODayStart = 4
QuickDetailsWindow.timer = 0

function QuickDetailsWindow.TimerToHMS()
    local seconds = QuickDetailsWindow.timer % 60
    local minutes = ( QuickDetailsWindow.timer / 60 ) % 60
    local hours = ( QuickDetailsWindow.timer / 3600 ) % 60
    return StringToWString( string.format( "%d:%02d:%02d", hours, minutes, seconds ) )
end

function QuickDetailsWindow.TimerToUOTime()
    if QuickDetailsWindow.LastKnownUOTimeInMinutes == nil then
        return CustomLocalization.Load("UnknownUseClock")
    else
        local timeSinceLastKnownUOHour = QuickDetailsWindow.timer - QuickDetailsWindow.LastKnownUOTimer
        local secondsPerUOMinute = 5
        local newUOTime = QuickDetailsWindow.LastKnownUOTimeInMinutes + timeSinceLastKnownUOHour / secondsPerUOMinute
        newUOTime = newUOTime % ( 24 * 60 )
        local minutes = ( newUOTime ) % 60
        local hours = math.floor( newUOTime / 60 )
        local isNight = hours >= QuickDetailsWindow.UONightStart or hours < QuickDetailsWindow.UODayStart
        local Night = ""
        if isNight then
            Night = WStringToString( CustomLocalization.Load("NightIndicator") )
        end
        return QuickDetailsWindow.TimeToFormattedTime( hours, minutes, nil, Night )
    end
end

function QuickDetailsWindow.TimeToFormattedTime( hours, minutes, seconds, nightIndicator )
    if nightIndicator == nil then
        nightIndicator = ""
    end
    local use24HourTime = CustomSettings.LoadBooleanValue( { settingName=QuickDetailsWindow.Use24HourTimeSetting, defaultValue=false } )
    hours = hours % 24
    local AMPM = ""
    if not use24HourTime then
        if hours < 12 then
            AMPM = WStringToString( CustomLocalization.Load("AMIndicator") )
        else
            AMPM = WStringToString( CustomLocalization.Load("PMIndicator") )
            hours = hours - 12
        end
        if hours == 0 then
            hours = 12
        end
    end
    if seconds == nil then
        return StringToWString( string.format( "%d:%02d %s %s", hours, minutes, AMPM, nightIndicator ) )
    else
        return StringToWString( string.format( "%d:%02d:%02d %s %s", hours, minutes, seconds, AMPM, nightIndicator ) )
    end
end

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function QuickDetailsWindow.Initialize()
--[[
    CustomSettingsWindow.AddFontSetting( "DetailsLabelFontSetting", QuickDetailsWindow.DetailLabelsFontSetting )
    CustomSettingsWindow.AddColorSetting( StringToWString("Quick Details Label Color"), QuickDetailsWindow.DetailLabelsLabelColorSetting, { r=255, g=255, b=255 } )
    CustomSettingsWindow.AddColorSetting( StringToWString("Quick Details Value Color"), QuickDetailsWindow.DetailLabelsValueColorSetting, { r=187, g=187, b=64 } )
    CustomSettingsWindow.AddOtherSliderSetting( "RealTimeOffset", QuickDetailsWindow.RealTimeOffsetSetting, 0, 26, -13 )
    CustomSettingsWindow.AddOtherBooleanSetting( "Use24HourTime", QuickDetailsWindow.Use24HourTimeSetting, false )
    ]]--
	WindowRegisterEventHandler( "QuickDetailsWindow", SystemData.Events.USER_SETTINGS_UPDATED, "QuickDetailsWindow.UpdateLabelFonts")
	WindowRegisterEventHandler( "QuickDetailsWindow", WindowData.PlayerStatus.Event, "QuickDetailsWindow.UpdateLabelFonts")
	QuickDetailsWindow.UpdateLabels()
end

QuickDetailsWindow.LastSecond = 0
function QuickDetailsWindow.UpdateTime(elapsed)
    local newLast = math.floor( QuickDetailsWindow.timer )
    QuickDetailsWindow.timer = QuickDetailsWindow.timer + elapsed
    if newLast > QuickDetailsWindow.LastSecond then
        QuickDetailsWindow.LastSecond = newLast
        QuickDetailsWindow.UpdateLabels()
    end
end

function QuickDetailsWindow.UpdateLabelFonts()
    if QuickDetailsWindow.DetailLabelsCreated then
        local basename = "QuickDetailsWindow"
        local fontSetting = CustomSettings.LoadStringValue( { settingName=QuickDetailsWindow.DetailLabelsFontSetting } )
        local labelColor = CustomSettings.LoadColorValue( {settingName=QuickDetailsWindow.DetailLabelsLabelColorSetting, defaultValue={ r=186, g=186, b=132 } } )
        local valueColor = CustomSettings.LoadColorValue( {settingName=QuickDetailsWindow.DetailLabelsValueColorSetting, defaultValue={ r=255, g=255, b=255 } } )
        for i,v in ipairs( QuickDetailsWindow.DetailLabels ) do
            local name = basename..v.name
            if fontSetting ~= nil then
                LabelSetFont(name.."Label", fontSetting, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING )
                LabelSetFont(name.."Value", fontSetting, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING )
            end
			LabelSetTextColor(name.."Label", labelColor.r, labelColor.g, labelColor.b)
			LabelSetTextColor(name.."Value", valueColor.r, valueColor.g, valueColor.b)
        end
    end
end

QuickDetailsWindow.LastBuffDebuffAnchor = nil
function QuickDetailsWindow.UpdateLabels()
    local basename = "QuickDetailsWindow"
    if not QuickDetailsWindow.DetailLabelsCreated then
        for i,v in ipairs( QuickDetailsWindow.DetailLabels ) do
            local name = basename..v.name
            CreateWindowFromTemplate(name, "StatusDetailsTemplate", basename)
            local postfix = L":  "
            if v.noPostfix then
                postfix = L" "
            end
            if v.tid ~= nil then
                v.text = GetStringFromTid(v.tid)
            elseif v.ctid ~= nil then
                v.text = CustomLocalization.Load(v.ctid)
            end
            LabelSetText( name.."Label", v.text..postfix )
            LabelSetText( name.."Value", L"???" )
            WindowClearAnchors( name.."Value" )
            WindowAddAnchor( name.."Value", "right", name.."Label", "left", 0, 0 )
        end
        QuickDetailsWindow.DetailLabelsCreated = true
        QuickDetailsWindow.UpdateLabelFonts()
    end
    local nextAnchor = { relative="QuickDetailsWindowDetailsTextRoot", x=7, y=5 } 
    local noneVisible = true
    for i,v in ipairs( QuickDetailsWindow.DetailLabels ) do
        local name = basename..v.name
        if CustomSettings.LoadBooleanValue( { settingName="QuickDetailsWindowDetails_"..v.name, defaultValue=false } ) then
            noneVisible = false
            WindowSetShowing( name, true )
            WindowClearAnchors( name )
            WindowAddAnchor( name, "topleft", nextAnchor.relative, "topleft", nextAnchor.x, nextAnchor.y )
            nextAnchor = { relative=name, x=0, y=18 }
            LabelSetText( name.."Value", v.getValue() )
        else
            WindowSetShowing( name, false )
        end
    end
end

function QuickDetailsWindow.ShowDetailsContextMenu()
    for i,v in ipairs( QuickDetailsWindow.DetailLabels ) do
        local visible = CustomSettings.LoadBooleanValue( { settingName="QuickDetailsWindowDetails_"..v.name, defaultValue=false } )
        if v.tid ~= nil then
            v.text = GetStringFromTid(v.tid)
        end
        local str = v.text
        if v.noPostfix then
            str = wstring.sub( str, 0, wstring.len(str)-2 )
        end
        ContextMenu.CreateLuaContextMenuItemWithString( str, 0, i, not visible, visible )
    end
    ContextMenu.ActivateLuaContextMenu(QuickDetailsWindow.ShowDetailsContextMenuCallback)
end

function QuickDetailsWindow.ShowDetailsContextMenuCallback( returnCode, param )
    if param ~= nil then
        CustomSettings.SaveBooleanValue( { settingName="QuickDetailsWindowDetails_"..QuickDetailsWindow.DetailLabels[returnCode].name, settingValue=param } )
        QuickDetailsWindow.UpdateLabels()
    end
end

QuickDetailsWindow.LastKnownRealTime = { hour=99, minute=99, second=99 }
QuickDetailsWindow.LastKnownRealTimeTimer = 0
function QuickDetailsWindow.GetRealTime()
    local time = QuickDetailsWindow.LastKnownRealTime
    local newSecond = time.second + QuickDetailsWindow.timer - QuickDetailsWindow.LastKnownRealTimeTimer
    if newSecond > 59 then
        TextLogCreate( "ClockLog", 1 )
        TextLogAddEntry("ClockLog", nil, L"Lets get the time")
        local timestamp, filterType, entryText = TextLogGetEntry( "ClockLog", 0)
        timestamp = WStringToString( timestamp )
        -- at the end destroy the log to read out the correct time every start (because the INDEX seems to be broken without filter types
        TextLogDestroy("ClockLog")
        local newHour = string.sub(timestamp, 2,3)
        local newMinute = string.sub(timestamp, 5,6)
        newSecond = tonumber(string.sub(timestamp, 8,9))
        QuickDetailsWindow.LastKnownRealTime = { hour=newHour, minute=newMinute, second=newSecond }
        QuickDetailsWindow.LastKnownRealTimeTimer = QuickDetailsWindow.timer
    end
    return QuickDetailsWindow.TimeToFormattedTime( time.hour + CustomSettings.LoadNumberValue( {settingName=QuickDetailsWindow.RealTimeOffsetSetting, defaultValue=0} ), time.minute, newSecond )
end
