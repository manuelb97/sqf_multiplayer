params [
"_resetMissionState",
"_debug"
];

_mission_f = "scripts\missions\pvp\";

//Max Enemy Setter 
_baseMax = 30; //value for player count <2
_perPlayerAdd = 10;
[_baseMax, _perPlayerAdd, _debug] execVM "scripts\enemies\maxEnemies.sqf";

//Show progress 
[] execVM (_mission_f + "showProgressLoop.sqf");

//
{
	_loadout = _x;
	[missionNamespace, [_loadout, -1, 1]] call BIS_fnc_addRespawnInventory;
} forEach ["Blufor1", "Blufor2", "Blufor3"];