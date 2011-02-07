AlternateGridBackpack = {}

function AlternateGridBackpack.Initialize()
    AlternateGridBackpack.CreateGridViewSocketsOriginal = ContainerWindow.CreateGridViewSockets
    ContainerWindow.CreateGridViewSockets = AlternateGridBackpack.CreateGridViewSockets
end

function AlternateGridBackpack.CreateGridViewSockets( dialog, windowId )
	local GRID_WIDTH = 5
	local parent = dialog.."GridViewScrollChild"
	for i = 1, 125 do
		local socketName = dialog.."GridViewSocket"..i 
		local socketTemplate = "AlternateGridViewSocketTemplate"
		
		-- use the transparent grid background for legacy container views
		local legacyContainersMode = SystemData.Settings.Interface.LegacyContainers
		if( legacyContainersMode == true ) then
		    socketTemplate = "GridViewSocketLegacyTemplate"
		end
		
		CreateWindowFromTemplate(socketName, socketTemplate, parent)
		WindowSetId(socketName, i)
		if i == 1 then
			WindowAddAnchor(socketName, "topleft", parent, "topleft", 0, 0)
		elseif (i % GRID_WIDTH) == 1 then
			WindowAddAnchor(socketName, "bottomleft", dialog.."GridViewSocket"..i-GRID_WIDTH, "topleft", 0, 1)
		else
			WindowAddAnchor(socketName, "topright", dialog.."GridViewSocket"..i-1, "topleft", 1, 0)
		end
		WindowSetShowing(socketName, true)
	end
	ScrollWindowUpdateScrollRect(dialog.."GridView") 
	WindowSetShowing(dialog.."GridView", false)

--[[
    AlternateGridBackpack.CreateGridViewSocketsOriginal( dialog, windowId )
	WindowSetShowing( dialog.."GridView", true )
    
	for i = 1, 125 do
		local socketName = dialog.."GridViewSocket"..i 
		ButtonSetTexture( socketName, Button.ButtonState.NORMAL, "colored_grid_backpack", 0, 0 )
		ButtonSetTexture( socketName, Button.ButtonState.HIGHLIGHTED, "colored_grid_backpack", 50, 0 )
		ButtonSetTexture( socketName, Button.ButtonState.DISABLED, "colored_grid_backpack", 0, 0 )
		ButtonSetTexture( socketName, Button.ButtonState.PRESSED, "colored_grid_backpack", 0, 0 )
		ButtonSetTexture( socketName, Button.ButtonState.PRESSED_HIGHLIGHTED, "colored_grid_backpack", 50, 0 )
	end
	ScrollWindowUpdateScrollRect(dialog.."GridView")
	WindowSetShowing( dialog.."GridView", false )
	]]--
end
