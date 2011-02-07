<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="HideOwnObjectHandle" version="1.0" date="06/24/2010">
		<Author name="Illandril" email="illandril@modders-exchange.net" />
		<Description text="http://uo.modders-exchange.net" />
		
		<Dependencies>
			<Dependency name="CustomSettingsWindow" />
		</Dependencies>
		
		<Files>
			<File name="Localizations.lua" />
			<File name="HideOwnObjectHandle.lua" />
		</Files>
		
		<OnInitialize>
			<CallFunction name="HideOwnObjectHandle.Initialize" />
		</OnInitialize>
	</UiMod>
</ModuleFile>
