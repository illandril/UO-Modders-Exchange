<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="FontSelectionDamageNumbers" version="1.0" date="03/27/2010">

		<Author name="Illandril" email="illandril@modders-exchange.net" />
		<Description text="http://uo.modders-exchange.net" />

		<Dependencies>
			<Dependency name="CustomSettingsWindow" />
		</Dependencies>

		<Files>
			<File name="FontSelectionDamageNumbers.lua" />
			<File name="Localizations.lua" />
		</Files>
        
		<OnInitialize>
			<CallFunction name="FontSelectionDamageNumbers.Initialize" />
		</OnInitialize>
	</UiMod>
</ModuleFile>
