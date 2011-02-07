<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <UiMod name="dzSettings" version="0.1" date="09/23/2009">

    <Author name="Illandril" email="dar.uosa@gmail.com" />
    <Description text="" />

    <Dependencies>
      <Dependency name="CustomSettingsWindow" />
    </Dependencies>

    <Files>
      <File name="dzSettings.lua" />
    </Files>

    <OnInitialize>
      <CallFunction name="dzSettings.Initialize" />
    </OnInitialize>
  </UiMod>
</ModuleFile>
