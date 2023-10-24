//Paras
_escapeMarker 	= param [0,""];
_unitsArray 		= param [1,[]];
_finalWave 			= param [2,false];

//Enemy Array
_enemies = (_unitsArray select 3) + (_unitsArray select 4) + (_unitsArray select 5);

//Get player pos
_playerArray = [];
{ if (_x inArea Flare_Trigger) then {_playerArray pushBack _x}; } forEach allPlayers;

//Count current enemies
_targetPos = getPos (selectRandom _playerArray);

//Spawn final wave
_escapeMarkerPos = getMarkerPos _escapeMarker;
if (_targetPos distance _escapeMarkerPos < 500 && !(_finalWave)) then {
	_finalWave = true;
	//format["Spawning final wave"] remoteExec ["hint", 0, true]; 
	
	_finalGrpSizes = [];
	for '_i' from 1 to 3 do {
		_spawnPos = [_escapeMarkerPos, 0, 100, 3, 0, 20, 0, [[_targetPos, 400]]] call BIS_fnc_findSafePos;
		
		_grp = createGroup [east, true];
		for '_i' from 1 to selectRandom[3,4] do {
			(selectRandom _enemies) createUnit [[(_spawnPos select 0) + random 4, (_spawnPos select 1) + random 4], _grp];
		};
		
		//Give updated WPs
		_formation = selectRandom["WEDGE","ECH LEFT","ECH RIGHT","LINE"];
		_biaWP1 = _grp addWaypoint [_targetPos, 10];
		_biaWP1 setWaypointType "SAD";
		_biaWP1 setWaypointSpeed "FULL";
		_biaWP1 setWaypointFormation _formation;
		_biaWP1 setWaypointBehaviour "AWARE";
		_biaWP1 setWaypointCombatMode "YELLOW";
		
		//Set skill
		[_grp] remoteExec ["bia_set_skill", 0, true];
	};
};

//Equip flashlights if appropriate
remoteExec ["bia_enemy_flashlights", 0, true];

//Return if final wave spawned
_finalWave