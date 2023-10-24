//Paras
params [
"_missionLocation",
"_missionMarkers",
["_mobileEnemies",14],
["_cqbEnemies",6],
["_radius",100],
["_reinforcements_max",2],
"_defVehicles",
["_mortar",0],
["_mortarPatrols",1],
["_suicideBomber",0],
["_suicideBomberNum",1],
["_countdownMin",20],
"_unitsArray"
];

//Spawn Sector Defenders
if (count allPlayers > 1) then {
	_players = allPlayers;
	_players = _players - [manu];
	
	_host1 = selectRandom _players;
	_host2 = _host1;
	
	if (count _players > 1) then {
		_players = _players - [_host1];
		_host2 = selectRandom _players;
	};
	
	[_missionLocation, _missionMarkers, _radius, _mobileEnemies, _cqbEnemies, _unitsArray]		remoteExec ["bia_defenders", 			_host1, true];
	[_missionLocation, _missionMarkers, _defVehicles, _radius, _unitsArray] 							remoteExec ["bia_defence_vehicle",		_host2, true];
	if (_mortar == 1) then { [_missionLocation, _mortarPatrols, _unitsArray]							remoteExec ["bia_mortar", 				_host2, true]; };
	if (_suicideBomber == 1) then {
		for "_i" from 1 to _suicideBomberNum do {
			[_unitsArray, _missionLocation, _radius] 																remoteExec ["bia_suicide_bomber",		_host1, true];
		};
	};
} else {
	[_missionLocation, _missionMarkers, _radius, _mobileEnemies, _cqbEnemies, _unitsArray]		remoteExec ["bia_defenders", 			selectRandom allPlayers, true];
	[_missionLocation, _missionMarkers, _defVehicles, _radius, _unitsArray] 							remoteExec ["bia_defence_vehicle",		selectRandom allPlayers, true];
	if (_mortar == 1) then { [_missionLocation, _mortarPatrols, _unitsArray]							remoteExec ["bia_mortar", 				selectRandom allPlayers, true]; };
	if (_suicideBomber == 1) then {
		for "_i" from 1 to _suicideBomberNum do {
			[_unitsArray, _missionLocation, _radius] 																remoteExec ["bia_suicide_bomber",		selectRandom allPlayers, true];
		};
	};
};
if (_mortar == 1) then { "Hostile Forces are supported by a Mortar Team" remoteExec ["hint", 0, true]; uiSleep 5; };

//Create Task
_bia_taskName = str random [11111, 55555, 99999];
_markerPos = _missionLocation;
_players = if (isMultiplayer) then {playableUnits} else {[player]};
[_bia_taskName, _players, ["Liberate the Sector", "Sector Attack", "ATTACK"], _markerPos, "ASSIGNED", 2, true, true, "attack"] remoteExec ["BIS_fnc_setTask", 0, true];

//Equip flashlights if appropriate 
remoteExec ["bia_enemy_flashlights", 0, true];

//Start Reinforcement Loop
_initialEnemyCount = _mobileEnemies + _cqbEnemies + ((count _defVehicles) * 3) + _suicideBomberNum;
//[format ["Mobiles: %1\nCQB: %2\nVehicle Crew: %3\nSuicide: %4", _mobileEnemies,_cqbEnemies,((count _defVehicles) * 3),_suicideBomberNum]] remoteExec ["hint", 0, true]; uiSleep 3;
[_missionLocation,_missionMarkers,_radius,_initialEnemyCount,_reinforcements_max,_unitsArray] remoteExec ["bia_reinforcementLoop", selectRandom allPlayers, true];

//Start Countdown
_CountDown = [_countdownMin * 60] call BIS_fnc_countDown;
[format ["Clear the Sector within the next %1 Minutes", _countdownMin]] remoteExec ["hint", 0, true];
_countdownCounter = 1;

//Start Mission Loop
missionLoop = 1;
publicVariable "missionLoop";
while {missionLoop == 1} do {
	//Give Countdown Info
	_timeLeft = [0] call BIS_fnc_countdown;
	if (_timeLeft <= (_countdownMin * 60 - 120 *_countdownCounter)) then {
		[format["%1 Minutes left", round(_timeLeft / 60)]] remoteExec ["hintSilent", 0, true];
		_countdownCounter = _countdownCounter + 1;
	};
	
	//Check Current Mission State
	_objOpforLoop = [];
	{if ((side _x) == east && ((getPos _x) distance _missionLocation) < _radius && !(_x getVariable ["patrolBool", false])) then {_objOpforLoop pushBack _x}} forEach allUnits;
	_newEnemyObjCount = count _objOpforLoop;
	_objBluforLoop = [];
	{if ((side _x) == west && ((getPos _x) distance _missionLocation) < _radius) then {_objBluforLoop pushBack _x}} forEach allUnits;
	_FriendlyObjCount = count _objBluforLoop;
	
	//check for win
	if (_newEnemyObjCount == 0 && _timeLeft != 0 && _FriendlyObjCount != 0) then
	{
		missionLoop = 0;
		publicVariable "missionLoop";
		[_bia_taskName,"SUCCEEDED", true] remoteExec ["BIS_fnc_taskSetState", 0, true];
		
		//Add mission pos to database
		[[_missionLocation],"scripts\writeToDatabase.sqf"] remoteExecCall ["execVM", 2, false];

		//Delete markers
		{ deleteMarker _x; } forEach _missionMarkers;
	};
	
	//check for loss
	if (_timeLeft == 0) then
	{
		missionLoop = 0;
		publicVariable "missionLoop";
		[_bia_taskName,"FAILED", true] remoteExec ["BIS_fnc_taskSetState", 0, true];
	};
	uiSleep 5;
};

//Remove old loadouts
[[],"scripts\missions\reward.sqf"] remoteExec ["execVM", 0, true];

//Teleport back to base
"You are being teleported back to HQ" remoteExec ["hintSilent", 0, true];
uiSleep 5;
{ 
	if (_x distance hq_pos > 1000) then {
		_x setPosATL (getPosATL hq_pos); 
	};
} forEach allPlayers;

//Delete enemies
_opfor = [];
{if ((side _x) == east) then {_opfor pushBack _x}} forEach allUnits;
{deleteVehicle _x;} forEach _opfor;