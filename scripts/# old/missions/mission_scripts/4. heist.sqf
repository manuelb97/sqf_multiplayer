//Paras
params [
"_missionLocation",
["_missionArea","small"],
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

//Reset money at home
[objmoneybox, ["grad_lbm_myFunds",0]] remoteExec ["setVariable", 0, true];

//create cash
_cashClass = "Box_Syndicate_Ammo_F";
_cashPos = [_missionLocation, (_radius / 5), (_radius / 2), 5, 0, 5, 0] call BIS_fnc_findSafePos;
_cash = createVehicle [_cashClass, _cashPos, [], 1, "NONE"];
_cash allowDamage false;

clearWeaponCargoGlobal	_cash;
clearMagazineCargoGlobal 	_cash;
clearItemCargoGlobal 		_cash;
clearBackpackCargoGlobal 	_cash;

_basicMissionReward = 1000;
_cashAmount = _basicMissionReward;
[_cash] remoteExec ["grad_moneymenu_fnc_setStorage", 0, true];
if (_missionArea == "small")	then { _cashAmount = _basicMissionReward *(selectRandom[0.5,0.75,1,1.25,1.5]); };
if (_missionArea == "medium")	then { _cashAmount = _basicMissionReward *(selectRandom[1.75,2,2.25,2.5,2.75]); };
if (_missionArea == "big") 		then { _cashAmount = _basicMissionReward *(selectRandom[3,3.25,3.5,3.75,4]); };
if (_missionArea == "huge") 	then { _cashAmount = _basicMissionReward *(selectRandom[4.25,4.5,4.75,5,5.25]); };
_realCash = round _cashAmount;
[_cash, _realCash] remoteExec ["grad_moneymenu_fnc_setFunds", 0, true];

//find out if buildings nearby
_objects = getPos _cash nearObjects 100;
_houses = [];
{ 
	if (count (_x call BIS_fnc_buildingPositions) > 0 && !("scaffolding" in str _x) && !("ruin" in str _x)) then { _houses pushBack _x; };
} forEach _objects;

private ["_allPos"];
if (count _houses > 0) then {
	//find building with most covered positions
	_suitablePosPerHouse = [];
	{
		_positions = _x call BIS_fnc_buildingPositions;
		_positions = _positions select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 2, 3]]};
		_positions = _positions select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, -2, 3]]};
		_positions = _positions select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [2, 0, 3]]};
		_positions = _positions select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [-2, 0, 3]]};
		_suitablePosPerHouse pushBack (count _positions);
	} forEach _houses;

	//if no perfect positions found, search at least positions with roof
	if (selectMax _suitablePosPerHouse < 1) then {
		_suitablePosPerHouse = [];
		{
			_positions = _x call BIS_fnc_buildingPositions;
			_positions = _positions select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 0, 3]]};
			_suitablePosPerHouse pushBack (count _positions);
		} forEach _houses;
	};

	//select best house
	_maxPos = selectMax _suitablePosPerHouse;
	_idx = _suitablePosPerHouse find _maxPos;
	_finalHouse = _houses select _idx;

	_allPos = _finalHouse call BIS_fnc_buildingPositions;
	_cashPossPos = _allPos select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 2, 3]]};
	_cashPossPos = _cashPossPos select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, -2, 3]]};
	_cashPossPos = _cashPossPos select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [2, 0, 3]]};
	_cashPossPos = _cashPossPos select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [-2, 0, 3]]};
	
	if (count _cashPossPos < 1) then {
		_cashPossPos = _allPos select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 0, 3]]};
	};

	//set cash pos
	if (count _cashPossPos > 0) then {
		_finalPos = selectRandom _cashPossPos;
		_allPos deleteAt (_allPos find _finalPos);
		_cash setPos _finalPos;
	} else {
		_closestHouse = nearestBuilding getPos _cash;
		if (_closestHouse distance _missionLocation < 150) then {
			_allPos = _closestHouse call BIS_fnc_buildingPositions;
			_finalPos = selectRandom _allPos;
			_allPos deleteAt (_allPos find _finalPos);
			_cash setPos _finalPos;
			//hint "Random Pos used";
		} else {
			//hint "Closest house too far";
		};
	};
};

//spawn sentries
_grpSentries = createGroup east;
_sentryClasses = _unitsArray select 2;

//Spawn in cash building if one found
if (!isNil "_allPos") then {
	_sentryPosCount = count _allPos;
	_buildingSize = "small";
	
	if (_sentryPosCount < 5) 										then { _buildingSize = "small"; };
	if (_sentryPosCount > 5 && _sentryPosCount < 10) 	then { _buildingSize = "medium"; };
	if (_sentryPosCount > 10) 										then { _buildingSize = "big"; };
	
	_sentryAmount = 2;
	switch _buildingSize do {
		case "small": 	{ _sentryAmount = selectRandom[2,3,4]; };
		case "medium": 	{ _sentryAmount = selectRandom[4,5,6]; };
		case "big": 	{ _sentryAmount = selectRandom[6,7,8]; };
	};
	
	for '_i' from 1 to _sentryAmount do 
	{
		_sentryPos = selectRandom _allPos;
		if (count _allPos > 1) then {_allPos = _allPos - _sentryPos;};
		_sentry = _grpSentries createUnit [selectRandom _sentryClasses, _sentryPos, [], 0, "NONE"];
		_sentry setSkill 0.7;
		_sentry disableAI "PATH";
	};
} else {
	//Spawn sentries around cash since no building found
	for '_i' from 1 to selectRandom[2,3,4,5] do 
	{
		_sentryPos = [getPos _cash, 2, 20, 1, 0, 20, 0] call BIS_fnc_findSafePos;
		_sentry = _grpSentries createUnit [selectRandom _sentryClasses, _sentryPos, [], 0, "NONE"];
		_sentry setSkill 0.7;
		_sentry disableAI "PATH";
	};
};
uiSleep 0.5;

//Create Task
_bia_taskName = str random [11111, 55555, 99999];
_players = if (isMultiplayer) then {playableUnits} else {[player]};
[_bia_taskName, _players, ["Steal the Money", "Heist", "box"], _missionLocation, "ASSIGNED", 0, true, true, "box"] remoteExec ["BIS_fnc_setTask", 0, true];
uiSleep 0.5;

//Equip flashlights if appropriate
remoteExec ["bia_enemy_flashlights", 0, true];
uiSleep 0.5;

//Start Reinforcement Loop
_initialEnemyCount = _mobileEnemies + _cqbEnemies + ((count _defVehicles) * 3) + _suicideBomberNum;
//[format ["Mobiles: %1\nCQB: %2\nVehicle Crew: %3\nSuicide: %4", _mobileEnemies,_cqbEnemies,((count _defVehicles) * 3),_suicideBomberNum]] remoteExec ["hint", 0, true]; uiSleep 3;
[_missionLocation,_missionMarkers,_radius,_initialEnemyCount,_reinforcements_max,_unitsArray] remoteExec ["bia_reinforcementLoop", selectRandom allPlayers, true];

//Start Countdown
_CountDown = [_countdownMin * 60] call BIS_fnc_countDown;
[format ["Steal the financial ressources within %1 Minutes", _countdownMin]] remoteExec ["hint", 0, true];
_countdownCounter = 1;

//Start Mission Loop
missionLoop = 1;
publicVariable "missionLoop";
_escapeMsgDisplayed = false;
_teleportedPlayers = [];

while {missionLoop == 1} do {
	//Give Countdown Info
	_timeLeft = [0] call BIS_fnc_countdown;
	if (_timeLeft <= (_countdownMin * 60 - 120 *_countdownCounter)) then {
		[format["%1 Minutes left", round(_timeLeft / 60)]] remoteExec ["hintSilent", 0, true];
		_countdownCounter = _countdownCounter + 1;
	};
	
	//check for win
	_cashSaved = objmoneybox getVariable ["grad_lbm_myFunds",0];
	if (_timeLeft != 0 && _cashSaved == _realCash) then
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
	_cashLeft = _cash getVariable ["grad_lbm_myFunds",0];
	//hint format["Cash left: %1",_cashLeft];
	if (_timeLeft == 0 && _cashLeft != 0) then
	{
		missionLoop = 0;
		publicVariable "missionLoop";
		[_bia_taskName,"FAILED", true] remoteExec ["BIS_fnc_taskSetState", 0, true];
	};
	
	//check if hint should be displayed to escape
	if (_cashLeft == 0 && !_escapeMsgDisplayed) then {
		"Break contact with remaining enemies" remoteExec ["hintSilent", 0, true];
		_escapeMsgDisplayed = true;
	};
	
	if (_escapeMsgDisplayed) then {
		_missionAreaCenter = getMarkerPos (_missionMarkers select 0);
		_escapedPlayers = allPlayers select {!(_x inArea [_missionAreaCenter, 350,350,0,false])};
		
		if (count _escapedPlayers == count allPlayers) then {
			{ 
				if ((_x distance hq_pos > 1000) && !(_x in _teleportedPlayers)) then {
					"You are being teleported back to HQ" remoteExec ["hintSilent", _x, true];
					uiSleep 5;
					_x setPosATL (getPosATL hq_pos); 
					_teleportedPlayers pushBack _x;
				};
			} forEach allPlayers;
		};
	};
	
	uiSleep 5;
};

//Remove old loadouts
[[],"scripts\missions\reward.sqf"] remoteExec ["execVM", 0, true];

//Delete enemies
_opfor = [];
{if ((side _x) == east) then {_opfor pushBack _x}} forEach allUnits;
{deleteVehicle _x;} forEach _opfor;