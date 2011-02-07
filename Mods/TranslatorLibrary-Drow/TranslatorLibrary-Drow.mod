<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="TranslatorLibrary-Drow" version="0.1" date="09/14/2009">

		<Author name="Illandril" email="illandril@modders-exchange.net" />
		<Description text="http://uo.modders-exchange.net" />

		<Dependencies>
			<Dependency name="Translator" />
		</Dependencies>

		<Files>
			<File name="TranslatorLibrary-Drow.lua" />
		</Files>

		<OnInitialize>
			<CallFunction name="TranslatorLibrary.Drow.Initialize()" />
		</OnInitialize>
	</UiMod>
</ModuleFile>
