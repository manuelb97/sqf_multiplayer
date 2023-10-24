params [
"_aoRadius",
"_zoneRadius",
"_numZones",
"_urbanZoneMinBuildings",
"_vegeZoneMinTrees",
"_minZoneDistance",
"_maxZoneDistance"
];

//find small compounds or little forrest areas as zones 
_mapSize = worldName call BIS_fnc_mapSize;
_allBuildings = [_mapSize/2, _mapSize/2, 0] nearObjects ["Building", _mapSize / 1.5];
_numIterations = 0;
_zoneCenters = [];
_zoneTypes = [];

while {count _zoneCenters < _numZones} do 
{
	_zoneCenters = [];
	_randPos = getPos (selectRandom _allBuildings);
	_closeMinBuildings = _allBuildings select {_x distance2D _building <= _zoneRadius};

	if (count _closeMinBuildings >= _urbanZoneMinBuildings) then 
	{
		_zoneCenters pushBack _randPos;
		_triedAll = false;
		_triedTypes = [];

		while {count _zoneCenters < _numZones && !_triedAll} do 
		{
			_nextZone = selectRandom ["Urban", "Vegetation"];

			if (_nextZone == "Urban") then 
			{
				_urbanZoneFound = false;
				_aoBuildings = _allBuildings select {_x distance2D _building <= _aoRadius};
				_aoBuildings = _aoBuildings - _closeMinBuildings;

				{
					if (!_urbanZoneFound) then 
					{
						_building = _x;
						_zoneDist = [_building, _zoneCenters] call bia_closest_dist;

						if (_zoneDist >= _minDistance && _zoneDist <= _maxZoneDistance) then 
						{
							_closeMinBuildings = _allBuildings select {_x distance2D _building <= _zoneRadius};

							if (count _closeMinBuildings >= _urbanZoneMinBuildings && count _zoneCenters <= _numZones) then 
							{
								_zoneCenters pushBack _randPos;
								_zoneTypes pushBack _nextZone;
								_urbanZoneFound = true;
							};
						};
					};
				} forEach _aoBuildings;

				if (!_urbanZoneFound) then 
				{
					_triedTypes pushBack "Urban";
				};
			} else 
			{
				_vegeZoneFound = false;

				_aoTrees = nearestTerrainObjects [_randPos, ["TREE"], _aoRadius, False, true];
				_aoTrees = _aoTrees - (_aoTrees select {_x distance2D _randPos <= _zoneRadius});

				{
					if (!_vegeZoneFound) then 
					{
						_tree = _x;
						_zoneTrees = _aoTrees select {_x distance2D _tree <= _zoneRadius};

						if (count _zoneTrees >= _vegeZoneMinTrees) then 
						{
							_dists = _zoneTrees apply {_x distance2D _tree};

							if (selectMax _dists >= (_zoneRadius / 3)) then 
							{
								_zoneCenters pushBack _randPos;
								_zoneTypes pushBack _nextZone;
								_vegeZoneFound = true;
							};
						};
					};
				} forEach _aoTrees;

				if (!_vegeZoneFound) then 
				{
					_triedTypes pushBack "Vegetation";
				};
			};

			if ("Urban" in _triedTypes && "Vegetation" in _triedTypes) then 
			{
				_triedAll = true;
			};
		};
	};

	_numIterations = _numIterations + 1;
};

//Debug
["ConquestLocationFinder", format["Number of iterations before AO found: %1", _numIterations]] spawn bia_to_log;
_text = format["Mission AO includes the following zone types: %1", _zoneTypes];
["ConquestLocationFinder", _text] spawn bia_to_log;

//Return
_zoneCenters