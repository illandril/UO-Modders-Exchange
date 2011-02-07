ItemPropertyHighlighting = {}

-- Special Texts coloring
ItemPropertyHighlighting.SettingPrefix = "ItemPropertiesSpecialTexts_"
ItemPropertyHighlighting.ItemPropertiesColoring = false
ItemPropertyHighlighting.ItemPropertiesColoringSettingName = ItemPropertyHighlighting.SettingPrefix.."ItemPropertiesColoring"
ItemPropertyHighlighting.DefaultLabelFont = "UO_DefaultText"
ItemPropertyHighlighting.DefaultLabelFontSettingName = ItemPropertyHighlighting.SettingPrefix.."DefaultLabelFont"
ItemPropertyHighlighting.DefaultTitleLabelFont = "UO_GoldButtonText"
ItemPropertyHighlighting.DefaultTitleLabelFontSettingName = ItemPropertyHighlighting.SettingPrefix.."DefaultTitleLabelFont"

ItemPropertyHighlighting.ColorTable = {
    { r=0,   g=0,   b=0   },
    { r=255, g=0,   b=0   },
    { r=0,   g=255, b=0   },
    { r=0,   g=0,   b=255 },
    { r=255, g=255, b=0   },
    { r=255, g=0,   b=255 },
    { r=0,   g=255, b=255 },
    { r=255, g=255, b=255 },
}

ItemPropertyHighlighting.ItemChecks = { 
    LessThanQuarter = 0,
    MakesOverweight = 1,
    Percentage = 2,
    PercentageOverHalf = 3,
    InversePercentage = 4,
    InversePercentageOverHalf = 5,
    }

ItemPropertyHighlighting.FullMod = { r=187, g=187, b=64 }
ItemPropertyHighlighting.PartialMod = { r=0, g=0, b=255 }

ItemPropertyHighlighting.ItemSpecialTexts = {
    {
        name="insured",
        regex="^Insured$",
        color={ r=128, g=128, b=255 },
    },
    {
        name="blessed",
        regex="^Blessed$",
        color={ r=128, g=128, b=255 },
    },
    {
        name="exceptional",
        regex="^Exceptional$",
        color={ r=175, g=175, b=128 },
    },
    {
        name="cursed",
        regex="^Cursed$",
        color={ r=255, g=128, b=128 },
    },
    {
        name="engraved",
        regex="^Engraved: (.*)$",
        color={ r=175, g=175, b=95 },
        gsub="%1",
    },
    {
        name="price",
        regex="^Price: ([0-9,]+)$",
        useTitleFont=true,
        color={ r=175, g=175, b=95 },
        addCommas=true,
    },
    {
        name="vendorpenalty",
        regex="^Vending Penalty: ([0-9]+)$",
        addCommas=true,
    },
    {
        name="artifact",
        regex="^Artifact Rarity ([0-9]+)$",
        mainColor={ r=155, g=50, b=255 },
        conditionalColor={ r=155, g=50, b=255 },
        check=ItemPropertyHighlighting.ItemChecks.Percentage,
        param=12,
    },
    {
        name="setpiece",
        regex="^Part Of .* Set .*$",
        color={ r=0, g=230, b=0 },
        mainColor={ r=0, g=230, b=0 },
    },
    {
        name="incompleteset",
        regex="Only When Full Set Is Present:",
        color={ r=255, g=128, b=64 }, 
        useTitleFont=true,
    },
    {
        name="completeset",
        regex="^Full .* Set Present$",
        color={ r=175, g=175, b=95 },
    },
    {
        name="durability",
        regex="^Durability ([0-9]+) / ([0-9]+)$",
        conditionalColor={ r=255, g=0, b=0 },
        check=ItemPropertyHighlighting.ItemChecks.InversePercentageOverHalf,
    },
    {
        name="weight",
        regex="^Weight: ([0-9]+) Stones$",
        addCommas=true,
        conditionalColor={ r=255, g=0, b=0 },
        check=ItemPropertyHighlighting.ItemChecks.MakesOverweight,
    },
    {
        name="elvesonly",
        regex="^Elves Only$",
        color={ r=255, g=128, b=0 },
    },
    {
        name="gargoylesonly",
        regex="^Gargoyles Only$",
        color={ r=255, g=0, b=128 },
    },
    {
        name="questitem",
        regex="^Quest Item$",
        color={ r=0, g=255, b=128 },
    },
    {
        name="resist",
        regex=" Resist ([0-9]+)%%$",
        conditionalColor=ItemPropertyHighlighting.PartialMod,
        maxColor=ItemPropertyHighlighting.FullMod,
        check=ItemPropertyHighlighting.ItemChecks.PercentageOverHalf,
        param=20,
    },
    {
        name="balanced",
        regex="^Balanced$",
        color=ItemPropertyHighlighting.FullMod,
    },
    {
        name="damageincrease",
        regex="^Damage Increase ([0-9]+)%%$",
        conditionalColor=ItemPropertyHighlighting.PartialMod,
        maxColor=ItemPropertyHighlighting.FullMod,
        check=ItemPropertyHighlighting.ItemChecks.PercentageOverHalf,
        param=50,
    },
    {
        name="damagemodifier",
        regex="^Damage Modifier: ([0-9]+)%%$",
        conditionalColor=ItemPropertyHighlighting.PartialMod,
        maxColor=ItemPropertyHighlighting.FullMod,
        check=ItemPropertyHighlighting.ItemChecks.PercentageOverHalf,
        param=10,
    },
    {
        name="dcihci",
        regex=" Chance Increase ([0-9]+)%%$",
        conditionalColor=ItemPropertyHighlighting.PartialMod,
        maxColor=ItemPropertyHighlighting.FullMod,
        check=ItemPropertyHighlighting.ItemChecks.PercentageOverHalf,
        param=15,
    },
    {
        name="statbonus",
        regex=" Bonus ([0-9]+)$",
        conditionalColor=ItemPropertyHighlighting.PartialMod,
        maxColor=ItemPropertyHighlighting.FullMod,
        check=ItemPropertyHighlighting.ItemChecks.PercentageOverHalf,
        param=8,
    },
    {
        name="enhancepotions",
        regex="^Enhance Potions ([0-9]+)%%$",
        conditionalColor=ItemPropertyHighlighting.PartialMod,
        maxColor=ItemPropertyHighlighting.FullMod,
        check=ItemPropertyHighlighting.ItemChecks.PercentageOverHalf,
        param=25,
    },
    {
        name="fcr",
        regex="^Faster Cast Recovery ([0-9]+)$",
        conditionalColor=ItemPropertyHighlighting.PartialMod,
        maxColor=ItemPropertyHighlighting.FullMod,
        check=ItemPropertyHighlighting.ItemChecks.Percentage,
        param=3,
    },
    {
        name="fc",
        regex="^Faster Casting ([0-9]+)$",
        conditionalColor=ItemPropertyHighlighting.PartialMod,
        maxColor=ItemPropertyHighlighting.FullMod,
        check=ItemPropertyHighlighting.ItemChecks.Percentage,
        param=2,
    },
    {
        name="hitpointincrease",
        regex="^Hit Point Increase ([0-9]+)$",
        conditionalColor=ItemPropertyHighlighting.PartialMod,
        maxColor=ItemPropertyHighlighting.FullMod,
        check=ItemPropertyHighlighting.ItemChecks.PercentageOverHalf,
        param=5,
    },
    {
        name="regenerations",
        regex=" Regeneration ([0-9]+)$",
        conditionalColor=ItemPropertyHighlighting.PartialMod,
        maxColor=ItemPropertyHighlighting.FullMod,
        check=ItemPropertyHighlighting.ItemChecks.Percentage,
        param=3,
    },
    {
        name="lmc",
        regex="^Lower Mana Cost ([0-9]+)%%$",
        conditionalColor=ItemPropertyHighlighting.PartialMod,
        maxColor=ItemPropertyHighlighting.FullMod,
        check=ItemPropertyHighlighting.ItemChecks.PercentageOverHalf,
        param=10,
    },
    {
        name="lowerreagentcost",
        regex="^Lower Reagent Cost ([0-9]+)%%$",
        conditionalColor=ItemPropertyHighlighting.PartialMod,
        maxColor=ItemPropertyHighlighting.FullMod,
        check=ItemPropertyHighlighting.ItemChecks.PercentageOverHalf,
        param=20,
    },
    {
        name="luck",
        regex="^Luck ([0-9]+)$",
        conditionalColor=ItemPropertyHighlighting.PartialMod,
        maxColor=ItemPropertyHighlighting.FullMod,
        check=ItemPropertyHighlighting.ItemChecks.PercentageOverHalf,
        param=100,
    },
    {
        name="magearmor",
        regex="^Mage Armor$",
        color=ItemPropertyHighlighting.FullMod,
    },
    {
        name="mageweapon",
        regex="^Mage Weapon %-([0-9]+) Skill$",
        conditionalColor=ItemPropertyHighlighting.PartialMod,
        maxColor=ItemPropertyHighlighting.FullMod,
        check=ItemPropertyHighlighting.ItemChecks.InversePercentage,
        param=30,
    },
    {
        name="manaincrease",
        regex="^Mana Increase ([0-9]+)$",
        conditionalColor=ItemPropertyHighlighting.PartialMod,
        maxColor=ItemPropertyHighlighting.FullMod,
        check=ItemPropertyHighlighting.ItemChecks.PercentageOverHalf,
        param=8,
    },
    {
        name="nightsight",
        regex="^Night Sight$",
        color=ItemPropertyHighlighting.FullMod,
    },
    {
        name="rpd",
        regex="^Reflect Physical Damage ([0-9]+)%%$",
        conditionalColor=ItemPropertyHighlighting.PartialMod,
        maxColor=ItemPropertyHighlighting.FullMod,
        check=ItemPropertyHighlighting.ItemChecks.PercentageOverHalf,
        param=15,
    },
    {
        name="replenishcharges",
        regex="^Replenish Charges$",
        color=ItemPropertyHighlighting.FullMod,
    },
    {
        name="selfrepair",
        regex="^Self Repair ([0-9]+)$",
        conditionalColor=ItemPropertyHighlighting.PartialMod,
        maxColor=ItemPropertyHighlighting.FullMod,
        check=ItemPropertyHighlighting.ItemChecks.Percentage,
        param=5,
    },
    { -- This check might hit lots of other stuff too since it's so vague... 
      -- if we see too many false positives, we should remove it
        name="skillbonus",
        regex=" [+]([0-9]+)$",
        conditionalColor=ItemPropertyHighlighting.PartialMod,
        maxColor=ItemPropertyHighlighting.FullMod,
        check=ItemPropertyHighlighting.ItemChecks.PercentageOverHalf,
        param=15,
    },
    {
        name="slayer",
        regex=" Slayer$",
        color=ItemPropertyHighlighting.FullMod,
    },
    {
        name="spellchanneling",
        regex="^Spell Channeling$",
        color=ItemPropertyHighlighting.FullMod,
    },
    {
        name="sdi",
        regex="^Spell Damage Increase ([0-9]+)%%$",
        conditionalColor=ItemPropertyHighlighting.PartialMod,
        maxColor=ItemPropertyHighlighting.FullMod,
        check=ItemPropertyHighlighting.ItemChecks.PercentageOverHalf,
        param=12,
    },
    {
        name="staminaincrease",
        regex="^Stamina Increase ([0-9]+)$",
        conditionalColor=ItemPropertyHighlighting.PartialMod,
        maxColor=ItemPropertyHighlighting.FullMod,
        check=ItemPropertyHighlighting.ItemChecks.PercentageOverHalf,
        param=8,
    },
    {
        name="ssi",
        regex="^Swing Speed Increase ([0-9]+)%%$",
        conditionalColor=ItemPropertyHighlighting.PartialMod,
        maxColor=ItemPropertyHighlighting.FullMod,
        check=ItemPropertyHighlighting.ItemChecks.PercentageOverHalf,
        param=30,
    },
    {
        name="ubws",
        regex="^Use Best Weapon Skill$",
        color=ItemPropertyHighlighting.FullMod,
    },
    {
        name="physicaldamage",
        regex="^Physical Damage ([0-9]+)%%$",
        conditionalColor={ r=128, g=128, b=128 },
        check=ItemPropertyHighlighting.ItemChecks.Percentage,
        param=100,
    },
    {
        name="firedamage",
        regex="^Fire Damage ([0-9]+)%%$",
        conditionalColor={ r=255, g=175, b=0 },
        check=ItemPropertyHighlighting.ItemChecks.Percentage,
        param=100,
    },
    {
        name="colddamage",
        regex="^Cold Damage ([0-9]+)%%$",
        conditionalColor={ r=0, g=0, b=255 },
        check=ItemPropertyHighlighting.ItemChecks.Percentage,
        param=100,
    },
    {
        name="poisondamage",
        regex="^Poison Damage ([0-9]+)%%$",
        conditionalColor={ r=0, g=255, b=0 },
        check=ItemPropertyHighlighting.ItemChecks.Percentage,
        param=100,
    },
    {
        name="energydamage",
        regex="^Energy Damage ([0-9]+)%%$",
        conditionalColor={ r=255, g=0, b=255 },
        check=ItemPropertyHighlighting.ItemChecks.Percentage,
        param=100,
    },
    {
        name="lifespanunder15min",
        regex="^Lifespan: ([0-9]+) Seconds$",
        addCommas=true,
        conditionalColor={ r=255, g=0, b=0 },
        check=ItemPropertyHighlighting.ItemChecks.InversePercentage,
        param=900,
    },
    {
        name="othernumbers",
        regex="([0-9][0-9][0-9][0-9]+)",
        addCommas=true,
    },
}


function ItemPropertyHighlighting.Initialize()
    ItemPropertyHighlighting.OriginalUpdateItemPropertiesData = ItemProperties.UpdateItemPropertiesData
    ItemProperties.UpdateItemPropertiesData = ItemPropertyHighlighting.UpdateItemPropertiesData
    
    CustomSettingsWindow.AddFontSetting( "ItemPropertySettings", "TooltipTitleFontSetting", ItemPropertyHighlighting.DefaultTitleLabelFontSettingName, ItemPropertyHighlighting.DefaultTitleLabelFont )
    CustomSettingsWindow.AddFontSetting( "ItemPropertySettings", "TooltipBodyFontSetting", ItemPropertyHighlighting.DefaultLabelFontSettingName, ItemPropertyHighlighting.DefaultLabelFont )
    CustomSettingsWindow.AddBooleanSetting( "ItemPropertySettings", "UseItemPropertiesColoring", ItemPropertyHighlighting.ItemPropertiesColoringSettingName, ItemPropertyHighlighting.ItemPropertiesColoring )

    for i,v in ipairs( ItemPropertyHighlighting.ItemSpecialTexts ) do
        if v.color ~= nil then
            CustomSettingsWindow.AddColorSetting( "ItemPropertySettings", v.name.."_Color", ItemPropertyHighlighting.SettingPrefix..v.name.."_color", v.color, ItemPropertyHighlighting.ColorTable )
        end
        if v.mainColor ~= nil then
            CustomSettingsWindow.AddColorSetting( "ItemPropertySettings", v.name.."_Main_Color", ItemPropertyHighlighting.SettingPrefix..v.name.."_mainColor", v.mainColor, ItemPropertyHighlighting.ColorTable )
        end
        if v.conditionalColor ~= nil then
            CustomSettingsWindow.AddColorSetting( "ItemPropertySettings", v.name.."_Conditional_Color", ItemPropertyHighlighting.SettingPrefix..v.name.."_conditionalColor", v.conditionalColor, ItemPropertyHighlighting.ColorTable )
        end
        if v.conditionalMainColor ~= nil then
            CustomSettingsWindow.AddColorSetting( "ItemPropertySettings", v.name.."_Conditional_Main_Color", ItemPropertyHighlighting.SettingPrefix..v.name.."_conditionalMainColor", v.conditionalMainColor, ItemPropertyHighlighting.ColorTable )
        end
        if v.maxColor ~= nil then
            CustomSettingsWindow.AddColorSetting( "ItemPropertySettings", v.name.."_Max_Color", ItemPropertyHighlighting.SettingPrefix..v.name.."_maxColor", v.maxColor, ItemPropertyHighlighting.ColorTable )
        end
        if v.maxMainColor ~= nil then
            CustomSettingsWindow.AddColorSetting( "ItemPropertySettings", v.name.."_Max_Main_Color", ItemPropertyHighlighting.SettingPrefix..v.name.."_maxMainColor", v.maxMainColor, ItemPropertyHighlighting.ColorTable )
        end
    end
    CustomSettingsWindow.RegisterUpdateSettingsListener( ItemPropertyHighlighting.UpdateSettings )
end

function ItemPropertyHighlighting.UpdateSettings()
    -- Load item properties coloring setting
    ItemPropertyHighlighting.ItemPropertiesColoring = CustomSettings.LoadBooleanValue( { settingName=ItemPropertyHighlighting.ItemPropertiesColoringSettingName, defaultValue=ItemPropertyHighlighting.ItemPropertiesColoring } )

    -- Load any custom fonts
    ItemPropertyHighlighting.DefaultLabelFont = CustomSettings.LoadStringValue( { settingName=ItemPropertyHighlighting.DefaultLabelFontSettingName, defaultValue=ItemPropertyHighlighting.DefaultLabelFont } )
    ItemPropertyHighlighting.DefaultTitleLabelFont = CustomSettings.LoadStringValue( { settingName=ItemPropertyHighlighting.DefaultTitleLabelFontSettingName, defaultValue=ItemPropertyHighlighting.DefaultTitleLabelFont } )

    if ItemPropertyHighlighting.ItemPropertiesColoring then

        -- Load any custom colors
        for i,v in ipairs( ItemPropertyHighlighting.ItemSpecialTexts ) do
            v.color =  CustomSettings.LoadColorValue( {settingName=ItemPropertyHighlighting.SettingPrefix..v.name.."_color", defaultValue=v.color } )
            v.mainColor = CustomSettings.LoadColorValue( {settingName=ItemPropertyHighlighting.SettingPrefix..v.name.."_mainColor", defaultValue=v.mainColor } )
            v.conditionalColor = CustomSettings.LoadColorValue( {settingName=ItemPropertyHighlighting.SettingPrefix..v.name.."_conditionalColor", defaultValue=v.conditionalColor } )
            v.conditionalMainColor = CustomSettings.LoadColorValue( {settingName=ItemPropertyHighlighting.SettingPrefix..v.name.."_conditionalMainColor", defaultValue=v.conditionalMainColor } )
            v.maxColor = CustomSettings.LoadColorValue( {settingName=ItemPropertyHighlighting.SettingPrefix..v.name.."_maxColor", defaultValue=v.maxColor } )
            v.maxMainColor = CustomSettings.LoadColorValue( {settingName=ItemPropertyHighlighting.SettingPrefix..v.name.."_maxMainColor", defaultValue=v.maxMainColor } )
        end
    end
end

function ItemPropertyHighlighting.UpdateItemPropertiesData()
    ItemPropertyHighlighting.OriginalUpdateItemPropertiesData()
    if not ItemPropertyHighlighting.ItemPropertiesColoring then
        -- If it's not enabled, don't do anything
        return
    end
    
    if WindowData.ItemProperties.CurrentType ~= WindowData.ItemProperties.TYPE_ITEM then
        -- If it's not an item, nothing to do
        return
    end
    
    local this = WindowUtils.GetActiveDialog()
    local id = WindowData.ItemProperties.CurrentHover
    local labelText = {}
    local changedText = {}
    local labelColors = {}
    local changedColors = {}
    local labelFont = {}
    local changedFont = {}
    local numLabels = 0
    
    -- use instance id 0 for the current item properties object
    data = WindowData.ItemProperties[0]
    if data and data.PropertiesList then
        propList = data.PropertiesList
        propLen = table.getn( propList )
        
        for i = 1, propLen do
            local labelName = "ItemPropertiesItemLabel"..i
            numLabels = numLabels + 1
            -- DAB TODO: Show bold strings, for now just rip out the tag
            labelText[numLabels] = LabelGetText( labelName )
            changedText[numLabels] = false
            changedColors[numLabels] = false
            changedFont[numLabels] = false
            
            local text = WStringToString(labelText[numLabels])
            for specialTextIdx,v in ipairs( ItemPropertyHighlighting.ItemSpecialTexts ) do
                local s,f,cg1,cg2,cg3,cg4,cg5 = string.find( text, v.regex )
                if s ~= nil then
                    local cgs = { cg1, cg2, cg3, cg4, cg5 }
                    
                    if v.mainColor ~= nil then
                        labelColors[1] = v.mainColor
                        changedColors[1] = true
                    end
                    if v.color ~= nil then
                        labelColors[numLabels] = v.color
                        changedColors[numLabels] = true
                    end
                    if v.useTitleFont then
                        labelFont[numLabels] = ItemPropertyHighlighting.DefaultTitleLabelFont
                        changedFont[numLabels] = true
                    end
                    
                    local newText = text
                    if v.gsub ~= nil then
                        newText = string.gsub( text, v.regex, v.gsub )
                        changedText[numLabels] = true
                    end
                    
                    if v.addCommas then
                        for cgi,cg in ipairs(cgs) do
                            local num = tonumber(cg)
                            local newCg = cg
                            if num ~= nil then
                                newCg = WindowUtils.AddCommasToNumber(StringToWString(cg))
                                newCg = WStringToString(newCg)
                            end
                            newText = string.gsub( newText, cg, newCg )
                            changedText[numLabels] = true
                        end
                    end
                    
                    if v.check ~= nil then
                        local checkVal = ItemPropertyHighlighting.ItemCheck(v.check, cgs, v.param)
                        
                        if type( checkVal ) == type( true ) and checkVal then
                            if v.conditionalMainColor ~= nil then
                                labelColors[1] = v.conditionalMainColor
                                changedColors[1] = true
                            end
                            if v.conditionalColor ~= nil then
                                labelColors[numLabels] = v.conditionalColor
                                changedColors[numLabels] = true
                            end
                            if v.conditionalFont ~= nil then
                                labelFont[numLabels] = v.conditionalFont
                                changedFont[numLabels] = true
                            end
                            if v.conditionalGsub ~= nil then
                                newText = string.gsub( text, v.regex, v.conditionalGsub )
                                changedText[numLabels] = true
                            end
                        elseif type( checkVal ) == type( 0 ) and checkVal >= 0 and checkVal <= 1 then
                            if v.conditionalMainColor ~= nil then
                                if checkVal == 1 and v.maxMainColor ~= nil then
                                    labelColors[1] = v.maxMainColor
                                    changedColors[1] = true
                                else
                                    labelColors[1] = ItemPropertyHighlighting.MixColors( ItemProperties.TITLE_COLOR, v.conditionalMainColor, checkVal )
                                    changedColors[1] = true
                                end
                            end
                            if v.conditionalColor ~= nil then
                                local condColor = ItemProperties.BODY_COLOR
                                if numLabels == 1 then
                                    condColor = ItemProperties.TITLE_COLOR
                                end
                                if checkVal == 1 and v.maxColor ~= nil then
                                    labelColors[numLabels] = v.maxColor
                                    changedColors[numLabels] = true
                                else
                                    labelColors[numLabels] = ItemPropertyHighlighting.MixColors( condColor, v.conditionalColor, checkVal )
                                    changedColors[numLabels] = true
                                end
                            end
                            if v.conditionalFont ~= nil then
                                labelFont[numLabels] = v.conditionalFont
                                changedFont[numLabels] = true
                            end
                            if v.conditionalGsub ~= nil then
                                newText = string.gsub( text, v.regex, v.conditionalGsub )
                                changedText[numLabels] = true
                            end
                        end
                    end
                    
                    labelText[numLabels] = StringToWString(newText)
                    break
                end
            end
            
            if labelColors[numLabels] == nil then
                if( i==1 ) then 
                    if ( (WindowData.ItemProperties.CustomColorTitle) and (WindowData.ItemProperties.CustomColorTitle.Enable) and (i == WindowData.ItemProperties.CustomColorTitle.LabelIndex) and (WindowData.ItemProperties.CustomColorTitle.NotorietyEnable) ) then
                        labelColors[numLabels] = NameColor.TextColors[WindowData.ItemProperties.CustomColorTitle.NotorietyIndex+1]
                        changedColors[numLabels] = true
                    else
                        labelColors[numLabels] = ItemProperties.TITLE_COLOR
                        changedColors[numLabels] = true
                    end
                else
                    if WindowData.ItemProperties.CustomColorBody and WindowData.ItemProperties.CustomColorBody.Enable and i == WindowData.ItemProperties.CustomColorBody.LabelIndex then
                        labelColors[numLabels] = WindowData.ItemProperties.CustomColorBody.Color
                        changedColors[numLabels] = true
                    elseif WindowData.ItemProperties.CustomColorBody2 and WindowData.ItemProperties.CustomColorBody2.Enable and i == WindowData.ItemProperties.CustomColorBody2.LabelIndex then
                        labelColors[numLabels] = WindowData.ItemProperties.CustomColorBody2.Color
                        changedColors[numLabels] = true
                    else
                        labelColors[numLabels] = ItemProperties.BODY_COLOR
                        changedColors[numLabels] = true
                    end
                end 
            end
        end
    end
    local oldNumLabels = table.getn(labelText)
    labelText, labelColors, numLabels = ItemPropertiesEvaluator.parse(labelText, labelColors) -- added by pgcd
    
    numLabels = table.getn(labelText)
    if( numLabels > 0 ) then
        ItemProperties.CreatePropsLabels(numLabels)
        local propWindowWidth = 100
        local propWindowHeight = 4
        for i = 1, numLabels do
            local isNew = i > oldNumLabels
            if labelFont[i] == nil then
                labelFont[i] = ItemPropertyHighlighting.DefaultLabelFont
                changedFont[i] = true
            end
            labelName = "ItemPropertiesItemLabel"..i
            LabelSetText( labelName, labelText[i] )
            LabelSetTextColor( labelName, labelColors[i].r, labelColors[i].g, labelColors[i].b )
            LabelSetFont( labelName, labelFont[i], WindowUtils.FONT_DEFAULT_TEXT_LINESPACING )
            local w, h = LabelGetTextDimensions(labelName)
            propWindowWidth = math.max(propWindowWidth, w)
            propWindowHeight = propWindowHeight + h + 3 -- Allow for spacing
            WindowSetShowing(labelName, true)
        end
        
        propWindowWidth = propWindowWidth + 12
        WindowSetDimensions("ItemProperties", propWindowWidth, propWindowHeight)
        
        -- Set the window position
        windowOffset = 16
        scaleFactor = 1/InterfaceCore.scale    
        
        mouseX = SystemData.MousePosition.x
        propWindowX = mouseX - windowOffset - (propWindowWidth / scaleFactor)
        if propWindowX < 0 then
            propWindowX = mouseX + windowOffset
        end
            
        mouseY = SystemData.MousePosition.y
        propWindowY = mouseY - windowOffset - (propWindowHeight / scaleFactor)
        if propWindowY < 0 then
            propWindowY = mouseY + windowOffset
        end
        
        WindowSetOffsetFromParent("ItemProperties", propWindowX * scaleFactor, propWindowY * scaleFactor)
        WindowSetShowing("ItemProperties",true)
    end
end


function ItemPropertyHighlighting.ItemCheck(check, cgs, param)
    if check == ItemPropertyHighlighting.ItemChecks.LessThanQuarter then
        return tonumber(cgs[1]) / tonumber(cgs[2]) < 0.25
    elseif check == ItemPropertyHighlighting.ItemChecks.MakesOverweight then
        local w = WindowData.PlayerStatus.Weight + tonumber(cgs[1])
        local mw = WindowData.PlayerStatus.MaxWeight
        return w >= mw
    elseif check == ItemPropertyHighlighting.ItemChecks.Percentage then
        if type( param ) ~= type( 0 ) then
            return ItemPropertyHighlighting.Clamp( tonumber(cgs[1]) / tonumber(cgs[2]), 0, 1 )
        else
            return ItemPropertyHighlighting.Clamp( tonumber(cgs[1]) / param, 0, 1 )
        end
    elseif check == ItemPropertyHighlighting.ItemChecks.PercentageOverHalf then
        local retval = ItemPropertyHighlighting.ItemCheck( ItemPropertyHighlighting.ItemChecks.Percentage, cgs, param )
        if retval < 0.5 then
            retval = false
        else
            retval = (retval - 0.5) * 2
        end
        return retval
    elseif check == ItemPropertyHighlighting.ItemChecks.InversePercentage then
        if type( param ) ~= type( 0 ) then
            return 1 - ItemPropertyHighlighting.Clamp( tonumber(cgs[1]) / tonumber(cgs[2]), 0, 1 )
        else
            return 1 - ItemPropertyHighlighting.Clamp( tonumber(cgs[1]) / param, 0, 1 )
        end
    elseif check == ItemPropertyHighlighting.ItemChecks.InversePercentageOverHalf then
        local retval = ItemPropertyHighlighting.ItemCheck( ItemPropertyHighlighting.ItemChecks.InversePercentage, cgs, param )
        if retval < 0.5 then
            retval = false
        else
            retval = (retval - 0.5) * 2
        end
        return retval
    end
end

-- Clamp a number between the min and max values
function ItemPropertyHighlighting.Clamp( number, min, max )
    return math.min( math.max( number, min ), max )
end

-- Merge two colors
function ItemPropertyHighlighting.MixColors( colorA, colorB, percentage )
    local resColor = {}
    resColor.r = math.floor( colorA.r - ( percentage * ( colorA.r - colorB.r ) )  + 0.5 )
    resColor.b = math.floor( colorA.b - ( percentage * ( colorA.b - colorB.b ) )  + 0.5 )
    resColor.g = math.floor( colorA.g - ( percentage * ( colorA.g - colorB.g ) )  + 0.5 )
    return resColor
end


