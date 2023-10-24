//Paras
params [
"_type",
"_grp",
"_pos",
"_targetPos",
"_radius"
];

_tag = "GroupPatrol";

_grpPos = getPos leader _grp;
_numWPs = 4; //selectRandom [4];
_formations = ["COLUMN", "STAG COLUMN", "FILE"]; //"VEE", "DIAMOND" 
_speeds = ["LIMITED"]; //"NORMAL", "FULL"
_behaviour = "SAFE";

if (_type == "Attack") then
{
	_formations = ["LINE", "WEDGE", "ECH LEFT", "ECH RIGHT"];
	_speeds = ["FULL"];
	_behaviour = "AWARE";
};

//Create WP Arr
_wpPosArr = [];
_pos = [];
_counter = 1;

if (_type == "Vehicle") then
{
	_roads = _targetPos nearRoads (_radius * 1.5);

	while {count _wpPosArr < 4} do 
	{
		_found = false;

		if (count _roads > 0) then 
		{
			_selRoad = selectRandom _roads;
			_pos = getPos _selRoad;
			_roads deleteAt (_roads find _selRoad);
			_wpPosArr pushBack _pos;
			_found = true;
		} else 
		{
			_pos = [_targetPos, 0, _radius * _counter, 5, 0, 20, 0, [], []] call BIS_fnc_findSafePos;

			if (count _pos == 2) then //3 coordinates only on fail
			{
				_wpPosArr pushBack _pos;
				_found = true;
			};
		};
		
		if (!_found) then 
		{
			_counter = _counter + 0.1;
		};
	};
} else 
{
	while {count _wpPosArr < 4} do 
	{
		_pos = [_targetPos, 0, _radius * _counter, 0.5, 0, 20, 0, [], []] call BIS_fnc_findSafePos;

		if (count _pos == 2) then 
		{
			_wpPosArr pushBack _pos;
		} else 
		{
			_counter = _counter + 0.05;
		};
	};
};

//Add WPs
{
	_pos = _x;
	_formation = selectRandom _formations;
	_speed = selectRandom _speeds;

	if (_type == "Vehicle") then 
	{
		[_grp, _pos, 20, "MOVE", _formation, _speed, _behaviour, "YELLOW", 10, [30, 60, 90]] call bia_add_wp;
	} else 
	{
		[_grp, _pos, 10, "MOVE", _formation, _speed, _behaviour, "YELLOW", 10] call bia_add_wp;
	};
} forEach _wpPosArr;

_wps = waypoints _grp;
if (count _wps > 2) then 
{
	_cycleWP = _wps select ((count _wps) - 1);
	_cycleWP setWaypointType "CYCLE";
};

_grp setCurrentWaypoint [_grp, 1];
(units _grp) doMove (getWPPos [_grp, 1]);

if (_type == "Vehicle") then 
{
	_veh = vehicle ((units _grp) select 0);
	_veh setDir (_veh getDir (getWPPos [_grp, 1]));
};