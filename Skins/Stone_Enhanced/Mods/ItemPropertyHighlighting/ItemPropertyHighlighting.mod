<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="ItemPropertyHighlighting" version="2.0 Beta" date="04/08/2010">

		<Author name="Illandril" email="illandril@modders-exchange.net" />
		<Description text="http://uo.modders-exchange.net" />

		<Dependencies>
			<Dependency name="CustomSettingsWindow" />
		</Dependencies>
        
		<Files>
			<File name="ItemPropertyHighlighting.lua" />
			<File name="ItemPropertiesEvaluator.lua" />
			<File name="Localizations.lua" />
		</Files>

		<OnInitialize>
			<CallFunction name="ItemPropertiesEvaluator.Initialize" />
			<CallFunction name="ItemPropertyHighlighting.Initialize" />
		</OnInitialize>
	</UiMod>
</ModuleFile>
