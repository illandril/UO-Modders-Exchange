
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

BuffDebuff = {}

BuffDebuff.BuffData = {}
BuffDebuff.Timers = {}
BuffDebuff.BuffWindowId = {}
BuffDebuff.TableOrder = {}
BuffDebuff.ReverseOrder = {}
BuffDebuff.MaxLength = 6
BuffDebuff.Gap = 2
BuffDebuff.DeltaTime = 0
BuffDebuff.Fade = {start = 30, endtime = 10, amount = 0.2 }
BuffDebuff.TID = {}
BuffDebuff.TID.timeleft = 1075611
BuffDebuff.IconSize = 32
BuffDebuff.Firstlogin = true
----------------------------------------------------------------
-- Functions
----------------------------------------------------------------
function BuffDebuff.Update(timePassed)
	BuffDebuff.DeltaTime = BuffDebuff.DeltaTime + timePassed
	if( BuffDebuff.DeltaTime >= 1 ) then
		for key, value in pairs(BuffDebuff.Timers) do
			local time = value - BuffDebuff.DeltaTime
			--Debug.Print("Time passed for key ="..key.."time = "..math.ceil(time))
			if( time > 0 ) then
				BuffDebuff.Timers[key] = math.ceil(time)
			else
				BuffDebuff.Timers[key] = 0
				BuffDebuff.HandleBuffRemoved(key)
			end	
		end
		--Update the label
		BuffDebuff.UpdateTimer()
		--Reset delta time when it gets used to decrement the timers
		BuffDebuff.DeltaTime = 0
	end
end

function BuffDebuff.retrieveBuffData( buffData )
	if not buffData then
		Debug.PrintToDebugConsole( L"ERROR: buffData does not exist." )
		return false
	end      

	if(WindowData.BuffDebuffSystem.CurrentBuffId == 0) then
		return false
	end
	
	buffData.abilityId = WindowData.BuffDebuffSystem.CurrentBuffId
	buffData.TimerSeconds = WindowData.BuffDebuff.TimerSeconds
	buffData.HasTimer = WindowData.BuffDebuff.HasTimer
	buffData.NameVectorSize = WindowData.BuffDebuff.NameVectorSize
	buffData.ToolTipVectorSize = WindowData.BuffDebuff.ToolTipVectorSize
	buffData.IsBeingRemoved = WindowData.BuffDebuff.IsBeingRemoved
	buffData.NameWStringVector = WindowData.BuffDebuff.NameWStringVector
	buffData.ToolTipWStringVector =  WindowData.BuffDebuff.ToolTipWStringVector
	
	return true
end

function BuffDebuff.Initialize()
	--Debug.Print("BuffDebuff.Initialize() ")
	UOBuildTableFromCSV("Data/GameData/buffdata.csv", "BuffDataCSV")
	RegisterWindowData(WindowData.BuffDebuff.Type, 0)
	WindowRegisterEventHandler( "BuffDebuff", WindowData.BuffDebuff.Event, "BuffDebuff.ShouldCreateNewBuff")
end

function BuffDebuff.ShouldCreateNewBuff()
	local buffId = WindowData.BuffDebuffSystem.CurrentBuffId
	--If we have a buff debuff icon up, check to see if that is being removed
	--Debug.Print("BuffDebuf event triggered")

	local buffData = {}
	if( BuffDebuff.retrieveBuffData( buffData ) ) then
		BuffDebuff.BuffData[buffId] = buffData
		--Dont drop a buff without timer or if they are static (Protection etc.) Fix by Lucitus
		if(buffData.HasTimer == true or buffId == 1029 or buffId == 1031 or buffId == 1012 or buffId == 1013 or buffId == 1028 or WindowData.BuffDebuff.IsBeingRemoved == true ) then
			if( WindowData.BuffDebuff.IsBeingRemoved == true ) then
			--Debug.Print("BuffDebuf getting destroyed"..buffId)
				if (BuffDebuff.BuffWindowId[buffId] == true) then
					BuffDebuff.HandleBuffRemoved(buffId)
				end
			else
				local textureId = -1
				local rowServerNum = CSVUtilities.getRowIdWithColumnValue(WindowData.BuffDataCSV, "ServerId", buffId)
				if(rowServerNum ~= nil and WindowData.BuffDataCSV ~= nil and WindowData.BuffDataCSV[rowServerNum] ~= nil
				   and WindowData.BuffDataCSV[rowServerNum].IconId ~= nil) then
					textureId = tonumber(WindowData.BuffDataCSV[rowServerNum].IconId)
					--Debug.Print("Trying to get the icon "..WindowData.BuffDataCSV[rowServerNum].IconId)
				end
		
				if(textureId ~= nil and textureId ~= -1 )then
					BuffDebuff.CreateNewBuff()
				else
					BuffDebuff.BuffData[buffId] = nil
				end
			end
		end
	end
end

function BuffDebuff.HandleBuffRemoved(buffId)
	local iconName = "BuffDebuffIcon"..buffId
	 
	-- Need to find the position of the buffId before I can remove it so I can reanchor all the buffs
	local position = BuffDebuff.ReverseOrder[buffId]
	
	table.remove(BuffDebuff.TableOrder, position)
	-- Have to set this to nil since the buffId is removed from the table
	BuffDebuff.ReverseOrder[buffId] = nil
	BuffDebuff.BuffWindowId[buffId] = false
	BuffDebuff.BuffData[buffId] = nil
	BuffDebuff.Timers[buffId] = nil
	BuffDebuff.HandleReAnchorBuff(position)
	DestroyWindow(iconName)
end

function BuffDebuff.HandleReAnchorBuff(position)
	local endIcons = table.getn(BuffDebuff.TableOrder)
	local parent = "BuffDebuff"

	--Debug.Print("Reanchor positon = "..position)
	--Debug.Print("Reanchor endIcons = "..endIcons)
	for i=position, endIcons do
		local buffId = BuffDebuff.TableOrder[i]
		local iconName = parent.."Icon"..buffId
		--Reset reverse order for buff icons
		BuffDebuff.ReverseOrder[buffId] = i
		--Debug.Print("Reanchor i = "..i)
		WindowClearAnchors(iconName)
		
		if (i == 1) then
			WindowAddAnchor(iconName, "topleft", parent, "topleft", 0, 0)
		else
			local place = i % (BuffDebuff.MaxLength)
			--Need to anchor the icon on the next row since its greater then the max length of buff icons in one row
			if( place == 1) then
				WindowAddAnchor(iconName, "bottomleft", parent.."Icon"..BuffDebuff.TableOrder[i - BuffDebuff.MaxLength], "topleft", 0, BuffDebuff.Gap)
			else
				WindowAddAnchor(iconName, "topright", parent.."Icon"..BuffDebuff.TableOrder[i - 1], "topleft", BuffDebuff.Gap, 0)
			end
		end
	end
	
	local numIcons = table.getn(BuffDebuff.TableOrder)
	BuffDebuff.ResizeOuterWindow(parent, numIcons) 
end

function BuffDebuff.UpdateTimer()
	--Update the new timer label Lucitus
		local endNumber = table.getn(BuffDebuff.TableOrder)
		for i=1, endNumber do
			local buffId = BuffDebuff.TableOrder[i]
			local parent = "BuffDebuff"
			local iconName = parent.."Icon"..buffId
			
			if BuffDebuff.Timers[buffId] ~= nil and BuffDebuff.Timers[buffId] > 0 then
				local timer = tostring(BuffDebuff.Timers[buffId])				
				LabelSetText(iconName.."TimerLabel",StringToWString(timer)..L"s")
			end
		end	
end

function BuffDebuff.CreateNewBuff()
	local buffId = WindowData.BuffDebuffSystem.CurrentBuffId
	--Debug.Print("In Create New buff() id = "..buffId)
	local buffData = BuffDebuff.BuffData[buffId]
	local parent = "BuffDebuff"
	local iconName = parent.."Icon"..buffId
	if( BuffDebuff.BuffWindowId[buffId] ~= true)then
		-- Need to know the ordering so we can anchor the buffs correctly 
		table.insert(BuffDebuff.TableOrder, buffId) 
	

		CreateWindowFromTemplate(iconName, "BuffDebuffTemplate", parent)
		--Debug.Print("Created new icon = "..iconName)
		WindowSetId(iconName, buffId)
		--Debug.Print("Icon window name = "..iconName.."Icon Id is = "..WindowGetId(iconName))
		--Debug.Print("Window new buff created")
		local numIcons = table.getn(BuffDebuff.TableOrder)
		
		BuffDebuff.ReverseOrder[buffId] = numIcons
		
		--Debug.Print("Creating New buff window")
		if numIcons == 1 then
			WindowAddAnchor(iconName, "topleft", parent, "topleft", 0, 0)
		else
			local place = numIcons % (BuffDebuff.MaxLength)
			--Need to anchor the icon on the next row since its greater then the max length of buff icons in one row
			if( place == 1) then
				WindowAddAnchor(iconName, "bottomleft", parent.."Icon"..BuffDebuff.TableOrder[numIcons - BuffDebuff.MaxLength], "topleft", 0, BuffDebuff.Gap)
			else
				WindowAddAnchor(iconName, "topright", parent.."Icon"..BuffDebuff.TableOrder[numIcons - 1], "topleft", BuffDebuff.Gap, 0)
			end
		end
		
		BuffDebuff.ResizeOuterWindow(parent, numIcons) 
		BuffDebuff.BuffWindowId[buffId] = true
		BuffDebuff.UpdateStatus(buffId)
	else
		BuffDebuff.UpdateStatus(buffId)
	end
	
	if(buffData.HasTimer == true) then
		BuffDebuff.Timers[buffId] = buffData.TimerSeconds
		local timer = tostring(buffData.TimerSeconds)
		LabelSetText(iconName.."TimerLabel",StringToWString(timer)..L"s")
	end
end

function BuffDebuff.ResizeOuterWindow(windowName, numIcons)
	local numRows = math.ceil(numIcons / (BuffDebuff.MaxLength))
	local width = BuffDebuff.IconSize * BuffDebuff.MaxLength
	if(numIcons < BuffDebuff.MaxLength ) then
		width = BuffDebuff.IconSize * numIcons
	end
	
	local height = BuffDebuff.IconSize * (numRows)
	
	if( numIcons > 0) then
		WindowSetDimensions(windowName, width, height)
	else
		WindowSetDimensions(windowName, 0 , 0)
	end
end

function BuffDebuff.MouseOver()
	local buffId = WindowGetId(SystemData.ActiveWindow.name)
	local data = BuffDebuff.BuffData[buffId]
	if( data ) then
		local nameString = L""
		for i = 1, data.NameVectorSize do
			nameString = nameString..data.NameWStringVector[i]
		end
		
		local tooltipString = L""
		for i = 1, data.ToolTipVectorSize do
			tooltipString = tooltipString..data.ToolTipWStringVector[i]
		end	

		
		local bodyText = WindowUtils.translateMarkup(tooltipString)
		
		if(data.HasTimer == true and BuffDebuff.Timers[buffId] > 0) then
			local timeText = ReplaceTokens(GetStringFromTid(BuffDebuff.TID.timeleft), { towstring(tostring(BuffDebuff.Timers[buffId])) }) 
			bodyText = bodyText..L"\n"..timeText
		end
		
		local itemData = { windowName = "BuffDebuffIcon"..buffId,
							itemId = buffId,
							itemType = ItemProperties.type.TYPE_WSTRINGDATA,
							binding = L"",
							detail = nil,
							title =	WindowUtils.translateMarkup(nameString),
							body = bodyText	 }
							
		ItemProperties.SetActiveItem(itemData)	
			
		--Debug.Print("BuffDebuff UpdateStatus labelName = "..WStringToString( WindowUtils.translateMarkup(nameString)))
		--Debug.Print("BuffDebuff UpdateStatus tooltipName = "..WStringToString( WindowUtils.translateMarkup(tooltipString)) )
	end
end

function BuffDebuff.Shutdown()
	UnregisterWindowData(WindowData.BuffDebuff.Type, 0)
	
	UOUnloadCSVTable("BuffDataCSV")
end

function BuffDebuff.UpdateStatus(iconId)
	local buffId = iconId
	
	local parent = "BuffDebuffIcon"..buffId
	local iconTextureName = parent.."TextureIcon"
	
	--Debug.Print("BuffDebuff buffId = "..buffId)
	local rowServerNum = CSVUtilities.getRowIdWithColumnValue(WindowData.BuffDataCSV, "ServerId", buffId)
	local textureId = tonumber(WindowData.BuffDataCSV[rowServerNum].IconId)
	if( textureId ~= nil or textureId ~= -1) then
		--Debug.Print("BuffDebuff UpdateStatus textureId = "..textureId)
		local texture, x, y = GetIconData( textureId )
		DynamicImageSetTexture( iconTextureName, texture, x, y )
	end
end
