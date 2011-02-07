----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

dzInterfaceCore = {}
dzInterfaceCore.PartyText = "You are invited to join the party"

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

function dzInterfaceCore.Initialize()
	WindowRegisterEventHandler( "Root", SystemData.Events.TEXT_ARRIVED, "dzInterfaceCore.ProcessText")
end

function dzInterfaceCore.ResizeTooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, L"Resize Window")
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_BOTTOM )
end

function dzInterfaceCore.ProcessText()
	--Debug.Print("ProcessText "..dzInterfaceCore.PartyText)

	-- Only Process System Messages
	if (SystemData.TextChannelID == 1) then	
		local strProcessText = tostring(SystemData.Text)
		
		-- Process Party Invite
		if (string.find(strProcessText, dzInterfaceCore.PartyText) ~= nil) then
			dzInterfaceCore.ProcessParty()
		end
		
		
		
		
		
		
		-- Cleanup if Party Time Passes
		if( SystemData.Text == L"You notify them that you do not wish to join the party." and DoesWindowNameExist("PartyInviteDialog") ) then
			DestroyWindow("acceptpartyDialog")
		end
	end
end

function dzInterfaceCore.ProcessParty()
	--Debug.Print("dzInterfaceCore.ProcessParty")
	local strSystemText = tostring(SystemData.Text)
	local intX = string.find(strSystemText, ":")
	local strUser = string.sub(strSystemText, 0, intX-1)
	local btnOK = { text=L"Yes", callback=function() SendChat(L"/accept") end }
	local btnCancel = { text=L"No", callback=function() SendChat(L"/decline") end }
	local PartyDialog = 
	{
		windowName = "PartyInvite",
		title = L"Party Invitation",
		body= StringToWString(strUser)..L" invites you to join their party. Do you accept the invitation?",
		buttons = { btnOK, btnCancel }
	}
	UO_StandardDialog.CreateDialog(PartyDialog)
end
