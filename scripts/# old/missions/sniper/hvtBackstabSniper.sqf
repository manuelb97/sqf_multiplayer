//Paras
_hvtPos 		= param [0,[]];
_playerArray  	= param [1,[]];
_unitsArray 	= param [2,[]];

//Target Player
_targetPos = getPos (selectRandom _playerArray);

//Determine where patrols should spawn to backstab sniper
_spawnPosRaw = [_targetPos, selectRandom[300,350], ([_hvtPos, _targetPos] call BIS_fnc_dirTo) + selectRandom[15,30,45,60,75,345,330,315,300,285]] call BIS_fnc_relPos;

//Spawn backstabbers
_enemies = (_unitsArray select 3) + (_unitsArray select 4) + (_unitsArray select 5);
for '_i' from 1 to 3 do {
	_spawnPos = [_spawnPosRaw, 10, 200, 3, 0, 20, 0, [[_targetPos, 300]]] call BIS_fnc_findSafePos;
	
	_grp = createGroup [east, true];
	for '_i' from 1 to selectRandom[3,4] do {
		(selectRandom _enemies) createUnit [[(_spawnPos select 0) + random 4, (_spawnPos select 1) + random 4], _grp];
	};
	
	//Set skill
	[_grp] remoteExec ["bia_set_skill", 0, true];
	
	//Give updated WPs
	_biaWP1 = _grp addWaypoint [_targetPos, 10];
	_biaWP1 setWaypointType "SAD";
	_biaWP1 setWaypointSpeed "FULL";
	_biaWP1 setWaypointFormation (selectRandom["WEDGE","ECH LEFT","ECH RIGHT","LINE"]);
	_biaWP1 setWaypointBehaviour "AWARE";
	_biaWP1 setWaypointCombatMode "YELLOW";
};