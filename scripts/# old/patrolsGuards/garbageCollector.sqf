//{ deleteMarker _x; } forEach allMapMarkers;

//Paras
params [
"_maxObj",
"_minDist",
"_minDelay",
"_debug"
];

_tag = "GarbageCollector";

if (_debug) then 
{
	_text = format["Loop started"];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

while {true} do
{
	if (_debug) then 
	{
		_text = format["New Cycle"];
		[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
	};
	
	//Collect dead units, vehicles and dropped weapons
	_allDead = allDead;
	_vehicles = vehicles; 
	_players = allPlayers;
	
	//Dead objs sorted by distance to respective nearest player
	_allDead = [_allDead, [], 
	{
		_obj = _x;
		_nearestPlayer = ([_players, [], {_x distance _obj}, "ASCEND"] call BIS_fnc_sortBy) select 0;
		_obj distance _nearestPlayer
	}, "DESCEND"] call BIS_fnc_sortBy;
	
	//Destroyed vehicles sorted by distance to respective nearest player
	_wrecks = _vehicles select {_dmg = getDammage _x; _dmg == 1};
	_wrecks = [_wrecks, [], 
	{
		_obj = _x;
		_nearestPlayer = ([_players, [], {_x distance _obj}, "ASCEND"] call BIS_fnc_sortBy) select 0;
		_obj distance _nearestPlayer
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
		_nearestPlayer = ([_players, [], {_x distance _obj}, "ASCEND"] call BIS_fnc_sortBy) select 0;
		_obj distance _nearestPlayer
	}, "DESCEND"] call BIS_fnc_sortBy;
	
	//Delete collected stuff
	_objsToDel = _wrecks + _droppedWeapons + _allDead;
	
	//Normal Case, respect minDist
	if (count _objsToDel < (2 * _maxObj)) then
	{
		_objsToDel = _objsToDel select 
		{
			_nearestPlayer = ([_players, [], {_x distance _x}, "ASCEND"] call BIS_fnc_sortBy) select 0;
			_x distance _nearestPlayer >= _minDist
		};
	};
	
	//Use minDist / 2
	if (count _objsToDel >= (2 * _maxObj) && count _objsToDel < (3 * _maxObj)) then
	{
		if (_debug) then 
		{
			_text = format["Deleting objs closer than minDist, current objs: %1 (limit: %2)", count _objsToDel, _maxObj];
			[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
		};
		
		_objsToDel = _objsToDel select 
		{
			_nearestPlayer = ([_players, [], {_x distance _x}, "ASCEND"] call BIS_fnc_sortBy) select 0;
			_x distance _nearestPlayer >= (_minDist / 2)
		};
	};
	
	//Disregard minDist since too many objs
	if (count _objsToDel >= (3 * _maxObj)) then
	{
		if (_debug) then 
		{
			_text = format["Deleting objs with no regard to distance, current objs: %1", count _objsToDel];
			[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
		};
	};
	
	//Resize final delete array + delete
	if (count _objsToDel > _maxObj) then
	{
		if (_debug) then 
		{
			_text = format["Deleting %1 objs", (count _objsToDel) - _maxObj];
			[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
		};
		
		_objsToDel resize ((count _objsToDel) - _maxObj);
	} else
	{
		if (_debug) then 
		{
			_text = format["Deleting no objs, limit not reached"];
			[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
		};
		
		_objsToDel resize 0;
	};
	
	{
		deleteVehicle _x;
	} forEach _objsToDel;
	
	//Delete empty groups
	{
		_grp = _x;
		
		if (count (units _grp) < 1) then
		{
			deleteGroup _grp;
		};
	} forEach allGroups;
	
	uiSleep _minDelay;
};