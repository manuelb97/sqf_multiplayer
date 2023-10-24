//Params
params [
"_target", 
"_caller", 
"_arguments"
];

_drones = vehicles select {_x getVariable ["ActiveDrone", false]};

_marker = "";

if (count _drones > 0) then 
{
	_drone = _drones select 0;
	_objs = nearestObjects [getPos _drone, ["LaserTarget"], 3000, true];
	_laserTargets = _objs select {"lasertgt" in str _x};

	if (count _laserTargets > 0) then 
	{
		[
			"Marker placed by Drone"
		] remoteExec ["bia_spawn_text", _caller];

		_laserTarget = _laserTargets select 0;
		_pos = getPosATL _laserTarget;

		_marker = "droneMarker_" + (str random [11111, 55555, 99999]);
		createMarker [_marker, [_pos select 0, _pos select 1, 0]];
		_marker setMarkerTypeLocal "mil_dot_noShadow";
		_marker setMarkerColorLocal "ColorRed";
		_marker setMarkerTextLocal format["%1", [dayTime, "HH:MM"] call BIS_fnc_timeToString];
		_marker setMarkerSize [0.5, 0.5];
	};
};

uiSleep 60;
deleteMarker _marker;