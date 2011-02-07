<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="UOCatographer Position Log" version="1.1" date="11/28/2009">

		<Author name="Illandril" email="illandril@modders-exchange.net" />
		<Description text="http://uo.modders-exchange.net" />

		<Files>
			<File name="UOCartographer Position Log.lua" />
		</Files>
        
		<OnInitialize>
			<CallFunction name="UOCartographerPositionLog.Initialize" />
		</OnInitialize>
		<OnUpdate>
			<CallFunction name="UOCartographerPositionLog.Update" />
		</OnUpdate>
	</UiMod>
</ModuleFile>
