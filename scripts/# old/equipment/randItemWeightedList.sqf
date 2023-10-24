// [] call compileFinal preprocessFileLineNumbers  "scripts\Equipment\randItemWeightedList.sqf"

//Misc items
_misc = 
[
	"ACE_fieldDressing",
	"ACE_morphine",

	"HandGrenade",
	"rhs_mag_m18_green",
	"ACE_M84"
	// "B_IR_Grenade",

	// "1Rnd_HE_Grenade_shell",
	// "1Rnd_SmokeRed_Grenade_shell",
	// "UGL_FlareWhite_F",
	// "rhs_VOG25",
	// "rhs_GRD40_Red",
	// "rhs_VG40OP_white"
];

//Get weapon items 
_accs = [];
_mags = [];

_weapConfigs = (missionConfigFile >> "bia_weapon_configs") call Bis_fnc_getCfgSubClasses;
_tierWeaponArrs = getArray (missionConfigFile >> "bia_tier_configs" >> "weapons");
_tierWeapons = [];
{
	_tierArr = _x;
	{
		_tierWeapons pushBackUnique _x;
	} forEach _tierArr;
} forEach _tierWeaponArrs;
_weapConfigs = _weapConfigs arrayIntersect _tierWeapons; //only include weapons currently whitelisted

_accNames = ["optic"]; //"silencer", "laser", 
_magNames = ["mag", "secMag"];

{
	_weapClass = _x;

	{
		_accClass = _x;
		_accArr = getArray (missionConfigFile >> "bia_weapon_configs" >> _weapClass >> _accClass);

		{
			_acc = _x;
			if (_acc != "") then 
			{
				_accs pushBackUnique _acc;
			};
		} forEach _accArr;
	} forEach _accNames;
	
	{
		_magClass = _x;
		_magArr = getArray (missionConfigFile >> "bia_weapon_configs" >> _weapClass >> _magClass);

		{		
			_mag = _x;
			if (_mag != "") then 
			{
				_mags pushBackUnique _mag;
			};
		} forEach _magArr;
	} forEach _magNames;
} forEach _weapConfigs;

//Get gear items 
_gears = [];
_gearNames = ["vests", "backpacks", "headgear", "binos", "nvgs"];

{
	_gearName = _x;
	_arrOfArrs = getArray (missionConfigFile >> "bia_tier_configs" >> _gearName);
	_cutArrOfArrs = _arrOfArrs select [1, 100]; //dont select tier 5 gear already in respawn loadout

	{
		_tierArr = _x;
		{
			_gearItem = _x;

			if (_gearItem != "") then 
			{
				_gears pushBackUnique _x;
			};
		} forEach _tierArr;
	} forEach _cutArrOfArrs; 
} forEach _gearNames;

// need to add probability here since otherwise tier info lost 
// current probability approach very basic, not good enough 

_probs = [100, 33, 10];
_lists = [_misc + _mags, _gears, _accs];

_finalList = [[], []]; //items, weights
{
	_arr = _x;
	_listIdx = _forEachIndex;

	(_finalList select 0) append _x;//(_arr apply {[, ]});
	(_finalList select 1) append (_x apply {_probs select _listIdx});
} forEach _lists;

_finalList

/* 
[
	_commonItems =
	[
		//ACC
		"rhs_acc_pkas", 
		"rhsusf_acc_T1_high",
		"SMA_SFFL_BLK", 
		
		//Explosives
		"HandGrenade",
		"rhs_mag_m18_green",
		"ACE_M84",
		// "B_IR_Grenade",

		"1Rnd_HE_Grenade_shell",
		// "1Rnd_SmokeRed_Grenade_shell",
		"UGL_FlareWhite_F",
		"rhs_VOG25",
		// "rhs_GRD40_Red",
		"rhs_VG40OP_white",
		
		//AR Ammo
		"rhs_30Rnd_762x39mm_polymer",
		// "rhs_30Rnd_762x39mm_bakelite",
		// "rhs_30Rnd_762x39mm",
		"rhs_30Rnd_545x39_7N6M_AK",
		"rhs_mag_30Rnd_556x45_M855A1_Stanag"
	];

	_rareItems = 
	[
		//Misc
		// "ACE_RangeCard",
		
		//ACC
		"iansky_cmore", 
		"rhsusf_acc_compm4", 
		"rhsusf_acc_eotech_xps3",
		"rhs_acc_perst1ik_ris", 
		"rhs_acc_dtk4short", 
		"rhs_acc_dtk4long", 
		"rhsusf_acc_nt4_black",
		
		//AR Ammo
		"rhs_30Rnd_762x39mm_polymer_tracer",
		// "rhs_30Rnd_762x39mm_bakelite_tracer",
		// "rhs_30Rnd_762x39mm_tracer",
		"rhs_30Rnd_545x39_7N10_AK",
		"rhs_30Rnd_545x39_AK_plum_green",
		// "rhs_30Rnd_545x39_7U1_AK",
		"rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",
		
		//Spc Class Ammo,
		"rhs_100Rnd_762x54mmR",
		"rhs_100Rnd_762x54mmR_green",

		"rhs_10Rnd_762x54mmR_7N1",
		"rhs_10Rnd_762x54mmR_7N14",

		"ACE_10Rnd_762x51_M118LR_Mag",
		"ACE_10Rnd_762x51_M993_AP_Mag"
	];

	_uRareItems = 
	[
		//ACC
		"rhssaf_acc_G36_Rotex", 
		"SMA_supp_762",
		
		//Explosives
		"rhs_rpg7_OG7V_mag",
		"rhs_mag_maaws_HE",
		"MRAWS_HE_F",
		
		//AR Ammo
		"rhs_30Rnd_545x39_7N22_AK",
		"ACE_30Rnd_556x45_Stanag_M995_AP_mag",

		"rhs_mag_20Rnd_SCAR_762x51_m80a1_epr_bk",
		"rhs_mag_20Rnd_SCAR_762x51_m62_tracer_bk",

		//Spc Class Ammo
		"ACE_20Rnd_762x51_M118LR_Mag",
		"ACE_20Rnd_762x51_Mag_Tracer",
		"ACE_20Rnd_762x51_M993_AP_Mag",

		"rhsusf_100Rnd_762x51_m80a1epr",
		// "rhsusf_100Rnd_762x51_m62_tracer",
		// "rhsusf_100Rnd_762x51_m61_ap",

		"rhsusf_100Rnd_556x45_mixed_soft_pouch"
		// "rhsusf_100Rnd_556x45_M995_soft_pouch",
		// "rhsusf_200rnd_556x45_mixed_box",

		// "rhs_100Rnd_762x54mmR_7N13",
		// "rhs_100Rnd_762x54mmR_7N26",
	]; ]
*/

/*
	"rhs_rpg7_type69_airburst_mag",

	"rhssaf_30rnd_556x45_EPR_G36",
	"rhssaf_30rnd_556x45_Tracers_G36",
	"rhssaf_30rnd_556x45_SOST_G36",

	"rhsusf_50Rnd_762x51_m80a1epr",
	"rhsusf_50Rnd_762x51_m62_tracer",
	"rhsusf_50Rnd_762x51_m61_ap",

	"rhs_100Rnd_762x54mmR_7BZ3",
	"rhs_mag_20Rnd_762x51_m80_fnfal"

	"150Rnd_762x51_Box",
	"150Rnd_762x51_Box_Tracer",
	"150Rnd_762x54_Box"
	"150Rnd_762x54_Box_Tracer",

	"ACE_Kestrel4500"
	"ACE_ATragMX"

	"SMA_Silencer_556",
	"muzzle_snds_M",
	"muzzle_snds_B",  1

	"rhs_acc_1p63",
	"rhs_acc_pso1m21",
	
	"FHQ_optic_AIM",
	"optic_Aco",
	"optic_ACO_grn",
	"SMA_eotech552",
	"RKSL_optic_EOT552",
	"SMA_eotech",
	"rhsusf_acc_eotech_552",
	"CUP_optic_CompM2_Black",
	"FHQ_optic_MicroCCO",
	"rhsusf_acc_mrds",
	"rhsusf_acc_RX01_NoFilter",
	"rhsusf_acc_T1_low",
	"FHQ_acc_LLM01L",
	"acc_pointer_IR",

	"rhs_rpg7_PG7V_mag",
	"rhs_VG40OP_white", 1

	"rhs_mag_maaws_HEDP",
	"rhs_mag_maaws_HEAT",

	"MRAWS_HEAT55_F",
	"MRAWS_HEAT_F",

	"RPG32_HE_F",
	"RPG32_F",
	"Titan_AT",
	"Titan_AP",
*/