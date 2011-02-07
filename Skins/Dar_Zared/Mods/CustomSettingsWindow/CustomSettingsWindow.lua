CustomSettingsWindow = {}

CustomSettingsWindow.Fonts = {
    {
        ctid="SkinDefault",
        types={
            {
                ctid="NoteRequiresUIReload",
                internalName=nil,
            },
        },
    },
    {
        ctid="ECDefaultsFont",
        types={
            {
                ctid="DefaultNormalFont",
                internalName="UO_DefaultText",
            },
            {
                ctid="DefaultBoldFont",
                internalName="UO_GoldButtonText",
            },
            {
                ctid="DefaultTitleFont",
                internalName="UO_Title",
            },
            {
                ctid="DefaultChatFont",
                internalName="UO_ChatText",
            },
            {
                ctid="DefaultStatsFont",
                internalName="UO_StatsText",
            },
            {
                ctid="DefaultNameFont",
                internalName="UO_NeueText",
            },
            
        },
    }
}

CustomSettingsWindow.CORNER={ x=16, y=42 }
CustomSettingsWindow.TAB_SIZE={ x=117, y=23 }

CustomSettingsWindow.SettingTypes = {
    Boolean = "CustomSettingsTemplatesToggleSettingsButton",
    Combo = "CustomSettingsTemplatesComboBoxSetting",
    Color = "CustomSettingsTemplatesColorSetting",
    Font = "CustomSettingsTemplatesFontSetting",
    Slider = "CustomSettingsTemplatesSliderSetting"
}

--[[
setting = {
    ctid = 'SomethingAddedToLocalizations',
    type = CustomSettingsWindow.SettingTypes.???,
    name = '???', (Name to save to/load from CustomSettings)
    max = #, (For Slider only)
    min = #, (For Slider only)
    range = (max-min), (For Slider only)
    default = ???, (Value if nothing is loaded from CustomSettings)
    options = { opt1, opt2, ... }, (For Combo only, a list of strings)
}
  ]]--

CustomSettingsWindow.nextUID = 0
CustomSettingsWindow.Settings = {}
CustomSettingsWindow.SettingsByUID = {}
function CustomSettingsWindow.AddSettingToTab( tabCTID, setting )
    if CustomSettingsWindow.Settings[tabCTID] == nil then
        CustomSettingsWindow.Settings[tabCTID] = {}
    end
    local uid = CustomSettingsWindow.nextUID
    CustomSettingsWindow.nextUID = CustomSettingsWindow.nextUID + 1
    setting.uid = uid
    table.insert( CustomSettingsWindow.Settings[tabCTID], setting )
    CustomSettingsWindow.SettingsByUID[uid] = setting
end


function CustomSettingsWindow.AddFontSetting( tabCTID, ctid, name, default )
    local setting = {
        ctid=ctid,
        type=CustomSettingsWindow.SettingTypes.Font,
        name=name,
        default=default
    }
    CustomSettingsWindow.AddSettingToTab( tabCTID, setting )
end

function CustomSettingsWindow.AddColorSetting( tabCTID, ctid, name, default )
    local setting = {
        ctid=ctid,
        type=CustomSettingsWindow.SettingTypes.Color,
        name=name,
        default=default
    }
    CustomSettingsWindow.AddSettingToTab( tabCTID, setting )
end

function CustomSettingsWindow.AddSliderSetting( tabCTID, ctid, name, default, min, max )
    local setting = {
        ctid=ctid,
        type=CustomSettingsWindow.SettingTypes.Slider,
        name=name,
        min=min,
        max=max,
        range=(max - min),
        default=default
    }
    CustomSettingsWindow.AddSettingToTab( tabCTID, setting )
end

function CustomSettingsWindow.AddBooleanSetting( tabCTID, ctid, name, default )
    local setting = {
        ctid=ctid,
        type=CustomSettingsWindow.SettingTypes.Boolean,
        name=name,
        default=default
    }
    CustomSettingsWindow.AddSettingToTab( tabCTID, setting )
end

function CustomSettingsWindow.AddComboSetting( tabCTID, ctid, name, default, options )
    local setting = {
        ctid=ctid,
        type=CustomSettingsWindow.SettingTypes.Combo,
        name=name,
        default=default,
        options=options
    }
    CustomSettingsWindow.AddSettingToTab( tabCTID, setting )
end

CustomSettingsWindow.initialized = false
function CustomSettingsWindow.Initialize()
    CustomSettingsWindow.SettingsWindowUpdateSettings = SettingsWindow.UpdateSettings
    SettingsWindow.UpdateSettings = CustomSettingsWindow.UpdateSettings
    
    CustomSettingsWindow.InitialClearTabStates = SettingsWindow.ClearTabStates
    SettingsWindow.ClearTabStates = CustomSettingsWindow.ClearTabStates
    
    CustomSettingsWindow.OriginalSaveAllSettings = SettingsWindow.OnApplyButton
    SettingsWindow.OnApplyButton = CustomSettingsWindow.SaveAllSettings
    
    CustomSettingsWindow.SetupColorPicker()
end

function CustomSettingsWindow.SetupColorPicker()
    local colorsPerRow = 30
    local rows = colorsPerRow + 3
    local defaultColors = {}
    for i=1,rows do
        defaultColors[i] = (i-1) * colorsPerRow + 2
    end
    local hueTable = {}
    for idx, hue in pairs(defaultColors) do
        for i=0,colorsPerRow-1 do
            hueTable[(idx-1)*(colorsPerRow + 1)+i+1] = hue+i
        end
    end
    hueTable[(rows-1)*(colorsPerRow + 1) + colorsPerRow - 1] = 0
    hueTable[(rows-1)*(colorsPerRow + 1) + colorsPerRow] = 1

    CreateWindowFromTemplate( "CustomColorPicker", "CustomColorPickerWindowTemplate", "Root" )
    WindowSetShowing("CustomColorPicker", false)
    WindowClearAnchors( "CustomColorPicker" )
    WindowAddAnchor( "CustomColorPicker", "topleft", "Root", "topleft", 500, 400)
    CustomColorPickerWindow.SetNumColorsPerRow(colorsPerRow)
    CustomColorPickerWindow.SetSwatchSize(10)
    CustomColorPickerWindow.SetWindowPadding(16,28)
    CustomColorPickerWindow.SetFrameEnabled(true)
    CustomColorPickerWindow.SetCloseButtonEnabled(true)
    CustomColorPickerWindow.SetColorTable(hueTable,"CustomColorPicker")
    CustomColorPickerWindow.DrawColorTable("CustomColorPicker")
end

CustomSettingsWindow.UpdateSettingsListeners = {}
function CustomSettingsWindow.RegisterUpdateSettingsListener( listener )
    table.insert( CustomSettingsWindow.UpdateSettingsListeners, listener )
end

function CustomSettingsWindow.UpdateSettings()
    CustomSettingsWindow.SettingsWindowUpdateSettings()
    if CustomSettingsWindow.Initialized then
        for tab,settings in pairs( CustomSettingsWindow.Settings ) do
            for i,setting in ipairs( settings ) do
                if setting.type == CustomSettingsWindow.SettingTypes.Boolean then
                    CustomSettingsWindow.UpdateBooleanSetting( setting )
                elseif setting.type == CustomSettingsWindow.SettingTypes.Slider then
                    CustomSettingsWindow.UpdateSliderSetting( setting )
                elseif setting.type == CustomSettingsWindow.SettingTypes.Combo then
                    CustomSettingsWindow.UpdateComboSetting( setting )
                elseif setting.type == CustomSettingsWindow.SettingTypes.Color then
                    CustomSettingsWindow.UpdateColorSetting( setting )
                elseif setting.type == CustomSettingsWindow.SettingTypes.Font then
                    CustomSettingsWindow.UpdateFont( setting )
                end
            end
        end
    end
    for i,listener in ipairs( CustomSettingsWindow.UpdateSettingsListeners ) do
        listener()
    end
end

function CustomSettingsWindow.UpdateBooleanSetting( setting )
    local value = CustomSettings.LoadBooleanValue( { settingName=setting.name, defaultValue=setting.default } )
    ButtonSetPressedFlag( setting.windowName.."Button", value )
end

function CustomSettingsWindow.UpdateSliderSetting( setting )
    local value = CustomSettings.LoadNumberValue( { settingName=setting.name, defaultValue=setting.default } )
    SliderBarSetCurrentPosition( setting.windowName.."SliderBar", ( value - setting.min ) / setting.range )
    LabelSetText( setting.windowName.."Val", L""..value )
end

function CustomSettingsWindow.UpdateComboSetting( setting )
    local value = CustomSettings.LoadNumberValue( { settingName=setting.name, defaultValue=setting.default } )
    ComboBoxSetSelectedMenuItem( setting.windowName.."Combo", value )
end

function CustomSettingsWindow.UpdateColorSetting( setting )
    local color = CustomSettings.LoadColorValue( { settingName=setting.name, defaultValue=setting.default } )
    WindowSetTintColor( setting.windowName.."Color", color.r, color.g, color.b )
end

function CustomSettingsWindow.UpdateFont( setting )
    local windowName = setting.windowName
    local currentFont = CustomSettings.LoadStringValue( { settingName=setting.name, defaultValue=setting.default } )
    if currentFont == nil then
        LabelSetText( windowName.."Name", CustomLocalization.Load("SkinDefaultNotSet") )
    else
        LabelSetText( windowName.."Name", StringToWString( currentFont )..L" "..CustomLocalization.Load("UnknownFont") )
    end
    setting.selectedValue = currentFont
    for fontFaceIndex,fontFace in ipairs( CustomSettingsWindow.Fonts ) do
        for fontIndex,font in ipairs( fontFace.types ) do
            if font.internalName == currentFont then
                if font.internalName == nil then -- It's the Skin Default
                    LabelSetText( windowName.."Preview", L"" )
                    LabelSetText( windowName.."Name", CustomLocalization.Load( fontFace.ctid ) )
                else
                    LabelSetFont( windowName.."Preview", font.internalName, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING )
                    LabelSetText( windowName.."Preview", CustomLocalization.Load("FontPreviewText") )
                    LabelSetText( windowName.."Name", CustomLocalization.Load( fontFace.ctid )..L" > "..CustomLocalization.Load( font.ctid ) )
                end
            end
         end
    end
end

CustomSettingsWindow.Initialized = false
function CustomSettingsWindow.Update()
    if not CustomSettingsWindow.Initialized then
        CustomSettingsWindow.SetupWindow()
        CustomSettingsWindow.Initialized = true
        CustomSettingsWindow.UpdateSettings()
    end
end

function CustomSettingsWindow.SetupWindow()
    WindowClearAnchors( "SettingsWindowGraphicsTabButton" )
    local lastTabAnchor = { name="SettingsWindow", x=CustomSettingsWindow.CORNER.x, y=CustomSettingsWindow.CORNER.y }
    for tab,settings in pairs( CustomSettingsWindow.Settings ) do
        -- create the tab
        local tabWindow = "CustomSettingsWindow_"..tab
        local tabContainer = tabWindow.."ScrollChild"
        lastTabAnchor = CustomSettingsWindow.SetupTab( tab, tabWindow, tabContainer, lastTabAnchor )
        local anchor = { name=tabContainer, relative="topleft", y=10 }
        for i,setting in ipairs( settings ) do
            if setting.type == CustomSettingsWindow.SettingTypes.Color then
                anchor = CustomSettingsWindow.SetupColorSetting( tabContainer, setting, anchor )
            elseif setting.type == CustomSettingsWindow.SettingTypes.Font then
                anchor = CustomSettingsWindow.SetupFontSetting( tabContainer, setting, anchor )
            else
                anchor = CustomSettingsWindow.SetupOtherSetting( tabContainer, setting, anchor )
            end
        end
        CreateWindowFromTemplate( tabContainer.."Spacer", "CustomSettingsTemplatesSpacer", tabContainer )
        WindowAddAnchor( tabContainer.."Spacer", "bottomleft", anchor.name, "topleft", 0, anchor.y )
        ScrollWindowSetOffset( tabWindow, 0 )
        ScrollWindowUpdateScrollRect( tabWindow )
    end
    WindowAddAnchor( "SettingsWindowGraphicsTabButton", "topleft", lastTabAnchor.name, "topleft", CustomSettingsWindow.CORNER.x, lastTabAnchor.y + CustomSettingsWindow.TAB_SIZE.y )
    CustomSettingsWindow.SimpleClearTabStates()
end

function CustomSettingsWindow.SetupTab( tab, tabWindow, tabContainer, lastTabAnchor )
    if lastTabAnchor.x > CustomSettingsWindow.TAB_SIZE.x * 6 + CustomSettingsWindow.CORNER.x then
        lastTabAnchor.x = CustomSettingsWindow.CORNER.x
        lastTabAnchor.y = lastTabAnchor.y + CustomSettingsWindow.TAB_SIZE.y
    end
    
    CreateWindowFromTemplate( tabWindow.."_Button", "CustomSettingsWindowTabButton", "SettingsWindow" )
    WindowAddAnchor( tabWindow.."_Button", "topleft", lastTabAnchor.name, "topleft", lastTabAnchor.x, lastTabAnchor.y )
    ButtonSetText( tabWindow.."_Button", CustomLocalization.Load( tab ) )
    
    CreateWindowFromTemplate( tabWindow, "CustomSettingsScrollWindow", "SettingsWindow" )
    WindowAddAnchor( tabWindow, "bottomleft", "SettingsWindowGraphicsTabButton", "topleft", 0, 10 )
    
    lastTabAnchor.x = lastTabAnchor.x + CustomSettingsWindow.TAB_SIZE.x
    return lastTabAnchor

    --SettingsWindowGraphicsTabButton
    --SettingsWindowTabButton
end

function CustomSettingsWindow.OpenTab()
    SettingsWindow.ClearTabStates()
    local windowName = SystemData.ActiveWindow.name
    ButtonSetDisabledFlag( windowName, true )
    WindowSetShowing( windowName.."Tab", false )
    WindowSetShowing( string.gsub( windowName, "_Button$", "" ), true )
end

function CustomSettingsWindow.ClearTabStates()
    CustomSettingsWindow.SimpleClearTabStates()
    CustomSettingsWindow.InitialClearTabStates()
end

function CustomSettingsWindow.SimpleClearTabStates()
    for tab,settings in pairs( CustomSettingsWindow.Settings ) do
        ButtonSetPressedFlag( "CustomSettingsWindow_"..tab.."_Button", false )
        ButtonSetDisabledFlag( "CustomSettingsWindow_"..tab.."_Button", false )
        WindowSetShowing( "CustomSettingsWindow_"..tab.."_ButtonTab", true )
        WindowSetShowing( "CustomSettingsWindow_"..tab, false )
    end
end

function CustomSettingsWindow.SetupFontSetting( parent, setting, anchor )
    local windowName = parent..setting.name
    setting.windowName = windowName
    CreateWindowFromTemplate( windowName, setting.type, parent )
    WindowAddAnchor( windowName, anchor.relative, anchor.name, "topleft", 0, anchor.y )
    ButtonSetText( windowName.."Button", CustomLocalization.Load( setting.ctid ) )
    WindowSetId( windowName.."Button", setting.uid )
    
    anchor.name = windowName
    anchor.relative = "bottomleft"
    anchor.y = 0
    return anchor
end

function CustomSettingsWindow.SetupColorSetting( parent, setting, anchor )
    local windowName = parent..setting.name
    setting.windowName = windowName
    CreateWindowFromTemplate( windowName, setting.type, parent )
    WindowAddAnchor( windowName, anchor.relative, anchor.name, "topleft", 0, anchor.y )
    LabelSetText( windowName.."Label", CustomLocalization.Load( setting.ctid ) )
    WindowSetId( windowName.."Color", setting.uid )

    anchor.name = windowName
    anchor.relative = "bottomleft"
    anchor.y = 0
    return anchor
end

function CustomSettingsWindow.SetupOtherSetting( parent, setting, anchor )
    local windowName = parent..setting.name
    setting.windowName = windowName
    CreateWindowFromTemplate( windowName, setting.type, parent )
    WindowAddAnchor( windowName, anchor.relative, anchor.name, "topleft", 0, anchor.y )
    LabelSetText( windowName.."Label", CustomLocalization.Load( setting.ctid ) )
    
    if setting.type == CustomSettingsWindow.SettingTypes.Combo then
        for valueIdx, value in ipairs( setting.options ) do
            ComboBoxAddMenuItem( windowName.."Combo", CustomLocalization.Load( value ) )
        end
    elseif setting.type == CustomSettingsWindow.SettingTypes.Boolean then
        ButtonSetCheckButtonFlag( windowName.."Button", true )
    elseif setting.type == CustomSettingsWindow.SettingTypes.Slider then
        WindowSetId( windowName.."SliderBar", setting.uid )
    end

    anchor.name = windowName
    anchor.relative = "bottomleft"
    anchor.y = 0
    return anchor
end


function CustomSettingsWindow.ShowFontMenu()
    local id = WindowGetId(SystemData.ActiveWindow.name)
    -- local setting = CustomSettingsWindow.SettingsByUID[id]
    
    for fontFaceIndex,fontFace in ipairs( CustomSettingsWindow.Fonts ) do
        local subMenu = {}
        local isActiveFontFace = false
        for fontIndex,font in ipairs( fontFace.types ) do
            local isActiveFont = false -- TODO: Make this check the setting
            isActiveFontFace = isActiveFontFace or isActiveFont
            local fontMenuItem = {
                str = CustomLocalization.Load( font.ctid ),
                flags = 0,
                returnCode = { face=fontFace, font=font },
                param=id,
                pressed=isActiveFont,
            }
            table.insert( subMenu, fontMenuItem )
        end
        ContextMenu.CreateLuaContextMenuItemWithString( CustomLocalization.Load( fontFace.ctid ),0,nil,id,isActiveFontFace,subMenu)
    end
    ContextMenu.ActivateLuaContextMenu(CustomSettingsWindow.FontMenuCallback)
end

function CustomSettingsWindow.FontMenuCallback( returnCode, param )
    if param ~= nil and returnCode ~= nil then
        local font = returnCode.font
        local fontFace = returnCode.face
        local setting = CustomSettingsWindow.SettingsByUID[param]
        local windowName = setting.windowName
        CustomSettingsWindow.SettingsByUID[param].selectedValue = font.internalName
        if font.internalName == nil then -- It's the Skin Default
            LabelSetText( windowName.."Preview", L"" )
            LabelSetText( windowName.."Name", CustomLocalization.Load( fontFace.ctid ) )
        else
            LabelSetFont( windowName.."Preview", font.internalName, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING )
            LabelSetText( windowName.."Preview", CustomLocalization.Load("FontPreviewText") )
            LabelSetText( windowName.."Name", CustomLocalization.Load( fontFace.ctid )..L" > "..CustomLocalization.Load( font.ctid ) )
        end
    end
end

function CustomSettingsWindow.SaveAllSettings()
    for tab,settings in pairs( CustomSettingsWindow.Settings ) do
        for i,setting in ipairs( settings ) do
            if setting.type == CustomSettingsWindow.SettingTypes.Boolean then
                CustomSettings.SaveBooleanValue( { settingName=setting.name, settingValue=ButtonGetPressedFlag(setting.windowName.."Button" ) } )
            elseif setting.type == CustomSettingsWindow.SettingTypes.Slider then
                CustomSettings.SaveNumberValue( { settingName=setting.name, settingValue=setting.selectedValue } )
            elseif setting.type == CustomSettingsWindow.SettingTypes.Combo then
                CustomSettings.SaveNumberValue ( { settingName=setting.name, settingValue=ComboBoxGetSelectedMenuItem( setting.windowName.."Combo" ) } ) 
            elseif setting.type == CustomSettingsWindow.SettingTypes.Color then
                CustomSettings.SaveColorValue( { settingName=setting.name, settingValue=setting.selectedValue } )
            elseif setting.type == CustomSettingsWindow.SettingTypes.Font then
                CustomSettings.SaveStringValue( { settingName=setting.name, settingValue=setting.selectedValue } )
            end
        end
    end
    CustomSettingsWindow.OriginalSaveAllSettings()
end

function CustomSettingsWindow.SliderSettingPicked()
    local id = WindowGetId( SystemData.ActiveWindow.name )
    local setting = CustomSettingsWindow.SettingsByUID[id]
    local value = math.floor( ( SliderBarGetCurrentPosition( setting.windowName.."SliderBar" ) * setting.range ) + setting.min )
    setting.selectedValue = value
    LabelSetText( setting.windowName.."Val", L""..value )
end

CustomSettingsWindow.ActiveColorWindow = nil
function CustomSettingsWindow.ShowColorPicker()
    Debug.Print("ShowColorPicker...")
    CustomSettingsWindow.ActiveColorWindow = WindowGetId( SystemData.ActiveWindow.name )
	CustomColorPickerWindow.SetAfterColorSelectionFunction( CustomSettingsWindow.CustomColorPicked )
	--CustomColorPickerWindow.SelectColor("CustomColorPicker", 1) -- TODO: Find a way to get this
	WindowSetShowing("CustomColorPicker", true)
end

function CustomSettingsWindow.CustomColorPicked()
    local hueNumber = CustomColorPickerWindow.colorSelected["CustomColorPicker"]
    local red,green,blue = HueRGBAValue(hueNumber)
    WindowSetTintColor( CustomSettingsWindow.SettingsByUID[CustomSettingsWindow.ActiveColorWindow].windowName, red, green, blue)
    CustomSettingsWindow.SettingsByUID[CustomSettingsWindow.ActiveColorWindow].selectedValue = { r=red, g=green, b=blue }
    Debug.Print("Color picked: "..hueNumber)
end
