//Paras
params [
"_marker",
"_tier",
"_maxEnemies",
"_defVehNum",
"_radius",
"_varName",
"_debug"
];

_tag = "SpawnSectorEnemies";
_infantry = [[_tier], "Infantry", _debug] call bia_get_tier_cat;
_vehicles = [[_tier], "CombatVehicle", _debug] call bia_get_tier_cat;

//Spawn Guards
_cqbDist = 15;
_maxGuards = round(_maxEnemies * 0.3);
_guardPositions = [getMarkerPos _marker, _radius, _maxGuards, _debug] call bia_guard_positions;
[_guardPositions, _cqbDist, _infantry, _varName, _debug] spawn bia_compound_guards;

_guardNum = count _guardPositions;

//Spawn Patrols 
_numPatrols = _maxEnemies - _guardNum; // round((_maxEnemies * 0.7) + (_maxGuards - _guardNum));
_minSpawnDistance = _radius / 3;
_maxSpawnDistance = _radius;

_nearBuildings = (getMarkerPos _marker) nearObjects ["Building", _radius];
_nearBuildings = _nearBuildings select {count ([_x] call BIS_fnc_buildingPositions) > 0};
_positions = _nearBuildings apply {getPos _x}; // [getPos _x, 1, 20, objDist, waterMode, maxGrad, shoreMode, blacklistPos, defaultPos] call BIS_fnc_findSafePos

if (count _positions < 4) then 
{
	_positions = _radius;
};

[getMarkerPos _marker, _minSpawnDistance, _maxSpawnDistance, _numPatrols, _positions, _infantry, _varName, _radius, _debug] spawn bia_compound_patrols;

//Spawn Vehicles 
if (_defVehNum > 0) then 
{
	[_tag, "Spawning vehicle defenders", _debug] spawn bia_to_log;

	_defVehicles = [];
	for "_i" from 1 to _defVehNum do 
	{
		_defVehicles pushBack (selectRandom _vehicles);
	};

	[_tag, format["Def Vehicles: %1", _defVehicles], _debug] spawn bia_to_log;

	[getMarkerPos _marker, _defVehicles, _infantry, _radius * 2, _varName, _debug] spawn bia_vehicle_guards;
};