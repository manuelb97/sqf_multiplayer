// [5, 100, 300] call compileFinal preprocessFileLineNumbers "scripts\missions\liberation_rpg\markOccupied.sqf";

//Paras
params [
"_minNearBuildings",
"_radius",
"_minDist",
"_debug"
];

{ deleteMarker _x } forEach allMapMarkers;

_tag = "MarkEnemyBuildings";
_relevantMarkerTypes = missionNamespace getVariable ["MarkerTypes", []];

_zoneSize = 4000;
_sectors = [];

if (count _sectors < 1) then 
{
	_mapSize = worldName call BIS_fnc_mapSize;
	_mapCenter = [_mapSize / 2, _mapSize / 2, 0];
	_locs = [];

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
_createdMarkers = [];
{
	_x params ["_type", "_pos"];
	_shape = "loc_Ruin";
	_prefix = "military";
	_marker = _prefix + "_" + (str random [11111, 55555, 99999]);
	createMarker [_marker, _pos];
	_marker setMarkerTypeLocal _shape;
	_marker setMarkerColorLocal "colorOPFOR";
	_marker setMarkerSize [1, 1];
	//_marker setMarkerDir 45;
	_createdMarkers pushBack _marker;
} forEach _finalSectors;

[_tag, format["%1", str _finalSectors]] spawn bia_to_log;
[_tag, format["Marking %1 Buildings as Hostile", count _sectors]] spawn bia_to_log;

while {count _createdMarkers < count _finalSectors} do 
{
	uiSleep 1;
};

//sort markers by most nearby markers
_debugMarker = [];
_finalSectors = [_finalSectors, [], 
{
	_x params ["_type", "_pos"];
	_nearMarkers = _createdMarkers select 
	{
		getMarkerPos _x distance2D _pos <= (_zoneSize / 2)
	};
	_debugMarker pushBack (count _nearMarkers);
	count _nearMarkers 
}, "DESCEND"] call BIS_fnc_sortBy;

[_tag, format["%1", str _debugMarker]] spawn bia_to_log;

//go through list descending, once 1 used, only use ones far enough away
_zoneInfos = [
	["SF", "colorOPFOR"]
	, ["Army", "colorBLUFOR"]
	, ["Milita", "ColorGreen"]
	// , ["Bandit", "ColorGreen"]
];

_positionsUsed = [];
{
	_x params ["_txt", "_color"];

	if (count _positionsUsed == 0) then 
	{
		_positionsUsed pushBack (_finalSectors select 0 select 1);
		_finalSectors deleteAt 0;
	} else 
	{
		{
			_x params ["_type", "_pos"];
			_idx = _forEachIndex;
			_closeToUsed = 0;
			{
				_usedPos = _x;
				[_tag, format["%1 %2 %3", _pos, _usedPos, _positionsUsed]] spawn bia_to_log;
				if (_pos distance2D _usedPos <= _zoneSize) then 
				{
					_closeToUsed = _closeToUsed + 1;
				};
			} forEach _positionsUsed;

			if (_closeToUsed < 1) then 
			{
				_positionsUsed pushBack _pos;
				_finalSectors deleteAt _idx;
				break;
			};
		} forEach _finalSectors;
	};

	_marker = "zone" + "_" + _txt + "_" + (str random [11111, 55555, 99999]);
	_pos = _positionsUsed select _forEachIndex;
	createMarker [_marker, _pos];
	_marker setMarkerShapeLocal "ELLIPSE";
	_marker setMarkerColorLocal _color;
	_marker setMarkerAlphaLocal 0.25;
	_marker setMarkerSize [_zoneSize / 2, _zoneSize / 2];

	_nearMarkers = _createdMarkers select 
	{
		getMarkerPos _x distance2D (_pos) <= (_zoneSize / 2)
	};

	[_tag, format["%1 zone (%2), number of near markers: %3", _txt, _pos, count _nearMarkers]] spawn bia_to_log;
} forEach _zoneInfos;