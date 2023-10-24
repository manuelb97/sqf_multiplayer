params [
"_qrfPos"
];

_varName = "SupportQRF";

//Find spawn pos 
_randomPos = _qrfPos getPos [500, random 360];
_spawnPos = [_qrfPos, 500, 750, 5, 0, 20, 0, [], [_randomPos, _randomPos]] call BIS_fnc_findSafePos;

//Spawn vehicle
_classes = ["B_T_LSV_01_armed_F", "O_LSV_02_armed_F", "rhsusf_m1165a1_gmv_m2_m240_socom_d", "rhsusf_m1165a1_gmv_m134d_m240_socom_d"];
_class = selectRandom _classes;
_newvehicle = createVehicle [_class, _spawnpos, [], 0, "NONE"];
_newvehicle setVariable ["OpforVehicle", true, true];
_newvehicle setVariable [_varName, true, true];

clearWeaponCargoGlobal 		_newvehicle;
clearMagazineCargoGlobal 	_newvehicle;
clearItemCargoGlobal 		_newvehicle;
clearBackpackCargoGlobal	_newvehicle;

//Unflip vehicle
_normalVec = surfaceNormal getPos _newvehicle;
_newvehicle setVectorUp _normalVec;
_newvehicle setPosATL [getPosATL _newvehicle select 0, getPosATL _newvehicle select 1, 0];
_newvehicle setdamage 0;

//Create group
_crewGrp = createGroup [west, true];
_crewSeats = [_class, true] call BIS_fnc_crewCount;

for "_i" from 1 to _crewSeats do 
{
	_soldier = _crewGrp createUnit ["rhsusf_socom_marsoc_cso", getpos _newvehicle, [], 0, "NONE"];
	_soldier moveInAny _newvehicle;
	_soldier disableAI "AUTOCOMBAT";
	_soldier setVariable [_varName, true, true];
};

//Set skill for combat vehicles group
_combatCrew = units _crewGrp;
[_combatCrew, 0.25] call bia_set_skill;

//Move convoy to designation
_newvehicle doMove _qrfPos;
_crewGrp setBehaviourStrong "CARELESS";

while {_newvehicle distance2D _qrfPos > 200} do 
{
	uiSleep 1;
};

//Make them fight + disembark
_crewGrp setBehaviourStrong "AWARE";

while {_newvehicle distance2D _qrfPos > 20} do 
{
	uiSleep 1;
};

{
	_x moveOut _newvehicle;
	unassignVehicle _x;
} forEach (units _crewGrp);

(units _crewGrp) allowGetIn false;

//Delete all 
_delUnits = [_newvehicle] + (units _crewGrp);

while {count (allPlayers select {_x distance2D hq_pos > 100}) > 0} do 
{
	uiSleep 1;
};

{
	deleteVehicle _x;
} forEach _delUnits;