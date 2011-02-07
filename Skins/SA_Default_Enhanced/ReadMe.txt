This is a UiMod file for "Ultima Online Stygian Abyss"
Contributors
Textures - Dermott
Contributor - Ash
Inspired by - Gildar/Illandril, Pinco, Lucitus

Resizable Map - Dar and Zared


Installation - extract files into UserInterface folder of your Stygian Abyss install path.
Directory Structure should be:
UserInterface
	SA_Default_Enhanced
		EnhancedUI
		Icons
		Source
		Textures
	
Enhancements

Current Changes
	Damage numbers will no longer capture mouse clicks
	Added Dar and Zared's Resizable map mod

v1.28	Fix - Total Skill Points was not calculating properly, fixed now

v1.27	Removed Texture modifications to keep skin as generic as possible

v1.25
	Changed Overhead text font
	Skills window on 1st opening will default to Custom tab
	Skills window total points will display to tenth of decimal
	Buff/Debuff timers from BB_Enhanced

v1.0
- note most of these are how I like to have the Ui setup, and until we get more developers and a way to save user preferences some features are always on and others can be toggled using a command call.

Spells & Power Words - Default is to translate into English, this can be changed with command calls.  
	1 - Default Power Word only
	2 - Don't display over head
	3 - display Power word - English
	4 - English Only

to change can set to a 'Command' Action, change x to the number you want
	script OverheadText.currentSpell = x

Anti-Spam functions again these are toggleable by command, default is quiet mode
	"/quiet mode" = will only show overhead if it is not a repeat of what player already said
	"/silence" mode = Only EM and NPC speech is shown over head
	"/voice" mode = normal

command structure is:
	script OverheadText.FilterMode = "/quiet"
	script OverheadText.FilterMode = "/silence"
	script OverheadText.FilterMode = "/voice"

Personally I put these in a macro with an emote letting spammers know they being squelched.

system will determine if player's Chivalry is higher than magery and use that for the heal/cure buttons on the Party mobile healthbar.
Added 3rd button to Party mobile healthbar, for chivalry it is remove curse, for magery it is bless.

Also if create a mobile healthbar for your pet, it will have these 3 buttons (note not the petwindow group but only the mobile ones for now)

Display radar coordinates underneath the radar.

Added in some custom Icons as well, simple icons to label macros that had no clear available icon.  system inserts these at the top of the icon chooser menu to make it easier to find.