<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="Enhanced Status HUD" version="1.2" date="11/28/2009">
		<Author name="Illandril" email="illandril@modders-exchange.net" />
		<Description text="http://uo.modders-exchange.net" />
		
		<Dependencies>
			<Dependency name="CustomSettingsWindow" />
		</Dependencies>
		
		<Files>
			<File name="Loader.lua" />
			<File name="Localizations.lua" />
			<File name="Enhanced Status HUD.lua" />
		</Files>
		
		<OnInitialize>
			<CallFunction name="EnhancedStatusHUD.Initialize" />
		</OnInitialize>
		<OnShutdown>
			<CallFunction name="EnhancedStatusHUD.Shutdown" />
		</OnShutdown>
	</UiMod>
</ModuleFile>
