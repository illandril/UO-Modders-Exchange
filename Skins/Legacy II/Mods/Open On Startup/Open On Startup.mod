<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="OpenOnStartup" version="1.0" date="11/23/2009">
		<Author name="Illandril" email="illandril@modders-exchange.net" />
		<Description text="http://uo.modders-exchange.net" />
		
		<Dependencies>
			<Dependency name="CustomSettingsWindow" />
		</Dependencies>
		
		<Files>
			<File name="Localizations.lua" />
			<File name="Open On Startup.lua" />
		</Files>
		
		<OnInitialize>
			<CallFunction name="OpenOnStartup.Initialize" />
		</OnInitialize>
		<OnUpdate>
			<CallFunction name="OpenOnStartup.Update" />
		</OnUpdate>
	</UiMod>
</ModuleFile>
