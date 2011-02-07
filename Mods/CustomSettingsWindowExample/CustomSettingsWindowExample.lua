CustomSettingsWindowExample = {}
function CustomSettingsWindowExample.Initialize()
    CustomSettingsWindow.AddFontSetting( "testtab", "testfont", "testfont", "UO_Title" )
    CustomSettingsWindow.AddColorSetting( "testtab", "testcolor", "testcolor", { r=0,g=0,b=255 } )
    CustomSettingsWindow.AddSliderSetting( "testtab", "testslider", "testslider", 50, 25, 100 )
    CustomSettingsWindow.AddBooleanSetting( "testtab", "testboolean", "testboolean", false )
    CustomSettingsWindow.AddComboSetting( "testtab", "testcombo", "testcombo", 1, { "Hi", "Bye", "Howdy" } )
    
    CustomSettingsWindow.AddBooleanSetting( "testtab2", "testboolean2", "testboolean2", false )
    CustomSettingsWindow.AddSliderSetting( "testtab2", "testslider2", "testslider2", 50, 25, 100 )
    CustomSettingsWindow.AddColorSetting( "testtab2", "testcolor2", "testcolor2", { r=0,g=0,b=0 } )
    CustomSettingsWindow.AddComboSetting( "testtab2", "testcombo2", "testcombo2", 1, { "Hi", "Bye", "Howdy" } )
    CustomSettingsWindow.AddFontSetting( "testtab2", "testfont2", "testfont2", "UO_Title" )
end
