params [
"_compoundRadius"
];

_mapSize = worldName call BIS_fnc_mapSize;
_allBuildings = [_mapSize/2, _mapSize/2, 0] nearObjects ["Building", _mapSize / 1.5];
_allBuildings = _allBuildings select {count ([_x] call BIS_fnc_buildingPositions) > 0};

//get buildings surrounded by other buildings 
_compoundBuildings = _allBuildings select 
{
	_building = _x;
	_closeMinBuildings = _allBuildings select {_x distance2D _building <= _compoundRadius};
	_closeMaxBuildings = _allBuildings select {_x distance2D _building <= (_compoundRadius * 1.5)};
	_compundBuilding = false;

	if (count _closeMinBuildings >= _minBuildings && count _closeMaxBuildings <= _maxBuildings) then 
	{
		_compundBuilding = true;
	};

	_compundBuilding
};

//sort compound buildings by number of buildings surrorunding 
_sortedCompoundBuildings = 
[
	_compoundBuildings, 
	[], 
	{
		_building = _x;
		_closeBuildings = _allBuildings select {_x distance2D _building <= _compoundRadius};
		count _closeBuildings
	}, 
	"DESCEND"
] call BIS_fnc_sortBy;

//unique compound centers 
_uniqueCompoundBuildings = [];

{
	_compoundBuilding = _x;

	if (_forEachIndex == 0) then 
	{
		_uniqueCompoundBuildings pushBack _compoundBuilding;
	} else 
	{
		_dists = _uniqueCompoundBuildings apply {_compoundBuilding distance2D _x};

		if (selectMin _dists > _compoundRadius) then 
		{
			_uniqueCompoundBuildings pushBack _compoundBuilding;
		};
	};
} forEach _sortedCompoundBuildings;

_selectedCompoundCenterBuilding = selectRandom _uniqueCompoundBuildings;
_missionLocation = getPos _selectedCompoundCenterBuilding;

//Debug
_text = format["Mission taking place at %1 with %2 buildings", _missionLocation, count (_allBuildings select {_missionLocation distance2D _x <= _compoundRadius})];
["PvP_Defense", _text] spawn bia_to_log;

//Return
_missionLocation