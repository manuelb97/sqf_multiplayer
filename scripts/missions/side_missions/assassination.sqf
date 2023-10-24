//Paras
params [
"_target", 
"_caller", 
"_arguments"
];

if (missionNamespace getVariable ["SideMissionActive", false]) exitWith 
{
	"There is already an active side mission you fucking retard" remoteExec ["hint", 0];
};

missionNamespace setVariable ["SideMissionActive", true, true];
"Preparing Side Mission (Assassination)" remoteExec ["hint", 0];

_debug = _arguments select 0;
_tag = "SideMissionAssassination";
_varName = "side_mission_opfor";
[_tag, "Started", _debug] spawn bia_to_log;

//Determine mission location
_missionLocation = [];
_radius = 50;

while {count _missionLocation < 1} do 
{
	_pos = [nil, ["water"]] call BIS_fnc_randomPos;
	_nearBuilds = _pos nearObjects ["Building", 500];

	_missionBuilding = "";
	{
		_building = _x;
		_buildPos = getPos _building;
		
		_nearestMarker = [allMapMarkers, _buildPos] call BIS_fnc_nearestPosition;

		_compoundBuilds = _buildPos nearObjects ["Building", _radius];
		_compoundBuilds = _compoundBuilds select {count([_x] call BIS_fnc_buildingPositions) > 1};

		if 
		(
			count _compoundBuilds > 2 
			&& _buildPos distance2D (getMarkerPos _nearestMarker) > 500
		) then 
		{
			_missionLocation = _buildPos;
		};

	} forEach _nearBuilds;
};

//Spawn HVT 
_inHouse = true;
_tier = [_debug] call bia_get_curr_tier;
_officerClasses = [[_tier], "Officer", _debug] call bia_get_tier_cat;
[_missionLocation, _inHouse, _officerClasses, _radius, _varName, _debug] spawn bia_spawn_hvt; //remoteExec ["bia_spawn_hvt", missionNamespace getVariable ["BiA_Host", manu], false];

while {count (allUnits select {_x getVariable ["HVT", false]}) < 1} do
{
	uiSleep 1;
};
_hvt = (allUnits select {_x getVariable ["HVT", false]}) select 0;

//Spawn Enemies 
_marker = "side_mission_" + (str random [11111, 55555, 99999]);
createMarker [_marker, _missionLocation];
[_marker, _tier, 15, 0, _radius, _varName, _debug] spawn bia_sector_enemies;

//Create Task 
_taskName = str random [11111, 55555, 99999];
[_taskName, allPlayers, ["Eliminate the Target", "Assassination", "ATTACK"], _missionLocation, "ASSIGNED", 0, true, true, "kill"] remoteExec ["BIS_fnc_setTask", 0, true];

//Change Weather 
_includeNight = true;
_includeFog = true;
_forceNight = false;
_forceFogTwilight = selectRandom[true, false];
_forceSpecialWeather = false;

[_includeNight, _includeFog, _forceNight, _forceFogTwilight, _forceSpecialWeather, 0, _debug] spawn bia_change_weather;

//Spawn Lamps 
//[_missionLocation, _radius, _debug] spawn bia_spawn_lamps;

//Start Mission Loop
_missionRunning = true;
_timeSpotted = 0;
_timeOver = 0;
_timeTillFail = 180;
_newAggro = 0;

while {_missionRunning} do 
{
	//Check if infiltration so far success
	_playerArr = allPlayers select {_x distance2D _missionLocation <= 500};
	_infoArr = [];
	{
		_player = _x;
		_infoVal = east knowsAbout _player;
		_infoArr pushBack _infoVal;
	} forEach _playerArr;
	
	//Start timer if detected
	if (selectMax _infoArr == 4 && _timeSpotted == 0) then
	{
		_timeSpotted = serverTime;
		composeText 
		[
			"You were detected", 
			lineBreak, 
			format["You got %1 Minutes until the Mission fails", round(_timeTillFail / 60)]
		] remoteExec ["hint", 0];
		
		_endTime = serverTime + _timeTillFail;
		_countdown = [_endTime, "SideMissionActive", _debug] spawn bia_countdown;
	};
	
	if (_timeSpotted != 0) then 
	{
		_timeOver = serverTime - (_timeSpotted + _timeTillFail);
	};

	//check for win
	if (!alive _hvt) then
	{
		_missionRunning = false;
		[_taskName,"SUCCEEDED", true] remoteExec ["BIS_fnc_taskSetState", 0, true];
		
		//Reduce Aggro
		_newAggro = round((missionNamespace getVariable ["Aggression", 0]) * 0.5);
	};

	//Check for loss (discovered and not killed within time window)
	if (_timeOver > 0) then 
	{
		_missionRunning = false;
		[_taskName,"FAILED", true] remoteExec ["BIS_fnc_taskSetState", 0, true];
		
		//Increase Aggro
		_newAggro = round((missionNamespace getVariable ["Aggression", 0]) * 1.1);
	};
	
	uiSleep 1;
};

missionNamespace setVariable ["SideMissionActive", false, true];
missionNamespace setVariable ["Aggression", _newAggro, true];
["Aggression", _newAggro] call bia_save_to_profile;
[_tag, "Finished", _debug] spawn bia_to_log;

_allPlayersAtBase = false;
while {!_allPlayersAtBase} do 
{
	_numPlayers = count allPlayers;
	_playersInBase = allPlayers select {_x distance2D hq_pos < 100};

	if (count _playersInBase == _numPlayers) then 
	{
		_allPlayersAtBase = true;
	};

	uiSleep 1;
};

//Delete enemies 
{
	deleteVehicle _x;
} forEach (allUnits select {_x getVariable [_varName, false]});

//Change Weather 
_includeNight = false;
_includeFog = false;
_forceNight = false;
_forceFogTwilight = false;

[_includeNight, _includeFog, _forceNight, _forceFogTwilight, _debug] spawn bia_change_weather;