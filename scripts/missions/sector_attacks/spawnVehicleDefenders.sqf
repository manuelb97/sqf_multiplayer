//Paras
params [
"_missionLocation",
"_defVehicles",
"_infantry",
"_radius",
"_varName",
"_debug"
];

_tag = "VehicleDefenders";

if (_debug) then 
{
	_text = format["Vehicle Defenders Script Start"];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

if (count _defVehicles > 0) then 
{
	{
		_vehicle = _x;
		_spawnPos = [_missionLocation, _radius / 4, _radius, 5, 0, 20, 0, [[]], [_missionLocation, _missionLocation]] call BIS_fnc_findSafePos;

		_counter = 1;
		while {count _spawnPos == 3} do //is only on fail the case
		{
			_spawnPos = [_missionLocation, _radius / 4, _radius + 10 * _counter, 5, 0, 20, 0, [[]], [_missionLocation, _missionLocation]] call BIS_fnc_findSafePos;
			_counter = _counter + 1;
		};
		
		_roads = _spawnPos nearRoads (_radius / 2);
		if (count _roads > 0) then
		{
			_spawnPos = getPos (selectRandom _roads);
		};
		
		["Patrol", _spawnpos, _missionLocation, _radius, _infantry, _vehicle, "Combat", _varName, _debug] remoteExec ["bia_spawn_veh_group", missionNamespace getVariable ["BiA_Host", 2]];
		//spawn bia_spawn_veh_group; //
	} forEach _defVehicles;
};