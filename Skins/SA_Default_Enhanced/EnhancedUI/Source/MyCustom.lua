----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MyCustom = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
local TIME_DELAY = 1
local timeLeft = TIME_DELAY
local callFunc = false

----------------------------------------------------------------
-- EMMenuWindow Functions
----------------------------------------------------------------

function MyCustom.Initialize()
	MacroPickerWindowEnhancements.Initialize()
	ObjectHandleWindowEnhancements.Initialize()
	SkillsWindowMod.Initialize()
	Debug.Print("Custom Init Finished")
end



function MyCustom.Shutdown()
	-- just a place holder for now
	local x = 0
end


function MyCustom.OnUpdate( elapsed )
    timeLeft = timeLeft - elapsed
    if timeLeft > 0 then
        return -- cut out early
    end
    
	if callFunc == true then
		callFunc = false
		MyCustom.myFunction()
		timeLeft = TIME_DELAY -- reset to TIME_DELAY seconds
	end
	timeLeft = TIME_DELAY
end

function MyCustom.DismountKill()
	UserActionUseItem(WindowData.PlayerStatus.PlayerId ,false)
	MyCustom.AddEvent(MyCustom.SayKill, 0.075) -- creates a small pause to allow pet to hear command
end

function MyCustom.SayKill()
	-- will only send kill command if there is a current target
	if WindowData.CurrentTarget.HasTarget then
		SendChat(L"All Kill")
--		UserActionToggleWarMode()
--		MyCustom.SendTarget()
		MyCustom.AddEvent(MyCustom.SendTarget, .00) -- set delay to 0 as the normal update delay inherit in the calling of the function is enough
	end
end

function MyCustom.SendTarget()
		--sends the target information for the targeting cursor
		HandleSingleLeftClkTarget(WindowData.CurrentTarget.TargetId)
end

function MyCustom.AddEvent(e, t)
	-- custom function to execute a function after so many seconds.
	-- e = function name
	-- t = number of seconds to wait before calling function
	--  currently only allowed to time delay one function at a time.
	
	if not callFunc then
		MyCustom.myFunction = e
		timeLeft = t
		callFunc = true
	else
		Debug.Print("Already have one event in queue")
	end
end


function MyCustom.tableToFile( data, filename )
	-- custom function useful only for debuging and developing
	-- data is a valid table, example - SystemData
	-- filename is string name of file suchs as "system.log"
	-- files saved in the logs folder
	if type(data) == "table" then

	text = GGManager.tableToString(data)
	
	TextLogCreate( filename, 1)
    TextLogSetEnabled( filename, true )
    TextLogClear(filename)
    TextLogSetIncrementalSaving( filename, true, "logs/" .. filename )
    TextLogAddEntry( filename, nil, text )
    TextLogDestroy( filename )
	
	
	else
		Debug.Print("Wasn't a table, aborting save")
	end

end
