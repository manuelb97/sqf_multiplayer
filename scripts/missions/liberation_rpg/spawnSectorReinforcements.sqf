//Paras
params [
"_marker",
"_supportMarker",
"_tier",
"_maxEnemies",
"_varName",
"_debug"
];

_reinforcementTag = "Reinforcement";

_supportSpawnPos = getMarkerPos _supportMarker;

_infantry = [[_tier], "Infantry", _debug] call bia_get_tier_cat;
_combatVehicles = [[_tier], "CombatVehicle", _debug] call bia_get_tier_cat;
_transportVehicles = [[_tier], "Transport", _debug] call bia_get_tier_cat;

_numVehicles = ceil((_maxEnemies - 2) / 15); //-3 for leading combat vehicle
_supportVehicles = [selectRandom _combatVehicles];

for "_i" from 1 to _numVehicles do 
{
	_supportVehicles pushBack (selectRandom _transportVehicles);
};

_enemiesSpawned = 0;
_spawnPosArr = [];

{
	_vehicle = _x;
	_spawnPos = [_supportSpawnPos, 0, 150, 10, 0, 20, 0, _spawnPosArr, [_supportSpawnPos, _supportSpawnPos]] call BIS_fnc_findSafePos;

	_counter = 1;
	while {count _spawnPos == 3} do //is only on fail the case
	{
		_spawnPos = [_supportSpawnPos, 0, 150 + 10 * _counter, 10, 0, 20, 0, _spawnPosArr, [_supportSpawnPos, _supportSpawnPos]] call BIS_fnc_findSafePos;
		_counter = _counter + 1;
	};

	_roads = _spawnPos nearRoads 150;
	_roads = _roads apply {getPos _x};
	_roads = _roads - (_spawnPosArr apply {_x select 0});

	if (count _roads > 0) then
	{
		_spawnPos = selectRandom _roads;
	};
	_spawnPosArr pushBack [_spawnPos, 10];

	_type = "Transport";
	if (_forEachIndex == 0) then 
	{
		_type = "Combat";
	};

	["QRF", _spawnpos, getMarkerPos _marker, 150, _infantry, _vehicle, _type, _varName, _debug] remoteExec ["bia_spawn_veh_group", missionNamespace getVariable ["BiA_Host", 2]];
	//spawn bia_spawn_veh_group; //
} forEach _supportVehicles;

[_reinforcementTag, format["Spawned %1 vehicles", count _supportVehicles]] spawn bia_to_log;

//check for [0,0] spawns + WPs