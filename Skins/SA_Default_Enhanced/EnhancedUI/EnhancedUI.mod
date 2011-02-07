<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="AddonName" version="1.0" date="DD/MM/YYYY" autoenabled="true">

		<Author name="Author" email="user@domain.tld" />
		<Description text="What the mod does" />

		<Files>
<!--			<File name="icons.xml" /> -->
<!--			<File name="Source/MyCustom.xml" /> -->
			<File name="Source/MyCustom.Lua" />
			<File name="Source/MacroPickerWindow.lua" />
			<File name="Source/ObjectHandle.lua" />
			<File name="Source/SkillsWindowMod.lua" />

		</Files>
		<OnInitialize>
			<CallFunction name="MyCustom.Initialize" />

		</OnInitialize>

                <OnUpdate>
                        <CallFunction name="MyCustom.OnUpdate" />
                </OnUpdate>        
		<OnShutdown>
			<CallFunction name="MyCustom.Shutdown" />
		</OnShutdown>
	</UiMod>
</ModuleFile>