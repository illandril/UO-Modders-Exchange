----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

PetRenameWindow = {}
PetRenameWindow.TextEntered = nil
PetRenameWindow.id = nil
PetRenameWindow.Callfunction = nil
PetRenameWindow.IllegalCharacters = nil

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------


----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function PetRenameWindow.Initialize()
	local WindowName = "PetRenameWindow"

	--WindowUtils.SetWindowTitle(WindowName,GetStringFromTid(1079164))
	WindowUtils.SetWindowTitle(WindowName, L"Rename Pet")
	
	local submitButtonName = GGManager.translateTID(1077787)		-- "Submit"
	local clearButtonName = GGManager.translateTID(3000154)		-- "Clear"
	local cancelButtonName = GGManager.translateTID(GGManager.CANCEL_TID)

	ButtonSetText(WindowName.."SubmitButton", submitButtonName )
	ButtonSetText(WindowName.."ClearButton", clearButtonName )
	ButtonSetText(WindowName.."CancelButton", cancelButtonName )	
end

function PetRenameWindow.Create(rdata)
	local WindowName = "PetRenameWindow"
	-- rdata.titel: Line under the title
	-- rdata.text: Text in the rename Window
	-- rdata.callfunction: function to call after submit 
	-- rdata.id: id if need to convert
	-- Reset the Error Messages
	LabelSetText (WindowName.."Subtitle2",L"")
	WindowSetShowing("PetRenameWindow", true)
	if (rdata.title ~= nil) then
		LabelSetText(WindowName.."Subtitle1", rdata.title)
	end
	if (rdata.text ~= nil) then
		TextEditBoxSetText( WindowName.."TextEntryBox", rdata.text )
	else
		TextEditBoxSetText( WindowName.."TextEntryBox", L"" )
	end
	if (rdata.callfunction == nil) then
		Debug.Print("No call function")
	end
    PetRenameWindow.id = rdata.id
	PetRenameWindow.IllegalCharacters = rdata.IllegalCharacters
	PetRenameWindow.Callfunction = rdata.callfunction 
	WindowAssignFocus(WindowName.."TextEntryBox", true)
	
end

function PetRenameWindow.OnClear()
	TextEditBoxSetText( "PetRenameWindowTextEntryBox", L"" )
	WindowAssignFocus("PetRenameWindowTextEntryBox", true)
end

function PetRenameWindow.OnCancel()
	WindowSetShowing("PetRenameWindow", false)
end

function PetRenameWindow.OnSubmit()
	-- Global Variables 
	-- PetRenameWindow.TextEntered 
	-- PetRenameWindow.id 
	-- PetRenameWindow.Callfunction 
	
	local WindowName = "PetRenameWindow"
	local text_entered = TextEditBoxGetText( WindowName.."TextEntryBox" )
	if (text_entered ~= nil and text_entered ~= L"") then
		-- make sure there are no unicode chars in the string
		local ValidString = SingleLineTextEntry.CheckForUnicodeChars(text_entered)
        if ValidString and PetRenameWindow.IllegalCharacters ~= nil then
            local s,f = string.find(tostring(text_entered),PetRenameWindow.IllegalCharacters)
            if s ~= nil then
                ValidString = false
            end
        end
		if ValidString == true then
			PetRenameWindow.TextEntered = text_entered
			PetRenameWindow.Callfunction()
			PetRenameWindow.OnCancel()
		else
			-- tell player the string contained illegal characters and to try again
			LabelSetText (WindowName.."Subtitle2",GetStringFromTid(1079165))
			WindowAssignFocus(WindowName.."TextEntryBox", true)
		end
	else
		-- tell player the string contained illegal characters and to try again
		LabelSetText (WindowName.."Subtitle2",GetStringFromTid(1079165))
		WindowAssignFocus(WindowName.."TextEntryBox", true)
	end
end


function PetRenameWindow.Shutdown()
    local x = 1 -- KR doesn't like empty functions
end
