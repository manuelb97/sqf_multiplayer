//Paras
params [
"_resetMissionState",
"_debug"
];

_mission_f = "scripts\missions\sector_attacks\";

if (_resetMissionState) then
{
	["ClearedPosArr", []] call bia_save_to_profile;
	["Aggression", 0] call bia_save_to_profile;
	["initServerCode", "Resetting Mission Progress"] spawn bia_to_log;
};

//Mission important marker types 
missionNamespace setVariable ["MarkerTypes", ["mil_box", "loc_Ruin", "KIA"], true];

//Mark enemy buildings
_maxPerHouse = 3;
_minNearBuildings = 5;
_radius = 100;
_minDist = 300;
_cityBuildNum = 20;
_handle = [_maxPerHouse, _minNearBuildings, _radius, _minDist, _cityBuildNum, _debug] execVM (_mission_f + "markHostileSectors.sqf");
waitUntil { scriptDone _handle };

//Mark cleared Buildings
_clearedPosArr = ["ClearedPosArr", []] call bia_load_from_profile;
_handle = [_clearedPosArr] execVM (_mission_f + "markFriendlySectors.sqf");
waitUntil { scriptDone _handle };

//Show Progress
[false] execVM (_mission_f + "showProgressLoop.sqf");

//Aggression Manager 
_startVal = ["Aggression", 0] call bia_load_from_profile;
missionNamespace setVariable ["Aggression", _startVal, true];
[_debug] execVM (_mission_f + "aggressionManager.sqf");

//Auto activate sectors 
[800, [50,100,150], 20, 60, _debug] execVM (_mission_f + "autoActivateSectors.sqf");

//Counter Attack Loop 
// [10, 1200, 2700, 60, _debug] execVM (_mission_f + "counterAttackLoop.sqf"); // 1800
//_minAggro", _minStartTime", _minBreakTime", _hqChance", _debug"

/*
//Enemy patrols 
_infantry = [["Tier_4"], "Infantry", _debug] call bia_get_tier_cat;
[250, 350, 3, 400, 60, _infantry, _debug] execVM (_mission_f + "patrols.sqf"); //120
//_minSpawnDistance, _maxSpawnDistance,_maxEnemiesPerPlayer, _despawnDistance, _delay, _unitArray,_debug

//Enemy House Guards
_riflemen = [["Tier_4"], "RifleClasses", _debug] call bia_get_tier_cat;
[50, 100, 2, 3, 125, 15, 0.5, _riflemen, _debug] execVM (_mission_f + "guards.sqf");
// _minSpawnDistance _maxSpawnDistance _guardsPerPlayer _maxPerHouse _despawnDistance _cqbDist _chanceToLeaveBuilding _unitArray _debug
*/