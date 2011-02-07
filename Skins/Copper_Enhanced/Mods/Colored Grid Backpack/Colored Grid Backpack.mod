<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="Colored Grid Backpack" version="1.0" date="02/05/2010">
		<Author name="Illandril" email="illandril@modders-exchange.net" />
		<Description text="http://uo.modders-exchange.net" />
		
		<Dependencies>
			<Dependency name="CustomSettingsWindow" />
		</Dependencies>
		
		<Files>
			<File name="Loader.lua" />
			<File name="Localizations.lua" />
			<File name="Colored Grid Backpack.lua" />
		</Files>
		
		<OnInitialize>
			<CallFunction name="ColoredGridBackpack.Initialize" />
		</OnInitialize>
	</UiMod>
</ModuleFile>
