
dzSettings = {}

function dzSettings.Initialize()
	CustomSettingsWindow.AddBooleanSetting( "dzSettings", "Use Party Window", "dzUsePartyWindow", false )
	CustomSettingsWindow.AddBooleanSetting( "dzSettings", "Show Party invite dialog", "dzPartyInvites", false )
end
