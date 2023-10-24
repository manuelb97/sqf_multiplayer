//Paras
params [
"_missionLocation",
"_missionMarkers",
["_radius",100],
"_groupSizes",
"_unitsArray"
];
_escapeMarker 			= _missionMarkers select 2;

//Prep Stuff
_finalWave = false;
_maxEnemies = 0;
{ _maxEnemies = _maxEnemies + _x; } forEach _groupSizes;

//Wait for Mission to start
while {isNil "missionLoop"} do {uiSleep 5;};
//[format ["Starting Reinforcement Loop"]] remoteExec ["hint", 0, true]; uiSleep 3;

//Start Loop
while {missionLoop == 1} do {
	//Delete outpaced enemis and redirect
	_playerArray = [];
	{ if (_x inArea Flare_Trigger) then {_playerArray pushBack _x}; } forEach allPlayers;
	
	if (count _playerArray > 0) then {
		_targetPos = getPos (selectRandom _playerArray);
		
		//Delete outpaced enemies
		_deleteUnits = [];
		{if (side _x == east && _x distance _targetPos > 600) then {_deleteUnits pushBack _x}} forEach allUnits;
		if (count _deleteUnits > 0) then {
			{ deleteVehicle _x; } forEach _deleteUnits;
			//hint format["Deleting outpaced groups"]; uiSleep 3;
		};
		
		//Give new WPs if far away from player
		_opforGroups = [];
		{if (side (leader _x) == east) then {_opforGroups pushBack _x}} forEach allGroups;
		{
			if ((leader _x) distance _targetPos > 150) then {
				//Delete outdated WPs
				for "_i" from (count waypoints _x - 1) to 0 step -1 do {deleteWaypoint [_x, _i];};
				
				//Give updated WPs
				_formation = selectRandom["WEDGE","ECH LEFT", "ECH RIGHT","LINE"];
				_biaWP1 = _x addWaypoint [_targetPos, 10];
				_biaWP1 setWaypointType "MOVE";
				_biaWP1 setWaypointSpeed "NORMAL";
				_biaWP1 setWaypointFormation _formation;
				_biaWP1 setWaypointBehaviour "AWARE";
				_biaWP1 setWaypointCombatMode "YELLOW";
			};
		} forEach _opforGroups;
		//hint format["Deleted old WPs and gave new to outpaced groups"]; uiSleep 3;
	};

	//Count enemies
	_escapeOpfor = [];
	{if ((_x distance _missionLocation) < _radius && side _x == east && !(_x getVariable ["patrolBool",false])) then {_escapeOpfor pushBack _x}} forEach allUnits;
	_escapeOpforCount = count _escapeOpfor;
	//hint format["Current enemies: %1, Max enemies: %2", _escapeOpforCount, _maxEnemies]; uiSleep 3;

	//Reinforcements
	if (_escapeOpforCount < _maxEnemies) then 
	{
		_players = allPlayers;
		_host = selectRandom _players;
		if (count _players > 1) then {
			_players = _players - [manu];
			_host = selectRandom _players;
		};
		
		//format["Spawning reinforcements"] remoteExec ["hint", 0, true]; uiSleep 3;
		[_groupSizes,_missionMarkers,_unitsArray] remoteExec ["bia_escape_enemies", _host, true];
		remoteExec ["bia_enemy_flashlights", 0, true];
		uiSleep 30;
	};

	//Final Wave
	_finalWave = [_escapeMarker, _unitsArray, _finalWave] call compile preprocessFileLineNumbers "scripts\missions\escape\escapeFinalWave.sqf";
	//if (_finalWave ) then { hint "Final Wave was spawned already"; };
	
	remoteExec ["bia_enemy_flashlights", 0, true];
	uiSleep 5;
};