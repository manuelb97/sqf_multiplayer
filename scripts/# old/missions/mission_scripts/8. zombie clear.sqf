//Paras
params [
"_missionLocation",
"_missionMarkers",
["_radius",100],
["_countdownMin",20],
"_tier"
];

_players = allPlayers;
_host = selectRandom _players;
if (count _players > 1) then {
	_players = _players - [manu];
	_host = selectRandom _players;
};

//Spawn zombies
[_missionLocation, _radius,_tier] remoteExec ["bia_spawn_zombies", _host, true];

//Create Task
_bia_taskName = str random [11111, 55555, 99999];
_players = if (isMultiplayer) then {playableUnits} else {[player]};
[_bia_taskName, _players, ["Defend the sector from the zombie hordes", "Zombie Defence", "DEFEND"], _missionLocation, "ASSIGNED", 0, true, true, "defend"] remoteExec ["BIS_fnc_setTask", 0, true];

//Give flashlights to players
remoteExec ["bia_player_flashlights", 0, true];

//Disable Flare_Trigger
[Flare_Trigger, ["this","", ""]] remoteExec ["setTriggerStatements", 0, true];

//Start Countdown
_CountDown = [_countdownMin * 60] call BIS_fnc_countDown;
[format ["Eliminate all zombies within the next %1 Minutes", _countdownMin]] remoteExec ["hint", 0, true];
_countdownCounter = 1;

//Switch Lamps
_lamps = _missionLocation nearObjects _radius;
_lamps = _lamps select {"lamp" in (str _x)};
{
	if (lightIsOn _x == "ON") then {
		[_x,"OFF"] remoteExec ["switchLight",0, true];
	};
} forEach _lamps;

//Mission Loop
_missionLoop 		= 1;
_countdown_set 	= false;
_playersEnteredZone = false;
while {_missionLoop == 1} do 
{
	//Give Countdown Info
	_timeLeft = [0] call BIS_fnc_countdown;
	if (_timeLeft <= (_countdownMin * 60 - 120 *_countdownCounter)) then {
		[format["%1 Minutes left", round(_timeLeft / 60)]] remoteExec ["hintSilent", 0, true];
		_countdownCounter = _countdownCounter + 1;
	};
	
	//Check Current Mission State
	_objOpforLoop = [];
	{if ((side _x) == east && _x distance _missionLocation < (_radius + 3000)) then {_objOpforLoop pushBack _x}} forEach allUnits;
	_newEnemyObjCount = count _objOpforLoop;
	//[format ["Number of zombies: %1", _newEnemyObjCount]] remoteExec ["hint", 0, true];uiSleep 3;
	_objBluforLoop = [];
	{if ((side _x) == west && ((getPos _x) distance _missionLocation) < _radius) then {_objBluforLoop pushBack _x}} forEach allUnits;
	_FriendlyObjCount = count _objBluforLoop;
	//hint format["Players in Zone: %1",_FriendlyObjCount];
	
	//check for win
	if (_newEnemyObjCount == 0 && _FriendlyObjCount != 0 && _timeLeft != 0) then
	{
		_missionLoop = 0;
		[_bia_taskName,"SUCCEEDED", true] remoteExec ["BIS_fnc_taskSetState", 0, true];

		//Add mission pos to database
		[[_missionLocation],"scripts\writeToDatabase.sqf"] remoteExecCall ["execVM", 2, false];

		//Delete markers
		{ deleteMarker _x; } forEach _missionMarkers;
	};
	
	//check for loss
	if (_FriendlyObjCount > 0 && !_playersEnteredZone) then {_playersEnteredZone = true;};
	if (_playersEnteredZone) then {
		if ((_newEnemyObjCount != 0 && _timeLeft == 0) || _FriendlyObjCount == 0) then
		{
			_missionLoop = 0;
			[_bia_taskName,"FAILED", true] remoteExec ["BIS_fnc_taskSetState", 0, true];
		};
	};
	
	//Check if flashlights have to be equipped
	remoteExec ["bia_player_flashlights", 0, true];
	
	uiSleep 5;
};

//Remove old loadouts
[[],"scripts\missions\reward.sqf"] remoteExec ["execVM", 0, true];

//Teleport back to base
"You are being teleported back to HQ" remoteExec ["hintSilent", 0, true];
uiSleep 3;
{ 
	if (_x distance hq_pos > 1000) then {
		_x setPosATL (getPosATL hq_pos); 
	};
} forEach allPlayers;

//Delete enemies
_opfor = [];
{if ((side _x) == east) then {_opfor pushBack _x}} forEach allUnits;
{deleteVehicle _x;} forEach _opfor;

//Reset Flare Trigger
[Flare_Trigger, ["this","if (daytime < 6 or daytime > 19) then { _players = thisList; _playerPos = (selectRandom _players) getPos [random [50, 100, 150],random 360];
					[[_playerPos, (selectRandom ['ACE_40mm_Flare_green','ACE_40mm_Flare_red']), 0, 2, 60, nil, 0, 150, 1, []], 'BIS_fnc_fireSupportVirtual', true, true] call BIS_fnc_MP; };", ""]
] remoteExec ["setTriggerStatements", 0, true];