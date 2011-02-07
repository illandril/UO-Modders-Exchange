IconLoader = {}

IconLoader.conflicts = 0
IconLoader.iconCount = 0
IconLoader.defaultStartID = 1000000
IconLoader.textures = {}
IconLoader.initializationComplete = false

function IconLoader.Initialize()
    IconLoader.oldGetIconData = GetIconData
    GetIconData = IconLoader.GetIconData
    IconLoader.startID = CustomSettings.LoadNumberValue( { settingName="Icons__STARTID", defaultValue=IconLoader.defaultStartID } )
    IconLoader.nextID = IconLoader.startID
end


function IconLoader.Update()
    if not IconLoader.initializationComplete then
        for k,v in pairs( IconLoader.textures ) do
            if type(k) == type("") then
                CustomSettings.SaveNumberValue( { settingName="Icons___"..k, settingValue=v } )
            end
        end
        for i,v in ipairs( MacroPickerWindow.MacroIcons ) do
            if type(v) == type("") then
                MacroPickerWindow.MacroIcons[i] = IconLoader.textures[v]
            end
        end
        CustomSettings.SaveNumberValue( { settingName="Icons__STARTID", settingValue=IconLoader.nextID } )
        IconLoader.initializationComplete = true
        Debug.Print( "Icon Loader Conflicts: "..IconLoader.conflicts )
        Debug.Print( "Icon Loader initialized - reloading hotbar" )
        for index, hotbarId in pairs( SystemData.Hotbar.HotbarIds ) do
            Hotbar.ReloadHotbar( hotbarId )
        end
    end
end

function IconLoader.IncrementNextID()
    IconLoader.nextID = IconLoader.nextID + 1
    while IconLoader.textures[IconLoader.nextID] ~= nil do
        IconLoader.nextID = IconLoader.nextID + 1
    end
end

function IconLoader.AddIconData( textureName )
    Debug.Print( "Adding "..textureName )
    if IconLoader.textures[textureName] ~= nil then
        Debug.Print( "Duplicate icon load attempted: "..textureName )
        return
    end
    IconLoader.iconCount = IconLoader.iconCount + 1
    if IconLoader.iconCount > 5000 then
        if IconLoader.iconCount == 5001 then
            Debug.Print( "MASSIVE icon loading... bailing." )
        end
        return
    end
    local id = CustomSettings.LoadNumberValue( { settingName="Icons___"..textureName } )
    if id == nil then
        id = IconLoader.nextID
        IconLoader.IncrementNextID()
    else
        local conflictingTexture = IconLoader.textures[id]
        if conflictingTexture ~= nil then
            IconLoader.conflicts = IconLoader.conflicts + 1
            local newID = IconLoader.nextID
            IconLoader.IncrementNextID()
            IconLoader.textures[newID] = conflictingTexture
            IconLoader.textures[conflictingTexture] = newID
        end
    end
    table.insert( MacroPickerWindow.MacroIcons, textureName )
    IconLoader.textures[id] = textureName
    IconLoader.textures[textureName] = id
end

function IconLoader.BetterID( id )
    if id >= IconLoader.defaultStartID then
        return IconLoader.textures[id]
    end
    return id
end

function IconLoader.GetIconData( id )
    if type( id ) == type( "" ) then
        return id,0,0
    end
    if id >= IconLoader.defaultStartID then
        local textureName = IconLoader.textures[id]
        if textureName ~= nil then
            return textureName,0,0
        end
    end
    return IconLoader.oldGetIconData( id )
end
