params [
"_resetMissionState",
"_debug"
];

_mission_f = "scripts\missions\house_raids\";

//Loadout 
{
	_loadout = format["West_%1", _x];
	[west, [_loadout, -1, -1]] call BIS_fnc_addRespawnInventory;
} forEach ["House_Raids"];

//Max Enemy Setter 
_baseMax = 10; //value for player count <2
_perPlayerAdd = 5;
[_baseMax, _perPlayerAdd, _debug] execVM "scripts\enemies\maxEnemies.sqf";

//Weather 
[600, 0, 0, false] execVM "scripts\weather\changeWeatherManager.sqf";

//Player Markers 
[5, _debug] execVM "scripts\hq\playerTrackMarkers.sqf";
// [1, false] execVM "scripts\hq\vehicleAimPos.sqf";

//Mortar
[_debug] execVM "scripts\enemies\mortarSupport.sqf";

//Night Flares
[90, _debug] execVM "scripts\enemies\nightFlares.sqf"; //cooldown, debug

//Garbage Collector
[10, 100, 180, []] execVM "scripts\garbage_collector\garbageCollector.sqf"; //"_maxObj _minDist _minDelay _excItems

//Mark enemy buildings
_maxPerHouse = 3;
_handle1 = [] execVM (_mission_f + "markEnemyBuildings.sqf");
waitUntil { scriptDone _handle1 };

//Mark cleared Buildings
_clearedPosArr = ["ClearedPosArr", []] call bia_load_from_profile;

if (_resetMissionState) then 
{
	_clearedPosArr = [];
};

_handle2 = [_clearedPosArr] execVM (_mission_f + "markClearedBuildings.sqf");
waitUntil { scriptDone _handle2 };

//Check for cleared buildings
[] execVM (_mission_f + "checkBuildingsClearedLoop.sqf");

//Mark enemy special sectors 
[12, 15] execVM (_mission_f + "mark_sectors.sqf");

//Show progress 
[] execVM (_mission_f + "showProgressLoop.sqf");

//Aggression manager 
[] execVM (_mission_f + "aggressionManager.sqf");

//Spawn Enemies 
[75, 100, _maxPerHouse, 125, 15] execVM (_mission_f + "guards.sqf"); //_minSpawnDistance _maxSpawnDistance _maxPerHouse _despawnDistance _cqbDist
[100, 200, 5, 250, 60] execVM (_mission_f + "patrols.sqf"); // _minSpawnDistance, _maxSpawnDistance, _maxWaveSize, _despawnDistance, _delay 120
// [400, 600, 1, 800, 1] execVM (_mission_f + "patrol_vehicles.sqf"); // _minSpawnDistance _maxSpawnDistance _maxVehicles _despawnDistance _delay 600

//Enemy Supports 
_enemy_f = "scripts\enemies\";
[] execVM (_enemy_f + "mortarSupport.sqf");
[180] execVM (_enemy_f + "nightFlares.sqf");

//Friendly Support 
while {!("76561198010214456" in (allPlayers apply {getPlayerUID _x}))} do 
{
	uiSleep 1;
};

[manu] remoteExec ["bia_house_raid_support", manu];