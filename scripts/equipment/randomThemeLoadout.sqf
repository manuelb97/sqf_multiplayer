// [player, "Rifle"] call compileFinal preprocessFileLineNumbers "scripts\equipment\randomThemeLoadout.sqf"

//Paras
params [
"_target", 
"_player", 
"_arguments"
];

_arguments params ["_class"];

//determine kit
_classes = ["Rifle", "MG", "DMR", "Sniper"]; // 
_rifleCalsses = ["Rifle", "Grenadier", "Rifle_AT"];

if (_class == "") then 
{
	_class = selectRandom _classes;

	if (_class == "Rifle") then 
	{
		_class = selectRandom _rifleCalsses;
	};
};

_allKitConfigs = (missionConfigFile >> "bia_kit_configs") call BIS_fnc_getCfgSubClasses;
_classKits = _allKitConfigs select {getText (missionConfigFile >> "bia_kit_configs" >> _x >> "role") == _class};
_classKit = selectRandom _classKits;

//get kit info
_kitInfoNames = ["primArr", "atArr", "secArr", "vestAmmo", "backAmmo", "role"];
_kitSpecs = _kitInfoNames apply 
{
	_ret = getText (missionConfigFile >> "bia_kit_configs" >> _classKit >> _x);

	if (_x != "role") then 
	{
		_ret = parseSimpleArray (getText (missionConfigFile >> "bia_kit_configs" >> _classKit >> _x));
	};

	_ret
};
_kitSpecs params (_kitInfoNames apply {"_" + _x});

// adjust arr 
_weapArrs = [_primArr, _atArr, _secArr];
_weapArrs = _weapArrs apply 
{
	_arr = _x;
	_arr apply 
	{
		_ret = _x;
		if (_arr find _x in [4,5]) then 
		{
			if (_x == "") then 
			{
				_ret = [];
			} else 
			{
				_ret = [_x, [_x] call bia_mag_bullets];
			};
		};
		_ret
	};
};
_weapArrs params ["_primArr", "_atArr", "_secArr"];

_ammoArrs = [_vestAmmo, _backAmmo];
_ammoArrs = _ammoArrs apply 
{
	_arr = _x;
	_arr apply 
	{
		_x + [[_x select 0] call bia_mag_bullets]
	};
};
_ammoArrs params ["_vestAmmo", "_backAmmo"];

//Create loadout
_uniformItems = [["ACE_EarPlugs", 1], ["ACE_Flashlight_XL50", 1], ["ACE_fieldDressing", 15], ["ACE_morphine", 5], ["ACE_RangeCard", 1]]; // , ["ACE_personalAidKit", 1]
_vestItems = [["ACE_Kestrel4500", 1], ["ACE_ATragMX", 1], ["HandGrenade", 2, 1], ["rhs_mag_m18_green", 2, 1]] + _vestAmmo;
_backpackItems = [] + _backAmmo;

_loadout = 
[
	_primArr, 
	_atArr,
	_secArr, 
	["VSM_MulticamTropic_Camo", _uniformItems],
	["V_CarrierRigKBT_01_light_Olive_F", _vestItems], 
	["B_AssaultPack_eaf_F", _backpackItems],
	"H_HelmetHBK_headset_F", 
	"rhsusf_shemagh2_gogg_grn",
	["ACE_Vector", "", "", "", ["", 0], [], ""],
	["ItemMap", "ItemGPS", "ItemRadio", "ItemCompass", "ACE_Altimeter", "rhsusf_ANPVS_15"]
];

//Apply loadout
[_player] call bia_blank_loadout;
_player setUnitLoadout _loadout;
// [_player] call ace_weaponselect_fnc_putWeaponAway;