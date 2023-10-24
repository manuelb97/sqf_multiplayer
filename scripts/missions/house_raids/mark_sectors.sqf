// [12, 15] call compileFinal preprocessFileLineNumbers "scripts\missions\house_raids\mark_sectors.sqf";

params [
"_numCenters",
"_mapSizeCoef"
];

//define distance between centers abased on map size 
_mapSize = worldName call BIS_fnc_mapSize;
_distance = _mapSize / _mapSizeCoef;

//get all buildings
_allBuildings = [_mapSize/2,_mapSize/2,0] nearObjects ["House", _mapSize / 1.5];

_allBuildings = _allBuildings select {!("pier" in (str _x))};
_allBuildings = _allBuildings select {!("lighthouse" in (str _x))};

_enterableBuildings = [];
{
	_numBuildingPos = count ([_x, 1] call BIS_fnc_buildingPositions);
	if (getPos _x distance2D hq_pos > 100 && _numBuildingPos > 0) then 
	{
		_enterableBuildings pushBack _x
	};
} forEach _allBuildings;

//get building density around buildings 
_densityRadius = _distance / 2;
_densities = _enterableBuildings apply 
{
	_building = _x;
	_closeBuilds = (_enterableBuildings - [_building]) select {_x distance2D _building <= _densityRadius};
	count _closeBuilds
};

_sortedEnterableBuildings = [_enterableBuildings, [], 
{
	_idx = _enterableBuildings find (_x);
	_densities select _idx
}, "DESCEND"] call BIS_fnc_sortBy;

//determine unique density centers 
_centers = [];
_idx = 0;

while {count _centers < _numCenters} do 
{
	_building = _sortedEnterableBuildings select _idx;

	if (_idx == 0) then 
	{
		_centers pushBack _building;
	} else 
	{
		_distances = _centers apply {_x distance2D _building};

		if (selectMin _distances > _distance) then 
		{
			_centers pushBack _building;
		};
	};

	_idx = _idx + 1;
};

//mark centers 
_factionDiff = _numCenters / 3;

{
	_color = "ColorRed";

	if (_forEachIndex > (_factionDiff - 1) && _forEachIndex < _factionDiff * 2) then 
	{
		_color = "ColorBlue";
	} else 
	{
		if (_forEachIndex >= _factionDiff * 2) then  
		{
		_color = "ColorGreen";
		};
	};

	_marker = str random [11111, 55555, 99999];
	createMarker [_marker, getPos _x];
	_marker setMarkerShapeLocal "ELLIPSE";
	_marker setMarkerColorLocal _color;
	_marker setMarkerAlphaLocal 0.6;
	// _marker setMarkerBrushLocal "FDiagonal";
	_marker setMarkerSize [_densityRadius, _densityRadius];
} forEach _centers;

_text = format["%1 Sectors successfully marked", count _centers];
["SectorMarkers", _text] remoteExec ["bia_to_log", 2]; 