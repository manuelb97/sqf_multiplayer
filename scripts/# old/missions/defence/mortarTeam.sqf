// [getPos manu, 2, ["Tier_4"] call compile preprocessFileLineNumbers "scripts\missions\factionUnits.sqf"] remoteExec ["bia_mortar", selectRandom allPlayers, true];

//Paras
params [
"_missionLocation",
"_mortarPatrols",
"_unitsArray"
];

/*
//Debug
{ deleteMarker _x; } forEach allMapMarkers;
_missionLocation = getPos manu;
_mortarPatrols = 2;
_unitsArray = ["Tier_4"] call compile preprocessFileLineNumbers "scripts\missions\factionUnits.sqf";
*/

//get faction units
_mortarOperator = _unitsArray select 2;
_mortarPatrol = (_unitsArray select 2) + (_unitsArray select 3) + (_unitsArray select 4) + (_unitsArray select 5);

//Create Mortar
_mortarType = "RHS_M252_WD";

//find pos without water
_landPos = _missionLocation getPos [random [1750, 2000, 2250], random 360];
while {surfaceIsWater _landPos} do {
	_landPos = _missionLocation getPos [random [1750, 2000, 2250], random 360];
};

_bestPlaces = selectBestPlaces [_landPos, 500, "0.5*houses + 0*meadow + 1*forest - 1*sea", 1, 1];
_bestPlace = _bestPlaces select 0 select 0;
_spawnpos = ([_bestPlace, 0, 200, 3, 0, 10, 0] call BIS_fnc_findSafePos) vectorAdd [0, 0, 0.5];

//"Hostile Forces are supported by a Mortar Team" remoteExec ["hint", 0, true]; //now included in mission script
[_spawnpos] execVM "scripts\missions\clearGround.sqf";
_newvehicle = _mortarType createVehicle _spawnpos;
_newvehicle setpos _spawnpos;
_newvehicle allowdamage false;

//Add teleport / HALO actions to mortar
[_newvehicle,['Teleport to HQ','scripts\TeleportToPos.sqf', [hq_pos], 1.5, true, true, "", "true", 5]] remoteExec ["addAction", 0, true];
[_newvehicle,['H.A.L.O.','scripts\HALO.sqf',nil,2,true,false,"","true",5,false,"",""]] remoteExec ["addAction", 0, true];

//Create Mortar Marker
_mortarMarker1 = str random [11111, 55555, 99999];
createMarker [_mortarMarker1, ((getPos _newvehicle) getpos [random [30, 40, 50], random 360])];
_mortarMarker1 setMarkerType "Empty";
_mortarMarker1 setMarkerSize [100, 100];
_mortarMarker1 setMarkerShape "ELLIPSE";
_mortarMarker1 setMarkerBrush "FDiagonal";
_mortarMarker1 setMarkerColor "colorOPFOR";

_mortarMarker2 = str random [11111, 55555, 99999];
_textMarkerPos = getMarkerPos _mortarMarker1;
createMarker [_mortarMarker2,_textMarkerPos];
_mortarMarker2 setMarkerType "mil_warning";
_mortarMarker2 setMarkerColor "colorOPFOR";
_mortarMarker2 setMarkerText "Mortar Location";

//Create Fortifications


//Create Mortar Crew
_grp = createGroup [east, true];
_mortarOp = _grp createUnit [(selectRandom _mortarOperator), _newvehicle getpos [random 10, random 360],[],0,"NONE"];
((units _grp) select 0) moveInAny _newvehicle;
_newvehicle allowdamage true;
_newvehicle setdamage 0;

//Give to GAIA
[_grp, _mortarMarker1, "MOVE"] remoteExec ["bia_give_to_gaia", 0, true];

//Set skill
[_grp] remoteExec ["bia_set_skill", 0, true];

//Create Mortar Patrol
for "_i" from 1 to _mortarPatrols do {
	_grpPatrol = createGroup [east, true];
	_grpPatrolSize = selectRandom[3,3,3,4,5,5];
	
	_grpPatrolSpawnPos = [getPos _newvehicle, 0, 200, 5, 0, 10, 0] call BIS_fnc_findSafePos;
	
	while {count units _grpPatrol < _grpPatrolSize} do {
		(selectRandom _mortarPatrol) createUnit [_grpPatrolSpawnPos, _grpPatrol];
	};
	
	//Give to GAIA
	[_grpPatrol, _mortarMarker1, "NOFOLLOW"] remoteExec ["bia_give_to_gaia", 0, true];
	
	//Set skill
	[_grpPatrol] remoteExec ["bia_set_skill", 0, true];
};

_mortarThreat = 1;
while {_mortarThreat == 1} do {
	if (!alive _mortarOp || (count crew _newvehicle) < 1) then {
		deleteMarker _mortarMarker1;
		deleteMarker _mortarMarker2;
		
		"The Mortar Threat has been eliminated" remoteExec ["hint", 0, true];
		
		_mortarThreat = 0;
	};
	
	uiSleep 5;
};

//Wait till no players are close, delete all mortar opfor
while {
	_closePlayers = [];
	{if (_x distance _spawnpos < 500) then {_closePlayers pushBack _x;}} forEach allPlayers;
	count _closePlayers != 0
} do {uiSleep 5;};
_mortarOpfor = [];
{if ((side _x) == east && _x distance _spawnpos < 600) then {_mortarOpfor pushBack _x};} forEach allUnits;
{deleteVehicle _x;} forEach _mortarOpfor;