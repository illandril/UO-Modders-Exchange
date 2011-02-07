-------------------------------------------------------------------------------
-- Title: Custom Settings
-- Authors: Ash, Illandril
-- Version: 2.0
-- Date: September 26, 2008
-- Description:
--     This collection of functions allows for the saving of custom settings
--     by using bogus window positions.
-- Usage:
--     CustomSettings.Save<Type>Value( args )
--         Saves the value of type <Type>
--         Supported Save arguments are...
--             settingName (required) - the name of the setting
--             settingValue (required) - the value of the setting; if nil, any
--                                       previously saved value will be deleted
--             saveChanges (optional) - if true, CustomSettings.SaveChanges is
--                                      called immediately after the saving
--     CustomSettings.Load<Type>Value( args )
--         Supported Save arguments are...
--             settingName (required) - the name of the setting
--             defaultValue (optional) - a value that will be returned if
--                                       no value (or nil) was previously saved
--
-- Supported Types:
--     Boolean - true or false
--     Number - Any number, integer or double
--     Color - A table with 'r', 'g', 'b', and (optionally) 'a' values (0-255)
--     String - A string with fewer than 60 characters, using only ascii values
--
-- Warnings:
--     Data Loss Risk: If you call CustomSettings.SaveChanges during the
--         logout procedure, character settings will be lost. When adding and
--         testing new custom settings code, always backup the settings files
--         of any character you log in as until you are confident everything
--         is working correctly. Simply using CustomSettings.Save<Type>, and
--         not using CustomSettings.SaveChanges, during shutdown will still
--         save your settings.
--     Performance Risk: Saving and loading custom settings, especially
--         strings, takes time. This time should not noticeably impact players,
--         but you should avoid saving or loading in situations where players
--         might be in danger just to be safe (startup and shutdown, or
--         through user actions on a settings window are the best times).
-------------------------------------------------------------------------------

CustomSettings = {}

-- Values to use for saving boolean values
CustomSettings.BooleanTrue = 1
CustomSettings.BooleanFalse = 0

-- Values to use for special values
CustomSettings.IsNil = -9999

-- A cache to speed things up
CustomSettings.IndexCache = {}

-- Values to store in the WindowPosition table when creating a new entry
CustomSettings.DefaultPosX = CustomSettings.IsNil
CustomSettings.DefaultPosY = CustomSettings.IsNil
CustomSettings.DefaultWidth = CustomSettings.IsNil
CustomSettings.DefaultHeight = CustomSettings.IsNil

-- A prefix to be added to custom settings (to avoid collisions with actual window names)
CustomSettings.SettingPrefix = "CustomSetting___"

-- Ascii table for converting ints to ascii values
CustomSettings.ExtraSettingsPerString=4
CustomSettings.AsciiStartIndex = 32
CustomSettings.AsciiSize = 128
CustomSettings.AsciiPerSetting = 3
CustomSettings.Ascii = 
{
 " ","!","\"","#","$","%","&","'","(",")","*","+",",","-",".","/",
 "0","1","2","3","4","5","6","7","8","9",
 ":",";","<","=",">","?","@",
 "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
 "[","\\","]","^","_","`",
 "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
 "{","|","}","~"
}

-------------------------------------------------------------------------------
-- CustomSettings.AllowDecorations
-- This function makes it easy to extend other functions.
-- See CustomSettings.Decorate<Saver/Loader> for examples
-------------------------------------------------------------------------------
function CustomSettings.AllowDecorations(func)
  local currentfunc = func
  local function decorate(newfunc)
    local lastfunc = currentfunc
    currentfunc = function(...) return newfunc(lastfunc, ...) end
  end
  local wrapper = function(...) return currentfunc(...) end
  return wrapper, decorate
end

-------------------------------------------------------------------------------
-- CustomSettings Debugging
-- These decorators, when used properly, add extra details to the logs to help
-- find problems in the use of the CustomSettings module
-- They will automatically be added to every default Save and Load call if
-- CustomSettings.ExcessiveDebugging is set to true
-- CustomSettings.ExcessiveDebugging also adds debugging to other decorators
-------------------------------------------------------------------------------
CustomSettings.ExcessiveDebugging = false
function CustomSettings.PrintSaveDebug( fn, args )
    Debug.Print("CustomSettings Save::")
    Debug.DumpToConsole("args", args)
    return fn( args )
end
function CustomSettings.PrintLoadDebug( fn, args )
    Debug.Print("CustomSettings Load::")
    Debug.DumpToConsole("    args", args)
    return fn( args )
end

-------------------------------------------------------------------------------
-- CustomSettings Caching
-- These decorators, when used properly, allow Saving and Loading functions to
-- make use of a Cache. This doesn't do much good for booleans and numbers, but
-- can save time with repeat-loads for Strings and Colors
-------------------------------------------------------------------------------
CustomSettings.Cache = {}

function CustomSettings.LoadUsingCache( fn, args )
    local value = nil
    if CustomSettings.Cache[args.settingName] == nil then
        value = fn( args )
        CustomSettings.Cache[args.settingName] = value
    else
        if CustomSettings.ExcessiveDebugging then
            Debug.Print( "Using cache for "..args.settingName )
        end
        value = CustomSettings.Cache[args.settingName]
    end
    return value
end

function CustomSettings.StoreResultInCache( fn, args )
    local result = fn( args )
    CustomSettings.Cache[args.settingName] = result
    return result
end

function CustomSettings.StoreValueInCache( fn, args )
    local success = fn( args )
    if success then
        CustomSettings.Cache[args.settingName] = args.settingValue
    end
    return success
end

-------------------------------------------------------------------------------
-- CustomSettings.FixSettingName
-- This decorator will ensure that args.settingName has the appropriate prefix
-- It should added as a decorator after any decorator that makes use of
-- args.settingName
-------------------------------------------------------------------------------
function CustomSettings.FixSettingName( fn, args )
    assert( type( args.settingName ) == type( "" ), "settingName must be a string" )
    -- If the settingName doesn't have the prefix already, add it
    if not ( string.sub( args.settingName, 1, string.len( CustomSettings.SettingPrefix ) ) == CustomSettings.SettingPrefix ) then
        args.settingName = CustomSettings.SettingPrefix..args.settingName
    end
    return fn( args )
end

-------------------------------------------------------------------------------
-- CustomSettings.LoadUsingDefault
-- This decorator will return args.defaultValue if a nil value is returned
-------------------------------------------------------------------------------
function CustomSettings.LoadUsingDefault( fn, args )
    local value = fn( args )
    -- If the result was nil, use the default
    if value == nil then
        if CustomSettings.ExcessiveDebugging then
            Debug.Print( "Using defaultValue for "..args.settingName )
        end
        value = args.defaultValue
    end
    return value
end

-------------------------------------------------------------------------------
-- CustomSettings.LoadUsingDefault
-- This decorator will delete a setting if args.settingValue is nil
-------------------------------------------------------------------------------
function CustomSettings.DeleteSettingIfNil( fn, args )
    if args.settingValue == nil then
        return CustomSettings.DeleteSetting( args.settingName )
    else
        return fn( args )
    end
end

-------------------------------------------------------------------------------
-- CustomSettings.AllowSaveChanges
-- This decorator will call CustomSettings.SaveChanges if a save is successful
-------------------------------------------------------------------------------
function CustomSettings.AllowSaveChanges( fn, args )
    local result = fn( args )
    if args.saveChanges == true then
        CustomSettings.SaveChanges()
    end
    return result
end

-------------------------------------------------------------------------------
-- CustomSettings.SaveRawValues
-- Description:
--     Saves the raw x, y, w, and h values of a setting
-- Parameters:
--     settingName - the name of the setting
--     x, y, w, h - the x, y, w, and h values fo the setting
-------------------------------------------------------------------------------
function CustomSettings.SaveRawValues( settingName, x, y, w, h )
    local index = CustomSettings.GetOrCreateSettingIndex( settingName )
    SystemData.Settings.Interface.WindowPositions.WindowPosX[index] = x or CustomSettings.IsNil
    SystemData.Settings.Interface.WindowPositions.WindowPosY[index] = y or CustomSettings.IsNil
    SystemData.Settings.Interface.WindowPositions.WindowWidth[index] = w or CustomSettings.IsNil
    SystemData.Settings.Interface.WindowPositions.WindowHeight[index] = h or CustomSettings.IsNil
end

-------------------------------------------------------------------------------
-- CustomSettings.GetRawValues
-- Description:
--     Gets the raw x, y, w, and h values of a setting
-- Parameters:
--     settingName - the name of the setting
-- Returns:
--     The raw x, y, w, and h values for the setting
-------------------------------------------------------------------------------
function CustomSettings.GetRawValues( settingName )
    local index = CustomSettings.GetSettingIndex( settingName )
    local x = SystemData.Settings.Interface.WindowPositions.WindowPosX[index]
    local y = SystemData.Settings.Interface.WindowPositions.WindowPosY[index]
    local w = SystemData.Settings.Interface.WindowPositions.WindowWidth[index]
    local h = SystemData.Settings.Interface.WindowPositions.WindowHeight[index]
    return x,y,w,h
end

-------------------------------------------------------------------------------
-- CustomSettings.DeleteSetting
-- Description:
--     Gets rid of a setting
-- Parameters:
--     settingName - the name of the setting (with the prefix)
-- Returns:
--     True if successful
-------------------------------------------------------------------------------
function CustomSettings.DeleteSetting( settingName )
    local index = CustomSettings.GetSettingIndex( settingName )
    if index ~= nil then
        SystemData.Settings.Interface.WindowPositions.Names[index] = nil
        SystemData.Settings.Interface.WindowPositions.WindowPosX[index] = nil
        SystemData.Settings.Interface.WindowPositions.WindowPosY[index] = nil
        SystemData.Settings.Interface.WindowPositions.WindowWidth[index] = nil
        SystemData.Settings.Interface.WindowPositions.WindowHeight[index] = nil
    end
end

-------------------------------------------------------------------------------
-- CustomSettings.GetOrCreateSettingIndex
-- Description:
--     Gets the index of a setting, creating a new entry if it doesn't exist 
-- Parameters:
--     settingName - the name of the setting (with the prefix)
-- Returns:
--     The index of for the setting
-------------------------------------------------------------------------------
function CustomSettings.GetOrCreateSettingIndex( settingName )
    local index = CustomSettings.GetSettingIndex( settingName )

    -- If it doesnt exist yet then add it
    if( index == nil ) then
        index = table.getn(SystemData.Settings.Interface.WindowPositions.Names) + 1
        SystemData.Settings.Interface.WindowPositions.Names[index] = settingName
        CustomSettings.ClearSettingAtIndex( index )
    end

    return index
end

-------------------------------------------------------------------------------
-- CustomSettings.GetSettingIndex
-- Description:
--     Gets the index of a setting
-- Parameters:
--     settingName - the name of the setting (with the prefix)
-- Returns:
--     The index of for the setting, or nil if it doesn't exist yet
-------------------------------------------------------------------------------
function CustomSettings.GetSettingIndex( settingName )
    -- Find the index for the setting in the window positions table
    local index = nil
    if CustomSettings.IndexCache[settingName] ~= nil then
        index = CustomSettings.IndexCache[settingName]
    else
        for i, windowName in pairs(SystemData.Settings.Interface.WindowPositions.Names) do
            if( settingName == windowName ) then
                index = i
                CustomSettings.IndexCache[settingName] = index
                break
            end
        end
    end
    return index
end

-------------------------------------------------------------------------------
-- CustomSettings.ClearSettingAtIndex
-- Description:
--     Clears the setting with the specified index
-- Parameters:
--     settingIndex - the index of the setting
-------------------------------------------------------------------------------
function CustomSettings.ClearSettingAtIndex( settingIndex )
    if( settingIndex ~= nil ) then
        SystemData.Settings.Interface.WindowPositions.WindowPosX[settingIndex] = CustomSettings.DefaultPosX
        SystemData.Settings.Interface.WindowPositions.WindowPosY[settingIndex] = CustomSettings.DefaultPosY
        SystemData.Settings.Interface.WindowPositions.WindowWidth[settingIndex] = CustomSettings.DefaultWidth
        SystemData.Settings.Interface.WindowPositions.WindowHeight[settingIndex] = CustomSettings.DefaultHeight
    end
end

-------------------------------------------------------------------------------
-- CustomSettings.CheckColor
-- Description:
--     Checks to see if an argument is a valid color table
-- Parameters:
--     color - the argument to check
-- Returns:
--     True if it is a valid color, false otherwise
-------------------------------------------------------------------------------
function CustomSettings.CheckColor( color )
    local good = true
    if type( color ) ~= type( {} ) then
        good = false
    elseif type( color.r ) ~= type( 0 ) or color.r < 0 or color.r > 255 then
        good = false
    elseif type( color.g ) ~= type( 0 ) or color.g < 0 or color.g > 255 then
        good = false
    elseif type( color.b ) ~= type( 0 ) or color.b < 0 or color.b > 255 then
        good = false
    elseif color.a ~= nil and ( type( color.a ) ~= type( 0 ) or color.a < 0 or color.a > 255 ) then
        good = false
    end
    return good
end

-------------------------------------------------------------------------------
-- CustomSettings.SaveChanges
-- Description:
--     Raises the event that causes the client to actually save the window data
--     where the custom settings are stored
-------------------------------------------------------------------------------
function CustomSettings.SaveChanges()
    UserSettingsChanged()
end

----------------------------------------------------------
--  ######     ###    ##     ## #### ##    ##  ######   --
-- ##    ##   ## ##   ##     ##  ##  ###   ## ##    ##  --
-- ##        ##   ##  ##     ##  ##  ####  ## ##        --
--  ######  ##     ## ##     ##  ##  ## ## ## ##   #### --
--       ## #########  ##   ##   ##  ##  #### ##    ##  --
-- ##    ## ##     ##   ## ##    ##  ##   ### ##    ##  --
--  ######  ##     ##    ###    #### ##    ##  ######   --
----------------------------------------------------------
-------------------------------------------------------------------------------
-- CustomSettings.DecorateSaver
-- Description:
--     Adds common capabilities into saving functions
-------------------------------------------------------------------------------
function CustomSettings.DecorateSaver( saver, extraDecorations )
    local saver, decorate = CustomSettings.AllowDecorations( saver )
    decorate( CustomSettings.DeleteSettingIfNil )  -- Clear the setting if the passed value is nil (should be done first)
    decorate( CustomSettings.StoreValueInCache )   -- Save the passed value to the cache if save is a success (should be done second)
    if extraDecorations ~= nil then
        for i,fn in ipairs( extraDecorations ) do -- Add in any extra decorations for this saver
            decorate( fn )
        end
    end
    decorate( CustomSettings.FixSettingName )      -- Fix the name of the setting to use the prefix (should be done last)
    
    if CustomSettings.ExcessiveDebugging then
        decorate( CustomSettings.PrintSaveDebug )
    end
    return saver
end

-------------------------------------------------------------------------------
-- CustomSettings.SaveBooleanValue
-- Description:
--     See Usage: CustomSettings.Save<Type>Value( args )
-------------------------------------------------------------------------------
function CustomSettings.SaveBooleanValue( args )
    -- Check the types of the arguments
    assert( type( args.settingValue ) == type( true ), "settingValue must be a boolean" )
    
    -- Determine the raw value for the boolean
    local y = CustomSettings.BooleanFalse
    if args.settingValue then
        y = CustomSettings.BooleanTrue
    end
    
    CustomSettings.SaveRawValues( args.settingName, nil, y, nil, nil )
    return true
end
CustomSettings.SaveBooleanValue = CustomSettings.DecorateSaver( CustomSettings.SaveBooleanValue )

-------------------------------------------------------------------------------
-- CustomSettings.SaveNumberValue
-- Description:
--     See Usage: CustomSettings.Save<Type>Value( args )
-------------------------------------------------------------------------------
function CustomSettings.SaveNumberValue( args )
    -- Check the types of the arguments
    assert( type( args.settingValue ) == type( 0 ), "settingValue must be a number" )
    
    -- Save the value
    CustomSettings.SaveRawValues( args.settingName, args.settingValue, nil, nil, nil )
    return true
end
CustomSettings.SaveNumberValue = CustomSettings.DecorateSaver( CustomSettings.SaveNumberValue )

-------------------------------------------------------------------------------
-- CustomSettings.SaveColorValue
-- Description:
--     See Usage: CustomSettings.Save<Type>Value( args )
-------------------------------------------------------------------------------
function CustomSettings.SaveColorValue( args )
    -- Check the types of the arguments
    assert( CustomSettings.CheckColor( args.settingValue ), "settingValue must be a color" )
    
    -- Save the value
    CustomSettings.SaveRawValues( args.settingName, args.settingValue.r, args.settingValue.g, args.settingValue.b, args.settingValue.a )
    return true
end
CustomSettings.SaveColorValue = CustomSettings.DecorateSaver( CustomSettings.SaveColorValue )

-------------------------------------------------------------------------------
-- CustomSettings.SaveStringValue
-- Description:
--     See Usage: CustomSettings.Save<Type>Value( args )
-------------------------------------------------------------------------------
function CustomSettings.SaveStringValue( args )
    -- Check the types of the arguments
    assert( type( args.settingValue ) == type( "" ), "settingValue must be a string" )
    local maxChars = CustomSettings.AsciiPerSetting * 4 * CustomSettings.ExtraSettingsPerString
    assert( string.len( args.settingValue ) <= maxChars, "settingValue must be fewer than "..tostring(maxChars).." characters long" )
    
    -- Determine the raw value for the string
    function PackBytes(...)
        return arg
    end
    local stringBytes = PackBytes( string.byte( args.settingValue, 1, string.len( args.settingValue  ) ) )
    local xywh = {}
    local idx = 0
    for i,v in ipairs( stringBytes ) do
        local iMod = (i-1) % CustomSettings.AsciiPerSetting
        if iMod == 0 then
            idx = idx + 1
            xywh[idx] = 0
        end
        v = v * ( CustomSettings.AsciiSize ^ iMod )
        xywh[idx] = xywh[idx] + v
    end
    
    -- Save the value
    CustomSettings.SaveRawValues( args.settingName, xywh[1], xywh[2], xywh[3], xywh[4] )
    for i=1,CustomSettings.ExtraSettingsPerString do
        CustomSettings.SaveRawValues( args.settingName.."_"..i, xywh[1 + i*4], xywh[2 + i*4], xywh[3 + i*4], xywh[4 + i*4] )
    end
    return true
end
CustomSettings.SaveStringValue = CustomSettings.DecorateSaver( CustomSettings.SaveStringValue )



--------------------------------------------------------------------
-- ##        #######     ###    ########  #### ##    ##  ######   --
-- ##       ##     ##   ## ##   ##     ##  ##  ###   ## ##    ##  --
-- ##       ##     ##  ##   ##  ##     ##  ##  ####  ## ##        --
-- ##       ##     ## ##     ## ##     ##  ##  ## ## ## ##   #### --
-- ##       ##     ## ######### ##     ##  ##  ##  #### ##    ##  --
-- ##       ##     ## ##     ## ##     ##  ##  ##   ### ##    ##  --
-- ########  #######  ##     ## ########  #### ##    ##  ######   --
--------------------------------------------------------------------
-------------------------------------------------------------------------------
-- CustomSettings.DecorateLoader
-- Description:
--     Adds common capabilities into loading functions
-------------------------------------------------------------------------------
function CustomSettings.DecorateLoader( loader, extraDecorations )
    local loader, decorate = CustomSettings.AllowDecorations( loader )
    decorate( CustomSettings.StoreResultInCache )  -- Save the result of the actual call to the cache (should be done first)
    decorate( CustomSettings.LoadUsingCache )      -- Allow the value to be pulled from the cache, if it's there
    decorate( CustomSettings.LoadUsingDefault )    -- Allow a default to be used for the value, if one wasn't saved
    if extraDecorations ~= nil then
        for i,fn in ipairs( extraDecorations ) do -- Add in any custom decorations for the loader
            decorate( fn )
        end
    end
    decorate( CustomSettings.FixSettingName )      -- Fix the name of the setting to use the prefix (should be done last)

    if CustomSettings.ExcessiveDebugging then
        decorate( CustomSettings.PrintLoadDebug )
    end
    return loader
end

-------------------------------------------------------------------------------
-- CustomSettings.LoadBooleanValue
-- Description:
--     See Usage: CustomSettings.Load<Type>Value( args )
-------------------------------------------------------------------------------
function CustomSettings.LoadBooleanValue( args )
    local value = nil

    -- Get the raw saved values
    local x,y,w,h = CustomSettings.GetRawValues( args.settingName )

    -- Convert the raw value into the boolean equivalent
    if y == CustomSettings.BooleanTrue then
        value =  true
    elseif y == CustomSettings.BooleanFalse then
        value = false
    end

    -- Return the value
    return value
end
CustomSettings.LoadBooleanValue = CustomSettings.DecorateLoader( CustomSettings.LoadBooleanValue )

-------------------------------------------------------------------------------
-- CustomSettings.LoadNumberValue
-- Description:
--     See Usage: CustomSettings.Load<Type>Value( args )
-------------------------------------------------------------------------------
function CustomSettings.LoadNumberValue( args )
    local value = nil

    -- Get the raw saved values
    local x,y,w,h = CustomSettings.GetRawValues( args.settingName )

    -- Check the x to make sure it wasn't 'IsNil'
    if x ~= CustomSettings.IsNil then
        value =  x
    end

    -- Return the value
    return value
end
CustomSettings.LoadNumberValue = CustomSettings.DecorateLoader( CustomSettings.LoadNumberValue )

-------------------------------------------------------------------------------
-- CustomSettings.LoadColorValue
-- Description:
--     See Usage: CustomSettings.Load<Type>Value( args )
-------------------------------------------------------------------------------
function CustomSettings.LoadColorValue( args )
    local value = nil

    -- Get the raw saved values
    local r,g,b,a = CustomSettings.GetRawValues( args.settingName )
    if a == CustomSettings.IsNil then
        a = nil
    end
    color = { r=r, g=g, b=b, a=a }

    -- Check to make sure it's a valid color
    if CustomSettings.CheckColor( color ) then
        value = color
    end

    -- Return the value
    return value
end
CustomSettings.LoadColorValue = CustomSettings.DecorateLoader( CustomSettings.LoadColorValue )

-------------------------------------------------------------------------------
-- CustomSettings.LoadStringValue
-- Description:
--     See Usage: CustomSettings.Load<Type>Value( args )
-------------------------------------------------------------------------------
function CustomSettings.LoadStringValue( args )
    local value = ""

    -- Get the raw saved values
    local x,y,w,h = CustomSettings.GetRawValues( args.settingName )
    local xywh = { x, y, w, h }
    for i=1,CustomSettings.ExtraSettingsPerString do
        x,y,w,h = CustomSettings.GetRawValues( args.settingName.."_"..i )
        xywh[i*4 + 1] = x
        xywh[i*4 + 2] = y
        xywh[i*4 + 3] = w
        xywh[i*4 + 4] = h
    end

    -- Convert the raw values into a string
    local offset = CustomSettings.AsciiStartIndex - 1
    for i,v in ipairs( xywh ) do
        local done = false
        while v > 0 and not done do
            local i = math.floor( v / CustomSettings.AsciiSize )
            local d = v % CustomSettings.AsciiSize
            v = i;
            d = d - offset
            if d > 0 then
                value = value..CustomSettings.Ascii[d]
            elseif d == -offset then
                done = true
                break
            else
                -- An invalid character was saved
                Debug.Print("CustomSettings.LoadString: An invalid character was found - "..tostring(d))
                done = true
                value = nil
                break
            end
        end
        if done then
            break
        end
    end

    -- Check to make sure we at least got one letter
    if value == "" then
        value = nil
    end

    -- Return the value
    return value
end
CustomSettings.LoadStringValue = CustomSettings.DecorateLoader( CustomSettings.LoadStringValue )
