//Paras
params [	
"_spawnPos",
"_targetPos",
"_infantry",
"_vehicles",
"_debug"
];

//Spawn vehicle
_vehClass = selectRandom _vehicles;
_newvehicle = _vehClass createVehicle _spawnpos;
_newvehicle allowdamage false;
_newvehicle setpos _spawnpos;

clearWeaponCargoGlobal 	_newvehicle;
clearMagazineCargoGlobal 	_newvehicle;
clearItemCargoGlobal 		_newvehicle;
clearBackpackCargoGlobal	_newvehicle;

//_newvehicle addMPEventHandler ["MPKilled", { _nul = _this call killedVehInfo; }];
_newvehicle allowdamage true;
_newvehicle setdamage 0;
[_newvehicle, ["patrolVehicleBool", true]] remoteExec ["setVariable", 0, true];

//Create group
_grp = createGroup [east, true];
_crewSeats = [_vehClass, true] call BIS_fnc_crewCount;

if (_crewSeats > 4) then 
{
	_crewSeats = 4;
};

for "_i" from 1 to _crewSeats do 
{
	_soldier = _grp createUnit [selectRandom _infantry, getpos _newvehicle, [], 0, "NONE"];
	[_soldier, ["patrolVehicleBool", true]] remoteExec ["setVariable", 0, true];
	//_soldier setVariable ["patrolVehicleBool", true];
	_soldier addMPEventHandler ["MPKilled", { _nul = _this call killedManInfo; }];
};
_grp deleteGroupWhenEmpty true;

{
	_x moveInAny _newvehicle;
} forEach units _grp;

// fix stuck at spawn
sleep 1;
{
	moveOut _x;
} forEach units _grp;
sleep 1;
{
	_x moveInAny _newvehicle;
} forEach units _grp;
sleep 1;
{
	moveOut _x;
} forEach units _grp;
sleep 1;
{
	_x moveInAny _newvehicle;
} forEach units _grp;

//Make vehicle patrol
[_grp, getPos leader _grp, _targetPos, _debug] spawn bia_group_patrol;