<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="SmallAtlas" version="1.1" date="06/09/2010">

		<Author name="Illandril" email="illandril@modders-exchange.net" />
		<Description text="http://uo.modders-exchange.net" />
		
		<Dependencies>
			<Dependency name="CustomSettingsWindow" />
		</Dependencies>
		
		<Files>
			<File name="Localizations.lua" />
			<File name="SmallAtlas.lua" />
		</Files>
        
		<OnInitialize>
			<CallFunction name="SmallAtlas.Initialize" />
		</OnInitialize>
	</UiMod>
</ModuleFile>
