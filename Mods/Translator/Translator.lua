Translator = {}
TranslatorLibrary = {} -- namespace for mods that add languages to the translator (should be TranslatorLibrary.<language>)
Translator.Words = {}

Translator.WindowName = "Root" -- Will be adding an actual translator window
Translator.FullyInitialized = false

function Translator.Initialize()
    WindowRegisterEventHandler( Translator.WindowName, SystemData.Events.TEXT_ARRIVED, "Translator.TextArrived")       
end

function Translator.Update()
    if not Translator.FullyInitialized then
        -- Code for optimization will go here
        Translator.FullyInitialized = true
    end
end

function Translator.TextArrived()
    local systemMessage = SystemData.TextSourceID == -1
    local playersOwnMessage = SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId
--[[
	if systemMessage || playersOwnMessage then
		return
	end
]]--

    -- OverheadText.GetsOverhead[SystemData.TextChannelID]
    -- local hueR,hueG,hueB = HueRGBAValue(SystemData.TextColor)
    -- SystemData.Text
    Debug.Print( WStringToString( SystemData.Text ).." == "..WStringToString( Translator.TranslateToEnglish( SystemData.Text, "Drow" ) ) )
end

function Translator.TranslateToEnglish( phrase, language )
    return Translator.Translate( phrase, Translator.Words[language].from )
end

function Translator.TranslateFromEnglish( phrase, language )
    return Translator.Translate( phrase, Translator.Words[language].to )
end

function Translator.Translate( phrase, languageTable )
    local newPhrase = L""
    local words = Translator.ToWords( phrase )
    for wordIndex,word in ipairs( words ) do
        if languageTable[word] ~= nil then
            newPhrase = newPhrase..languageTable[word]
        else
            newPhrase = newPhrase..L"?["..word..L"]?"
        end
        newPhrase = newPhrase..L" | "
    end
    return newPhrase
end

function Translator.ToWords( phrase )
    local t = {}
    local function helper(word) table.insert(t, word) return "" end
    if not phrase:gsub(L"%w+", helper):find"%S" then return t end
end

function Translator.AddWord( language, languageText, englishText )
    if languageText:len() < Translator.QuickRegexMax then
        Translator.QuickRegexMax = languageText:len()
    end
    if Translator.Words[language] == nil then
        Translator.Words[language] = {}
        Translator.Words[language].to = {}
        Translator.Words[language].from = {}
    end
    if Translator.Words[language].to[englishText] == nil then
        Translator.Words[language].to[englishText] = languageText
    end
    if Translator.Words[language].from[languageText] == nil then
        Translator.Words[language].from[languageText] = englishText
    end
end



