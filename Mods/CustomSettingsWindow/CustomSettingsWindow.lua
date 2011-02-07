CustomSettingsWindow = {}

CustomSettingsWindow.Fonts = {
    {
        ctid="SkinDefault",
        types={
            {
                ctid="NoteRequiresUIReload",
                internalName=nil,
            }
        }
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
                ctid="DefaultNameFont",
                internalName="UO_NeueText",
            }
        }
    },
    {
        ctid="ArialNarrow",
        types={
            {
                ctid="Arial_Narrow_13",
                internalName="Arial_Narrow_13",
            },
            {
                ctid="Arial_Narrow_14",
                internalName="Arial_Narrow_14",
            },
            {
                ctid="Arial_Narrow_15",
                internalName="Arial_Narrow_15",
            },
            {
                ctid="Arial_Narrow_18",
                internalName="Arial_Narrow_18",
            },
            {
                ctid="Arial_Narrow_20",
                internalName="Arial_Narrow_20",
            },
            {
                ctid="Arial_Narrow_22",
                internalName="Arial_Narrow_22",
            }
        }
    },
    {
        ctid="Avatar",
        types={
            {
                ctid="Avatar_14",
                internalName="Avatar_14",
            },
            {
                ctid="Avatar_15",
                internalName="Avatar_15",
            },
            {
                ctid="Avatar_16",
                internalName="Avatar_16",
            },
            {
                ctid="Avatar_18",
                internalName="Avatar_18",
            },
            {
                ctid="Avatar_20",
                internalName="Avatar_20",
            }
        }
    },
    {
        ctid="Kingthings_Exeter",
        types={
            {
                ctid="King_13",
                internalName="King_13",
            },
            {
                ctid="King_14",
                internalName="King_14",
            },
            {
                ctid="King_16",
                internalName="King_16",
            },
            {
                ctid="King_17",
                internalName="King_17",
            },
            {
                ctid="King_18",
                internalName="King_18",
            },
            {
                ctid="King_20",
                internalName="King_20",
            },
            {
                ctid="King_22",
                internalName="King_22",
            }
        }
    },
    {
        ctid="MTG",
        types={
            {
                ctid="magic_18",
                internalName="magic_18",
            },
            {
                ctid="magic_20",
                internalName="magic_20",
            },
            {
                ctid="magic_22",
                internalName="magic_22",
            }
        },
    },
    {
        ctid="TimesNewRoman",
        types={
            {
                ctid="TimesNewRoman_13",
                internalName="TimesNewRoman_13",
            },
            {
                ctid="TimesNewRoman_14",
                internalName="TimesNewRoman_14",
            },
            {
                ctid="TimesNewRoman_16",
                internalName="TimesNewRoman_16",
            },
            {
                ctid="TimesNewRoman_17",
                internalName="TimesNewRoman_17",
            },
            {
                ctid="TimesNewRoman_18",
                internalName="TimesNewRoman_18",
            },
            {
                ctid="TimesNewRoman_20",
                internalName="TimesNewRoman_20",
            },
            {
                ctid="TimesNewRoman_22",
                internalName="TimesNewRoman_22",
            },
            {
                ctid="TimesNewRoman_Bold_14",
                internalName="TimesNewRoman_Bold_14",
            },
            {
                ctid="TimesNewRoman_Bold_18",
                internalName="TimesNewRoman_Bold_18",
            },
            {
                ctid="TimesNewRoman_Bold_20",
                internalName="TimesNewRoman_Bold_20",
            },
            {
                ctid="TimesNewRoman_Bold_22",
                internalName="TimesNewRoman_Bold_22",
            }
        }
    },
    {
        ctid="Tenace",
        types={
            {
                ctid="Tenace_13",
                internalName="Tenace_13",
            },
            {
                ctid="Tenace_14",
                internalName="Tenace_14",
            },
            {
                ctid="Tenace_15",
                internalName="Tenace_15",
            },
            {
                ctid="Tenace_16",
                internalName="Tenace_16",
            },
            {
                ctid="Tenace_18",
                internalName="Tenace_18",
            },
            {
                ctid="Tenace_20",
                internalName="Tenace_20",
            },
            {
                ctid="Tenace_22",
                internalName="Tenace_22",
            }
        }
    },
    {
        ctid="UO_Classic",
        types={
            {
                ctid="UO_15",
                internalName="UO_15",
            },
            {
                ctid="UO_16",
                internalName="UO_16",
            },
            {
                ctid="UO_17",
                internalName="UO_17",
            },
            {
                ctid="UO_18",
                internalName="UO_18",
            },
            {
                ctid="UO_20",
                internalName="UO_20",
            },
            {
                ctid="UO_22",
                internalName="UO_22",
            }
        }
    }
}

CustomSettingsWindow.CORNER={ x=16, y=43 }
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
    scale = #, (For Slider only)
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

function CustomSettingsWindow.AddSliderSetting( tabCTID, ctid, name, default, min, max, scale )
    local setting = {
        ctid=ctid,
        type=CustomSettingsWindow.SettingTypes.Slider,
        name=name,
        min=min,
        max=max,
        range=(max - min),
        default=default,
        scale=scale
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

function CustomSettingsWindow.Initialize()
    CustomSettingsWindow.SettingsWindowUpdateSettings = SettingsWindow.UpdateSettings
    SettingsWindow.UpdateSettings = CustomSettingsWindow.UpdateSettings
    
    CustomSettingsWindow.InitialClearTabStates = SettingsWindow.ClearTabStates
    SettingsWindow.ClearTabStates = CustomSettingsWindow.ClearTabStates
    
    CustomSettingsWindow.OriginalSaveAllSettings = SettingsWindow.OnApplyButton
    SettingsWindow.OnApplyButton = CustomSettingsWindow.SaveAllSettings
    
    CustomSettingsWindow.SetupColorPicker()
    CustomSettingsWindow.SetupFonts()
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

function CustomSettingsWindow.SetupFonts()
    local types = {}
	-- Add the Chat Window fonts to our list
    for idx,font in ipairs( ChatSettings.Fonts ) do
        Debug.Print( "FontName: "..font.shownName )
        table.insert( types, { internalName=font.fontName, name=font.shownName } )
    end
    table.insert( CustomSettingsWindow.Fonts, 3, { ctid="ECChatFonts", types=types } )
	
	-- Add all our new fonts to the Chat Window
	local n = #ChatSettings.Fonts
	for idx,fontfamily in ipairs( CustomSettingsWindow.Fonts ) do
		if fontfamily.ctid ~= "ECChatFonts" then
			for idx2,font in ipairs( fontfamily.types ) do
				if font.internalName ~= nil then
					n = n + 1
					local fontName = nil
					if font.ctid ~= nil then
						fontName = CustomLocalization.Load( font.ctid )
					elseif font.name ~= nil then
						fontName = StringToWString( font.name )
					end
					if fontName == nil then
						fontName = L"???"
					end
					fontName = WStringToString( fontName )
					ChatSettings.Fonts[n] = { fontName = font.internalName, isDefault = false, shownName = fontName }
				end
			end
		end
	end
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
    local displayValue = value
    if setting.scale ~= nil then
        displayValue = ( value * 1.0 ) / ( setting.scale * 1.0 )
    end
    LabelSetText( setting.windowName.."Val", wstring.format( L"%.2g", displayValue ) )
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
                    local fontName = nil
                    if font.ctid ~= nil then
                        fontName = CustomLocalization.Load( font.ctid )
                    elseif font.name ~= nil then
                        fontName = StringToWString( font.name )
                    end
                    if fontName == nil then
                        fontName = L"???"
                    end
                    LabelSetText( windowName.."Name", CustomLocalization.Load( fontFace.ctid )..L" > "..fontName )
                end
            end
         end
    end
end

CustomSettingsWindow.ChatFontWindowSet = false
CustomSettingsWindow.Initialized = false
function CustomSettingsWindow.Update()
    if not CustomSettingsWindow.Initialized then
        CustomSettingsWindow.SetupWindow()
        CustomSettingsWindow.Initialized = true
        CustomSettingsWindow.UpdateSettings()
    end
	if DoesWindowExist( "ChatFontWindow" ) then
		if not CustomSettingsWindow.ChatFontWindowSet then
			CustomSettingsWindow.ChatFontWindowSet = true
			local size = #ChatSettings.Fonts
			local itemWindow = "ChatFontWindowItem"..size
			--WindowAddAnchor( "ChatFontWindow", "bottomleft", itemWindow, "bottomleft", 20, 40 )
			WindowSetDimensions( "ChatFontWindow", 400, 105 + 25 * size )
		end
	else
		CustomSettingsWindow.ChatFontWindowSet = false
	end
end

function CustomSettingsWindow.SetupWindow()
    WindowClearAnchors( "SettingsWindowGraphicsTabButton" )
    local lastTabAnchor = { name="SettingsWindow", x=CustomSettingsWindow.CORNER.x, y=CustomSettingsWindow.CORNER.y }
    local tabCount = 0
    local nextTabLoopAnchor = { name="SettingsWindow", x=CustomSettingsWindow.CORNER.x, y=CustomSettingsWindow.CORNER.y }
    for tab,settings in pairs( CustomSettingsWindow.Settings ) do
        if tabCount % 6 == 0 then
            lastTabAnchor = { name="SettingsWindow", x=CustomSettingsWindow.CORNER.x, y=CustomSettingsWindow.CORNER.y + ( CustomSettingsWindow.TAB_SIZE.y * tabCount / 6 ) }
        end
        tabCount = tabCount + 1
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
    local x,y = _WindowGetDimensions( "SettingsWindow" )
    WindowSetDimensions( "SettingsWindow", x, y + CustomSettingsWindow.TAB_SIZE.y + (lastTabAnchor.y - CustomSettingsWindow.CORNER.y ) )

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
            local fontName = nil
            if font.ctid ~= nil then
                fontName = CustomLocalization.Load( font.ctid )
            elseif font.name ~= nil then
                fontName = StringToWString( font.name )
            end
            if fontName == nil then
                fontName = L"???"
            end
            local fontMenuItem = {
                str = fontName,
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
            local fontName = font.name
            local fontName = nil
            if font.ctid ~= nil then
                fontName = CustomLocalization.Load( font.ctid )
            elseif font.name ~= nil then
                fontName = StringToWString( font.name )
            end
            if fontName == nil then
                fontName = L"???"
            end
            LabelSetText( windowName.."Name", CustomLocalization.Load( fontFace.ctid )..L" > "..fontName )
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
    CustomSettingsWindow.UpdateSettings()
end

function CustomSettingsWindow.SliderSettingPicked()
    local id = WindowGetId( SystemData.ActiveWindow.name )
    local setting = CustomSettingsWindow.SettingsByUID[id]
    local value = math.floor( ( SliderBarGetCurrentPosition( setting.windowName.."SliderBar" ) * setting.range ) + setting.min )
    setting.selectedValue = value
    local displayValue = value
    if setting.scale ~= nil then
        displayValue = ( value * 1.0 ) / ( setting.scale * 1.0 )
    end
    LabelSetText( setting.windowName.."Val", wstring.format( L"%.2g", displayValue ) )
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
