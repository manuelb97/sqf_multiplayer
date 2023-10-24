//Paras
params [
"_missionLocation",
"_missionMarkers",
["_radius",100],
["_reinforcements_max",2],
["_mortar",[false,2]],
["_countdownMin",20],
"_unitsArray"
];

//Create Task
_bia_taskName = str random [11111, 55555, 99999];
_markerPos = _missionLocation;
_players = if (isMultiplayer) then {playableUnits} else {[player]};
[_bia_taskName, _players, ["Defend the Sector", "Sector Defence", "DEFEND"], _markerPos, "ASSIGNED", 0, true, true, "defend"] remoteExec ["BIS_fnc_setTask", 0, true];

//Create defence ammo box
[_missionLocation] execVM "scripts\missions\missionAmmobox.sqf";

//Prep Notification
_prepTimer = 5;
while {_prepTimer > 0} do {
	_prepTimer = _prepTimer - 1;
	"Prepare yourself for the Enemy Attack" remoteExec ["hintSilent", 0, true];
	uiSleep 1;
};

//Prep Timer
_timer = 120; //120
while {_timer > 0} do {
	_timer = _timer - 1;
	
	_minutes = floor (_timer / 60);
	_seconds = _timer % 60;
	_minutes_zero = '';
	_seconds_zero = '';

	if ( _minutes < 10 ) then { _minutes_zero = '0'; };
	if ( _seconds < 10 ) then { _seconds_zero = '0'; };
	
	[format [ '%1%2:%3%4',_minutes_zero,_minutes,_seconds_zero,_seconds ]] remoteExec ["hintSilent", 0, true];
	uiSleep 1;
};

//Start Notification
_startTimer = 5;
while {_startTimer > 0} do {
	_startTimer = _startTimer - 1;
	"Prep Time is over, get ready for the Enemy Attack" remoteExec ["hintSilent", 0, true];
	uiSleep 1;
};

//Artillery Barrage
"Artillery incoming!" remoteExec ["hint", 0, true];
uiSleep 5;
_ammo = "Sh_82mm_AMOS"; 
_markerPos = _missionLocation getPos [random [25, 50, 75],random 360];
[_markerPos, _ammo, 100, _mortar select 1, [2,5], nil, 0, 400, 80, []] spawn BIS_fnc_fireSupportVirtual;

//Spawn constant foot reinforcements
[_missionLocation,_missionMarkers,_reinforcements_max,_unitsArray] remoteExec ["bia_defence_foot_reinforcement", selectRandom allPlayers, true];

//Start Reinforcement Loop
_enemyObjCount = 30; //to always trigger reinforcement when cooldown finished
[_missionLocation,_missionMarkers,_radius,_enemyObjCount,_reinforcements_max,_unitsArray] remoteExec ["bia_reinforcementLoop", selectRandom allPlayers, true];

//Start Countdown
_CountDown = [_countdownMin * 60] call BIS_fnc_countDown;
[format ["Defend the Sector! If at one point no Friendlies are present within the next %1 Min. the Sector is lost", _countdownMin]] remoteExec ["hint", 0, true];
_countdownCounter = 1;

//Mission Loop
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
	{if ((side _x) == west && ((getPos _x) distance _missionLocation) < (_radius + 100)) then {_objBluforLoop pushBack _x}} forEach allUnits;
	_newFriendlyObjCount = count _objBluforLoop;
	
	// check for win
	if (_timeLeft == 0 && _newEnemyObjCount == 0 && _newFriendlyObjCount != 0) then
	{
		missionLoop = 0;
		publicVariable "missionLoop";
		[_bia_taskName,"SUCCEEDED", true] remoteExec ["BIS_fnc_taskSetState", 0, true];
		
		//Add mission pos to database
		[[_missionLocation],"scripts\writeToDatabase.sqf"] remoteExecCall ["execVM", 2, false];

		//Delete markers
		{ deleteMarker _x; } forEach _missionMarkers;
	};
	
	// check for loss
	if (_newFriendlyObjCount == 0) then
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