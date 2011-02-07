OpenSkillTrackerOnStartup = {}
function OpenSkillTrackerOnStartup.Initialize()
	if SkillsWindow.SkillsTrackerMode == 0 then
		SkillsWindow.SkillsTrackerMode = 1
		CreateWindow( "SkillsTrackerWindow", true )
	end
	SkillsWindow.UpdateSkillsTrackerToggleButtonText()	
end
