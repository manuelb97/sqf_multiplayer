//Paras
params [
"_target",
"_player",
"_actionParams"
];

//Remove action
//[_player, 1, ["ACE_SelfActions", "BiA_Supports", "BiA_CAS_AC130"]] call ace_interact_menu_fnc_removeActionFromObject;

_supportPos = getPos _player;
_supportTime = 200; //180;
_loiterRadius = 600; //1000 for UAV in MCC
_debug = true;

_tag = "SupportAC130";

if (_debug) then 
{
	_text = format["Support AC130 Script started"];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

//Setup
_class = selectRandom ["B_T_VTOL_01_armed_F"];
_spawnPos = _supportPos getPos [1250, random 360];
_veh = createVehicle [_class, _spawnPos, [], 0, "FLY"];

//_veh setDir (_veh getDir _supportPos);

[_veh, ["supportAC130", true]] remoteExec ["setVariable", 0, true];
_crewSeats = [_class, true] call BIS_fnc_crewCount;

if (_crewSeats > 5) then 
{
	_crewSeats = 5;
};

//Create Crew
_grp = createGroup west;

for "_i" from 1 to _crewSeats do 
{
	_soldier = _grp createUnit ["B_Pilot_F", getpos _veh, [], 0, "NONE"];
	[_soldier, ["supportAC130", true]] remoteExec ["setVariable", 0, true];
	_soldier setSkill 1;
	_soldier moveInAny _veh;
	_soldier disableAI "TARGET";
};
_grp deleteGroupWhenEmpty true;

//WPs
_wp = _grp addWaypoint [_supportPos, 10];
_wp setWaypointType "LOITER";
_wp setWaypointLoiterRadius _loiterRadius;
_wp setWaypointLoiterType "CIRCLE_L";
_wp setWaypointBehaviour "CARELESS"; //"CARELESS";
_wp setWaypointCombatMode "BLUE";//"BLUE";
_wp setWaypointSpeed "LIMITED";

_veh flyInHeight 400;

//Duration Control
if (_debug) then 
{
	_text = format["Waiting for CAS to get close to enemy pos"];
	[_tag, _text] remoteExec ["bia_to_log", 2, false];
};

while {_veh distance _supportPos > (_loiterRadius * 3) && alive _veh} do
{
	uiSleep 1;
};

_player addAction ["Remote Control Support","scripts\missions\support\remoteControl.sqf", ["B_T_VTOL_01_armed_F"], 1.5,true,false,"","true",5,false,"",""];

if (_debug) then 
{
	_text = format["CAS Duration started: %1", _supportTime];
	[_tag, _text] remoteExec ["bia_to_log", 2, false];
};

[_supportTime, true] call BIS_fnc_countdown;

while {([0] call BIS_fnc_countdown) > 0 && alive _veh} do
{
	if (!alive _player) then
	{
		objNull remoteControl (gunner _veh);
		_player switchCamera "internal";
	};
	
	uiSleep 1;
};

//Stop patrol
if (_debug) then 
{
	_text = format["Stopping CAS"];
	[_tag, _text] remoteExec ["bia_to_log", 2, false];
};

objNull remoteControl (gunner _veh);
_player switchCamera "internal"; //sandra sieht aus meiner perspektive //might need to call separte script locally (remote exec for x player)

for "_i" from (count waypoints _grp - 1) to 0 step -1 do 
{
	deleteWaypoint [_grp, _i];
};

_veh doMove _spawnPos;

while {_veh distance _supportPos < 2000 && alive _veh} do
{
	uiSleep 1;
};

if (_debug) then 
{
	_text = format["Deleting CAS"];
	[_tag, _text] remoteExec ["bia_to_log", 2, false];
};

_supportObjs = allUnits select {_x getVariable ["supportAC130", false]};
{
	deleteVehicle _x;
} forEach _supportObjs; 

deleteVehicle _veh;