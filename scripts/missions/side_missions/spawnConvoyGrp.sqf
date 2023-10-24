params [
"_convoyStart",
"_convoyEnd",
"_convoyWpPosArr",
"_infantry",
"_vehicles",
["_convoySpeed",50],
["_convoySeparation",50],
["_pushThrough", true],
"_varName", 
"_debug"
];

_armedVehicles = _vehicles select 0;
_transportTrucks = _vehicles select 1;// select 0;

_grp = createGroup [east, true];

//Spawn armed vehicles
_combatCrew = [];

_convoyVehicles = [];
{
	//Spawn vehicle
	_vehClass = _x;
	_vehicle = createVehicle [_vehClass, _convoyStart, [], 50, "NONE"];
	_convoyVehicles pushBack _vehicle;
	_vehicle setVariable ["OpforVehicle", true, true];
	_vehicle setVariable [_varName, true, true];

	clearWeaponCargoGlobal 		_vehicle;
	clearMagazineCargoGlobal 	_vehicle;
	clearItemCargoGlobal 		_vehicle;
	clearBackpackCargoGlobal	_vehicle;
	
	//Unflip vehicle
	_normalVec = surfaceNormal getPos _vehicle;
	_vehicle setVectorUp _normalVec;
	_vehicle setPosATL [getPosATL _vehicle select 0, getPosATL _vehicle select 1, 0];
	
	//Spawn crew
	_crewSeats = ([_vehClass, true] call BIS_fnc_crewCount) min 10;

	_crew = [];
	for "_i" from 1 to _crewSeats do 
	{
		_soldier = _grp createUnit [selectRandom _infantry, getpos _vehicle, [], 0, "NONE"];
		_soldier setVariable [_varName, true, true];
		_hasSeat = _soldier moveInAny _vehicle;
		_crew pushBack _soldier;
	};

	_combatCrew append _crew;
} forEach _armedVehicles;

//Spawn troop transport
_cargoCrew = [];
{
	_vehClass = _x;
	_vehicle = createVehicle [_vehClass, _convoyStart, [], 50, "NONE"];
	_convoyVehicles pushBack _vehicle;
	_vehicle setVariable ["OpforVehicle", true, true];

	clearWeaponCargoGlobal 	_vehicle;
	clearMagazineCargoGlobal 	_vehicle;
	clearItemCargoGlobal 		_vehicle;
	clearBackpackCargoGlobal	_vehicle;

	_crewSeats = ([_vehClass, true] call BIS_fnc_crewCount) min 10;

	_transportCrew = [];
	for "_i" from 1 to _crewSeats do 
	{
		_soldier = _grp createUnit [selectRandom _infantry, getpos _vehicle, [], 0, "NONE"];
		_soldier setVariable [_varName, true, true];
		_hasSeat = _soldier moveInAny _vehicle;
		
		if (_hasSeat) then
		{
			_transportCrew pushBack _soldier;
		} else
		{
			deleteVehicle _soldier;
		};
	};
	_cargoCrew append _transportCrew;
} forEach _transportTrucks;

//Set some grp params
{
	_x setVariable ["Convoy", true, true];
	_x setVariable [_varName, true, true];
	_x addMPEventHandler ["MPKilled", { _nul = _this call killedManInfo; }];
} forEach (units _grp);

_infSkill = missionNamespace getVariable "InfantrySkill";
_vehSkill = missionNamespace getVariable "VehicleSkill";
[_cargoCrew, _infSkill] call bia_set_skill;
[_combatCrew, _vehSkill] call bia_set_skill;

{
	_x setdamage 0;
	(driver _x) setSkill 1;
} forEach _convoyVehicles;

_grp setBehaviour "SAFE";
[_grp, _convoySpeed, _convoySeparation, _pushThrough] spawn bia_group_convoy;

//Set convoy path
{
	_markerPos = getMarkerPos _x;
	[_grp, _markerPos] call bia_add_wp;

	if (_forEachIndex == 0) then 
	{
		{
			_veh = _x;
			_veh setDir (_veh getDir _markerPos);
		} forEach _convoyVehicles;
	};
} forEach (_convoyWpPosArr select [2, count _convoyWpPosArr]);

missionNamespace setVariable ["ConvoyReady", true, true];

_grp setCurrentWaypoint [_grp, 1];
{
	_x setDir (_x getDir (getWPPos [_grp, 1]));
} forEach _convoyVehicles;
(units _grp) doMove (getWPPos [_grp, 1]);

//Check for wp completion
while {count (waypoints _grp) > 0} do
{
	_leader = leader _grp;
	_wpPos = getWPPos [_grp, 1]; //need to use 1 since 0 is current pos?

	if (_leader distance2D _wpPos < 30) then
	{
		deleteWaypoint [_grp, 0];
	};

	uiSleep 1;
};