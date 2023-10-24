//{ deleteMarker _x; } forEach allMapMarkers;

_mapSize = worldName call BIS_fnc_mapSize;
_allBuildings = [_mapSize/2,_mapSize/2,0] nearObjects ["House", _mapSize / 1.5];

//remove problematic buildings
_allBuildings = _allBuildings select {!("pier" in (str _x))};
_allBuildings = _allBuildings select {!("lighthouse" in (str _x))};

// no need to exclude since script now enables clearing
//_allBuildings = _allBuildings select {!("hangar_f" in (str _x))};
//_allBuildings = _allBuildings select {!("cargo_tower" in (str _x))};
//_allBuildings = _allBuildings select {!("airport_tower" in (str _x))};

_enemyBuildings = [];
{
	_numBuildingPos = count ([_x, 1] call BIS_fnc_buildingPositions);
	if (getPos _x distance2D hq_pos > 100 && _numBuildingPos > 0) then {_enemyBuildings pushBack _x};
} forEach _allBuildings;

{
	_marker = "building_" + str random [11111, 55555, 99999];
	createMarker [_marker, getPos _x];
	_marker setMarkerTypeLocal "mil_dot";
	_marker setMarkerColorLocal "ColorRed";
	_marker setMarkerSize [0.5, 0.5];
} forEach _enemyBuildings;

_text = format["Marking %1 Buildings as Hostile", count _enemyBuildings];
["MarkEnemyBuildings", _text] remoteExec ["bia_to_log", 2]; 