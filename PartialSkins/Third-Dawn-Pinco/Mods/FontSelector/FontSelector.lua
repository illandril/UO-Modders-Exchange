----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

FontSelector = {}

local function Font( iname, iid, idefault, ishownName )
    local newChannel = 
    {
        fontName         = iname,
        id           = iid,
        isDefault    = idefault,
        shownName    = ishownName,
    };

    return newChannel;
end

FontSelector.Selection = ""

FontSelector.RunicFontItem = ""

 FontSelector.Fonts = {}
    --                               name of font     id  default  name to be shown
    FontSelector.Fonts[1] = Font( "UO_Overhead_Chat", 1, false, "Default" )
	FontSelector.Fonts[2] = Font( "avatar", 1, false, "Avatar" )
	FontSelector.Fonts[3] = Font( "avatar_bold", 1, false, "Avatar Bold" )
	FontSelector.Fonts[4] = Font( "chiller", 1, false, "Chiller" )
	FontSelector.Fonts[5] = Font( "comics", 1, false, "Comic Sans" )
	FontSelector.Fonts[6] = Font( "comics_bold", 1, false, "Comic Sans Bold" )
	FontSelector.Fonts[7] = Font( "diablo", 1, false, "Diablo" )
	FontSelector.Fonts[8] = Font( "gothic", 1, false, "Gothic Ultra Trendy" )
	FontSelector.Fonts[9] = Font( "magic_22", 1, false, "Magic the Gathering" )
	FontSelector.Fonts[10] = Font( "magic", 1, false, "Magic School" )
	FontSelector.Fonts[11] = Font( "runic", 1, false, "Runes" )
	FontSelector.Fonts[12] = Font( "gargrunic", 1, false, "Gargish Runes" )
	FontSelector.Fonts[13] = Font( "samurai", 1, false, "Samurai" )
	FontSelector.Fonts[14] = Font( "times", 1, false, "Times New Roman" )
	FontSelector.Fonts[15]= Font( "times_bold", 1, false, "Times New Roman Bold" )
	FontSelector.Fonts[16] = Font( "font_verdana_shadow_med2", 1, false, "Verdana" )
	FontSelector.Fonts[17] = Font( "font_verdana_bold_shadow_med2", 1, false, "Verdana Bold" )
	FontSelector.Fonts[18] = Font( "UO_20", 1, false, "Ultima Online" )
	


-- OnInitialize Handler
function FontSelector.Initialize()

    
    --WindowSetScale("FontSelector", 1.28)
    Interface.DestroyWindowOnClose["FontSelector"] = true
    
    local size = #FontSelector.Fonts
    for idx=1, size do

		local itemWindow = "FontSelectorItem"..idx
		if DoesWindowNameExist( itemWindow) then
			DestroyWindow(itemWindow)
		end
		CreateWindowFromTemplate (itemWindow, "FontRowTemplate", "FontSelector")
		LabelSetFont( itemWindow.."Label", FontSelector.Fonts[idx].fontName, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING )
		LabelSetText( itemWindow.."Label", StringToWString(FontSelector.Fonts[idx].shownName) )
		WindowSetId(itemWindow, idx)
		WindowClearAnchors(itemWindow)
		
		if (FontSelector.Fonts[idx].fontName == "runic" ) then
			FontSelector.RunicFontItem = itemWindow
		end
	    local attachIndex = idx -1
	    if (DoesWindowNameExist("FontSelectorItem"..attachIndex)) then
			if (not WindowGetShowing("FontSelectorItem"..attachIndex)) then
				attachIndex = dx -2
			end
	    end
	    
	    if (attachIndex<=0) then
			attachIndex = 1
	    end
	    
		if( idx == 1 ) then
			WindowAddAnchor( itemWindow, "topleft", "FontSelector", "topleft", 20, 40 )
		else
			if (FontSelector.Fonts[idx-1].fontName == "magic" or FontSelector.Fonts[idx-1].fontName == "diablo" or FontSelector.Fonts[idx-1].fontName == "chiller" or FontSelector.Fonts[idx-1].fontName == "gargrunic") then
				WindowAddAnchor( itemWindow, "bottomleft", "FontSelectorItem"..attachIndex, "topleft", 0, 15 )
			else
				WindowAddAnchor( itemWindow, "bottomleft", "FontSelectorItem"..attachIndex, "topleft", 0, 0 )
			end
			
		end
    
   end
   ScrollWindowSetOffset( "FontSelector", 0 )
   ScrollWindowUpdateScrollRect( "FontSelector" )	
   
end


function FontSelector.Shutdown()
    DestroyWindow("FontSelector")
end

function FontSelector.SetFontToSelection()
	if (FontSelector.Selection == "chat") then
		OverheadText.FontIndex = WindowGetId(SystemData.ActiveWindow.name)
		CustomSettings.SaveNumber("OverheadTextFontIndex", OverheadText.FontIndex)
		WindowSetShowing("FontSelector", false)
	elseif (FontSelector.Selection == "names") then
		OverheadText.NameFontIndex = WindowGetId(SystemData.ActiveWindow.name)
		CustomSettings.SaveNumber("OverheadTextNameFontIndex", OverheadText.NameFontIndex)
		WindowSetShowing("FontSelector", false)
	elseif (FontSelector.Selection == "spells") then
		OverheadText.SpellsFontIndex = WindowGetId(SystemData.ActiveWindow.name)
		CustomSettings.SaveNumber("OverheadTextSpellsFontIndex", OverheadText.SpellsFontIndex)
		WindowSetShowing("FontSelector", false)
	elseif (FontSelector.Selection == "damage") then
		OverheadText.DamageFontIndex = WindowGetId(SystemData.ActiveWindow.name)
		CustomSettings.SaveNumber("OverheadTextDamageFontIndex", OverheadText.DamageFontIndex)
		WindowSetShowing("FontSelector", false)
	end
end

function FontSelector.CloseFontWindow()
	WindowSetShowing("FontSelector", false)
end

function FontSelector.ItemMouseOver()
	local fontIndex = WindowGetId(SystemData.ActiveWindow.name)
	local itemWindow = "FontSelectorItem"..fontIndex
	
	LabelSetTextColor(itemWindow.."Label",243,227,49)
end

function FontSelector.ClearMouseOverItem()
	local fontIndex = WindowGetId(SystemData.ActiveWindow.name)
	local itemWindow = "FontSelectorItem"..fontIndex
	
	LabelSetTextColor(itemWindow.."Label",255,255,255)
end