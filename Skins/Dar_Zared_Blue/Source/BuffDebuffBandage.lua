
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

BuffDebuffBandage = {}

BuffDebuffBandage.BuffData = {}
BuffDebuffBandage.Timers = {}
BuffDebuffBandage.BuffWindowId = {}
BuffDebuffBandage.TableOrder = {}
BuffDebuffBandage.ReverseOrder = {}
BuffDebuffBandage.MaxLength = 6
BuffDebuffBandage.Gap = 2
BuffDebuffBandage.DeltaTime = 0
BuffDebuffBandage.Fade = {start = 30, endtime = 10, amount = 0.2 }
BuffDebuffBandage.TID = {}
BuffDebuffBandage.TID.timeleft = 1075611
BuffDebuffBandage.IconSize = 32

BuffDebuffBandage.BandageDelayTime = 0 -- Starts off at 0 since no bandages have been used yet
BuffDebuffBandage.BandageDelayDiff = 1 -- Counts down the timer with a 1 second counter
BuffDebuffBandage.CurrentDelta = 0	  -- How much time has passed since the previous update time
----------------------------------------------------------------
-- Functions
----------------------------------------------------------------
function BuffDebuffBandage.Initialize()

end

function BuffDebuffBandage.Shutdown()

end

function BuffDebuffBandage.CreateBandageBuff()
	local buffId =1
	local buffData = BuffDebuffBandage.BuffData[buffId]
	if( BuffDebuffBandage.BuffWindowId[buffId] ~= true)then
		-- Need to know the ordering so we can anchor the buffs correctly 
		table.insert(BuffDebuffBandage.TableOrder, buffId) 

		local parent = "BuffDebuffBandage"
		local iconName = parent.."Icon"..buffId
		CreateWindowFromTemplate(iconName, "BuffDebuffTemplate", parent)
		Debug.Print("Created new icon = "..iconName)
		WindowSetId(iconName, buffId)
		--Debug.Print("Icon window name = "..iconName.."Icon Id is = "..WindowGetId(iconName))
		Debug.Print("Window new buff created")
		local numIcons = table.getn(BuffDebuffBandage.TableOrder)

		BuffDebuffBandage.ReverseOrder[buffId] = numIcons
		
		Debug.Print("Creating New buff window")
		if numIcons == 1 then
			WindowAddAnchor(iconName, "topleft", parent, "topleft", 0, 0)
		else
			local place = numIcons % (BuffDebuffBandage.MaxLength)
			--Need to anchor the icon on the next row since its greater then the max length of buff icons in one row
			if( place == 1) then
				WindowAddAnchor(iconName, "bottomleft", parent.."Icon"..BuffDebuffBandage.TableOrder[numIcons - BuffDebuffBandage.MaxLength], "topleft", 0, BuffDebuffBandage.Gap)
			else
				WindowAddAnchor(iconName, "topright", parent.."Icon"..BuffDebuffBandage.TableOrder[numIcons - 1], "topleft", BuffDebuffBandage.Gap, 0)
			end
		end
		BuffDebuffBandage.ResizeOuterWindow(parent, numIcons) 
		BuffDebuffBandage.BuffWindowId[buffId] = true
		BuffDebuffBandage.UpdateStatusForBandage(buffId)
	else
		BuffDebuffBandage.UpdateStatusForBandage(buffId)
	end
end

function BuffDebuffBandage.UpdateStatusForBandage(iconId)
	local buffId = iconId
	local parent = "BuffDebuffBandageIcon"..buffId
	local iconTextureName = parent.."TextureIcon"
	
	Debug.Print("BuffDebuffBandage buffId = "..buffId)
	local textureId = 620
		
	if( textureId ~= nil or textureId ~= -1) then
		Debug.Print("BuffDebuffBandage UpdateStatus textureId = "..textureId)
		local texture, x, y = GetIconData( textureId )
		Debug.Print(texture.." , "..x.." , "..y)
		DynamicImageSetTexture( iconTextureName, texture, 10, 10 )
	end
end

function BuffDebuffBandage.UpdateBandageCounter(counter)
	local label = "BuffDebuffBandageIcon1BandageTime"
	local parent = "BuffDebuffBandageIcon"
	
	if (BuffDebuffBandage.BuffWindowId[1] == true) then
		LabelSetText(label, counter)
		LabelSetTextColor(label, 255,0,0)
	end
end
