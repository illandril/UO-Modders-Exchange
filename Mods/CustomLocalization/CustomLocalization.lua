-------------------------------------------------------------------------------
-- Title: Custom Localization
-- Authors: Illandril
-- Version: 0.1
-- Date: September 28, 2008
-- Description:
--     This collection of functions allows for the use of localized text that
--     is supplied by players, not EA, for use when enhancements require text
--     that isn't already used elsewhere in the client.
-- Usage:
--     CustomLocalization.Load( name )
--         Loads the string of the given name for the client's active locale.
--     CustomLocalization.LoadForLocale( name, locale )
--         Loads the string of the given name for the specified locale.
--         This is intended for use for debugging purposes, though could be
--         used for other reasons if there is some alternative use.
--         Valid locales are SystemData.Settings.Language.LANGUAGE_xxx
--
-- Warnings:
--     Performance Risk: Using localization as opposed to hard-coded strings
--                       will be slower and use more memory. This impact should
--                       be minimal, however, since you should only need to
--                       load the strings the first time a window loads.
--     UOBuildTableFromCSV Limit: I got client crashes on startup when I added
--                                the 107th and 108th columns to my original
--                                CSV file. After removing the columns, the
--                                crashes stopped. Using multiple CSVs and
--                                merging them in the Lua seemed to fix this
--                                problem. It might be a good idea to split up
--                                the CSV files based on content in the future.
-------------------------------------------------------------------------------

CustomLocalization = {}
CustomLocalization.LocaleFiles = {
    "UserInterface/"..SystemData.Settings.Interface.customUiName.."/Enhancements/CustomLocalization.csv",
    "UserInterface/"..SystemData.Settings.Interface.customUiName.."/Enhancements/CustomLocalization2.csv",
}
CustomLocalization.isInitialized = false
CustomLocalization.Strings = {}
CustomLocalization.Languages = {}

function CustomLocalization.Initialize()
    if not CustomLocalization.isInitialized then
        Debug.Print("Initializing Custom Localization...")
        for k,v in pairs( SystemData.Settings.Language ) do
            if string.find( k, "LANGUAGE_" ) == 1 then
                CustomLocalization.Languages[string.gsub(k, "LANGUAGE_", "")] = v
            end
        end
        --[[ CSV stuff doesn't work :(
        for fileIdx,file in ipairs( CustomLocalization.LocaleFiles ) do
            UOBuildTableFromCSV( file, "CustomLocalization" )
            for lineIdx,line in ipairs( WindowData.CustomLocalization ) do
                local language = WStringToString(line["language"])
                local languageNum = CustomLocalization.Languages[language]
                if languageNum == nil then
                    Debug.Print("Invalid language found in CSV: "..language)
                else
                    if CustomLocalization.Strings[languageNum] == nil then
                        CustomLocalization.Strings[languageNum] = {}
                    end
                    for key,value in pairs( line ) do
                        CustomLocalization.Strings[languageNum][key] = CustomLocalization.utf8toUnicode(value)
                    end
                end
            end
            UOUnloadCSVTable( "CustomLocalization" )
        end
        ]]--
        
        CustomLocalization.isInitialized = true
        Debug.Print("Custom Localization Initialization complete!")
    end
end

function CustomLocalization.AddLocalization( languageNum, key, value )
    CustomLocalization.Initialize()
    if CustomLocalization.Strings[languageNum] == nil then
        CustomLocalization.Strings[languageNum] = {}
    end
    CustomLocalization.Strings[languageNum][key] = value
end

function CustomLocalization.Load( name )
    return CustomLocalization.LoadForLocale( name, SystemData.Settings.Language.type )
end

function CustomLocalization.LoadForLocale( name, type )
    CustomLocalization.Initialize()
    if CustomLocalization.Strings[type] ~= nil then
        if CustomLocalization.Strings[type][name] ~= nil and CustomLocalization.Strings[type][name] ~= L"" then
            return CustomLocalization.Strings[type][name]
        end
    end
    -- We don't actually have stuff here yet
    -- Debug.Print("Localized string not found for '"..name.."', returning the name")
    return StringToWString( name )
end

------------------------------------------------------------------------------- 
-- CustomLocalization.utf8toUnicode 
-- Description: 
--     This function converts UTF-8 string into Unicode (UCS-2 or wstring) string
-- Parameters: 
--     arg1 - UTF-8 string
-- Returns: 
--     Converted Unicode string
------------------------------------------------------------------------------- 
function CustomLocalization.utf8toUnicode(str)
  if type(str) == 'wstring' then
    str = WStringToString(str)
  end
  if str == nil or str == "" then
    return L""
  end

  local ch = string.byte(str)
  local code, codelen, wchar

  if ch < 0x80 then
    -- ASCII
    codelen = 1
    code = ch

  else
    -- Non-ASCII
    local z = ch
    local y, x, w, v, u = string.byte( string.sub(str, 2), 1, 5 )

    if ch < 0xC0 then
      -- wrong sequence
      codelen = 1
      code = ch
    end

    if ch < 0xE0 then
      codelen = 2
      code = (z-0xC0)*2^6  + (y-0x80)

    elseif ch < 0xF0 then
      codelen = 3
      code = (z-0xE0)*2^12 + (y-0x80)*2^6  + (x-0x80)

    elseif ch < 0xF8 then
      codelen = 4
      code = (z-0xF0)*2^18 + (y-0x80)*2^12 +(x-0x80)*2^6  + (w-0x80)

    elseif ch < 0xFC then
      codelen = 5
      code = (z-0xF8)*2^24 + (y-0x80)*2^18 +(x-0x80)*2^12 + (w-0x80)*2^6  + (v-0x80)

    elseif ch < 0xFE then
      codelen = 6
      code = (z-0xFC)*2^30 + (y-0x80)*2^24 +(x-0x80)*2^18 + (w-0x80)*2^12 + (v-0x80)*2^6 + (u-0x80)

    end
  end

  return wstring.char( code ) .. CustomLocalization.utf8toUnicode( string.sub(str, codelen+1) )
end
