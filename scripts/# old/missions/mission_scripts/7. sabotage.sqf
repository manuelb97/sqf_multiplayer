//Paras
params [
"_missionLocation",
"_missionMarkers",
["_mobileEnemies",14],
["_cqbEnemies",6],
["_radius",100],
["_reinforcements_max",2],
"_defVehicles",
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
} else {
	[_missionLocation, _missionMarkers, _radius, _mobileEnemies, _cqbEnemies, _unitsArray]		remoteExec ["bia_defenders", 			selectRandom allPlayers, true];
	[_missionLocation, _missionMarkers, _defVehicles, _radius, _unitsArray] 							remoteExec ["bia_defence_vehicle",		selectRandom allPlayers, true];
};

//Spawn sabotage obj
_classArr = ["rhs_p37","rhs_prv13","Land_Communication_F"];
_numTrees = count (nearestTerrainObjects [_missionLocation, ["TREE"], _radius, true]);
_sabPos = [];
if (_numTrees > 100) then {
	_objectsCenter = nearestObjects [_missionLocation, [], 25];
	{ hideObjectGlobal _x; } forEach _objectsCenter; 
	_sabPos = [_missionLocation, 0, 25, 1, 0, 10, 0] call BIS_fnc_findSafePos;
} else {
	_sabPos = [_missionLocation, 0, (_radius / 2), 8, 0, 10, 0] call BIS_fnc_findSafePos;
};
_obj = createVehicle [selectRandom _classArr, _sabPos, [], 0, "NONE"];

//spawn sentries
_grpSentries = createGroup east;
_sentryClasses = _unitsArray select 2;
for '_i' from 1 to selectRandom[4,5,6,7,8] do 
{
	_spawnPosRaw = _obj getPos [selectRandom[8,10,12,15], selectRandom[0,45,90,135,180,225,270,315]];
	_spawnPos = [_spawnPosRaw, 0, 20, 1, 0, 5, 0,[],_spawnPosRaw] call BIS_fnc_findSafePos;
	if (count _spawnPos < 2) then {_spawnPos = getPos _obj;};
	_sentry = _grpSentries createUnit [selectRandom _sentryClasses, _spawnPos, [], 15, "NONE"];
	_sentry disableAI "PATH";
};

//Create Task
_bia_taskName = str random [11111, 55555, 99999];
_players = if (isMultiplayer) then {playableUnits} else {[player]};
[_bia_taskName, _players, ["Sabotage the Enemy Communication Asset", "Sabotage Mission", "ATTACK"], _missionLocation, "ASSIGNED", 0, true, true, "destroy"] remoteExec ["BIS_fnc_setTask", 0, true];

//Equip flashlights if appropriate
remoteExec ["bia_enemy_flashlights", 0, true];

//Add demo charge giver
[HQ_Arsenal, ["Add C4 to Loadout",'scripts\missions\sabotage\addDemoCharge.sqf',[],1.5,true,false,"","true",4,false,"",""]] remoteExec ["addAction", 0, true];
_addC4 = (actionIDs HQ_Arsenal) select ((count actionIDs HQ_Arsenal) -1);

//Start Reinforcement Loop
_initialEnemyCount = _mobileEnemies + _cqbEnemies + ((count _defVehicles) * 3);
//[format ["Mobiles: %1\nCQB: %2\nVehicle Crew: %3", _mobileEnemies,_cqbEnemies,((count _defVehicles) * 3)]] remoteExec ["hint", 0, true]; uiSleep 3;
[_missionLocation,_missionMarkers,_radius,_initialEnemyCount,_reinforcements_max,_unitsArray] remoteExec ["bia_reinforcementLoop", selectRandom allPlayers, true];

//Start Countdown
_CountDown = [_countdownMin * 60] call BIS_fnc_countDown;
[format ["Destroy the enemy asset within the next %1 Minutes", _countdownMin]] remoteExec ["hint", 0, true];
_countdownCounter = 1;

//Start Mission Loop
missionLoop = 1;
publicVariable "missionLoop";
_c4Checks = false;

while {missionLoop == 1} do {
	//Make Obj only destroyable by C4
	if (!_c4Checks) then {
		[_obj] remoteExec ["bia_obj_destroyable", selectRandom allPlayers, true];
		_c4Checks = true;
	};
	
	//Give Countdown Info
	_timeLeft = [0] call BIS_fnc_countdown;
	if (_timeLeft <= (_countdownMin * 60 - 120 *_countdownCounter)) then {
		[format["%1 Minutes left", round(_timeLeft / 60)]] remoteExec ["hintSilent", 0, true];
		_countdownCounter = _countdownCounter + 1;
	};
	
	//check for win
	_timeLeft = [0] call BIS_fnc_countdown;
	if (!alive _obj && _timeLeft != 0) then
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
	if (alive _obj && _timeLeft == 0) then
	{
		missionLoop = 0;
		publicVariable "missionLoop";
		[_bia_taskName,"FAILED", true] remoteExec ["BIS_fnc_taskSetState", 0, true];
	};
	
	uiSleep 5;
};

//Wait till all players are out of zone
"Break contact with remaining enemies" remoteExec ["hintSilent", 0, true];
while { 
	_escapedPlayers = [];
	{
		_playerPos = getPos _x;
		_missionAreaCenter = getMarkerPos (_missionMarkers select 0);
		if (!(_playerPos inArea [_missionAreaCenter, 350,350,0,false])) then {
			_escapedPlayers pushBack _x;
		};
	} forEach allPlayers;
	(count _escapedPlayers) != (count allPlayers)
} do {uiSleep 2;};

//Remove C4 action, already done by reward.sqf
//[HQ_Arsenal, _addC4] remoteExec ["removeAction", 0, true];

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