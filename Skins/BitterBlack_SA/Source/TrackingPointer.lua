----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

TrackingPointer = {}
TrackingPointer.PointerOn = false

function TrackingPointer.OnUpdate(timePassed)
	if (SystemData.TrackingPointer.PointerType ~= 0) then
		TrackingPointer.PointerOn = true
		local visible, x, y, rotation
		visible,x,y,rotation = TranslatePointer(SystemData.TrackingPointer.PointerType, SystemData.TrackingPointer.PointerX, SystemData.TrackingPointer.PointerY)
--		Debug.Print("x="..x.."y="..y.."rotation="..rotation)
		DynamicImageSetTexture("TrackingPointerPointerImage", "UO_Common", 368, 27)
		WindowClearAnchors("TrackingPointerPointerImage")
		WindowAddAnchor("TrackingPointerPointerImage", "topleft", "Root", "center", x, y)
		DynamicImageSetRotation("TrackingPointerPointerImage", rotation)
		WindowSetShowing("TrackingPointerPointerImage", true)
		DynamicImageSetTexture("TrackingPointerPointerImageBackground", "UO_Common", 286, 1)
		WindowClearAnchors("TrackingPointerPointerImageBackground")
		WindowAddAnchor("TrackingPointerPointerImageBackground", "topleft", "Root", "center", x + 3, y + 3)
		DynamicImageSetRotation("TrackingPointerPointerImageBackground", rotation +180)
		WindowSetShowing("TrackingPointerPointerImageBackground", true)
	else
		if (TrackingPointer.PointerOn) then
--			Debug.Print("Turning off tracking pointer")
			WindowSetShowing("TrackingPointerPointerImage", false)
			WindowSetShowing("TrackingPointerPointerImageBackground", false)
			TrackingPointer.PointerOn = false
		end
	end
end
