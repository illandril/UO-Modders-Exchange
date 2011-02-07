MacroPickerWindowEnhancements = {}
function MacroPickerWindowEnhancements.Initialize()

    -- for i=N,M do ==> N = minimum number in icons.xml, M = maximum number in icons.xml
    -- Of course, make sure the icons are properly specified in the XML, and there are no gaps
	local y = table.getn( MacroPickerWindow.MacroIcons )
	
	local x1 = 90000 -- do not change this number
	local x2 = 90024 -- this should be only number to change
	local newIcons = x2 - x1
	-- attempt to move all icons down to make room for new icons at top.
	
	-- first insert blanks into the table as this was only way found to increase the size of the table.
    for i=x1,x2 do
        table.insert( MacroPickerWindow.MacroIcons, 0 )
    end
	
	--second shift everything down the number of newIcons being inserted
	for x = y, 1, -1 do
		MacroPickerWindow.MacroIcons[x + newIcons+1] = MacroPickerWindow.MacroIcons[x]
	end

	--lastly replace the first slots with the new icon values.
	for i1 = 0, newIcons do
		MacroPickerWindow.MacroIcons[i1+1] = x1 + i1
	end
	

end
