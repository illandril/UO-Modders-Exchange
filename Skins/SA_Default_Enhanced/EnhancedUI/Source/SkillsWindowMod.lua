SkillsWindowMod = {}

local maxskill_index = 57

SkillsWindowMod.FirstShowTab = true
function SkillsWindowMod.Initialize()
--SkillsWindowMod.oldInit = SkillsWindow.Initialize
--SkillsWindow.Initialize = SkillsWindowMod.newInit
SkillsWindowMod.ShowTabOriginal = SkillsWindow.ShowTab
SkillsWindow.ShowTab = SkillsWindowMod.ShowTabNew

SkillsWindow.UpdateTotalSkillPoints = SkillsWindowMod.UpdateTotalSkillPointsNew
end

function SkillsWindowMod.newInit()
	SkillsWindowMod.oldInit()
	
	WindowName = "SkillsWindow"
	showing = WindowGetShowing(WindowName)
	data.activeTab = SkillsWindow.CUSTOM_TAB_NUM
--	if (showing) then
		SkillsWindow.ShowTab(data.activeTab)
		Debug.Print("Did it load?")
-- 	end	
	
end

function SkillsWindowMod.ShowTabNew(tabnum)
    if SkillsWindowMod.FirstShowTab then
        tabnum = SkillsWindow.CUSTOM_TAB_NUM
        SkillsWindowMod.FirstShowTab = false
    end
    SkillsWindowMod.ShowTabOriginal(tabnum)
   
end

function SkillsWindowMod.UpdateTotalSkillPointsNew()
	local SkillPointsUsed = 0
	for i=0, maxskill_index do
		SkillPointsUsed = SkillPointsUsed + WindowData.SkillDynamicData[i].RealSkillValue
	end
	SkillPointsUsed = SkillPointsUsed / 10

	local SkillPointsUsedStr = string.format("%.1f", SkillPointsUsed)
	WindowClearAnchors( "SkillsWindowTotalSkillPoints" )
	WindowAddAnchor( "SkillsWindowTotalSkillPoints", "bottomright", "SkillsWindowTabWindow1", "bottomright", 8, 20)
	LabelSetText("SkillsWindowTotalSkillPoints", GetStringFromTid(1077767)..StringToWString(SkillPointsUsedStr)) -- "Skill Points Used: ###.#"
end