SA Copper Enhanced
Verison 1.7.6
Author: Dermott of LS

Other credits:

KR Bitter Black graphic elements: B-LAU 
Suggestions, testing, bug squashing: Zym Dragon, Ash, DarkChronus, Frarc
Additional Mods: Gildar, pgcd

Stat icons: Zym Dragon
Classic UO Font: Zym Dragon

UI Elements: SA Default adjusted by Dermott of LS, Bitter Black elements by B-LAU adjusted by Dermott of LS, Original elements by Dermott of LS

Installation note: REMOVE the old installation of Stone Enhanced before installing the new version as older versions may have files that were removed to resolve a conflict

Notes:
V 2.0
- Buff Bars should update properly with the new buff icons
- Spell Buttons in Party and Pet bars are now active and will determine the higher skill between Chivalry and Magery and cast the appropriate spell
- Option to  show player houses in Atlas mode now available.

V 1.9
- Added in Small Atlas mod by Illandril, changed layout of Atlas somewhat
- Rewrote StatusBarTemplates to be clearer codewise and to work with the various status bars in the skin better
- Changed the texture bindings of Zoom and Atlas Key buttons, resized them down a little to fix the textures better
- Changed font of Object Handles to UO Classic
- Retextured the Healthbars in the Pet Window to look like the mobile health bar, added in spell buttons (NOTE: These do NOT work as of this release, they are there for future functionality)
- Replaced CoreWindowTemplates.XML with new version and retweaked accordingly, this solves the "sticky party bars" bug
- Shopkeeper NPC Vendor window had some slight formatting tweaks


V 1.8
- Open On Startup Mod removed to solve a UI conflict
- Updated a couple of the new icons to better fit the skin (Actions)
- Added in back end Font support
- Overhead Names, Overhead Chat, and Damage Numbers can now be hotswapped for the new fonts.
- New Fonts added to Copper Enhanced:
- - Arial Narrow
- - Avatar
- - Kingthings Exeter
- - Magic Medieval
- - Tenace SSi
- - Times New Roman
- - Times New Roman Bold
- - UO Classic

v 1.7.7.1
- Removed a file that caused a conflict

V 1.7.7
- ContainerWindow.XML has been updated to work with the new system and retain formatting
- Mobile Health Bars have been updated to revert back to their normal C-E and S-E looks. Unfortunately, this loses (for now) the Hits % display on the health bars, however it is still present on the TargetWindow.
- Fonts folder has been added as well as a selection of fonts for back end support for font customization.

V 1.7.6
- Redesigned Status Bars to make them a bit easier to see, to fit the textures better, and to use better shading
- Rewrote the StatusWindow file to accommodate buff bar tooltips
- Added back in Item Properties EValuator/Highlighter as updated by Gildar
- Coordinates now remain visible in the Atlas Window while Center on Player is selected even if cursor is not in the map window
- Resized the coordinates text to be slightly larger and readable
- Fixed issues with the Buff Bar not showing the tooltips (Gildar)
- Fixed an issue with the Quick Details Window overlapping buff bar timers (Gildar)
- Made Quick Details Window static, it will still move with the appearance and disappearance of buff bar icons, but it will no longer be draggable

V 1.7.5
- Added in Hotbar Locking Functionality
- Added in textures for Gargoyle Paperdolls
- REMOVED Item Property mods until they can be updated to not conflict with skills tooltips or each other
- Updated Atlas map to be based more on the default version, but retain the ability to hide facet info, more work to be done to retain coordinates and resize issues
- Tweaked Container gumps to allow for Colored Grid Backpack mod
- Updated custom mod files
- Added in Colored Grid Backpack and tweaked the texture used to fit the C-E theme
- Added in font selection for damage numbers

V 1.7.4
- Added in Overhead Spell Transform Mixed by request (Shows spells as such "Kal Ort Por - Recall")
- Updated Remember Custom UI mod
- Changed the look of the Target Window, it now matches the mobile health bar (but is bigger)
- Changed the border that affects the gameplay window and inner border of various windows. This gives better visibility to the resize icon as well as gives the other windows a bit of a cleaner look

V 1.7.3

- Added in latest version of Item Properties EValuator and a version of Highlighting that seemed to work together decently
- Small texture tweak to Target Window

V 1.7.2
- Changed the look of the Target Window to be more in line with the look of the Copper Enhanced UI as a whole and removed the Bitter Black elements accordingly
- Reduced length of mobile health bars to 75% of default
- Changed the look of the hotbars to be more in line with the look of the Copper Enhanced UI as a whole and removed the Bitter Black elements accordingly
- Made health bars wider to accommodate less width, formatted accordingly
- Retweaked interface windows to have a more streamlined appearance with the Mobile Health Bars
- Returned the "fade" on hotbar slots in which an item is placed, but is not present in the character's backpack

V 1.7.1
- Updated for Patch 7.0.5.1. changes
- Hotbars:

Reworked the "Targeted" color codings based on the latest patch as follows:

The little triangle has been retained and the static border has been removed (i.e. the color coded border you see in Default has been reverted to the triangle)

When you mouse over a given hotbar slot, it will highlight with the colored border according to target type.

Colors:

Red: Current
Green: Cursor
Blue: Self
Black: Stored
Grey: No target or empty slot

The shading in the upper right corner from the Default UI has been added for greater hotkey visibility

Hotbars look cleaner now overall.

Icons:

Copperized and implemented the new icons added with 7.0.5.1. These are:

Command
Equip Last Weapon
Bandage Self
Bandage Selected Target

UI Cleanup:

- Tweaked the Close window X button to be centered again in the title bar of windows

- Tweaked the texture coords call for the box that goes behind the actions icons in the Actions list to center it appropriately.

V 1.7
- Updated pgcd's item properties evaluator mod
- Updated Quick Details Wiundow to fix a bug
- Added Remember Custom UI Mod

V 1.6.9
- Added in Copperized Chat icon in menu bar
- Added in XML support for Chat icon in Menu bar

V 1.6.8
- Added Open on Startup Mod
- Added UO Cartographer support Mod
- Combined Item Properties Evaluator and Highlighting Mods into a single cohesive package thanks to pgcd's efforts.  Changed single property highlighting for top level intensities back to the Highlight Mod default of gold.

V 1.6.5

- Updated Item Property Highlighting to latest version
- Added in changed XML file in Object Handle Toggle Window to reference new texture

V 1.6.1

- Removed files to update to 11/12/2009 patch
- Changed Status Window
	- Removed character portrait and "useless" button
	- Moved XXX/XXX stat display into copper box on left for easier reading (if you do not have these stats visible, this will appear as a blank box)

V 1.6

- Added in Mods folder with a selection of mods re-created by Gildar from the Enhanced KR mods


V 1.5

- Changed the textures for the Main Menu bar (usually in the lower right) including a new War/Peace shield of original design and a new backpack icon and endcap
- Changed the textures used for the radar map and Status Window.  Made health, mana and stamina bars larger which should help with visibility of the numerical data
- Changed the endcaps to hotbars
- Changed the font and color of coordinates in Atlas map mode for better visbility
- Status Window SHOULD be right clickable for the context menu (if it is not, check for Statuswindow.lua and delete that file, it should then work.
- Changed the textures for drop menu boxes to better fit the skin theme


v 1.3

- Removed Icons.XML which prevents SA skills from showing
- Tweaked the ALL and CLEAR NPC shopkeeper buttons a but for better visibility
- Tweaked fonts and positions of hotbar hotkey and quantity labels

v 1.0 First release of SA Copper Enhanced

Changes from the Basic SACopper skin:

- Texture changes to Tabs and Menu buttons
- Current version (9/3/09) of resizable Atlas (Dar/Zared)
- SA_Enhanced features imported
	- Coordinates now appear under the radar map (?)
	- Buff bar now has timers for buffs/debuffs (Ash/?)
	- Target Arcanist Window is now functiuonal (Pinco/Ash)
	- "Smart" Mobile Health/Party bar buttons (Ash)