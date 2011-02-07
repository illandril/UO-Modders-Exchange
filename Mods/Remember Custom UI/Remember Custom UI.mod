<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="Remember Custom UI" version="2.0" date="12/02/2009">
		<Author name="Illandril" email="illandril@modders-exchange.net" />
		<Description text="http://uo.modders-exchange.net" />
		
		<Dependencies>
			<Dependency name="CustomSettings" />
		</Dependencies>
		
		<Files>
			<File name="Remember Custom UI.lua" />
		</Files>
		
		<OnInitialize>
			<CallFunction name="RememberCustomUI.Initialize" />
		</OnInitialize>
	</UiMod>
</ModuleFile>
