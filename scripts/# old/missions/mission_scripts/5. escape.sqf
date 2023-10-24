/*
_markers = ["Escape",getPos manu,200] call compile preprocessFileLineNumbers "scripts\missions\missionMarkers.sqf";
_unitsArray = ["Tier_4"] call compile preprocessFileLineNumbers "scripts\missions\factionUnits.sqf";

[getPos manu, 1000, _markers, 1000, [], [1,2,3,4],_unitsArray] execVM "scripts\missions\mission_scripts\5. escape.sqf";

_markers = ["Escape",getPos manu,200] call compile preprocessFileLineNumbers "scripts\missions\missionMarkers.sqf";
_unitsArray = ["Tier_4"] call compile preprocessFileLineNumbers "scripts\missions\factionUnits.sqf";

[getPos manu,"medium", _markers,1000,[],[1,2,3,4],_unitsArray] remoteExec ["bia_escape1", 0, true];

[getPos manu,"medium", _markers,1000,[],[1,2,3,4],_unitsArray] execVM "scripts\missions\mission_scripts\5. escape.sqf";
*/

//Paras
params [
"_missionLocation",
["_missionArea","small"],
"_missionMarkers",
["_radius",100],
"_escapeVehicles",
"_groupSizes",
"_unitsArray"
];

//set escape marker
_escapeMarker = _missionMarkers select 2;

//spawn boats if necessary
//[_missionLocation,_escapeMarker] remoteExec ["bia_escape_boats", selectRandom allPlayers, true];

//Create Task
_bia_taskName = str random [11111, 55555, 99999];
_markerPos = _missionLocation;
_players = if (isMultiplayer) then {playableUnits} else {[player]};
[_bia_taskName, _players, ["Escape the Sector", "Sector Escape", "mil_warning"], _markerPos, "ASSIGNED", 2, true, true, "run"] remoteExec ["BIS_fnc_setTask", 0, true];

//Give players info
"Grab your Loadout" remoteExec ["hint", 0, true];
uiSleep 3;
_timer = 37;
[format["Mission starts in %1 seconds",_timer]] remoteExec ["hint", 0, true];
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

//Create start pos and teleport players
"You are being teleported" remoteExec ["hint", 0, true];
uiSleep 3;
_startPos = _missionLocation;
{
	_x setPos _startPos;
} forEach allPlayers;

//Spawn enemies
[_groupSizes,_missionMarkers,_escapeMarker,_unitsArray,false] remoteExec ["bia_escape_enemies", selectRandom allPlayers, true];

//Remove HALO action + add rejoin action
[mission_prep, HaloID] remoteExec ["removeAction", 0, true];
[mission_prep,["Teleport to Team Mate","scripts\missions\escape\teleportToFriendlies.sqf",[],1.5,true,false,"","true",5,false,"",""]] remoteExec ["addAction", 0, true];
_friendlyTeleportID = (actionIDs mission_prep) select 0;

//Start Reinforcement Loop
[_missionLocation,_missionMarkers,_radius,_groupSizes,_unitsArray] remoteExec ["bia_escapeReinforcementLoop", selectRandom allPlayers, true];

//Mission Loop
missionLoop = 1;
publicVariable "missionLoop";
_survivedinZone = false;

while {missionLoop == 1} do {
	//Check Current Mission State
	_objBluforLoop = [];
	{if ((_x distance _missionLocation) < (_radius + 300)) then {_objBluforLoop pushBack _x}} forEach allPlayers;
	_newFriendlyObjCount = count _objBluforLoop;
	_escapedPlayers = [];
	{ if (_x inArea _escapeMarker) then {_escapedPlayers pushBack _x;}; } forEach allPlayers;
	
	if (count _escapedPlayers == count allPlayers) then {
		"Survive for one more moment" remoteExec ["hintSilent", 0, true];
		uiSleep 30;
		
		_escapedPlayers = [];
		{ if (_x inArea _escapeMarker) then {_escapedPlayers pushBack _x;}; } forEach allPlayers;
		
		if (count _escapedPlayers == count allPlayers) then {
			_survivedinZone = true;
		};
	};
	
	//Win
	if (_survivedinZone) then {
		missionLoop = 0;
		publicVariable "missionLoop";
		[_bia_taskName,"SUCCEEDED", true] remoteExec ["BIS_fnc_taskSetState", 0, true];

		//Add mission pos to database
		[[_missionLocation],"scripts\writeToDatabase.sqf"] remoteExecCall ["execVM", 2, false];

		//Delete markers
		{ deleteMarker _x; } forEach _missionMarkers;
	};
	
	//Loss
	if (_newFriendlyObjCount == 0) then {
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
uiSleep 3;
{ 
	if (_x distance hq_pos > 1000) then {
		_x setPosATL (getPosATL hq_pos); 
	};
} forEach allPlayers;

//Delete enemies
_opfor = [];
{if ((side _x) == east) then {_opfor pushBack _x}} forEach allUnits;
{deleteVehicle _x;} forEach _opfor;

//Delete teleport action + re-add HALO action
[mission_prep, _friendlyTeleportID] remoteExec ["removeAction", 0, true];
[mission_prep,['H.A.L.O.','scripts\HALO.sqf',nil,1.5,true,false,"","true",5,false,"",""]] remoteExec ["addAction", 0, true];
HaloID = (actionIDs mission_prep) select 0;
publicVariable "HaloID";