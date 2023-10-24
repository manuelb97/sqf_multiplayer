//{ deleteMarker _x; } forEach allMapMarkers;

//Paras
params [
"_maxPerHouse",
"_minNearBuildings",
"_radius",
"_minDist",
"_cityBuildNum",
"_debug"
];

_tag = "MarkEnemyBuildings";
_minNearBuildings = _minNearBuildings + 1;
_relevantMarkerTypes = missionNamespace getVariable ["MarkerTypes", []];

_sectors = [];

if (count _sectors < 1) then 
{
	_mapSize = worldName call BIS_fnc_mapSize;
	_mapCenter = [_mapSize/2,_mapSize/2,0];

	//cities
	_locTypes = ["NameCityCapital", "NameCity", "NameVillage", "Name"]; // , "NameLocal"
	_locs = nearestLocations [_mapCenter, _locTypes, _mapSize / 1.5, _mapCenter];
	_locs = _locs select 
	{
		_locPos = locationPosition _x;
		_locPos set [2,0];
		_nearBuilds = _locPos nearObjects ["Building", _radius];
		_nearBuilds = _nearBuilds select {count([_x] call BIS_fnc_buildingPositions) >= 0};

		count _nearBuilds >= _cityBuildNum 
		&& _locPos distance2D hq_pos >= _minDist
	};

	_locs = _locs apply 
	{
		_pos = locationPosition _x;
		_closeBuilds = _pos nearObjects ["Building", _radius];

		_ret = _pos;

		if (count _closeBuilds > 0) then 
		{
			_closeBuilds = [_closeBuilds, [], 
			{
				_building = _x;
				_closeBuildPos = [_building] call BIS_fnc_buildingPositions;
				_nearBuilds = (getPos _building) nearObjects ["Building", _radius];
				{
					_closeBuildPos append ([_x] call BIS_fnc_buildingPositions);
				} forEach _nearBuilds;
				
				count _closeBuildPos 
			}, "DESCEND"] call BIS_fnc_sortBy;
	
			_ret = getPos (_closeBuilds select 0);
		};

		_ret
	};

	_locs = _locs apply {["city", _x]};
	_sectors append _locs;
	
	[_tag, format["%1 locations found", count _locs]] spawn bia_to_log;

	//military basess
	_allBuildings = [_mapSize/2,_mapSize/2,0] nearObjects ["Building", _mapSize / 1.5];
	_milBuilds = _allBuildings select 
	{
		(
			"cargo" in (str _x)
			|| "barracks" in (str _x)
			|| "unfinished" in (str _x)
			|| "shed_ind" in (str _x)
		)
		&& !("container" in (str _x))
		&& !("slum" in (str _x))
		&& (getPos _x) distance2D hq_pos > _minDist
	};

	_milBuilds = _milBuilds select 
	{
		_nearBuilds = (getPos _x) nearObjects ["Building", _radius];
		_nearBuilds = _nearBuilds select 
		{
			count([_x] call BIS_fnc_buildingPositions) > 0
		};

		(getPos _x) distance2D ([_locs apply {_x select 1}, (getPos _x)] call BIS_fnc_nearestPosition) >= _minDist
		&& count _nearBuilds > 1
	};

	_milBuilds = [_milBuilds, [], 
	{
		_building = _x;
		_closeBuildPos = [_building] call BIS_fnc_buildingPositions;
		_nearBuilds = (getPos _building) nearObjects ["Building", _radius];
		{
			_closeBuildPos append ([_x] call BIS_fnc_buildingPositions);
		} forEach _nearBuilds;
		
		count _closeBuildPos 
	}, "DESCEND"] call BIS_fnc_sortBy;
	
	/*
	_excludeBuilds = [];
	{
		_building = _x;
		_idx = _forEachIndex;

		if (!(_building in _excludeBuilds)) then 
		{
			_closeBuildings = (getPos _building) nearObjects ["Building", 300]; //some bases big
			_followingBuilds = _milBuilds select [_idx + 1, count _milBuilds];
			_followingBuilds = _closeBuildings arrayIntersect _followingBuilds;
			_excludeBuilds append _followingBuilds;
		};
	} forEach _milBuilds;
	
	_excludeBuilds = _excludeBuilds arrayIntersect _excludeBuilds;
	_milBuilds = _milBuilds - _excludeBuilds;
	*/

	_finalMilBuilds = [];
	{
		_building = _x;
		if (_milBuilds find _building == 0) then 
		{
			_finalMilBuilds pushBack _building;
		} else 
		{
			_min = selectMin (_finalMilBuilds apply {_x distance2D _building});

			if (_min >= _minDist) then 
			{
				_finalMilBuilds pushBack _building;
			};
		};
	} forEach _milBuilds;

	_finalMilBuilds = _finalMilBuilds apply {["military", getPos _x]};
	_sectors append _finalMilBuilds;
	
	[_tag, format["%1 unmarked mil bases found", count _finalMilBuilds]] spawn bia_to_log;

	//smaller compounds
	_allBuildings = _allBuildings select 
	{
		_building = _x;
		_distances = _sectors apply {_building distance2D (_x select 1)};

		!("pier" in (str _building)) 
		&& !("lighthouse" in (str _building))
		&& count ([_building] call BIS_fnc_buildingPositions) >= _maxPerHouse
		&& count ((getPos _building) nearObjects ["Building", _radius]) >= _minNearBuildings
		&& selectMin _distances >= _minDist
	};

	[_tag, format["%1 possible Compound Buildings found", count _allBuildings]] spawn bia_to_log;
	
	//sort by building positions in compound
	_allBuildings = [_allBuildings, [], 
	{
		_closeBuildPos = [_x] call BIS_fnc_buildingPositions;
		_nearBuilds = (getPos _x) nearObjects ["Building", _radius];
		{
			_closeBuildPos append ([_x] call BIS_fnc_buildingPositions);
		} forEach _nearBuilds;
		
		count _closeBuildPos 
	}, "DESCEND"] call BIS_fnc_sortBy;
	
	//remove buildings of same compound, prio for high pos buildings
	_excludeBuilds = [];
	{
		_building = _x;
		_idx = _forEachIndex;

		if (!(_building in _excludeBuilds)) then 
		{
			_closeBuildings = (getPos _building) nearObjects ["Building", _radius];
			_followingBuilds = _allBuildings select [_idx + 1, count _allBuildings];
			_followingBuilds = _closeBuildings arrayIntersect _followingBuilds;
			_excludeBuilds append _followingBuilds;
		};

		if (count _excludeBuilds > 100000) then //probably 100 million total
		{
			_excludeBuilds = _excludeBuilds arrayIntersect _excludeBuilds;
		};
	} forEach _allBuildings;
	
	_excludeBuilds = _excludeBuilds arrayIntersect _excludeBuilds;
	_allBuildings = _allBuildings - _excludeBuilds;
	
	[_tag, format["%1 non duplicate compounds found", count _allBuildings]] spawn bia_to_log;
	
	//select only good compounds
	_enemyBuildings = [];
	_includedBuildings = [];
	{
		_building = _x;
		_nearBuildingsInitial = (getPos _building) nearObjects ["Building", _radius];
		_nearBuildings = _nearBuildingsInitial select 
		{
			count([_x] call BIS_fnc_buildingPositions) >= 1
			&& !("pier" in (str _x)) 
			&& !("lighthouse" in (str _x))
			&& !(_x in _includedBuildings)
		};

		if (count _nearBuildings >= _minNearBuildings && !(_building in _includedBuildings)) then 
		{
			_enemyBuildings pushBack _building;
	
			_includedBuildings pushBack _building;
			_includedBuildings append _nearBuildingsInitial;
		};
	} forEach _allBuildings;
	
	[_tag, format["Reduced compounds to %1", count _enemyBuildings]] spawn bia_to_log;

	//check if compounds far enough away from each other 
	_compoundCounter = 0;
	{
		_building = _x;
		_dists = _sectors apply {_building distance2D (_x select 1)};

		if (_building distance2D hq_pos >= _minDist && selectMin _dists >= _minDist) then 
		{
			_sectors pushBack ["village", getPos _building];
			_compoundCounter = _compoundCounter + 1;
		};
	} forEach _enemyBuildings;

	[_tag, format["%1 small compounds found", _compoundCounter]] spawn bia_to_log;
} else 
{
	[_tag, "Loading saved marker info"] spawn bia_to_log;
};

//remove sectors too close to rest 
_finalSectors = [];
{
	_x params ["_type", "_pos"];
	_dists = _finalSectors apply {_pos distance2D (_x select 1)};

	if (count _finalSectors < 1) then 
	{
		_finalSectors pushBack _x;
	} else 
	{
		if (selectMin _dists > _minDist) then 
		{
			_finalSectors pushBack _x;
		};
	};
} forEach _sectors;

//create markers
{
	_x params ["_type", "_pos"];

	_shape = _relevantMarkerTypes select 0; //"mil_box";
	_prefix = "village";
	switch (_type) do
	{
		case "military": 
		{
			_shape = _relevantMarkerTypes select 1; //"loc_Ruin";
			_prefix = "military"
		};
		case "city": 
		{
			_shape = _relevantMarkerTypes select 2; //"KIA";
			_prefix = "city"
		};
	};

	_marker = _prefix + "_" + (str random [11111, 55555, 99999]);
	createMarker [_marker, _pos];
	_marker setMarkerTypeLocal _shape;
	_marker setMarkerColorLocal "colorOPFOR";
	_marker setMarkerSize [1, 1];
	//_marker setMarkerDir 45;
} forEach _finalSectors;

[_tag, format["Marking %1 Buildings as Hostile", count _sectors]] spawn bia_to_log;