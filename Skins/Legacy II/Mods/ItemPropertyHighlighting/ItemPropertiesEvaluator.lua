----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------
-- v 0.9.4

ItemPropertiesEvaluator = {}

ItemPropertiesEvaluator.IsGargoyle = true
ItemPropertiesEvaluator.QueensForge = true
ItemPropertiesEvaluator.TerMurForge = false
ItemPropertiesEvaluator.DisplayIndividualIntensities = true
ItemPropertiesEvaluator.DisplayWorth = true
ItemPropertiesEvaluator.DisplayGroups = true
ItemPropertiesEvaluator.ShowImbuenda = true

ItemPropertiesEvaluator.BonusWorthForSetItems = 1000 -- this REALLY depends on taste!

ItemPropertiesEvaluator.LOW_INTENSITY = {r=255,g=32,b=32}
ItemPropertiesEvaluator.MED_INTENSITY = {r=0,g=255,b=64} -- will unravel to essence
ItemPropertiesEvaluator.HIGH_INTENSITY = {r=187,g=187,b=64} -- will  unravel to relic if enhanced and POFed > 50

ItemPropertiesEvaluator.IntensityThreshold = 60	-- adjust to taste (60 should be a good value)
ItemPropertiesEvaluator.GroupThreshold = 75 -- same as above (75 here though)

-- no need to edit below 

ItemPropertiesEvaluator.RelicIntensity = 451
ItemPropertiesEvaluator.EssenceIntensity = 200 -- assuming home forge

if ItemPropertiesEvaluator.IsGargoyle then
	ItemPropertiesEvaluator.RelicIntensity = ItemPropertiesEvaluator.RelicIntensity-20
	ItemPropertiesEvaluator.EssenceIntensity = ItemPropertiesEvaluator.EssenceIntensity - 20
end

if ItemPropertiesEvaluator.QueensForge then
	ItemPropertiesEvaluator.RelicIntensity = ItemPropertiesEvaluator.RelicIntensity-30
elseif ItemPropertiesEvaluator.TerMurForge then
	ItemPropertiesEvaluator.RelicIntensity = ItemPropertiesEvaluator.RelicIntensity-10
end




-- Bod rewards and desirability, the value for des can be changed to reflect different desirabilities.
-- Please note that POF has a des of 1000 to make sure that even BODs that have a 10% chance show up as keepers  

ItemPropertiesEvaluator.BodRewards = {
	[L"shovel"] = {des = 0};
	[L"pickaxe"] = {des = 0};
	[L"gloves+1"] = {des = 0};
	[L"prospector"] = {des = 0};
	[L"gargoyle"] = {des = 0};
	[L"gloves+3"] = {des = 0};
	[L"gloves+5"] = {des = 0};
	[L"POF"] = {des = 1000};
	[L"dull"] = {des = 100};
	[L"shadow"] = {des = 100};
	[L"copper"] = {des = 100};
	[L"bronze"] = {des = 100};
	[L"golden"] = {des = 100};
	[L"agapite"] = {des = 100};
	[L"verite"] = {des = 100};
	[L"valorite"] = {des = 100};
	[L"PS105"] = {des = 0};
	[L"PS110"] = {des = 0};
	[L"PS115"] = {des = 0};
	[L"PS120"] = {des = 50};
	[L"anvil"] = {des = 0};
	[L"ASH10"] = {des = 100};
	[L"ASH15"] = {des = 100};
	[L"ASH30"] = {des = 100};
	[L"ASH60"] = {des = 100};
	[L"cloth1"] = {des = 0};
	[L"cloth2"] = {des = 0};
	[L"cloth3"] = {des = 0};
	[L"cloth4"] = {des = 50};
	[L"sandals"] = {des = 0};
	[L"hide"] = {des = 0};
	[L"tapestry"] = {des = 0};
	[L"rug"] = {des = 0};
	[L"cbd"] = {des = 100};
	[L"spined"] = {des = 100};
	[L"horned"] = {des = 100};
	[L"barbed"] = {des = 100};
	
}


ItemPropertiesEvaluator.TYPE_JEWEL = 1
ItemPropertiesEvaluator.TYPE_WEAPON = 2
ItemPropertiesEvaluator.TYPE_ARMOR = 3
ItemPropertiesEvaluator.TYPE_SHIELD = 4
ItemPropertiesEvaluator.TYPE_HAT = 5
ItemPropertiesEvaluator.TYPE_BOD = 999
ItemPropertiesEvaluator.TYPE_SKIP = 0


-- All the names for various items?

ItemPropertiesEvaluator.JewelryNames = {
	L"ring$";L"bracelet"
}

ItemPropertiesEvaluator.WeaponNames = {
	[L"stone war sword"]={m="m";};
	[L"glass sword"]={m="m";};[L"glass staff"]={m="m";};
	[L"dual short axes"]={m="m";};[L"dread sword"]={m="m";};[L"talwar"]={m="m";};[L"dual pointed spear"]={m="m";};[L"gargish dagger"]={m="m";};
	[L"bloodblade"]={m="m";};[L"shortblade"]={m="m";};[L"disk mace"]={m="m";};[L"serpentstone staff"]={m="m";};
	[L"boomerang"]={m="m";isBow=true};[L"cyclone"]={m="m";isBow=true};[L"soul glaive"]={m="m";isBow=true};
	[L"two handed axe"]={m="m";};[L"bardiche"]={m="m";};[L"battle axe"]={m="m";};[L"bladed staff"]={m="m";};[L"bone harvester"]={m="m";};
	[L"broadsword"]={m="m";};[L"butcher knife"]={m="m";};[L"crescent blade"]={m="m";};[L"cutlass"]={m="m";};[L"double axe"]={m="m";};
	[L"executioner's axe"]={m="m";};[L"halberd"]={m="m";};[L"hatchet"]={m="m";};[L"katana"]={m="m";};[L"large battle axe"]={m="m";};[L"long sword"]={m="m";};
	[L"pickaxe"]={m="m";};[L"scimitar"]={m="m";};[L"scythe"]={m="m";};[L"skinning knife"]={m="m";};[L"viking sword"]={m="m";};[L"bokuto"]={m="w";};[L"no-dachi"]={m="m";};
	[L"wakizashi"]={m="m";};[L"daisho"]={m="m";};[L"elven machete"]={m="m";};[L"ornate axe"]={m="m";};[L"radiant scimitar"]={m="m";};[L"rune blade"]={m="m";};
	[L"black staff"]={m="w";};[L"club"]={m="w";};[L"gnarled staff"]={m="w";};[L"hammer pick"]={m="m";};[L"magic wand"]={m="m";};[L"maul"]={m="m";};
	[L"quarterstaff"]={m="w";};[L"scepter"]={m="m";};[L"shepherd's crook"]={m="w";};[L"sledge hammer"]={m="m";};[L"smith's hammer"]={m="m";};
	[L"war axe"]={m="m";};[L"war hammer"]={m="m";};[L"war mace"]={m="m";};[L"nunchaku"]={m="m";};[L"tessen"]={m="m";};[L"tetsubo"]={m="w";};[L"diamond mace"]={m="m";};
	[L"wild staff"]={m="w";};[L"double bladed staff"]={m="m";};[L"kryss"]={m="m";};[L"lance"]={m="m";};[L"pike"]={m="m";};[L"pitchfork"]={m="m";};
	[L"short spear"]={m="m";};[L"spear"]={m="m";};[L"war fork"]={m="m";};[L"lajatang"]={m="m";};[L"tekagi"]={m="m";};[L"kama"]={m="m";};[L"sai"]={m="m";};[L"assassin spike"]={m="m";};
	[L"elven spellblade"]={m="m";};[L"leafblade"]={m="m";};[L"war cleaver"]={m="m";};[L"mace"]={m="m";};[L"axe"]={m="m";};[L"dagger"]={m="m";};[L"cleaver"]={m="m";};
	[L"heavy crossbow"]={m="w";isBow=true};[L"repeating crossbow"]={m="w";isBow=true};[L"yumi"]={m="w";isBow=true};
	[L"elven composite longbow"]={m="w";isBow=true};[L"magical shortbow"]={m="w";isBow=true};
	[L"crossbow"]={m="w";isBow=true};[L"composite bow"]={m="w";isBow=true};[L"bow"]={m="w";isBow=true};	
	}

ItemPropertiesEvaluator.ArmorNames = { -- these are not actually right but i'll figure out something
	[L"raven helm"]={m="w";[L"physical resist"]=5;[L"fire resist"]=1;[L"poison resist"]=2;[L"cold resist"]=2;[L"energy resist"]=5};
	[L"vulture helm"]={m="w";[L"physical resist"]=5;[L"fire resist"]=1;[L"poison resist"]=2;[L"cold resist"]=2;[L"energy resist"]=5};
	[L"winged helm"]={m="w";[L"physical resist"]=5;[L"fire resist"]=1;[L"poison resist"]=2;[L"cold resist"]=2;[L"energy resist"]=5};
	[L"dragon helm"]={m="o";[L"physical resist"]=3;[L"fire resist"]=3;[L"poison resist"]=3;[L"cold resist"]=3;[L"energy resist"]=3};
	[L"circlet"]={m="m";[L"physical resist"]=1;[L"fire resist"]=5;[L"poison resist"]=2;[L"cold resist"]=2;[L"energy resist"]=5};
	[L"helmet"]={m="m";[L"physical resist"]=2;[L"fire resist"]=4;[L"poison resist"]=4;[L"cold resist"]=3;[L"energy resist"]=2};
	[L"closed helm"]={m="m";[L"physical resist"]=3;[L"fire resist"]=3;[L"poison resist"]=3;[L"cold resist"]=3;[L"energy resist"]=3};
	[L"bascinet"]={m="m";[L"physical resist"]=7;[L"fire resist"]=2;[L"poison resist"]=2;[L"cold resist"]=2;[L"energy resist"]=2};
	[L"norse helm"]={m="m";[L"physical resist"]=4;[L"fire resist"]=1;[L"poison resist"]=4;[L"cold resist"]=4;[L"energy resist"]=2};
	[L"orc helm"]={m="m";[L"physical resist"]=3;[L"fire resist"]=1;[L"poison resist"]=3;[L"cold resist"]=3;[L"energy resist"]=5};
	[L"studded"]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"poison resist"]=3;[L"cold resist"]=3;[L"energy resist"]=4};
	[L"chainmail"]={m="m";[L"physical resist"]=4;[L"fire resist"]=4;[L"poison resist"]=4;[L"cold resist"]=1;[L"energy resist"]=2};
	[L"ringmail"]={m="m";[L"physical resist"]=3;[L"fire resist"]=3;[L"poison resist"]=1;[L"cold resist"]=5;[L"energy resist"]=3};
	[L"gargish platemail"]={m="m";[L"physical resist"]=8;[L"fire resist"]=6;[L"poison resist"]=5;[L"cold resist"]=6;[L"energy resist"]=5};
	[L"gargish leather"]={m="l";[L"physical resist"]=5;[L"fire resist"]=6;[L"poison resist"]=7;[L"cold resist"]=6;[L"energy resist"]=6};	
	[L"^platemail"]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"poison resist"]=2;[L"cold resist"]=3;[L"energy resist"]=2};
	[L"plate helm"]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"poison resist"]=2;[L"cold resist"]=3;[L"energy resist"]=2};
	[L"gargish cloth"]={m="o";[L"physical resist"]=5;[L"fire resist"]=7;[L"poison resist"]=6;[L"cold resist"]=6;[L"energy resist"]=6};
	[L"gargish stone"]={m="m";[L"physical resist"]=6;[L"fire resist"]=6;[L"poison resist"]=4;[L"cold resist"]=8;[L"energy resist"]=6};
	[L"barbed leather"]={m="l";[L"physical resist"]=4;[L"fire resist"]=5;[L"poison resist"]=5;[L"cold resist"]=6;[L"energy resist"]=7};
	[L"horned leather"]={m="l";[L"physical resist"]=4;[L"fire resist"]=7;[L"poison resist"]=5;[L"cold resist"]=5;[L"energy resist"]=5};
	[L"spined leather"]={m="l";[L"physical resist"]=7;[L"fire resist"]=4;[L"poison resist"]=3;[L"cold resist"]=3;[L"energy resist"]=3};
	[L"^leather"]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"poison resist"]=3;[L"cold resist"]=3;[L"energy resist"]=3};
	[L"ninja"]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"poison resist"]=3;[L"cold resist"]=3;[L"energy resist"]=4};
	[L"leaf "]={m="l";[L"physical resist"]=2;[L"fire resist"]=3;[L"poison resist"]=2;[L"cold resist"]=4;[L"energy resist"]=4};
	[L"hide"]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"poison resist"]=4;[L"cold resist"]=3;[L"energy resist"]=2};
	[L"woodland"]={m="w";[L"physical resist"]=5;[L"fire resist"]=3;[L"poison resist"]=2;[L"cold resist"]=3;[L"energy resist"]=2};
	[L"darkwood"]={m="w";[L"physical resist"]=8;[L"fire resist"]=5;[L"poison resist"]=5;[L"cold resist"]=7;[L"energy resist"]=5};
	[L"bone"]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"poison resist"]=4;[L"cold resist"]=2;[L"energy resist"]=4};
	[L"dragon"]={m="o";[L"physical resist"]=3;[L"fire resist"]=3;[L"poison resist"]=3;[L"cold resist"]=3;[L"energy resist"]=3};
}

ItemPropertiesEvaluator.ShieldNames = {
	[L"tear kite shield"]={m="m";[L"energy resist"]=1};
	[L"gargish kite shield"]={m="m";[L"energy resist"]=1};
	[L"buckler"]={m="m";[L"poison resist"]=1;};
	[L"large stone shield"]={m="m";[L"poison resist"]=1;};
	[L"wooden shield"]={m="w";[L"energy resist"]=1};
	[L"bronze shield"]={m="m";[L"cold resist"]=1;};
	[L"small plate shield"]={m="m";[L"cold resist"]=1;};
	[L"metal kite shield"]={m="m";[L"energy resist"]=1};
	[L"heater shield"]={m="m";[L"fire resist"]=1;};
	[L"large plate shield"]={m="m";[L"fire resist"]=1;};
	[L"medium plate shield"]={m="m";[L"fire resist"]=1;};
	[L"metal shield"]={m="m";[L"fire resist"]=1;};
	[L"order shield"]={m="m";[L"physical resist"]=1;};
	[L"chaos shield"]={m="m";[L"physical resist"]=1;};
}


ItemPropertiesEvaluator.HatNames = {
	[L"bear mask"]={[L"physical resist"]=5;[L"fire resist"]=3;[L"poison resist"]=8;[L"cold resist"]=4;[L"energy resist"]=4};
	[L"deer mask"]={[L"physical resist"]=2;[L"fire resist"]=6;[L"poison resist"]=8;[L"cold resist"]=1;[L"energy resist"]=7};
	[L"orc mask"]={[L"physical resist"]=1;[L"fire resist"]=1;[L"poison resist"]=7;[L"cold resist"]=7;[L"energy resist"]=8};
	[L"tribal mask"]={[L"physical resist"]=6;[L"fire resist"]=9;[L"poison resist"]=6;[L"cold resist"]=10;[L"energy resist"]=5}; -- this one is the max from both types
	[L"skullcap"]={[L"physical resist"]=0;[L"fire resist"]=3;[L"poison resist"]=5;[L"cold resist"]=8;[L"energy resist"]=8};
	[L"bandana"]={[L"physical resist"]=0;[L"fire resist"]=3;[L"poison resist"]=5;[L"cold resist"]=8;[L"energy resist"]=8};
	[L"floppy hat"]={[L"physical resist"]=0;[L"fire resist"]=5;[L"poison resist"]=9;[L"cold resist"]=5;[L"energy resist"]=5};
	[L"wide-brim hat"]={[L"physical resist"]=0;[L"fire resist"]=5;[L"poison resist"]=9;[L"cold resist"]=5;[L"energy resist"]=5};
	[L"straw hat"]={[L"physical resist"]=0;[L"fire resist"]=5;[L"poison resist"]=9;[L"cold resist"]=5;[L"energy resist"]=5};
	[L"tall straw hat"]={[L"physical resist"]=0;[L"fire resist"]=5;[L"poison resist"]=9;[L"cold resist"]=5;[L"energy resist"]=5};
	[L"wizard's hat"]={[L"physical resist"]=0;[L"fire resist"]=5;[L"poison resist"]=9;[L"cold resist"]=5;[L"energy resist"]=5};
	[L"bonnet"]={[L"physical resist"]=0;[L"fire resist"]=5;[L"poison resist"]=9;[L"cold resist"]=5;[L"energy resist"]=5};
	[L"feathered hat"]={[L"physical resist"]=0;[L"fire resist"]=5;[L"poison resist"]=9;[L"cold resist"]=5;[L"energy resist"]=5};
	[L"tricorne hat"]={[L"physical resist"]=0;[L"fire resist"]=5;[L"poison resist"]=9;[L"cold resist"]=5;[L"energy resist"]=5};
	[L"jester hat"]={[L"physical resist"]=0;[L"fire resist"]=5;[L"poison resist"]=9;[L"cold resist"]=5;[L"energy resist"]=5};
	[L"flower garland"]={[L"physical resist"]=0;[L"fire resist"]=3;[L"poison resist"]=5;[L"cold resist"]=8;[L"energy resist"]=8};
	[L"cloth ninja hood"]={[L"physical resist"]=0;[L"fire resist"]=5;[L"poison resist"]=9;[L"cold resist"]=5;[L"energy resist"]=5};
	[L"kasa"]={[L"physical resist"]=0;[L"fire resist"]=5;[L"poison resist"]=9;[L"cold resist"]=5;[L"energy resist"]=5};
}

ItemPropertiesEvaluator.Enhancements = {}	
ItemPropertiesEvaluator.Enhancements[ItemPropertiesEvaluator.TYPE_ARMOR] = {
	["m"] = {
		{en = L"Dull Copper"; q = 1.02; p = {L"lower requirements";}; b = 20;};
		{en = L"Shadow Iron"; q = 1.03};
		{en = L"Copper"; q = 1.04};
		{en = L"Bronze"; q = 1.05};
		{en = L"Gold"; q = 1.07; p = {L"lower requirements";L"luck";}; b = 70;};
		{en = L"Agapite"; q = 1.09};
		{en = L"Verite"; q = 1.12};
		{en = L"Valorite"; q = 1.20};
		};
	["l"] = {
		{en = L"Spined Leather"; q=1.01};
		{en = L"Horned Leather"; q=1.02};
		{en = L"Barbed Leather"; q=1.04};
		};
	["w"] = {
		{en = L"Oak"; q = 1.01; p = {L"luck";}; b = 40};
		{en = L"Ash"; q = 1.03; p = {L"lower requirements";}; b = 20;};
		{en = L"Yew"; q = 1.07; p = {L"hit point regeneration";}; b = 50;}; 
		{en = L"Bloodwood"; q = 1.10; p = {L"hit point regeneration";}; b = 100;};
		{en = L"Frostwood"; q = 1.20};
		{en = L"Heartwood?"; q = 1.15; p = {L"dummy"}; b = 100}	 
		};
	}

ItemPropertiesEvaluator.Enhancements[ItemPropertiesEvaluator.TYPE_SHIELD] = {
	["m"] = {
		{en = L"Dull Copper"; q = 1.02; p = {L"lower requirements";}; b = 20;};
		{en = L"Shadow Iron"; q = 1.03};
		{en = L"Copper"; q = 1.04};
		{en = L"Bronze"; q = 1.05};
		{en = L"Gold"; q = 1.07; p = {L"lower requirements";L"luck";}; b = 70;};
		{en = L"Agapite"; q = 1.09};
		{en = L"Verite"; q = 1.12};
		{en = L"Valorite"; q = 1.20};
		};
	["w"] = {
		{en = L"Oak"; q = 1.01;};
		{en = L"Ash"; q = 1.03; p = {L"lower requirements";}; b = 20;};
		{en = L"Yew"; q = 1.07; p = {L"hit point regeneration";}; b = 50;}; 
		{en = L"Bloodwood"; q = 1.10; p = {L"hit point regeneration";L"luck"}; b = 140;};
		{en = L"Frostwood"; q = 1.20; p ={L"spell channeling";}; b = 100};
		{en = L"Heartwood?"; q = 1.15; p = {L"dummy"}; b = 100}	 
		};
	}

ItemPropertiesEvaluator.Enhancements[ItemPropertiesEvaluator.TYPE_WEAPON] = {
	["m"] = {
		{en = L"Dull Copper"; q = 1.02; p = {L"lower requirements";}; b = 20;};
		{en = L"Shadow Iron"; q = 1.03};
		{en = L"Copper"; q = 1.04};
		{en = L"Bronze"; q = 1.05};
		{en = L"Gold"; q = 1.07; p = {L"lower requirements";L"luck";}; b = 70;};
		{en = L"Agapite"; q = 1.09};
		{en = L"Verite"; q = 1.12};
		{en = L"Valorite"; q = 1.20};
		};
	["w"] = {
		{en = L"Oak"; q = 1.01; p = {L"luck";L"damage increase"}; b = 50};
		{en = L"Ash"; q = 1.03; p = {L"lower requirements";L"swing speed increase";}; b = 53.333;};
		{en = L"Yew"; q = 1.07; p = {L"hit chance increase";L"damage increase";}; b = 53.333;}; 
		{en = L"Bloodwood"; q = 1.10; p = {L"hit point regeneration";L"hit life leech"}; b = 132;};
		{en = L"Frostwood"; q = 1.20; p = {L"damage increase";}; b = 24};
		{en = L"Heartwood?"; q = 1.15; p = {L"dummy"}; b = 50}	 
		};
	}


ItemPropertiesEvaluator.Groups = {
	LRC_LMC_MR = {total=0, range = 200; weight = 1; desc = L"Mana/Regs"},
	FC_FCR = {total=0, range = 200; weight = 1; desc = L"FC/FCR"},
	LRC_LMC_MR_FC_FCR_LUCK = {total=0, range = 200; weight = 1; desc = L"Luck/mage"; func = 1},
	RESISTS = {total=0, range = 59; weight = 0.2; desc = L"All 70s piece"; func = 1},
	EXTREME_RESISTS = {total=0, range = 30; weight = 0.1; desc = L"Extreme resists"; func = 1},
	POISON_ONLY = {total=0, range = 100; weight = 1; desc = L"Golem trainer"; func = 1}, -- 100% poison works only when there is no hit effect
	HCI_DCI = {total=0, range = 200; weight = 1; desc = L"Hit/Def chance"},
	HLD_HLA = {total=0, range = 200; weight = 1; desc = L"PvP hit"},
	HCI_DCI_HLD_HLA = {total=0, range = 400; weight = 1; desc = L"PvP Uber"},
	BAL_EP = {total=0, range = 200; weight = 1; desc = L"Pot archer"},
	SC_FC0 = {total=0, range = 100; weight = 1; desc = L"No penalty SC"; func = 1},
	LEECH = {total=0, range = 200; weight = 1; desc = L"Leeches"},
	SWING_LEECH = {total=0, range = 250; weight = 1; desc = L"Fast leech"},
	SWING_EFFECT = {total=0, range = 250; weight = 1; desc = L"Fast effect"},
	LEECH_EFFECT = {total=0, range = 100; weight = 0.1; desc = L"Effect/Leech"; func = 1}, -- leeches are less effective when paired with hit effects
	HEALING_ANATOMY = {total=0, range = 200; weight = 1; desc = L"Healer skills"},
	TACTICS_WEAPON = {total=0, range = 200; weight = 1; desc = L"Warrior skills"},
	EVAL_MED_MAGERY = {total=0, range = 200; weight = 1; desc = L"Mage skills"},
	TAMING_LORE_VET = {total=0, range = 200; weight = 1; desc = L"Tamer skills"},
	NINJITSU_STEALTH = {total=0, range = 200; weight = 1; desc = L"Ninja skills"},
	NECRO_SS = {total=0, range = 200; weight = 1; desc = L"Necromancer skills"},
	MUSIC_BARD = {total=0, range = 200; weight = 1; desc = L"Bard skills"},
	DPS = {total=0,range=400; weight = 1, desc = L"DPS"},
	}


-- mods should have a range and a weight to judge their value
ItemPropertiesEvaluator.Mods = {
-- resists
	[L"physical resist"] = {iw=1; intensity = 0; range = 15; weight = 1; func = "RESIST"; groups = {"RESISTS";"EXTREME_RESISTS"}};
	[L"fire resist"] = {iw=1; intensity = 0; range = 15; weight = 1; func = "RESIST"; groups = {"RESISTS";"EXTREME_RESISTS"} };
	[L"poison resist"] = {iw=1; intensity = 0; range = 15; weight = 1; func = "RESIST"; groups = {"RESISTS";"EXTREME_RESISTS"} };
	[L"cold resist"] = {iw=1; intensity = 0; range = 15; weight = 1; func = "RESIST"; groups = {"RESISTS";"EXTREME_RESISTS"} };
	[L"energy resist"] = {iw=1; intensity = 0; range = 15; weight = 1; func = "RESIST"; groups = {"RESISTS";"EXTREME_RESISTS"} };
-- damage types
	[L"fire damage"] = {iw=0; intensity = 0; range = 100; weight = 0; groups = {}};
--	[L"physical damage"] = {intensity = 0; range = 100; weight = 0; groups = {}};
	[L"poison damage"] = {iw=0; intensity = 0; range = 100; weight = 0; groups = {"POISON_ONLY"}};
	[L"cold damage"] = {iw=0; intensity = 0; range = 100; weight = 0; groups = {}};
	[L"energy damage"] = {iw=0; intensity = 0; range = 100; weight = 0; groups = {}};
	[L"chaos damage"] = {iw=1; intensity = 0; range = 100; weight = 0; groups = {} };
-- stat bonuses
	[L"strength bonus"] = {iw=1; intensity = 0; range = 8; weight = 1; groups = {} };
	[L"dexterity bonus"] = {iw=1; intensity = 0; range = 8; weight = 1; groups = {} };
	[L"intelligence bonus"] = {iw=1; intensity = 0; range = 8; weight = 1; groups = {} };
	[L"hit point increase"] = {iw=1; intensity = 0; range = 5; weight = 1.2; groups = {} };
	[L"stamina increase"] = {iw=1; intensity = 0; range = 8; weight = 1; groups = {}};
	[L"mana increase"] = {iw=1; intensity = 0; range = 8; weight = 1; groups = {}};
-- regen
	[L"stamina regeneration"] = {iw=1; intensity = 0; range = 3; weight = 0.9; groups = {}};
	[L"mana regeneration"] = {iw=1; intensity = 0; range = 2; weight = 1; groups = {"LRC_LMC_MR_FC_FCR_LUCK"; "LRC_LMC_MR"} };
	[L"hit point regeneration"] = {iw=1; intensity = 0; range = 2; weight = 1; groups = {} };
-- leeches
	[L"hit life leech"] = {iw=1; intensity = 0; range = 50; weight = 1; func="LEECH_RANGE"; groups = {"LEECH"; "SWING_LEECH"; "LEECH_EFFECT"} };
	[L"hit mana leech"] = {iw=1; intensity = 0; range = 50; weight = 1; func="LEECH_RANGE"; groups = {"LEECH"; "SWING_LEECH"; "LEECH_EFFECT"} };
	[L"hit stamina leech"] = {iw=1; intensity = 0; range = 50; weight = 1; groups = {"LEECH"; "SWING_LEECH"; "LEECH_EFFECT"}};
-- hit effects
	[L"hit dispel"] = {iw=1; intensity = 0; range = 50; weight = 0.8; groups = {"LEECH_EFFECT"}};
	[L"hit fireball"] = {iw=1; intensity = 0; range = 50; weight = 1; groups = {"SWING_EFFECT"; "LEECH_EFFECT"; "POISON_ONLY"} };
	[L"hit harm"] = {iw=1; intensity = 0; range = 50; weight = 0.9; groups = {"SWING_EFFECT"; "LEECH_EFFECT"; "POISON_ONLY"} };
	[L"hit lightning"] = {iw=1; intensity = 0; range = 50; weight = 1; groups = {"SWING_EFFECT"; "LEECH_EFFECT"; "POISON_ONLY"} };
	[L"hit lower attack"] = {iw=1; intensity = 0; range = 50; weight = 1; groups = {"HLD_HLA"; "HCI_DCI_HLD_HLA"} };
	[L"hit lower defense"] = {iw=1; intensity = 0; range = 50; weight = 1; groups = {"HLD_HLA"; "HCI_DCI_HLD_HLA"} };
	[L"hit magic arrow"] = {iw=1; intensity = 0; range = 50; weight = 0.9; groups = {"SWING_EFFECT"; "POISON_ONLY"} };
	[L"velocity"] = {iw=1; intensity = 0; range = 50; weight = 1.1; groups = {"SWING_EFFECT"; "POISON_ONLY"} };

-- hit area effects
	[L"hit cold area"] = {iw=1; intensity = 0; range = 50; weight = 0.1; groups = {} };
	[L"hit energy area"] = {iw=1; intensity = 0; range = 50; weight = 0.1; groups = {} };
	[L"hit fire area"] = {iw=1; intensity = 0; range = 50; weight = 0.1; groups = {} };
	[L"hit physical area"] = {iw=1; intensity = 0; range = 50; weight = 0.1; groups = {} };
	[L"hit poison area"] = {iw=1; intensity = 0; range = 50; weight = 0.1; groups = {} };
-- combat related
	[L"damage increase"] = {iw=1; intensity = 0; range = 50; weight = 0.5; groups = {}; jewelrange = 25; func = "DI" };
	[L"defense chance increase"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"HCI_DCI"; "HCI_DCI_HLD_HLA"} };
	[L"hit chance increase"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"HCI_DCI"; "HCI_DCI_HLD_HLA"} };
	[L"swing speed increase"] = {iw=1; intensity = 0; range = 30; weight = 1; groups = {"SWING_LEECH"; "SWING_EFFECT"} };
	[L"use best weapon skill"] = {iw=1; intensity = 0; range = ""; weight = 1; groups = {} };
	[L"weapon speed"] = {iw=0; intensity = 0; range = "-5"; weight = 1; groups = {"SWING_EFFECT"; "SWING_LEECH"}; func = "WEAPON_SPEED" };
	[L"weapon damage"] = {iw=0; intensity = 0; range = ""; weight = 0; groups = {"DPS"}; func = "DPS"};

-- potions related
	[L"balanced"] = {iw=1; intensity = 0; range = ""; weight = 1; groups = {BAL_EP} };
	[L"enhance potions"] = {iw=1; intensity = 0; range = 25; weight = 1; groups = {BAL_EP} };

-- magery

	[L"faster cast recovery"] = {iw=1; intensity = 0; range = 3; weight = 1.2; groups = {"LRC_LMC_MR_FC_FCR_LUCK"; "LRC_LMC_MR"; "FC_FCR"} };
	[L"faster casting"] = {iw=1; intensity = 0; range = 1; weight = 1.2; groups = {"LRC_LMC_MR_FC_FCR_LUCK"; "LRC_LMC_MR"; "FC_FCR"; "SC_FC0"} };
	[L"lower mana cost"] = {iw=1; intensity = 0; range = 8; weight = 1; groups = {"LRC_LMC_MR_FC_FCR_LUCK"; "LRC_LMC_MR"} };
	[L"lower reagent cost"] = {iw=1; intensity = 0; range = 20; weight = 1; groups = {"LRC_LMC_MR_FC_FCR_LUCK"; "LRC_LMC_MR"} };
	[L"mage armor"] = {iw=1; intensity = 0; range = ""; weight = 1; groups = {} };
	[L"mage weapon"] = {iw=1; intensity = 0; range = "-30"; weight = 1; groups = {}; func = "MAGE_WEAPON" };
	[L"spell channeling"] = {iw=1; intensity = 0; range = ""; weight = 0.5; groups = {"SC_FC0"} };
	[L"spell damage increase"] = {iw=1; intensity = 0; range = 12; weight = 1; groups = {} };

-- other
	[L"durability"] = {iw=1; intensity = 0; range = 100; weight = 0.5; groups = {}; func = "DURABILITY"};
	[L"lower requirements"] = {iw=1; intensity = 0; range = 100; weight = 0.5; groups = {}; func = "LOWER_REQ"};
	[L"luck"] = {iw=1; intensity = 0; range = 100; bowrange = 120; weight = 1; groups = {"LRC_LMC_MR_FC_FCR_LUCK"} };
	[L"night sight"] = {iw=1; intensity = 0; range = ""; weight = 0.3; groups = {} };
	[L"reflect physical damage"] = {iw=1; intensity = 0; range = 15; weight = 0.5; groups = {} };
	[L"replenish charges"] = {iw=0; intensity = 0; range = ""; weight = 1; groups = {} };
	[L"self repair"] = {iw=0; intensity = 0; range = 5; weight = 0.8; groups = {}};
	[L"cursed"] = {iw=0; intensity = 0; range = ""; weight = -2.5; groups = {}};

-- skill bonuses (non-talisman)
	[L"anatomy +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"HEALING_ANATOMY"} };
	[L"animal lore +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"TAMING_LORE_VET"} };
	[L"animal taming +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"TAMING_LORE_VET"} };
	[L"archery +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"TACTICS_WEAPON"} };
	[L"bushido +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {} };
	[L"chivalry +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {} };
	[L"discordance +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"MUSIC_BARD"} };
	[L"evaluate intelligence +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"EVAL_MED_MAGERY"} };
	[L"fencing +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"TACTICS_WEAPON"} };
	[L"focus +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {} };
	[L"healing +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"HEALING_ANATOMY"} };
	[L"mace fighting +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"TACTICS_WEAPON"} };
	[L"magery +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"EVAL_MED_MAGERY"} };
	[L"meditation +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"EVAL_MED_MAGERY"} };
	[L"musicianship +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"MUSIC_BARD"} };
	[L"necromancy +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"NECRO_SS"} };
	[L"ninjitsu +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"NINJITSU_STEALTH"} };
	[L"parrying +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"TACTICS_WEAPON"} };
	[L"peacemaking +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"MUSIC_BARD"} };
	[L"provocation +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"MUSIC_BARD"} };
	[L"resisting spells +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {} };
	[L"spirit speak +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"NECRO_SS"} };
	[L"stealing +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {} };
	[L"stealth +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"NINJITSU_STEALTH"} };
	[L"swordsmanship +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"TACTICS_WEAPON"} };
	[L"tactics +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"TACTICS_WEAPON"} };
	[L"veterinary +"] = {iw=1; intensity = 0; range = 15; weight = 1; groups = {"TAMING_LORE_VET"} };
	[L"wrestling +"] = {iw=1; intensity = 0; range = 15; weight = 0.9; groups = {} };

--[[ skill bonuses (talisman)
	[L"blacksmithing bonus"] = {intensity = 0; range = 15; weight = 1; groups = {} };
	[L"carpentry bonus"] = {intensity = 0; range = 15; weight = 1; groups = {} };
	[L"wrestling"] = {intensity = 0; range = 15; weight = 1; groups = {} };
]]

-- slayer properties 

	[L"air elemental slayer"] = {iw=1; intensity = 0; range = ""; weight = 0.6; groups = {}};
	[L"arachnid slayer"] = {iw=1; intensity = 0; range = ""; weight = 1; groups = {} };
	[L"blood elemental slayer"] = {iw=1; intensity = 0; range = ""; weight = 1; groups = {} };
	[L"daemon slayer"] = {iw=1; intensity = 0; range = ""; weight = 1; groups = {} };
	[L"demon slayer"] = {iw=1; intensity = 0; range = ""; weight = 1; groups = {} };
	[L"dragon slayer"] = {iw=1; intensity = 0; range = ""; weight = 1; groups = {} };
	[L"earth elemental slayer"] = {iw=1; intensity = 0; range = ""; weight = 0.6; groups = {}};
	[L"elemental slayer"] = {iw=1; intensity = 0; range = ""; weight = 1; groups = {} };
	[L"fey slayer"] = {iw=1; intensity = 0; range = ""; weight = 1; groups = {} };
	[L"fire elemental slayer"] = {iw=1; intensity = 0; range = ""; weight = 0.6; groups = {}};
	[L"gargoyle slayer"] = {iw=1; intensity = 0; range = ""; weight = 0.6; groups = {}};
	[L"lizardman slayer"] = {iw=1; intensity = 0; range = ""; weight = 0.5; groups = {}};
	[L"ogre slayer"] = {iw=1; intensity = 0; range = ""; weight = 0.7; groups = {}};
	[L"ophidian slayer"] = {iw=1; intensity = 0; range = ""; weight = 0.5; groups = {}};
	[L"orc slayer"] = {iw=1; intensity = 0; range = ""; weight = 0.5; groups = {}};
	[L"poison elemental slayer"] = {iw=1; intensity = 0; range = ""; weight = 0.7; groups = {}};
	[L"repond slayer"] = {iw=1; intensity = 0; range = ""; weight = 1; groups = {} };
	[L"reptile slayer"] = {iw=1; intensity = 0; range = ""; weight = 1; groups = {} };
	[L"scorpion slayer"] = {iw=1; intensity = 0; range = ""; weight = 1; groups = {} };
	[L"snake slayer"] = {iw=1; intensity = 0; range = ""; weight = 0.6; groups = {}};
	[L"snow elemental slayer"] = {iw=1; intensity = 0; range = ""; weight = 0.5; groups = {}};
	[L"spider slayer"] = {iw=1; intensity = 0; range = ""; weight = 0.6; groups = {}};
	[L"terathan slayer"] = {iw=1; intensity = 0; range = ""; weight = 0.5; groups = {}};
	[L"troll slayer"] = {iw=1; intensity = 0; range = ""; weight = 0.5; groups = {}};
	[L"water elemental slayer"] = {iw=1; intensity = 0; range = ""; weight = 0.6; groups = {}};
	[L"undead slayer"] = {iw=1; intensity = 0; range = ""; weight = 1; groups = {} };

-- other slayers
	[L"bat slayer"] = {iw=1; intensity = 0; range = ""; weight = 0.5; groups = {}};
	[L"bear slayer"] = {iw=1; intensity = 0; range = ""; weight = 0.6; groups = {}};
	[L"beetle slayer"] = {iw=1; intensity = 0; range = ""; weight = 1; groups = {} };
	[L"bird slayer"] = {iw=1; intensity = 0; range = ""; weight = 1; groups = {} };
	[L"bovine slayer"] = {iw=1; intensity = 0; range = ""; weight = 1; groups = {} };
	[L"flame slayer"] = {iw=1; intensity = 0; range = ""; weight = 1; groups = {} };
	[L"ice slayer"] = {iw=1; intensity = 0; range = ""; weight = 1; groups = {} };
	[L"mage slayer"] = {iw=1; intensity = 0; range = ""; weight = 0.8; groups = {}};
	[L"vermin slayer"] = {iw=1; intensity = 0; range = ""; weight = 1; groups = {}}
	}

ItemPropertiesEvaluator.JewelryMods = {
	[L"damage increase"] = {iw=1; intensity = 0; range = 25; weight = 1; groups = {} };
}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

ItemPropertiesEvaluator.SettingPrefix = "ItemPropertiesSpecialTexts_"
ItemPropertiesEvaluator.UseItemPropertiesEvalatorSettingName = "UseItemPropertiesEvaluator"

function ItemPropertiesEvaluator.Initialize()
    CustomSettingsWindow.AddBooleanSetting( "ItemPropertySettings", "UseItemPropertiesEvaluator", ItemPropertiesEvaluator.UseItemPropertiesEvalatorSettingName, true )
    CustomSettingsWindow.RegisterUpdateSettingsListener( ItemPropertiesEvaluator.UpdateSettings )
end

function ItemPropertiesEvaluator.UpdateSettings()
    ItemPropertiesEvaluator.RelicIntensity = 451
    ItemPropertiesEvaluator.EssenceIntensity = 200 -- assuming home forge
    
    if ItemPropertiesEvaluator.IsGargoyle then
        ItemPropertiesEvaluator.RelicIntensity = ItemPropertiesEvaluator.RelicIntensity-20
        ItemPropertiesEvaluator.EssenceIntensity = ItemPropertiesEvaluator.EssenceIntensity - 20
    end
    
    if ItemPropertiesEvaluator.QueensForge then
        ItemPropertiesEvaluator.RelicIntensity = ItemPropertiesEvaluator.RelicIntensity-30
    elseif ItemPropertiesEvaluator.TerMurForge then
        ItemPropertiesEvaluator.RelicIntensity = ItemPropertiesEvaluator.RelicIntensity-10
    end
end

function ItemPropertiesEvaluator.parse(labelText, labelColors)
    if not CustomSettings.LoadBooleanValue( { settingName=ItemPropertiesEvaluator.UseItemPropertiesEvalatorSettingName, defaultValue=true } ) then
        return labelText, labelColors, table.getn(labelText)
    end
	local itemTitle = wstring.lower(labelText[1]) -- added by pgcd
	local propLen = table.getn(labelText)
	local intensity = 0
	local numLabels = 0
	local k, v

	ItemPropertiesEvaluator.Worth = 0
	ItemPropertiesEvaluator.Intensity = 0
	ItemPropertiesEvaluator.AdjustedIntensity = 0
	ItemPropertiesEvaluator.TotalProperties = 0
	ItemPropertiesEvaluator.CanEnhance = false
	ItemPropertiesEvaluator.ExtraInfo = L""
	ItemPropertiesEvaluator.AllProps = {}
	ItemPropertiesEvaluator.ItemType = nil
	ItemPropertiesEvaluator.ItemArmorType = nil
	ItemPropertiesEvaluator.ItemDesc = L""
	ItemPropertiesEvaluator.CurrentDurability = 255
	ItemPropertiesEvaluator.CorrectionFactor = 1
	ItemPropertiesEvaluator.IsPartOfSet = false
	ItemPropertiesEvaluator.IsExceptional = false
	ItemPropertiesEvaluator.IsImbued = false
	ItemPropertiesEvaluator.Material = nil
	for k, v in pairs(ItemPropertiesEvaluator.Groups) do
		v["total"] = 0
	end
	for k, v in pairs(ItemPropertiesEvaluator.Mods) do
		v["intensity"] = 0
		v["value"] = ""
	end
	
	ItemPropertiesEvaluator.AllProps = labelText -- added by pgcd
	ItemPropertiesEvaluator.SetItemType(itemTitle) -- added by pgcd

	for i = 1, propLen do
		labelText[i], intensity = ItemPropertiesEvaluator.evaluate(labelText[i]) -- added by pgcd
		if intensity >= 90 then -- added by pgcd
			labelColors[i] = ItemPropertiesEvaluator.HIGH_INTENSITY -- added by pgcd
		end -- added by pgcd
	end
	for k, v in pairs(ItemPropertiesEvaluator.Mods) do
		if v.iw > 0 and v.intensity > 0 then
			ItemPropertiesEvaluator.Intensity = ItemPropertiesEvaluator.Intensity + v.intensity
			ItemPropertiesEvaluator.TotalProperties = ItemPropertiesEvaluator.TotalProperties+1 
		end
	end

	if ItemPropertiesEvaluator.Worth > 0 then -- added by pgcd
		local ic = ItemPropertiesEvaluator.getIntensityColors()
		if ItemPropertiesEvaluator.ItemType ~= ItemPropertiesEvaluator.TYPE_BOD then
			table.insert(labelColors,2, ic) -- added by pgcd
			table.insert(labelText,2, ItemPropertiesEvaluator.getWorth()) -- added by pgcd
		else
			labelColors[1] = ic			
		end
	end -- added by pgcd
	table.insert(labelText, ItemPropertiesEvaluator.getExtraInfo()) -- added by pgcd
	table.insert(labelColors, ItemProperties.TITLE_COLOR) -- added by pgcd


	return labelText, labelColors, table.getn(labelText)
end

function ItemPropertiesEvaluator.evaluate(prop)
	local lprop = wstring.lower(prop)
	if lprop == L"(imbued)" then
		ItemPropertiesEvaluator.IsImbued = true
		return prop, 0
	elseif wstring.find(lprop,L"full set") then
		ItemPropertiesEvaluator.IsPartOfSet = true
		ItemPropertiesEvaluator.Worth = ItemPropertiesEvaluator.Worth + ItemPropertiesEvaluator.BonusWorthForSetItems
		return prop, 0
	elseif ItemPropertiesEvaluator.IsPartOfSet or ItemPropertiesEvaluator.ItemType == ItemPropertiesEvaluator.TYPE_SKIP then
		return prop, 0
	elseif lprop == L"exceptional" then 
		ItemPropertiesEvaluator.IsExceptional = true
		return prop, 0
	end 
	local inten = 0
	for k, v in pairs(ItemPropertiesEvaluator.Mods) do
		m_start, m_end = wstring.find(lprop, k)
		if m_start then
			v.value = wstring.sub(prop, m_end+1)
			local specialDesc = false
			if v.func then
				percentile, specialDesc = ItemPropertiesEvaluator[v.func](wstring.sub(prop, m_end+1), k)
			else
				percentile = ItemPropertiesEvaluator.calcPercentile(v, wstring.sub(prop, m_end+1))
			end
			if ItemPropertiesEvaluator.DisplayIndividualIntensities then
				if specialDesc then 
					prop = prop .. L" (" .. specialDesc .. L")"
				elseif percentile > 0 then
					prop = prop .. L" (" .. percentile .. L"%)"
				end
			end
			if percentile > 0 then v.intensity = percentile end
			inten = percentile
			ItemPropertiesEvaluator.updateWorth(v.weight, percentile)
			ItemPropertiesEvaluator.updateGroups(v.groups, percentile, k)
			break
		end
	end
	return prop, inten
end

function ItemPropertiesEvaluator.calcPercentile(v, actualValue)
	local possibleRange
	if ItemPropertiesEvaluator.ItemType == ItemPropertiesEvaluator.TYPE_JEWEL and v.jewelrange ~= nil then
		possibleRange = v.jewelrange
	elseif ItemPropertiesEvaluator.IsBow ~= nil and v.bowrange ~= nil then
		possibleRange = v.bowrange
	else 
		possibleRange = v.range
	end	
	if possibleRange ~= "" then
		return math.floor((actualValue / possibleRange) * 100)
	else
		return 100
	end
end

function ItemPropertiesEvaluator.updateWorth(weight, perc)
	if perc >= ItemPropertiesEvaluator.IntensityThreshold then
		ItemPropertiesEvaluator.Worth = ItemPropertiesEvaluator.Worth + math.ceil(weight * perc)
	end
end

function ItemPropertiesEvaluator.updateGroups(groups, perc, mod)
	if #groups < 1 then 
		return
	end
	for k, v in pairs(groups) do
		if ItemPropertiesEvaluator.Groups[v].func then
			d = ItemPropertiesEvaluator[v](perc, mod)
			if d then 
				ItemPropertiesEvaluator.Groups[v].desc = d 
			end
		else
			ItemPropertiesEvaluator.Groups[v].total = ItemPropertiesEvaluator.Groups[v].total + perc;
		end
	end
end

function ItemPropertiesEvaluator.getWorth()
	if ItemPropertiesEvaluator.ItemType == ItemPropertiesEvaluator.TYPE_BOD then
		return --"" --ItemPropertiesEvaluator.Worth
	end
	
	if ItemPropertiesEvaluator.DisplayWorth then
		for k, v in pairs(ItemPropertiesEvaluator.Groups) do
			local i = math.floor(v.total / v.range * 100) * v.weight
			if i >= ItemPropertiesEvaluator.GroupThreshold then 
				ItemPropertiesEvaluator.Worth = ItemPropertiesEvaluator.Worth + i
			end
		end
		return wstring.format(L"(Worth: %i)", ItemPropertiesEvaluator.Worth)
	else
		return ItemPropertiesEvaluator.getIntensity()
	end
	
end

function ItemPropertiesEvaluator.getIntensityColors()
	local r = ItemPropertiesEvaluator.LOW_INTENSITY
	if ItemPropertiesEvaluator.ItemType == ItemPropertiesEvaluator.TYPE_BOD then
		local rw = ItemPropertiesEvaluator.CalcBODReward()
		if rw < 100 then
			return ItemPropertiesEvaluator.LOW_INTENSITY
		else
			return ItemPropertiesEvaluator.HIGH_INTENSITY
		end
		
	end
	local enhancewith = ItemPropertiesEvaluator.SelectMaterialFromIntensity(ItemPropertiesEvaluator.Intensity)
	if enhancewith ~= nil then
		ItemPropertiesEvaluator.ExtraInfo = ItemPropertiesEvaluator.ExtraInfo .. L"\n".. enhancewith
	end


	if ItemPropertiesEvaluator.Intensity>=ItemPropertiesEvaluator.RelicIntensity or ItemPropertiesEvaluator.CanEnhance then
		r = ItemPropertiesEvaluator.HIGH_INTENSITY
	elseif ItemPropertiesEvaluator.Intensity > ItemPropertiesEvaluator.EssenceIntensity then
		r = ItemPropertiesEvaluator.MED_INTENSITY
	end
	return r
end

function ItemPropertiesEvaluator.getIntensity()
	if ItemPropertiesEvaluator.IsImbued then
		ItemPropertiesEvaluator.CorrectionFactor = 0.80
	end
	if ItemPropertiesEvaluator.CurrentDurability < 50 then
		local cf = 0.02 * (50-ItemPropertiesEvaluator.CurrentDurability)
		ItemPropertiesEvaluator.CorrectionFactor = ItemPropertiesEvaluator.CorrectionFactor - cf
		ItemPropertiesEvaluator.ExtraInfo = ItemPropertiesEvaluator.ExtraInfo .. L"\nLow Durability: -"  .. math.floor(cf * 100) .. L"%"
	end
	ItemPropertiesEvaluator.AdjustedIntensity = math.floor(ItemPropertiesEvaluator.Intensity * ItemPropertiesEvaluator.CorrectionFactor)
	if ItemPropertiesEvaluator.Intensity > 0 then
		return wstring.format(L"Intensity: %i (%i%% of %i)",ItemPropertiesEvaluator.AdjustedIntensity,ItemPropertiesEvaluator.CorrectionFactor*100,ItemPropertiesEvaluator.Intensity)
	else 
		return L""
	end		
end

function ItemPropertiesEvaluator.getExtraInfo()
	if ItemPropertiesEvaluator.DisplayGroups then
		for k, v in pairs(ItemPropertiesEvaluator.Groups) do
			local i = math.floor(v.total / v.range * 100)
			if i > 70 then
				ItemPropertiesEvaluator.ExtraInfo = ItemPropertiesEvaluator.ExtraInfo .. L"\n" .. v.desc .. L": " .. i .. L"%"
			end
		end
	end
	local inten = L""
	if ItemPropertiesEvaluator.DisplayWorth then
		inten = ItemPropertiesEvaluator.getIntensity()
		if inten ~= L"" then
			inten = L"\n"..inten
		end
	end
	return ItemPropertiesEvaluator.ExtraInfo .. inten
end


function ItemPropertiesEvaluator.SetItemType(title)
	ItemPropertiesEvaluator.ItemDesc = title
	
	if title == L"a bulk order deed" then
		ItemPropertiesEvaluator.ItemType = ItemPropertiesEvaluator.TYPE_BOD
		ItemPropertiesEvaluator.CalcBODValue()
		return
	end

	if wstring.find(title, L"soulstone") then
		ItemPropertiesEvaluator.ItemType = ItemPropertiesEvaluator.TYPE_SKIP
		return
	end

	
	for k,v in pairs(ItemPropertiesEvaluator.JewelryNames) do
		if wstring.find(title, v) then
			ItemPropertiesEvaluator.ItemType = ItemPropertiesEvaluator.TYPE_JEWEL
			return
		end
	end
	for k,v in pairs(ItemPropertiesEvaluator.ShieldNames) do
		if wstring.find(title, k) then
			ItemPropertiesEvaluator.ItemType = ItemPropertiesEvaluator.TYPE_SHIELD
			ItemPropertiesEvaluator.ItemArmorType = k
			ItemPropertiesEvaluator.Material = v.m
			return
		end
	end
	for k,v in pairs(ItemPropertiesEvaluator.HatNames) do
		if wstring.find(title, k) then
			ItemPropertiesEvaluator.ItemType = ItemPropertiesEvaluator.TYPE_HAT
			ItemPropertiesEvaluator.ItemArmorType = k
			return
		end
	end

	for k,v in pairs(ItemPropertiesEvaluator.ArmorNames) do
--		Debug.Print(L"Checking "..k)
		if wstring.find(title, k) then
--			Debug.Print("Found")
			ItemPropertiesEvaluator.ItemType = ItemPropertiesEvaluator.TYPE_ARMOR
			ItemPropertiesEvaluator.ItemArmorType = k
			ItemPropertiesEvaluator.Material = v.m
			return
		end
	end

	for k,v in pairs(ItemPropertiesEvaluator.WeaponNames) do
		if wstring.find(title, k) then
			ItemPropertiesEvaluator.ItemType = ItemPropertiesEvaluator.TYPE_WEAPON
			ItemPropertiesEvaluator.IsBow = v.isBow
			ItemPropertiesEvaluator.Material = v.m
			return
		end
	end
end

function ItemPropertiesEvaluator.SelectMaterialFromIntensity(i)
	-- argument i: intensity
	local ri = ItemPropertiesEvaluator.RelicIntensity
	local props = ItemPropertiesEvaluator.TotalProperties
	local t = ItemPropertiesEvaluator.ItemType 
	local m = ItemPropertiesEvaluator.Material
	local en = false 
	local extraprops, factor, bonus
	
	if ItemPropertiesEvaluator.IsImbued then
		i = i * 0.80
	end

	if i>=ri or m == nil or ItemPropertiesEvaluator.Enhancements[t] == nil then
		return
	end
	local mats = ItemPropertiesEvaluator.Enhancements[t][m]
	if mats == nil then
		return
	end
	-- Debug.Print(L"Props:"..props..L";props1"..props1..L";props2"..props2)

	for k,v in pairs(mats) do
		-- check properties first
		extraprops = props
		factor = 1 
		bonus = 0
		if v.p ~= nil then
			for k1, v1 in ipairs(v.p) do
				if v1 == L"dummy" or ItemPropertiesEvaluator.Mods[v1].intensity == 0 then
					extraprops = extraprops + 1	 
				end
			end
			if extraprops > 5 then
				factor = 5/extraprops
			end 
			bonus = v.b
		end
--		Debug.Print(wstring.format(L"final %.1f (q %.2f, bonus %i, factor %.2f, extraprops %i, intensity %i)",(i * factor * v.q),v.q,bonus,factor,extraprops,i))
		if (i + bonus) * factor * v.q > ri then
			ItemPropertiesEvaluator.CanEnhance = true
			return L"Enhance with: "..v.en
		end		
	end	
	
end


function ItemPropertiesEvaluator.CalcBODValue()
	local p = ItemPropertiesEvaluator.AllProps
	local quantity, quality, material, lbodtype, skill, value
	
	local propLen = table.getn(p)

	local points = {
	[L"10"] = 10; [L"15"] = 25; [L"20"] = 50; 
	[L"normal_smith"] = 0; [L"normal_tailor"] = 0; [L"exceptional_smith"] = 200; [L"exceptional_tailor"] = 100;
	[L"iron ingots"] = 0; [L"dull copper"] = 200; [L"shadow iron"] = 250; [L"copper"] = 300; [L"bronze"] = 350;
	[L"gold"] = 400; [L"agapite"] = 450; [L"verite"] = 500; [L"valorite"] = 550;
	[L"cloth"] = 0; [L"normal leather"] = 0; [L"spined leather"] = 50; [L"horned leather"] = 100; [L"barbed leather"] = 150;
	[L"small"] = 0; [L"4piece"] = 300; [L"5piece"] = 400; [L"6piece"] = 500; [L"polearm"] = 200;
	[L"ringmail"] = 200; [L"chainmail"] = 300; [L"6pieceweapon"] = 300; [L"fencing"] = 350; [L"platemail"] = 400;
	}

	quantity = wstring.gsub(p[7],L"Amount To Make: ",L"")
	material = wstring.gsub(p[5],L"All Items Must Be Made With ",L"") -- ugly as whatever but easier than
	material = wstring.lower(wstring.gsub(material,L" Ingots.",L""))
	if points[material] > 150 or material == L"iron ingots" then
		skill = L"smith"
	else
		skill = L"tailor"
	end 

	quality = wstring.lower(p[6] .. L"_" .. skill)
	
	lbodtype = L"small"
	if propLen > 8 then -- large BOD, check bonus
		if skill == L"tailor" then
			lbodtype = (propLen - 7) .. L"piece"
		elseif wstring.find(p[8],L"Platemail") then
			lbodtype = L"platemail"
		elseif wstring.find(p[8],L"Ringmail") then
			lbodtype = L"ringmail"
		elseif wstring.find(p[8],L"Chainmail") then
			lbodtype = L"chainmail"
		elseif wstring.find(p[8],L"Bardiche") then
			lbodtype = L"polearm"
		elseif wstring.find(p[8],L"Dagger") then
			lbodtype = L"fencing"			
		else
			lbodtype = L"6pieceweapon"			
		end
	end

	value = points[quality] + points[quantity] + points[material] + points[lbodtype]
	ItemPropertiesEvaluator.Worth = value
	ItemPropertiesEvaluator.BodSkill = skill
end


function ItemPropertiesEvaluator.CalcBODReward()
	local w = ItemPropertiesEvaluator.Worth
	local rw
	if ItemPropertiesEvaluator.BodSkill == L"tailor" then
		if w <= 50 then rw = L"cloth1"
		elseif w <= 100 then rw = L"cloth2"
		elseif w <= 150 then rw = L"cloth3"
		elseif w <= 200 then rw = {[L"cloth4"] = 90; [L"sandals"] = 10;}
		elseif w <= 300 then rw = {[L"cloth4"] = 80; [L"sandals"] = 20;}
		elseif w <= 350 then rw = L"hide"
		elseif w <= 400 then rw = L"spined"
		elseif w <= 450 then rw = {[L"PS105"] = 40; [L"tapestry"] = 60;} 
		elseif w <= 500 then rw = L"rug"
		elseif w <= 550 then rw = L"PS110"
		elseif w <= 575 then rw = L"CBD"
		elseif w <= 600 then rw = L"PS115"
		elseif w <= 650 then rw = L"horned"
		elseif w <= 700 then rw = L"PS120"
		else rw = L"barbed"
		end
	else
		if w <= 10 then rw = L"shovel"
		elseif w <= 25 then rw = L"pickaxe"
		elseif w <= 200 then rw = {[L"pickaxe"] = 45; [L"shovel"] = 45; [L"gloves+1"] = 10}
		elseif w <= 375 then rw = {[L"prospector"] = 40; [L"gargoyle"] = 40; [L"gloves+3"] = 20}
		elseif w <= 425 then rw = {[L"prospector"] = 40; [L"gargoyle"] = 40; [L"POF"] = 20}
		elseif w <= 475 then rw = {[L"gloves+5"] = 10; [L"POF"] = 90}
		elseif w <= 525 then rw = L"dull"
		elseif w <= 575 then rw = {[L"dull"] = 60; [L"shadow"] = 40}
		elseif w <= 610 then rw = L"shadow"
		elseif w <= 625 then rw = {[L"PS105"] = 60; [L"shadow"] = 30; [L"anvil"] = 10}
		elseif w <= 660 then rw = L"copper"
		elseif w <= 675 then rw = {[L"PS110"] = 60; [L"copper"] = 30; [L"anvil"] = 10}
		elseif w <= 725 then rw = L"bronze"
		elseif w <= 775 then rw = L"ASH10"
		elseif w <= 825 then rw = L"PS115"
		elseif w <= 875 then rw = L"ASH15"
		elseif w <= 925 then rw = L"PS120"
		elseif w <= 975 then rw = L"golden"
		elseif w <= 1025 then rw = L"ASH30"
		elseif w <= 1075 then rw = L"agapite"
		elseif w <= 1125 then rw = L"ASH60"
		elseif w <= 1175 then rw = L"verite"
		else rw = L"barbed"
		end
	end
	if type(rw) == "wstring" then
		ItemPropertiesEvaluator.ExtraInfo = ItemPropertiesEvaluator.ExtraInfo .. L"\n"..rw  
		return ItemPropertiesEvaluator.BodRewards[rw].des
	else
		local rwdes = 0
		for k,v in pairs(rw) do
			ItemPropertiesEvaluator.ExtraInfo = ItemPropertiesEvaluator.ExtraInfo .. L"\n"..k..L": "..v..L"%"
			rwdes = rwdes + (ItemPropertiesEvaluator.BodRewards[k].des * 100 / v)
		end
		return rwdes
	end
end

-------------------------------------------------------------------------------------------------
-- Groups specialized functions, no return value
-------------------------------------------------------------------------------------------------
ItemPropertiesEvaluator.POISON_ONLY = function(perc, mod)
	local m = ItemPropertiesEvaluator.Mods
	if m[L"poison damage"].intensity == 100 and m[L"hit fireball"].intensity == 0 and m[L"hit harm"].intensity == 0 and m[L"hit lightning"].intensity == 0 and m[L"hit magic arrow"].intensity == 0 and m[L"velocity"].intensity == 0 then 
		ItemPropertiesEvaluator.Groups["POISON_ONLY"].total = 100
	else
		ItemPropertiesEvaluator.Groups["POISON_ONLY"].total = 0
	end
end

ItemPropertiesEvaluator.LEECH_EFFECT = function(perc, mod)
	local m = ItemPropertiesEvaluator.Mods
	if (m[L"hit mana leech"].intensity > 50 or m[L"hit life leech"].intensity > 50 or m[L"hit stamina leech"].intensity > 50) and (m[L"hit dispel"].intensity > 0 or m[L"hit fireball"].intensity > 0 or m[L"hit harm"].intensity > 0 or m[L"hit lightning"].intensity > 0 or m[L"hit magic arrow"].intensity > 0) then
		local l = m[L"hit mana leech"].intensity + m[L"hit life leech"].intensity + m[L"hit stamina leech"].intensity
		local e = m[L"hit dispel"].intensity + m[L"hit fireball"].intensity + m[L"hit harm"].intensity + m[L"hit lightning"].intensity + m[L"hit magic arrow"].intensity + m[L"hit physical area"].intensity + m[L"hit fire area"].intensity + m[L"hit poison area"].intensity + m[L"hit cold area"].intensity + m[L"hit energy area"].intensity
		ItemPropertiesEvaluator.Groups["LEECH_EFFECT"].total = 100 + e - l
	else
		ItemPropertiesEvaluator.Groups["LEECH_EFFECT"].total = 0
	end
end

ItemPropertiesEvaluator.SC_FC0 = function(perc, mod)
	local m = ItemPropertiesEvaluator.Mods
	if mod == L"spell channeling" and perc == 100 then
		m[L"faster casting"].intensity = 100
		ItemPropertiesEvaluator.Groups["SC_FC0"].total = 100
	elseif mod == L"faster casting" and perc == -100 then
		ItemPropertiesEvaluator.Groups["SC_FC0"].total = 0
		m[L"faster casting"].intensity = 0
	end
end

ItemPropertiesEvaluator.LRC_LMC_MR_FC_FCR_LUCK = function(perc, mod)
	local m = ItemPropertiesEvaluator.Mods
	if m[L"luck"].intensity >= 80 then
		ItemPropertiesEvaluator.Groups["LRC_LMC_MR_FC_FCR_LUCK"].total = m[L"luck"].intensity + m[L"lower reagent cost"].intensity + m[L"lower mana cost"].intensity + m[L"mana regeneration"].intensity + m[L"faster casting"].intensity + m[L"faster cast recovery"].intensity
	else
		ItemPropertiesEvaluator.Groups["LRC_LMC_MR_FC_FCR_LUCK"].total = 0
	end
end

ItemPropertiesEvaluator.RESISTS = function(perc, mod)
	local m = ItemPropertiesEvaluator.Mods
	local resists = {L"physical resist"; L"fire resist"; L"cold resist"; L"poison resist"; L"energy resist"}
	local sumRes = 0
	local r
	for k, v in pairs(resists) do
		r = tonumber(m[v].value)
		-- sumRes = sumRes + (m[v].intensity / 100 * m[v].range)
		if r ~= nil then 
			sumRes = sumRes + r
		end
	end
	ItemPropertiesEvaluator.Groups.RESISTS.total = math.ceil(sumRes)
	return L"Total Resists " .. ItemPropertiesEvaluator.Groups.RESISTS.total
end

ItemPropertiesEvaluator.EXTREME_RESISTS = function(perc, mod)
	if true then -- ItemPropertiesEvaluator.ItemType ~= ItemPropertiesEvaluator.TYPE_ARMOR or ItemPropertiesEvaluator.IsExceptional ~= true then
		return
	end -- not ready for prime time yet
	local m = ItemPropertiesEvaluator.Mods
	local resists = {L"physical resist"; L"fire resist"; L"cold resist"; L"poison resist"; L"energy resist"}
	local sumRes = 0
	local r, avgRes
	for k, v in pairs(resists) do
		sumRes = sumRes + m[v].intensity
	end
	avgRes = sumRes / 5
	sumRes = 0
	for k, v in pairs(resists) do
		sumRes = sumRes + (avgRes - m[v].intensity) ^ 2
	end
	ItemPropertiesEvaluator.Groups.EXTREME_RESISTS.total = math.floor(math.sqrt(sumRes))
--	Debug.Print(L"Extreme " .. ItemPropertiesEvaluator.Groups.EXTREME_RESISTS.total)

--	ItemPropertiesEvaluator.Groups.EXTREME_RESISTS.total = ItemPropertiesEvaluator.Groups.EXTREME_RESISTS.total + (3.5 - (value - baseres))^2
	return L"Extreme Resists " .. ItemPropertiesEvaluator.Groups.EXTREME_RESISTS.total


end
-------------------------------------------------------------------------------------------------
-- Single mods specialized functions, return intensity value
-------------------------------------------------------------------------------------------------

ItemPropertiesEvaluator.MAGE_WEAPON = function(value, mod) -- returns 300 for mage weapon -0 skill
	return (30+value) * 10
end

ItemPropertiesEvaluator.DI = function(value, mod)
	if ItemPropertiesEvaluator.IsExceptional and ItemPropertiesEvaluator.ItemType == ItemPropertiesEvaluator.TYPE_WEAPON and tonumber(value) <= 40 then 
		value = 0 
	end
	return ItemPropertiesEvaluator.calcPercentile(ItemPropertiesEvaluator.Mods[L"damage increase"],value)
end

ItemPropertiesEvaluator.LEECH_RANGE = function(value, mod) -- returns actual percentile
	local speed
	local ssi = 0
	local lprop
	local range
	
	local propLen = table.getn(ItemPropertiesEvaluator.AllProps)
	for i = 1, propLen do
		lprop = wstring.lower(ItemPropertiesEvaluator.AllProps[i])
		m_start, m_end = wstring.find(lprop, L"weapon speed")
		if m_start then
			speed = wstring.sub(lprop, m_end+1)
		end
		m_start, m_end = wstring.find(lprop, L"swing speed increase")
		if m_start then
			ssi = wstring.sub(lprop, m_end+1)
		end
	end
	range = (speed * 2500) / (100 + ssi)
	if ItemPropertiesEvaluator.IsBow ~= nil then range = range / 2 end
	return math.min(math.floor(value / range * 100),100)
end

ItemPropertiesEvaluator.WEAPON_SPEED = function(value, mod) -- TODO: improve the function to account for SSI and stamina
-- assumes 4s to be the slowest useable swing speed weapon
--	if(ItemPropertiesEvaluator.Mods[L"swing speed increase"].intensity > 0) then
		local stamTicks = math.floor(WindowData.PlayerStatus.MaxStamina / 30)
		local ssi = ItemPropertiesEvaluator.Mods[L"swing speed increase"].intensity/100 * ItemPropertiesEvaluator.Mods[L"swing speed increase"].range
		local actualspeed = math.max(1.25, math.floor((value * 4 - stamTicks) * (100 / (100 + ssi)))/4)
		ItemPropertiesEvaluator.actualspeed = actualspeed
		ItemPropertiesEvaluator.ExtraInfo = ItemPropertiesEvaluator.ExtraInfo .. L"\nActual Speed: " .. actualspeed .. L"s"
		ItemPropertiesEvaluator.ExtraInfo = ItemPropertiesEvaluator.ExtraInfo .. wstring.format(L"\nDPS: %.1f",ItemPropertiesEvaluator.avgdamage/actualspeed)
--	end 
	--return 100 - math.ceil((value - 2)/2*100)
	return 0
end

ItemPropertiesEvaluator.DPS = function(value, mod) -- TODO: improve the function to account for SSI and stamina
-- assumes 4s to be the slowest useable swing speed weapon
--	if(ItemPropertiesEvaluator.Mods[L"swing speed increase"].intensity > 0) then
	local d = wstring.match(L"([^%s]+)", value)
	local di = ItemPropertiesEvaluator.Mods[L"damage increase"].value
	if di == "" then di = 0 else di = di+0 end
	local mindmg, maxdmg = wstring.sub(value,0,3)+0, wstring.sub(value,-2)+0
	local dmg = (mindmg+maxdmg)/2
	-- Account for anatomy (1), tactics (17) and strength
	local bonus = WindowData.PlayerStatus.Strength*0.3  -- strength
	if WindowData.PlayerStatus.Strength >= 100 then bonus = bonus + 5 end
	bonus = bonus + (WindowData.SkillDynamicData[1].TempSkillValue / 20 + 5) -- anatomy 
	bonus = bonus + (WindowData.SkillDynamicData[17].TempSkillValue / 16) -- tactics
	if WindowData.SkillDynamicData[17].TempSkillValue >= 1000 then bonus = bonus + 6.25 end
	bonus = bonus + di
	ItemPropertiesEvaluator.avgdamage = dmg * (1+bonus/100)
--	ItemPropertiesEvaluator.ExtraInfo = ItemPropertiesEvaluator.ExtraInfo .. L"\nDPS: " .. mindamage/ItemPropertiesEvaluator.actualspeed .. L"/" .. maxdamage/ItemPropertiesEvaluator.actualspeed	
	
	return 0
end

ItemPropertiesEvaluator.RESIST = function(value, mod)
	local d
	local lrange = 15 -- possibly needs to be changed
	local baseres = 0
	local armortype = ItemPropertiesEvaluator.ArmorNames[ItemPropertiesEvaluator.ItemArmorType] 
	local shieldtype = ItemPropertiesEvaluator.ShieldNames[ItemPropertiesEvaluator.ItemArmorType]
	local hattype = ItemPropertiesEvaluator.HatNames[ItemPropertiesEvaluator.ItemArmorType]
	if ItemPropertiesEvaluator.ItemType == ItemPropertiesEvaluator.TYPE_ARMOR and armortype ~= nil 
	then 
		baseres = armortype[mod]
	elseif ItemPropertiesEvaluator.ItemType == ItemPropertiesEvaluator.TYPE_SHIELD and shieldtype ~= nil
	then
		baseres = shieldtype[mod]
	elseif ItemPropertiesEvaluator.ItemType == ItemPropertiesEvaluator.TYPE_HAT and hattype ~= nil
	then
		baseres = hattype[mod]
	end
	if baseres == nil then baseres = 0 end
	local intensity = math.floor((value - baseres) / lrange * 100)
	local r = wstring.gsub(mod, L" resist", L"Resist")

	r =  wstring.upper(wstring.sub(mod, 1, 1)) .. wstring.sub(r, 2)
	d = wstring.format(L"%i/%i", value, WindowData.PlayerStatus[WStringToString(r)])

	if ItemPropertiesEvaluator.ShowImbuenda and ItemPropertiesEvaluator.IsExceptional then
		local delta = value-baseres
		if delta == 2 then d = L"*" 
		elseif delta == 1 then d = L"**"
		elseif delta == 0 then d = L"***"
		end
	end
	
	if ItemPropertiesEvaluator.ItemType ~= ItemPropertiesEvaluator.TYPE_ARMOR then
		d = nil
	end
		 
	-- local 
	return intensity, d
-- compare against WindowData.PlayerStatus[PhysicalResist] etc
end

ItemPropertiesEvaluator.LOWER_REQ = function(value, mod)
--	local intensity = 0
--	if ItemPropertiesEvaluator.ItemType == ItemPropertiesEvaluator.TYPE_SHIELD then
--		intensity = value +0
--	end
	--return intensity
	return value + 0
end

ItemPropertiesEvaluator.DURABILITY = function(value, mod)
	local intensity = 0
	--if ItemPropertiesEvaluator.ItemType == ItemPropertiesEvaluator.TYPE_SHIELD and
	if wstring.find(value, L"%%") 
	then
		intensity = value +0
	else
		ItemPropertiesEvaluator.CurrentDurability = value+0
	end
	return intensity
end