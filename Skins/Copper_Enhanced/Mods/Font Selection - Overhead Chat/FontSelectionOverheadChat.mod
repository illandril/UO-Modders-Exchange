<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="FontSelectionOverheadChat" version="1.0" date="09/26/2009">

		<Author name="Illandril" email="illandril@modders-exchange.net" />
		<Description text="http://uo.modders-exchange.net" />

		<Dependencies>
			<Dependency name="CustomSettingsWindow" />
		</Dependencies>

		<Files>
			<File name="FontSelectionOverheadChat.lua" />
			<File name="Localizations.lua" />
		</Files>
        
		<OnInitialize>
			<CallFunction name="FontSelectionOverheadChat.Initialize" />
		</OnInitialize>
	</UiMod>
</ModuleFile>
