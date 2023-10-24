//Paras
params [
"_target", 
"_caller", 
"_actionId", 
"_arguments"
];

_box = _arguments select 0;

//Remove current Loadouts
{
	if (_x != _actionId) then
	{
		_box removeAction _x;
	};
} forEach actionIDs _box;
uiSleep 0.1;

//Define weapons
_weapons = [false] call compile preprocessFileLineNumbers "scripts\patrolsGuards\HQ\patrolLoadoutWeaponSel.sqf";

//Add Loadout Action Locally
[_box, _weapons] remoteExec ["bia_loadouts", 0, true];