<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="Translator" version="0.1" date="09/14/2009">

		<Author name="Illandril" email="illandril@modders-exchange.net" />
		<Description text="http://uo.modders-exchange.net" />

		<Files>
			<File name="Translator.lua" />
		</Files>

        <OnInitialize>
			<CallFunction name="Translator.Initialize()" />
		</OnInitialize>

		<OnUpdate>
			<CallFunction name="Translator.Update()" />
		</OnUpdate>
	</UiMod>
</ModuleFile>
