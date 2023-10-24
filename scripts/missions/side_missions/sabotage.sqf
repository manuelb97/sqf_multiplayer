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
"Preparing Side Mission (Sabotage)" remoteExec ["hint", 0];

_debug = _arguments select 0;
_tag = "SideMissionSabotage";
_varName = "side_mission_opfor";
[_tag, "Started", _debug] spawn bia_to_log;

//Determine mission location
_missionLocation = [];
_radius = 50;
_terrainObjs = ["TREE", "SMALL TREE", "FOREST BORDER", "FOREST TRIANGLE", "FOREST SQUARE", "FOREST"];

while {count _missionLocation < 1} do 
{
	_pos = [nil, ["water"]] call BIS_fnc_randomPos;
	_nearTerrain = nearestTerrainObjects [_pos, _terrainObjs, _radius, false, true];
	_nearestMarker = [allMapMarkers, _pos] call BIS_fnc_nearestPosition;

	if (count _nearTerrain > 20 && _pos distance2D (getMarkerPos _nearestMarker) > 500) then 
	{
		_missionLocation = _pos;
	};

	//[_tag, format["Terrain Objects found for %1: %2", _pos, count _nearTerrain], _debug] spawn bia_to_log;
};

//Spawn Sabotage Object 
[_missionLocation, _radius, _debug] spawn bia_spawn_sab_obj; //remoteExec ["bia_spawn_sab_obj", missionNamespace getVariable ["BiA_Host", manu], false];

while {count ((_missionLocation nearObjects ["House", _radius]) select {_x getVariable ["Sabotage", false]}) < 1} do
{
	uiSleep 1;
};
_hvt = ((_missionLocation nearObjects ["House", _radius]) select {_x getVariable ["Sabotage", false]}) select 0;

//Spawn Enemies 
_marker = "side_mission_" + (str random [11111, 55555, 99999]);
createMarker [_marker, _missionLocation];
_tier = [_debug] call bia_get_curr_tier;
[_marker, _tier, 15, 0, _radius, _varName, _debug] spawn bia_sector_enemies;

//Create Task 
_taskName = str random [11111, 55555, 99999];
[_taskName, allPlayers, ["Sabotage the Enemy Communication Asset", "Sabotage Mission", "ATTACK"], _missionLocation, "ASSIGNED", 0, true, true, "destroy"] remoteExec ["BIS_fnc_setTask", 0, true];

"Do not forget the C4 you retards" remoteExec ["hint", 0];

//Change Weather 
_includeNight = true;
_includeFog = true;
_forceNight = false;
_forceFogTwilight = false;
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
_forceSpecialWeather = false;

[_includeNight, _includeFog, _forceNight, _forceFogTwilight, _forceSpecialWeather, 0, _debug] spawn bia_change_weather;