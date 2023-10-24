// [hq_arsenal, true] call compileFinal preprocessFileLineNumbers "scripts\equipment\loadouts\addSniperLoadouts.sqf";

//Params
params [
"_obj",
"_debug"
];

//Add top action 
_sniperLoadouts = ["BiA_SniperLoadouts", "Sniper Loadouts", "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
[_obj, 0, ["ACE_MainActions"], _sniperLoadouts] call ace_interact_menu_fnc_addActionToObject;

//Read config values 
_gearCats = 
[
	"vals", "chances", 
	"uniforms", "vests", "backpacks", "headgear", "facegear", 
	"binos", "nvgs", "launchers", "weapons",
	"arMags", "glMags", "mgMags", "dmrMags", "launcherMags", "numNades"
];
_tierGear = _gearCats apply {getArray (missionConfigFile >> "bia_tier_configs" >> _x)};
_tierGear params 
[
	"_vals", "_chances", 
	"_uniforms", "_vests", "_backpacks", "_headgear", "_facegear", 
	"_binos", "_nvgs", "_launchers", "_weapons",
	"_arMags", "_glMags", "_mgMags", "_dmrMags", "_launcherMags", "_numNades"
];

//Mags 
_primMagCount = _arMags select ((count _arMags) - 1);
_snipMagCount = _dmrMags select ((count _dmrMags) - 1);
_weapons = (missionConfigFile >> "bia_weapon_configs") call BIS_fnc_getCfgSubClasses;

_snipConfigs = _weapons select {"Sniper" in getArray(missionConfigFile >> "bia_weapon_configs" >> _x >> "role")}; // DMR
_primConfigs = _weapons select {"SniperSecondary" in getArray(missionConfigFile >> "bia_weapon_configs" >> _x >> "role")}; //, "Grenadier"

_weapInfosCats = ["silencer", "laser", "optic", "mag", "secMag", "grip"];

_snipers = _snipConfigs apply 
{
	_weap = _x;
	_retArr = _weapInfosCats apply 
	{
		selectRandom getArray (missionConfigFile >> "bia_weapon_configs" >> _weap >> _x)
	};

	_retArr set [3, [_retArr select 3, [_retArr select 3] call bia_mag_bullets]];
	_retArr set [4, [_retArr select 4, [_retArr select 4] call bia_mag_bullets]];
	_retArr = [getText(missionConfigFile >> "bia_weapon_configs" >> _weap >> "weapClass")] + _retArr;

	_retArr
};

_primaries = _primConfigs apply 
{
	_weap = _x;
	_retArr = _weapInfosCats apply 
	{
		selectRandom getArray (missionConfigFile >> "bia_weapon_configs" >> _weap >> _x)
	};

	_retArr set [3, [_retArr select 3, [_retArr select 3] call bia_mag_bullets]];
	_retArr set [4, [_retArr select 4, [_retArr select 4] call bia_mag_bullets]];
	_retArr = [getText(missionConfigFile >> "bia_weapon_configs" >> _weap >> "weapClass")] + _retArr;

	_retArr
};

// Add loadout actions for each combination of sniper and primary
{
	_snipArr = _x;
	_snipName = getText(configFile >> "CfgWeapons" >> (_snipArr select 0) >> "displayName");
	_sniperActionName = format["BiA_Sniper_%1", _snipName];

	_sniperClassAction = [_sniperActionName, _snipName, "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
	[_obj, 0, ["ACE_MainActions", "BiA_SniperLoadouts"], _sniperClassAction] call ace_interact_menu_fnc_addActionToObject;

	{
		_primArr = _x;
		_weapName = getText(configFile >> "CfgWeapons" >> (_primArr select 0) >> "displayName");

		_actionClassName = format["BiA_Sniper_%1_%2", _snipName, _weapName];
		_loadoutArs = [_primArr, _primMagCount, _snipArr, _snipMagCount, _debug];

		_sniperLoadout = [_actionClassName, _weapName, "", {_this spawn bia_sniper_loadout;}, {true}, {}, _loadoutArs] call ace_interact_menu_fnc_createAction; // 
		[_obj, 0, ["ACE_MainActions", "BiA_SniperLoadouts", _sniperActionName], _sniperLoadout] call ace_interact_menu_fnc_addActionToObject;
	} forEach _primaries;
} forEach _snipers;