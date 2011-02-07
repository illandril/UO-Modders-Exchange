<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="ExamplePackage" version="1.0" date="01/09/2009">
		<Author name="Illandril" email="illandril@modders-exchange.net" />
		<Description text="http://uo.modders-exchange.net" />
		
		<Files>
			<File name="Loader.lua" />
		</Files>
		
		<OnInitialize>
			<CallFunction name="ExamplePackage.Announce" />
		</OnInitialize>
	</UiMod>
</ModuleFile>
