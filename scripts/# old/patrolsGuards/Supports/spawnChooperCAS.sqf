// [getPos manu, 60, 400, true] execVM "scripts\patrolsGuards\Supports\spawnChooperCAS.sqf";

/*
B_UAV_02_dynamicLoadout_F
B_T_VTOL_01_armed_F
RHS_A10

RHS_AH64DGrey
RHS_AH1Z
rhs_mi28n_vvs

//Paras
params [
"_supportPos",
"_supportTime",
"_loiterRadius",
"_debug"
];
*/


//Paras
params [
"_target",
"_player",
"_actionParams"
];

//Remove action
//[_player, 1, ["ACE_SelfActions", "BiA_Supports", "BiA_CAS_Helicopter"]] call ace_interact_menu_fnc_removeActionFromObject;

_supportPos = getPos _player;
_supportTime = 120;
_loiterRadius = 400;
_debug = true;

_tag = "SupportCAS";

if (_debug) then 
{
	_text = format["Support CAS Script started"];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

//Setup
_class = selectRandom ["RHS_AH64DGrey", "RHS_AH1Z", "rhs_mi28n_vvs"];
_spawnPos = _supportPos getPos [1250, random 360];
_veh = createVehicle [_class, _spawnPos, [], 0, "FLY"];
[_veh, ["supportCAS", true]] remoteExec ["setVariable", 0, true];
_crewSeats = [_class, true] call BIS_fnc_crewCount;

if (_crewSeats > 2) then 
{
	_crewSeats = 2;
};

//Create Crew
_grp = createGroup west;

for "_i" from 1 to _crewSeats do 
{
	_soldier = _grp createUnit ["B_Pilot_F", getpos _veh, [], 0, "NONE"];
	[_soldier, ["supportCAS", true]] remoteExec ["setVariable", 0, true];
	_soldier setSkill 1;
	_soldier moveInAny _veh;
};
_grp deleteGroupWhenEmpty true;

//WPs
_enemyUnits = allUnits select 
{
	_x getVariable ["patrolBool", false]
};

{
	_grp reveal [_x, 4];
} forEach _enemyUnits;

_wp = _grp addWaypoint [_supportPos, 10];
_wp setWaypointType "SAD"; //"LOITER";
//_wp setWaypointLoiterRadius _loiterRadius;
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointCombatMode "RED";
_wp setWaypointSpeed "LIMITED";

_veh flyInHeight 100;

//Duration Control
if (_debug) then 
{
	_text = format["Waiting for CAS to get close to enemy pos"];
	[_tag, _text] remoteExec ["bia_to_log", 2, false];
};

while {_veh distance2D _supportPos > 300 && alive _veh} do
{
	uiSleep 1;
};

if (_debug) then 
{
	_text = format["CAS Duration started: %1", _supportTime];
	[_tag, _text] remoteExec ["bia_to_log", 2, false];
};

[_supportTime, true] call BIS_fnc_countdown;

while {([0] call BIS_fnc_countdown) > 0 && alive _veh} do
{
	_enemyUnits = allUnits select 
	{
		_x getVariable ["patrolBool", false]
	};

	{
		_grp reveal [_x, 4];
	} forEach _enemyUnits;
	
	uiSleep 1;
};

//Stop patrol
if (_debug) then 
{
	_text = format["Stopping CAS"];
	[_tag, _text] remoteExec ["bia_to_log", 2, false];
};

for "_i" from (count waypoints _grp - 1) to 0 step -1 do 
{
	deleteWaypoint [_grp, _i];
};

_veh doMove _spawnPos;

while {_veh distance _supportPos < 1000 && alive _veh} do
{
	uiSleep 1;
};

if (_debug) then 
{
	_text = format["Deleting CAS"];
	[_tag, _text] remoteExec ["bia_to_log", 2, false];
};

_supportObjs = allUnits select {_x getVariable ["supportCAS", false]};
{
	deleteVehicle _x;
} forEach _supportObjs; 

deleteVehicle _veh;