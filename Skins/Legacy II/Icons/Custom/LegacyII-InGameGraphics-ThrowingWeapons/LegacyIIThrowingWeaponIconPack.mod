<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="LegacyIIThrowingWeaponIconPack" version="1.0" date="09/04/2009">

		<Author name="Illandril" email="illandril@modders-exchange.net" />
		<Description text="http://uo.modders-exchange.net" />
		
		<Dependencies>
			<Dependency name="IconLoader" />
		</Dependencies>
        
		<Files>
			<File name="Loader.lua" />
			<!-- Loader to be replaced with this once XML file loading through Mod files is fixed
			<File name="LegacyIIThrowingWeaponIconPack.xml" />
			-->
			<File name="LegacyIIThrowingWeaponIconPack.lua" />
		</Files>

		<OnInitialize>
			<CallFunction name="LegacyIIInGameThrowingWeaponIconPack.Initialize" />
		</OnInitialize>

	</UiMod>
</ModuleFile>
