//Paras
_tier 		= param [0,""];
_player 	= param [1,player];
_pistol 	= param [2,""];

//Mag count based on tier
_mags = 2;

//Set default values
_gun 			= "no";
_optic 		= "no";
_light 		= "no";
_silencer 	= "no";
_mag 		= "no";
_magCount	= _mags;

//Secondary Weapon
switch _pistol do {
	//Tier 1
    case "RHS_Glock": {
		_gun 		= "rhsusf_weap_glock17g4";
		_light 		= "acc_flashlight_pistol";
		_silencer	= selectRandom["rhsusf_acc_omega9k","no"];
		_mag 		= "rhsusf_mag_17Rnd_9x19_JHP";
	};
    case "BIS_FNX": {
		_gun 		= "hgun_Pistol_heavy_01_F";
		_optic 		= "optic_MRD";
		_light 		= "acc_flashlight_pistol";
		_silencer	= selectRandom["muzzle_snds_acp","no"];
		_mag 		= "11Rnd_45ACP_Mag";
	};
	//Tier 2
    case "RHS_MP443": {
		_gun 		= "rhs_weap_pya";
		_mag 		= "rhs_mag_9x19_17";
	};
    case "BIS_Custom_Covert": {
		_gun 		= "hgun_ACPC2_F";
		_light 		= "acc_flashlight_pistol";
		_silencer	= selectRandom["muzzle_snds_acp","no"];
		_mag 		= "9Rnd_45ACP_Mag";
	};
	//Tier 3
    case "RHS_M9": {
		_gun 		= "rhsusf_weap_m9";
		_mag 		= "rhsusf_mag_15Rnd_9x19_JHP";
	};
	//Tier 4
    case "RHS_M1911": {
		_gun 		= "rhsusf_weap_m1911a1";
		_mag 		= "rhsusf_mag_7x45acp_MHP";
	};
	/*
    case "RHS_6P9": {
		_gun 		= "rhs_weap_pb_6p9";
		_silencer	= selectRandom["rhs_acc_6p9_suppressor"];
		_mag 		= "rhs_mag_9x18_8_57N181S";
	};
    case "RHS_TT33": {
		_gun 		= "rhs_weap_tt33";
		_mag 		= "rhs_mag_762x25_8";
	};
    case "RHS_CZ99": {
		_gun 		= "rhs_weap_cz99";
		_mag 		= "rhssaf_mag_15Rnd_9x19_FMJ";
	};
    case "BIS_Makarov": {
		_player addWeapon "hgun_Pistol_01_F";
		_player addHandgunItem "10Rnd_9x21_Mag";
		for "_i" from 1 to 2 do {_player addItemToVest "10Rnd_9x21_Mag";};
	};
    case "RHS_PM": {
		_player addWeapon "rhs_weap_makarov_pm";
		_player addHandgunItem "rhs_mag_9x18_8_57N181S";
		for "_i" from 1 to 2 do {_player addItemToVest "rhs_mag_9x18_8_57N181S";};
	};
    case "RHS_Nambu": {
		_player addWeapon "rhs_weap_type94_new";
		_player addHandgunItem "rhs_mag_6x8mm_mhp";
		for "_i" from 1 to 2 do {_player addItemToVest "rhs_mag_6x8mm_mhp";};
	};
    case "BIS_PO7": {
		_player addWeapon "hgun_P07_blk_F";
		_player addHandgunItem "16Rnd_9x21_Mag";
		for "_i" from 1 to 2 do {_player addItemToVest "16Rnd_9x21_Mag";};
	};
    case "BIS_MP443": {
		_player addWeapon "hgun_Rook40_F";
		_player addHandgunItem "16Rnd_9x21_Mag";
		for "_i" from 1 to 2 do {_player addItemToVest "16Rnd_9x21_Mag";};
	};
    case "RHS_Nambu_17": {
		_player addWeapon "rhs_weap_type94_new";
		_player addHandgunItem "rhs_mag_9x19_17";
		for "_i" from 1 to 2 do {_player addItemToVest "rhs_mag_9x19_17";};
	};
    case "RHS_6P53": {
		_player addWeapon "rhs_weap_6p53";
		_player addHandgunItem "rhs_18rnd_9x21mm_7N28";
		for "_i" from 1 to 2 do {_player addItemToVest "rhs_18rnd_9x21mm_7N28";};
	};
	*/
};

//Add pistol + acc
_player addWeapon _gun;
if (_optic != "no") 	then { _player addHandgunItem _optic; };
if (_light != "no") 	then { _player addHandgunItem _light; };
if (_silencer != "no") 	then { _player addHandgunItem _silencer; };
if (_mag != "no") 		then { _player addHandgunItem _mag; };

//Add pistol mags
if (_player canAddItemToUniform [_mag, _magCount]) then {
	for "_i" from 1 to _magCount do {_player addItemToUniform _mag;};
} else {
	if (_player canAddItemToVest [_mag, _magCount]) then {
		for "_i" from 1 to _magCount do {_player addItemToVest _mag;};
	} else {
		if (backpack _player != "") then {
			for "_i" from 1 to _magCount do {_player addItemToBackpack _mag;};
		} else {
			_player addBackpack "dgr_pack";
			for "_i" from 1 to _magCount do {_player addItemToBackpack _mag;};
		};
	};
};

/*
//Grenades
_grenade = selectRandom ["Frag","2Frag","Smoke","2Smoke","FragSmoke"];
_grenMags = [];

switch _grenade do {
    case "Frag": {
		_grenMags = ["HandGrenade"];
	};
    case "2Frag": {
		_grenMags = ["HandGrenade","HandGrenade"];
	};
    case "Smoke": {
		_grenMags = ["rhs_mag_m18_green"];
	};
    case "2Smoke": {
		_grenMags = ["rhs_mag_m18_green","rhs_mag_m18_green"];
	};
    case "FragSmoke": {
		_grenMags = ["HandGrenade","rhs_mag_m18_green"];
	};
};

uiSleep 1;

//Add Grenades
if (_player canAddItemToUniform ["HandGrenade", count _grenMags]) then {
	{ _player addItemToUniform _x } forEach _grenMags;
} else {
	if (_player canAddItemToVest ["HandGrenade", count _grenMags]) then {
		{ _player addItemToVest _x } forEach _grenMags;
	} else {
		if (backpack _player != "") then {
			{ _player addItemToBackpack _x } forEach _grenMags;
		} else {
			_player addBackpack "dgr_pack";
			{ _player addItemToBackpack _x } forEach _grenMags;
		};
	};
};
*/