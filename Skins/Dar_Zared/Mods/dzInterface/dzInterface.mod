<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlnssi="http://www.w3.org/2001/XMLSchema-instance">
  <UiMod name="dzInterface" version="1.0" date="09/18/2009">

    <Author name="dar" email="dar.uosa@gmail.com" />
    <Description text="your desc" />

    <Files>
      <File name="dzInterfaceCore.lua" />
    </Files>
    
    <OnInitialize>
      <CallFunction name="dzInterfaceCore.Initialize" />
      <!--<CreateWindow name="PartyWindow" show="false"/>
      <CreateWindow name="PartyListWindow" show="false"/>
      <CreateWindow name="PetRenameWindow" show="false"/>-->
    </OnInitialize>
  
  </UiMod>
</ModuleFile>
