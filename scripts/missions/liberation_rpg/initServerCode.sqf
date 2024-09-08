//Paras
params [
"_resetMissionState",
"_debug"
];

_mission_f = "scripts\missions\liberation_rpg\";

if (_resetMissionState) then
{
	["ClearedPosArr", []] call bia_save_to_profile;
	["initServerCode", "Resetting Mission Progress"] spawn bia_to_log;
};

//Mission important marker types 
missionNamespace setVariable ["MarkerTypes", ["loc_Ruin", "KIA"], true];

//Mark enemy sites
_minNearBuildings = 5;
_radius = 100;
_minDist = 300;
_handle = [_minNearBuildings, _radius, _minDist, _debug] execVM (_mission_f + "markOccupied.sqf");
waitUntil { scriptDone _handle };

//Mark cleared sites
_clearedPosArr = ["ClearedPosArr", []] call bia_load_from_profile;
_handle = [_clearedPosArr] execVM (_mission_f + "markCleared.sqf");
waitUntil { scriptDone _handle };

//Enemy patrols 
[250, 350, 3, 400, 60] execVM (_mission_f + "patrols.sqf"); //120
//_minSpawnDistance, _maxSpawnDistance,_maxEnemiesPerPlayer, _despawnDistance, _delay, _unitArray,_debug

//Show Progress
[false] execVM (_mission_f + "showProgressLoop.sqf");

/*
//Auto enemy bases
[800, [50,100,150], 20, 60, _debug] execVM (_mission_f + "autoActivateSectors.sqf");

//Enemy House Guards
_riflemen = [["Tier_4"], "RifleClasses", _debug] call bia_get_tier_cat;
[50, 100, 2, 3, 125, 15, 0.5, _riflemen, _debug] execVM (_mission_f + "guards.sqf");
// _minSpawnDistance _maxSpawnDistance _guardsPerPlayer _maxPerHouse _despawnDistance _cqbDist _chanceToLeaveBuilding _unitArray _debug