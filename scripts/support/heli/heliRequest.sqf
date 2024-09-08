//Params
params [
"_target", 
"_caller", 
"_arguments"
];

_arguments params ["_class", "_tex"];

_spawnPos = getPosATL heli_spawn;
_spawnedVehicles = vehicles select {_x distance2D _spawnPos < 5};
{deleteVehicle _x;} forEach _spawnedVehicles;

uiSleep 0.5;
_heli = createVehicle [_class, _spawnPos, [], 0, "NONE"];
// _heli setPosATL _spawnPos;
missionNamespace setVariable ["BiA_Heli", _heli, true];

_ret = [_heli, _tex] call BIS_fnc_initVehicle;

if (!_ret) then 
{
	"Setting Vehicle Texture failed" remoteExec ["hint", _caller];
};

_pylonInfo = getAllPylonsInfo _heli;
_pylonIdxs = _pylonInfo apply {_x select 0};
_compMagsPerPylon = (_pylonIdxs apply {_heli getCompatiblePylonMagazines _x;}) select 0;

if (_class in ["RHS_AH64D_wd"]) then 
{
	if (headgear _caller != "rhsusf_ihadss") then 
	{
		removeHeadgear _caller;
		_caller addHeadgear "rhsusf_ihadss";
	};
};

if ("Laserdesignator_mounted" in (weapons _heli)) then 
{
	_heli removeWeaponGlobal "Laserdesignator_mounted";
};

/*
if ("PylonWeapon_300Rnd_20mm_shells" in _compMagsPerPylon) then 
{
	{
		_heli removeWeaponGlobal _x;
	} forEach (weapons _heli);

	{
		_heli setPylonLoadout [_x, "PylonWeapon_300Rnd_20mm_shells"];
	} forEach _pylonIdxs;
	
	_heli setvehicleammo 1;
};

_veh = missionNamespace getVariable ["BiA_Heli", objNull];
_veh allowDamage false;
manu allowDamage false;

[[allMapMarkers, test] call BIS_fnc_nearestPosition, "Tier_3", 0, 6, 75, "test", false] spawn bia_sector_enemies;

_veh = test;
_pylonInfo = getAllPylonsInfo _veh; 
 _pylonIdxs = _pylonInfo apply {_x select 0}; 
 _compMagsPerPylon = _pylonIdxs apply {_veh getCompatiblePylonMagazines _x;};
 _compMagsPerPylon
 */