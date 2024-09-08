//Params
params [
"_target", 
"_caller", 
"_arguments"
];

private ["_tag", "_debug", "_serverTime", "_nextDroneAvailable", "_activeDrone", "_crew", 
"_text", "_flyHeight", "_droneClass", "_spawnPos", "_drone", "_grp", "_gunner", "_wp", 
"_lasertarget", "_laserPos", "_missile", "_timeForNxtBomb"];

_tag = "Drone_Script";
_debug = _arguments select 0;
_debug = false;

// _serverTime = serverTime;
// _nextDroneAvailable = missionNamespace getVariable ["DroneNextAvailable", 0];
// _channelID = missionNamespace getVariable ["SupportChannel", 0];
// _cooldown = 600;
// _bombCD = 60;
_finalPosReached = false;
_relMarkerTypes = missionNamespace getVariable ["MarkerTypes", []];

_supp = "Overwatch";
_cd = missionNamespace getvariable [format["%1SupportCD", _supp], 300];
_lastExe = missionNamespace getvariable [format["Last%1Support", _supp], serverTime - _cd];

if (servertime >= (_lastExe + _cd)) then
{
	_lastExe = missionNamespace setvariable [format["Last%1Support", _supp], serverTime, true];

	//Wait for Input or Cancel
	openMap true;
	clicked = 0;
	mapPos = [];
	onMapSingleClick 
	{
		mapPos = _pos; 
		clicked = 1; 
		onMapSingleClick ""; 
		true;
	};

	while {!visibleMap} do
	{
		uiSleep 0.1;
	};
		
	while {clicked == 0 && visibleMap} do
	{
		uiSleep 0.1;
	};

	if (clicked == 0) exitWith {};
	openMap false;

	//Drone Spawn
	if (_debug) then 
	{
		_text = format["%1 Deleting Old Drone", _caller];
		[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
	};

	_activeDrone = false;
	private ["_veh"];
	{
		if (_x getVariable ["UAV_Active", false]) then
		{
			_activeDrone = true;
			_veh = vehicle _x;
		};
	} forEach allUnits;

	if (_activeDrone) then
	{
		_crew = crew _veh;
		{
			deleteVehicle _x;
		} forEach _crew;
		
		deleteVehicle _veh;
	};

	if (_debug) then 
	{
		_text = format["%1 Spawning Drone", _caller];
		[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
	};

	[
		"UAV Overwatch requested"
	] remoteExec ["bia_spawn_text", _caller];

	_flyHeight = 800;
	_droneClass = "B_UAV_01_F";
	_spawnPos = (mapPos getPos [random [100,150,200], random 360]) vectorAdd [0,0,_flyHeight];
	_drone = createVehicle [_droneClass, _spawnPos, [], 0, "FLY"];
	_drone setVariable ["ActiveDrone", true, true];
	_drone setPosATL _spawnPos;
	_grp = createVehicleCrew _drone;
	_grp deleteGroupWhenEmpty true;
	_gunner = gunner _drone;

	_gunner setVariable ["UAV_Active", true, true];
	_drone FlyInHeight _flyHeight;

	//Add Drone Route
	[_grp, mapPos vectorAdd [0,0,700], 10, "MOVE", "NO CHANGE", "FULL", "CARELESS", "BLUE"] call bia_add_wp;

	//Make Gunner watch AO 
	_relevantMarkers = allMapMarkers select {(getMarkerType _x) in _relMarkerTypes};
	_closestRelevantMarker = [_relevantMarkers, mapPos] call BIS_fnc_nearestPosition;
	_gunner doWatch (getMarkerPos _closestRelevantMarker);

	//Allow Drone crew to trigger sectors
	{
		_x setVariable["TriggerSectors", true, true];
	} forEach (units _grp);

	/*
	while {alive _drone} do 
	{
		_timeForNxtBomb = missionNamespace getVariable ["BombNextAvailable", 0];
		_objs = nearestObjects [getPos _drone, ["LaserTarget"], 3000, true];
		_laserTargets = _objs select {"lasertgt" in str _x};

		if (count _laserTargets > 0) then 
		{
			if (serverTime > _timeForNxtBomb) then
			{
				[
					"Target aquired, Missile Strike inbound", _x, _y, _dur, _fade, _delta, _layer, "Green"
				] remoteExec ["bia_spawn_text", _caller];
				
				_laserPos = getPosATL (_laserTargets select 0);
				uiSleep 5;
				
				_missile = createVehicle ["Bo_GBU12_LGB", _laserPos vectorAdd [0, 0, 600], [], 0, "CAN_COLLIDE"]; 
				_missile setVectorDirAndUp [[0, 0, -1], [0, 1, -1]]; 
				_missile setVelocity [0, 0, -50];
				
				missionNamespace setVariable ["BombNextAvailable", serverTime + _bombCD, true];
			} else 
			{
				[
					format["Next Missile Strike available in %1 sec.", round((missionNamespace getVariable ["BombNextAvailable", 0]) - serverTime)], 
					_x, _y, _dur, _fade, _delta, _layer, "Green"
				] remoteExec ["bia_spawn_text", _caller];
			};
		};

		if (_drone distance2D mapPos < 50 && !_finalPosReached) then 
		{
			_finalPosReached = true;
			
			[
				"UAV reached final position", _x, _y, _dur, _fade, _delta, _layer, "Green"
			] remoteExec ["bia_spawn_text", _caller];
		};

		uiSleep 5;
	};

	// Server time (time in sec since server restart)
	[
		format["Next UAV Overwatch available in %1 minutes", round(_cooldown / 60)], _x, _y, _dur, _fade, _delta, _layer, "Green"
	] remoteExec ["bia_spawn_text", _caller];

	missionNamespace setVariable ["DroneNextAvailable", serverTime + _cooldown, true];
	*/
} else
{
	[
		format["%1 Support denied, remaining Cooldown: %2", _supp, round((_lastExe + _cd) - serverTime)]
	] remoteExec ["bia_spawn_text", _caller];
};