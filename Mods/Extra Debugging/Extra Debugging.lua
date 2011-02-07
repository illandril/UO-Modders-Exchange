function Debug.DumpToConsole(name, value, memo)
	memo = memo or {}
	local t = type(value)
	local prefix = name.."="
	if Debug.Stringable[t] then
		Debug.Print(prefix..tostring(value))
	elseif t == "wstring" then
		Debug.Print(StringToWString(prefix)..value)
	elseif t == "table" then
		if memo[value] then
			Debug.Print(prefix..tostring(memo[value]))
		else
			memo[value] = name
			for k, v in pairs(value) do
				local fname = string.format("%s[%s]", name, tostring(k))
				Debug.DumpToConsole(fname, v, memo)
			end
		end
	else
		Debug.PrintToDebugConsole(StringToWString(prefix)..StringToWString("Can't serialize type "..t))
	end
end
