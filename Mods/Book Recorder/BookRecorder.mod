<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="BookRecorder" version="1.0" date="09/08/2009">
		<Author name="Illandril" email="illandril@modders-exchange.net" />
		<Description text="http://uo.modders-exchange.net" />

		<Dependencies>
			<Dependency name="CustomSettings" />
		</Dependencies>
		
		<Files>
			<File name="BookRecorder.lua" />
		</Files>
		
		<OnInitialize>
			<CallFunction name="BookRecorder.Initialize" />
		</OnInitialize>
	</UiMod>
</ModuleFile>
