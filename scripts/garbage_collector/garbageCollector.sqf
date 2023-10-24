//Paras
params [
"_maxObj",
"_minDist",
"_minDelay",
"_excItems"
];

_garbageTag = "GarbageCollector";

while {true} do
{
	_players = allPlayers;
	
	if (count _players > 0) then
	{
		//Collect dead units, vehicles and dropped weapons
		_allDead = allDead;
		_vehicles = vehicles select {_x distance2D hq_pos > 100}; 

		//Dead objs sorted by distance to respective nearest player
		_allDead = [_allDead, [], 
		{
			_obj = _x;
			_nearestPlayer = [_obj, _players] call bia_closest_obj; //([_players, [], {_x distance2D _obj}, "ASCEND"] call BIS_fnc_sortBy) select 0;
			_obj distance2D _nearestPlayer
		}, "DESCEND"] call BIS_fnc_sortBy;

		//Destroyed vehicles sorted by distance to respective nearest player
		_wrecks = _vehicles select 
		{
			(
				damage _x == 1 
				|| !(canMove _x) 
			)
			&& !("cutter" in str _x)
			&& count(crew _x) < 1
		};

		_wrecks = [_wrecks, [], 
		{
			_obj = _x;
			_nearestPlayer = [_obj, _players] call bia_closest_obj; //([_players, [], {_x distance2D _obj}, "ASCEND"] call BIS_fnc_sortBy) select 0;
			_obj distance2D _nearestPlayer
		}, "DESCEND"] call BIS_fnc_sortBy;

		//Dropped weapons sorted by distance to respective nearest player
		_droppedWeapons = [];
		{
			_veh = _x;
			
			if (typeOf _veh == "WeaponHolderSimulated") then
			{
				_droppedWeapons pushBack _veh;
			};
		} forEach _vehicles;

		_droppedWeapons = [_droppedWeapons, [], 
		{ 
			_obj = _x;
			_nearestPlayer = [_obj, _players] call bia_closest_obj; //([_players, [], {_x distance2D _obj}, "ASCEND"] call BIS_fnc_sortBy) select 0;
			_obj distance2D _nearestPlayer
		}, "DESCEND"] call BIS_fnc_sortBy;

		//Delete stuff
		_objsToDel = _allDead + _wrecks + _droppedWeapons;
		_objsToDel = _objsToDel select 
		{
			_ret = true;
			_obj = _x;

			{
				_excItem = _x;
				if (_excItem in (str _obj)) then 
				{
					_ret = false;
				};
			} forEach _excItems;

			_ret
		};

		{
			_obj = _x;
			_nearestPlayer = [_obj, _players] call bia_closest_obj; //([_players, [], {_obj distance2D _x}, "ASCEND"] call BIS_fnc_sortBy) select 0;
			if (_obj distance2D _nearestPlayer >= _minDist) then
			{
				deleteVehicle _x;
			};
		} forEach _objsToDel;

		//Delete bodies if count exceeds limit disregarding distances
		if (count _allDead > _maxObj) then
		{
			_numDel = (count _allDead) - _maxObj;
			_toDel = _allDead select [0, _numDel];
			{
				deleteVehicle _x;
			} forEach _toDel;
		};

		//Delete empty groups
		{
			_grp = _x;
			
			if (count (units _grp) < 1) then
			{
				deleteGroup _grp;
			};
		} forEach allGroups;
	};
	
	//Pause execution
	uiSleep _minDelay;
};