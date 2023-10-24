//Get buildings near player
_targetPos = getPos(selectRandom _playerArray);
_nearBuildings = _targetPos nearObjects ["Building", _maxSpawnDistance];
if (_debug) then 
{
	[format["Num Buildings found: %1",count _nearBuildings]] remoteExec ["hint", 0, true]; 
	uiSleep 3;
};

//Get buildings which can hold max guard amount & minDistance away from target
_nearBuildingsReduced = [];
{
	_building = _x;
	_numBuildPos = count(_building call BIS_fnc_buildingPositions);
	if (_numBuildPos >= _maxPerHouse) then 
	{
		if (_building distance _targetPos >= _minSpawnDistance) then 
		{
			_nearBuildingsReduced pushBack _building;
		};
	};
} forEach _nearBuildings;

if (_debug) then 
{
	[format["Num Buildings Reduced: %1",count _nearBuildingsReduced]] remoteExec ["hint", 0, true]; 
	uiSleep 3;
};

//Get final buildings to spawn enemies in
_allRelevantMarkers = allMapMarkers  select {_targetPos distance (getMarkerPos _x) < _maxSpawnDistance };
_enemyBuildings = [];
{
	_building = _x;
	_relevantMarkers = _allRelevantMarkers  select {_building distance (getMarkerPos _x) < 10 };
	_nearestMarker = [_relevantMarkers, _building] call BIS_fnc_nearestPosition;
	if ((markerColor _nearestMarker) == "ColorRed") then 
	{
		if ((getMarkerPos _nearestMarker) distance _building < 5) then 
		{
			_enemyBuildings pushBack _x;
		};
	};
} forEach _nearBuildings;

