//Paras
params [
"_missionLocation",
"_missionMarkers",
["_mobileEnemies",14],
["_radius",100],
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
	
	[_missionLocation, _missionMarkers, _radius, _mobileEnemies, 0, _unitsArray]	remoteExec ["bia_defenders", 			_host1, true];
	[_missionLocation, _missionMarkers, _defVehicles, _radius, _unitsArray] 		remoteExec ["bia_defence_vehicle",		_host2, true];
} else {
	[_missionLocation, _missionMarkers, _radius, _mobileEnemies, 0, _unitsArray]	remoteExec ["bia_defenders", 			selectRandom allPlayers, true];
	[_missionLocation, _missionMarkers, _defVehicles, _radius, _unitsArray] 		remoteExec ["bia_defence_vehicle",		selectRandom allPlayers, true];
};

//create hvt
_grp = createGroup east;
_hvtClass = _unitsArray select 1;
_hvtPos = [_missionLocation, 0, 100, 10, 0, 5, 0] call BIS_fnc_findSafePos;
_hvt = _grp createUnit [_hvtClass, _hvtPos, [], 0, "NONE"];
_hvt setVariable ["hvt", true, true];
removeAllWeapons _hvt;

//Create HVT escape plan
hvtEscaped = false;
publicVariable "hvtEscaped";
[_hvt,_missionLocation,_radius] remoteExec ["bia_hvt_fleeing", selectRandom allPlayers, true];

//spawn sentries
_grpSentries = createGroup east;
_sentryAmount = selectRandom[3,4,5];
_sentryClasses = _unitsArray select 2;
for '_i' from 1 to _sentryAmount do 
{
	_sentry = _grpSentries createUnit [selectRandom _sentryClasses, _hvtPos getPos [selectRandom[2,4,6,8,10,12],selectRandom[0,45,90,135,180,225,270,315]], [], 5, "NONE"];
	_sentry setSkill 1;
	_sentry disableAI "PATH";
	_sentry setUnitPos "UP";
};

//Create ffps
private ["_lastFFP","_FFPMarkers"];
for '_i' from 1 to 3 do {
	_ffpPos 					= [_hvtPos, 500, 1000, 5, 0, 20, 0] call BIS_fnc_findSafePos;
	_aslFFPPos 			= AGLToASL [_ffpPos select 0, _ffpPos select 1, 1];
	_aslHVTPos 			= AGLToASL [_hvtPos select 0, _hvtPos select 1, 1];
	_blockedLine 			= lineIntersects [_aslFFPPos, _aslHVTPos];
	_terranBlock 			= terrainIntersect[_aslFFPPos, _aslHVTPos];
	_visibility 				= [objNull, "VIEW"] checkVisibility [AGLToASL [_ffpPos select 0,_ffpPos select 1, 0], _aslHVTPos];
	
	if (isNil "_lastFFP") then {
		while {_blockedLine or _terranBlock or _visibility < 0.7} do {
			_ffpPos 					= [_hvtPos, 600, 1000, 5, 0, 20, 0] call BIS_fnc_findSafePos;
			_aslFFPPos 			= AGLToASL [_ffpPos select 0, _ffpPos select 1, 1];
			_aslHVTPos 			= AGLToASL [_hvtPos select 0, _hvtPos select 1, 1];
			_blockedLine 			= lineIntersects [_aslFFPPos, _aslHVTPos];
			_terranBlock 			= terrainIntersect[_aslFFPPos, _aslHVTPos];
			_visibility 				= [objNull, "VIEW"] checkVisibility [AGLToASL [_ffpPos select 0,_ffpPos select 1, 0], _aslHVTPos];
		};
	} else {
		while {_blockedLine or _terranBlock or _visibility < 0.7 or ((_lastFFP distance2D _ffpPos) < 500)} do {
			_ffpPos 					= [_hvtPos, 600, 1000, 5, 0, 20, 0] call BIS_fnc_findSafePos;
			_aslFFPPos 			= AGLToASL [_ffpPos select 0, _ffpPos select 1, 1];
			_aslHVTPos 			= AGLToASL [_hvtPos select 0, _hvtPos select 1, 1];
			_blockedLine 			= lineIntersects [_aslFFPPos, _aslHVTPos];
			_terranBlock 			= terrainIntersect[_aslFFPPos, _aslHVTPos];
			_visibility 				= [objNull, "VIEW"] checkVisibility [AGLToASL [_ffpPos select 0,_ffpPos select 1, 0], _aslHVTPos];
		};
	};
	
	_lastFFP = _ffpPos;

	_ffpMarker = str random [11111, 55555, 99999];
	createMarker [_ffpMarker, _ffpPos];
	_ffpMarker setMarkerType "mil_triangle";
	_ffpMarker setMarkerColor "ColorGreen";
	_FFPMarkers = _FFPMarkers + _ffpMarker;
};
_missionMarkers = _missionMarkers + _FFPMarkers;

//Create Task
_bia_taskName = str random [11111, 55555, 99999];
_players = if (isMultiplayer) then {playableUnits} else {[player]};
[_bia_taskName, _players, ["Eliminate the Target", "Sniper Mission", "ATTACK"], _missionLocation, "ASSIGNED", 0, true, true, "target"] remoteExec ["BIS_fnc_setTask", 0, true];

//Equip flashlights if appropriate
remoteExec ["bia_enemy_flashlights", 0, true];

//Start Countdown
_CountDown = [_countdownMin * 60] call BIS_fnc_countDown;
[format ["Eliminate the HVT within the next %1 Minutes", _countdownMin]] remoteExec ["hint", 0, true];
_countdownCounter = 1;

//Mission Loop
_missionLoop = 1;
_initialPunish = false;

while {_missionLoop == 1} do {
	//Give Countdown Info
	_timeLeft = [0] call BIS_fnc_countdown;
	if (_timeLeft <= (_countdownMin * 60 - 5 *_countdownCounter)) then {
		[format["%1 Minutes left", round(_timeLeft / 60)]] remoteExec ["hintSilent", 0, true];
		_countdownCounter = _countdownCounter + 1;
	};
	
	//check for win
	_timeLeft = [0] call BIS_fnc_countdown;
	if (!alive _hvt && _timeLeft != 0) then
	{
		_missionLoop = 0;
		[_bia_taskName,"SUCCEEDED", true] remoteExec ["BIS_fnc_taskSetState", 0, true];

		//Add mission pos to database
		[[_missionLocation],"scripts\writeToDatabase.sqf"] remoteExecCall ["execVM", 2, false];

		//Delete markers
		{ deleteMarker _x; } forEach _missionMarkers;
	};
	
	//check for loss
	if (alive _hvt && (hvtEscaped or _timeLeft == 0)) then
	{
		_missionLoop = 0;
		[_bia_taskName,"FAILED", true] remoteExec ["BIS_fnc_taskSetState", 0, true];
	};
	
	//Call Arty on Sniper
	_hvtMode = behaviour _hvt;
	//hint str _hvtMode;
	if (_hvtMode == "AWARE" || _hvtMode == "COMBAT") then {
		_playerArray = [];
		{ if (_x distance _missionLocation < 2000) then {_playerArray pushBack _x}; } forEach allPlayers;
		
		if (count _playerArray > 0) then {
			//Suppressive Fire
			if (!_initialPunish) then {
				//"Suppressive Fire" remoteExec ["hint", 0, true]; uiSleep 3;
				remoteExec ["bia_sniper_punish", 0, true];
			};
			
			//Chase Sniper
			//"Chase the sniper" remoteExec ["hint", 0, true]; uiSleep 3;
			remoteExec ["bia_sniper_chase", 0, true];
			
			//Spawn patrols behind sniper
			if (!_initialPunish) then {
				//"Backstabbers Spawned" remoteExec ["hint", 0, true]; uiSleep 3;
				[_hvtPos, _playerArray,_unitsArray] remoteExec ["bia_sniper_backstab", 0, true];
			};
			
			//Mortar
			if (!_initialPunish) then {
				"Mortar Barrage incoming!" remoteExec ["hint", 0, true];
				uiSleep 5;
				_playerPos = getPos (selectRandom _playerArray);
				_targetPos = _playerPos getPos[selectRandom[10,20,30,40,50],selectRandom[0,45,90,135,180,225,270,315]];
				[_targetPos, "Sh_82mm_AMOS", selectRandom[80,90,100,110,120], selectRandom[8,10,12,14], [3,8], {false}, selectRandom[50,60,70], 400, 80, []] spawn BIS_fnc_fireSupportVirtual;
				_initialPunish = true;
			};
		};
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
		if (!(_playerPos inArea [_missionAreaCenter, 1400,1400,0,false])) then {
			_escapedPlayers pushBack _x;
		};
	} forEach allPlayers;
	(count _escapedPlayers) != (count allPlayers)
} do {uiSleep 2;};

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