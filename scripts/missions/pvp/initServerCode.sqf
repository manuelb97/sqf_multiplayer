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

//Loadout 
_classes = [
	"CQB_Specialist", "Rifleman", "Heavy_Rifleman", "Medic",
	"Grenadier", "Grenadier_Launcher", "AT", "Mine",
	"AR", "LMG", "MMG",
	"SPR", "DMR", "Sniper"
];

{
	_loadout = format["West_%1", _x];
	[west, [_loadout, -1, -1]] call BIS_fnc_addRespawnInventory;
} forEach _classes;

{
	_loadout = format["East_%1", _x];
	[east, [_loadout, -1, -1]] call BIS_fnc_addRespawnInventory;
} forEach _classes;