HideOwnObjectHandle = {}

function HideOwnObjectHandle.Initialize()
    CustomSettingsWindow.AddBooleanSetting( "MiscSettings", "HideOwnObjectHandle", "HideOwnObjectHandle", false )
    HideOwnObjectHandle.OriginalCreateObjectHandles = ObjectHandleWindow.CreateObjectHandles
    ObjectHandleWindow.CreateObjectHandles = HideOwnObjectHandle.CreateObjectHandles
end

function HideOwnObjectHandle.CreateObjectHandles()
    HideOwnObjectHandle.OriginalCreateObjectHandles()
    if CustomSettings.LoadBooleanValue( { settingName="HideOwnObjectHandle", defaultValue=false } ) then
        ObjectHandle.DestroyObjectWindow( WindowData.PlayerStatus.PlayerId ) 
    end
end
