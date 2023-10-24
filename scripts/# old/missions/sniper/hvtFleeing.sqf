/*
_cqbUnitsArr= [];
{if (side _x == east) then {_cqbUnitsArr = units _x};} forEach allGroups;
*/

//Paras
_hvt 					= param [0,""];
_missionLocation	= param [1,[]];
_radius				= param [2,100];
//_fleePos	= param [1,[]];

//Unit static stand
_hvt setSkill 1;
_hvt disableAI "PATH";
_hvt setUnitPos "UP";
_hvt setBehaviour "SAFE";

//Create escape vehicle
_spawn = [_hvt, 75, 200, 5, 0, 20, 0, [[getPos _hvt, 100]]] call BIS_fnc_findSafePos;
_nearRoads = _spawn nearRoads 200;
if (count _nearRoads > 0) then {
	_spawnRoad = selectRandom _nearRoads;
	_spawn = [getPos _spawnRoad, 5, 100, 5, 0, 20, 0, [[getPos _hvt, 100]], getPos _spawnRoad] call BIS_fnc_findSafePos;
};
_veh = createVehicle ["rhsgref_hidf_M998_4dr_fulltop", _spawn, [], 5, "NONE"];

//Create driver
_pilotClass 	= selectRandom _pilotClasses;
_grp1 		= createGroup east;
_pilot 		= _grp1 createUnit ["rhs_msv_emr_armoredcrew", _spawn, [], 0, "NONE"];
_pilot moveInDriver _veh;
_pilot setVariable ["hvt", true, true];
_pilot disableAI "PATH";

//Wait till escape variable defined
while {isNil "hvtEscaped"} do {uiSleep 2;};

//Wait till fired upon
_hvtMode = behaviour _hvt;
while {_hvtMode != "COMBAT" && _hvtMode != "AWARE"} do {
	uiSleep 3;
	_hvtMode = behaviour _hvt;
	//[format["HVT combat mode: %1",_hvtMode]] remoteExec ["hintSilent", 0, true]; uiSleep 3;
};

//Enable taking cover
_hvt enableAI "PATH";
_hvt setUnitPos "AUTO";
_hvt setBehaviour "AWARE";

//Run to next car
//hint "Run to Escape Car";
_hvt assignAsCargo _veh;
_biaWP1 = (group _hvt) addWaypoint [getPos _veh, 8];
_biaWP1 setWaypointType "MOVE";
_biaWP1 setWaypointSpeed "FULL";
_biaWP1 setWaypointBehaviour "AWARE";
_biaWP1 setWaypointCombatMode "BLUE";

//Create flee pos
_playerArray = [];
{ if (_x inArea Flare_Trigger) then {_playerArray pushBack _x}; } forEach allPlayers;
_sniperPos = getPos (selectRandom _playerArray);
_feePosRaw = [_missionLocation, _radius + selectRandom[100,200,300,400], ([_sniperPos, getPos _veh] call BIS_fnc_dirTo) + selectRandom[15,30,45,60,75,345,330,315,300,285]] call BIS_fnc_relPos;
_fleePos = [_feePosRaw, 1, 200, 5, 0, 20, 0, [[_missionLocation, _radius]], _feePosRaw] call BIS_fnc_findSafePos;

//Flee pos debug
_escapeMarker = str random [11111, 55555, 99999];
createMarker [_escapeMarker, _fleePos];
_escapeMarker setMarkerType "Empty";
_escapeMarker setMarkerSize [75, 75];
_escapeMarker setMarkerShape "ELLIPSE";
_escapeMarker setMarkerBrush "SolidBorder";
_escapeMarker setMarkerColor "ColorGreen";

//Wait till arrived at car
while {_hvt distance _veh > 10} do {
	uiSleep 1;
	//hint "Waiting for HVT to arrive at car";
};
[_hvt] orderGetIn true;
//hint "HVT in escape car";

//Drive away
while { count crew _veh < 2 } do { uiSleep 1; };
_pilot enableAI "PATH";
_pilot doMove _fleePos;
while {_veh distance _fleePos > 50} do { uiSleep 1;};

//HVT escaped
hvtEscaped = true;
publicVariable "hvtEscaped";

//Make them unable to run out of escape pos
_grpPilot = group _pilot;
for "_i" from (count waypoints _grpPilot - 1) to 0 step -1 do {deleteWaypoint [_grpPilot, _i];};
_pilot disableAI "PATH";
{ unassignVehicle _x } forEach crew _veh; 
crew _veh allowGetIn false;
_hvt disableAI "PATH";