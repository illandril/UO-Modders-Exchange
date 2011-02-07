OpenInventoryOnStartup = {}
function OpenInventoryOnStartup.Initialize()
	local objectId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	local windowName = "ContainerWindow_"..objectId
	SystemData.DynamicWindowId = objectId
	if not DoesWindowNameExist( windowName ) then
		CreateWindowFromTemplate( windowName, "ContainerWindow", "Root" )
		ContainerWindow.UpdateContents(objectId)
	end
end

OpenInventoryOnStartup.cnt = 0
OpenInventoryOnStartup.initialized = false
function OpenInventoryOnStartup.Update()
    if not OpenInventoryOnStartup.initialized then
        OpenInventoryOnStartup.cnt = OpenInventoryOnStartup.cnt + 1
        if OpenInventoryOnStartup.cnt > 15 then
            OpenInventoryOnStartup.initialized = true
            OpenInventoryOnStartup.Initialize()
        end
    end
end
