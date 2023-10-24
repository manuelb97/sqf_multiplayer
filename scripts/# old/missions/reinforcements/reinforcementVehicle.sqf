/*
_missionLocation 		= getPos test;
_reinforcementType 	= "air";
_unitsArray = ["Tier_4"] call compile preprocessFileLineNumbers "scripts\missions\factionUnits.sqf";

[_missionLocation,_reinforcementType,_unitsArray] execVM "scripts\missions\reinforcements\reinforcementVehicle.sqf";
*/
// Land_HelipadEmpty_F

//Paras
params [
"_missionLocation",
"_missionMarkers",
"_reinforcementType",
"_unitsArray"
];

//Prep stuff
_missionAreaMarker	= _missionMarkers select 0;
_pilotClasses 		= _unitsArray select 3;
_infantry			= (_unitsArray select 3) + (_unitsArray select 4) + (_unitsArray select 5);
_airClasses			= _unitsArray select 6;
_groundClasses	= _unitsArray select 7;
_spawn 				= [_missionLocation, 900, 1100, 8, 0, 5, 0] call BIS_fnc_findSafePos;
_lz 					= [_missionLocation, 0, 300, 10, 0, 5, 0, [], _missionLocation] call BIS_fnc_findSafePos;
_attackPos 		= _missionLocation;
_angle 				= selectRandom[0,45,90,135,180,225,270,315];
_vehGroupSize		= selectRandom [6,7,8];

if (_reinforcementType == "ground") then {
	//find pos without water
	_landPos = _missionLocation getPos [random[700,800,900], random 360];
	while {surfaceIsWater _landPos} do {
		_landPos = _missionLocation getPos [random[700,800,900], random 360];
	};
	
	_spawn = [_landPos, 0, 100, 8, 0, 20, 0] call BIS_fnc_findSafePos;
	_nearRoads = _spawn nearRoads 100;
	
	if (count _nearRoads < 1) then {
		_spawn = [_spawn, 0, 50, 5, 0, 20, 0, [], getPos _spawnRoad] call BIS_fnc_findSafePos;
	} else {
		_spawnRoad = selectRandom _nearRoads;
		_spawn = [getPos _spawnRoad, 0, 50, 5, 0, 20, 0, [], getPos _spawnRoad] call BIS_fnc_findSafePos;
	};
	
	[_spawn] execVM "scripts\missions\clearGround.sqf";
};

private ["_vehType","_vehPad","_veh"];
if (_reinforcementType == "air") then {
	_vehType 		= selectRandom _airClasses;
	_vehPad		= createVehicle ["Land_HelipadEmpty_F", _lz];
	_veh 			= createVehicle [_vehType, _spawn, [], 0, "FLY"];
} else {
	_vehType 		= selectRandom _groundClasses;
	_veh 			= createVehicle [_vehType, _spawn, [], 0, "NONE"];
};

_crewSeats 		= [_vehType, false] call BIS_fnc_crewCount;
_cargoSeats 	= ([_vehType, true] call BIS_fnc_crewCount) - _crewSeats;

_pilotClass 	= selectRandom _pilotClasses;
_grp1 			= createGroup east;
_pilot 			= _grp1 createUnit [_pilotClass, _spawn, [], 0, "NONE"];
_pilot moveInDriver _veh;
_pilot setUnitRank "SERGEANT";
_pilot setSkill 1;
_pilot setBehaviour "CARELESS";
_pilot setUnitCombatMode  "YELLOW";

for "_i" from 1 to (_crewSeats - 1) do {
	_infantryClass	= selectRandom _infantry;
	_crewSoldier 	= _grp1 createUnit [_infantryClass, _spawn, [], 0, "NONE"];
	_crewSoldier moveInAny _veh;
};

//Disable VCOM
_grp1 setVariable ["Vcm_Disable",true];

_grp2 = createGroup east;
_cargoNum = _cargoSeats - 2;
if (_cargoNum > 8) then {_cargoNum = selectRandom[	round(_cargoNum - ((_cargoNum -8) / 1.5)),
																			round(_cargoNum - ((_cargoNum -8) / 2))];};
for "_i" from 1 to _cargoNum do { 
	_infantryClass	= selectRandom _infantry;
	_cargoSoldier	= _grp2 createUnit [_infantryClass, _spawn, [], 0, "NONE"];
	_cargoSoldier moveInCargo _veh;
};

//Add reinforcements to GAIA
[_grp2, _missionAreaMarker, "NOFOLLOW"] remoteExec ["bia_give_to_gaia", 0, true];

//while {(count (crew _veh)) < (_crewSeats + _cargoSeats - 2) } do {uiSleep 1;};
_veh doMove _lz;
while {_veh distance _lz > 200} do {uiSleep 4;};

if (_reinforcementType == "air") then {
	_veh land "GET OUT";
	//_veh allowDamage false;
	uiSleep 5;
	
	if (landResult _veh == "Found") then {
		while {(getPos _veh select 2) > 5} do { uiSleep 1; };
	} else {
		for "_i" from (count waypoints _grp1 - 1) to 0 step -1 do {deleteWaypoint [_grp1, _i];};
		_airWP = (group _pilot) addWaypoint [_lz, 15];
		uiSleep 5;
		_veh land "GET OUT";
	};
} else {
	_groundWP = (group _pilot) addWaypoint [_lz, 15];
	_groundWP setWaypointType "TR UNLOAD";
	_groundWP setWaypointSpeed "FULL";
};

while { (_veh distance _lz) > 50 || (getPos _veh select 2) > 5} do { uiSleep 2; };

_grp2 leaveVehicle _veh;
{
	unassignVehicle _x;
	doGetOut _x; 
	_x setBehaviour "AWARE";
} forEach units _grp2;
_grp2 setCombatMode "YELLOW";

//Wait till all disembarked
while { (count (crew _veh)) > _crewSeats } do {uiSleep 4;};

//add WP to avoid idle at LZ before GAIA kicks in
_defWP =_grp2 addWaypoint [_missionLocation, 25];
_defWP setWaypointBehaviour "AWARE";
_defWP setWaypointFormation "LINE";
_defWP setWaypointCombatMode "RED";
_defWP setWaypointSpeed "FULL";

//Set skill
[_grp2] remoteExec ["bia_set_skill", 0, true];

//Make them aware if they arent already
_currentBehavior = behaviour (units _grp2 select 0);
if (_currentBehavior != "AWARE" || _currentBehavior != "COMBAT") then {
	_grp2 setBehaviour "AWARE";
};

//Delete veh waypoints & force it to move to spawn
_landPos = getPosATL _veh;
_veh doMove _spawn;
uiSleep 30;
_newPos = getPosATL _veh;

if (_landPos distance _newPos < 10) then {
	for "_i" from (count waypoints _grp1 - 1) to 0 step -1 do {deleteWaypoint [_grp1, _i];};
	_veh doMove _spawn;
	uiSleep 30;
};

_newestPos = getPosATL _veh;

if (_newPos distance _newestPos < 10) then {
	uiSleep 120;
	{deleteVehicle _x;} forEach (crew _veh);
	deleteVehicle _veh;
	waituntil {(count units _grp1) == 0};
	deletegroup _grp1;
};

//Despawn vehicle
while { alive _veh && _veh distance _spawn > 200 } do { uiSleep 5; };
if (_veh distance _spawn < 200) then {
	{deleteVehicle _x;} forEach (crew _veh);
	deleteVehicle _veh;
	waituntil {(count units _grp1)==0};
    deletegroup _grp1;
};