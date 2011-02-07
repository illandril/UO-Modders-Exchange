<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="OverheadSpellTransformMixed" version="0.1" date="08/01/2009">

		<Author name="Illandril" email="illandril@modders-exchange.net" />
		<Description text="http://uo.modders-exchange.net" />
	
		<Dependencies>
			<Dependency name="OverheadSpellTransform" />
		</Dependencies>

		<Files>
			<File name="OverheadSpellTransformMixed.lua" />
		</Files>

		<OnInitialize>
			<CallFunction name="OverheadSpellTransformMixed.Initialize" />
		</OnInitialize>

	</UiMod>
</ModuleFile>
