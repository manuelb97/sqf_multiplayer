/*
[[1,2,3],["test1","test2","test3"],
["Tier_4"] call compile preprocessFileLineNumbers "scripts\missions\factionUnits.sqf"] 
call compile preprocessFileLineNumbers "scripts\missions\escape\escapeEnemies.sqf";
*/

//Paras
params [
"_groupSizes",
"_missionMarkers",
"_unitsArray"
];
_missionAreaMarker	= _missionMarkers select 0;
_escapeMarker 			= _missionMarkers select 2;

//Enemy Array
_enemies = (_unitsArray select 3) + (_unitsArray select 4) + (_unitsArray select 5);

//Get player pos
_playerArray = [];
{ if (_x inArea Flare_Trigger) then {_playerArray pushBack _x}; } forEach allPlayers;

//Spawn enemies to max amount
_maxEnemies = 0;
{ _maxEnemies = _maxEnemies + _x } forEach _groupSizes;

//Count current enemies
_targetPos = (getPos (selectRandom _playerArray)) getPos [random[75,135,200], random 360];
_objOpforLoop = [];
{if (side _x == east && ((getPos _x) distance _targetPos) < 1500 && !(_x getVariable ["patrolBool",false])) then {_objOpforLoop pushBack _x}} forEach allUnits;
_currentEnemies = count _objOpforLoop;

//Spawn new units
_escapeMarkerPos = getMarkerPos _escapeMarker;
if (_currentEnemies < _maxEnemies) then {
	_enemiesToSpawn = _maxEnemies - _currentEnemies;
	_enemiesCovered = 0;
	_grpSizeSpawn = [];
	
	while {_enemiesCovered < _enemiesToSpawn} do {
		_grpSize = selectRandom _groupSizes;
		if ((_enemiesCovered + _grpSize) <= _enemiesToSpawn) then {
			_grpSizeSpawn pushBack _grpSize;
			_enemiesCovered = _enemiesCovered + _grpSize;
		};
	};
	
	{
		_targetPos = (getPos (selectRandom _playerArray)) getPos [random[75,110,150], random 360];
		_spawnPosRaw = [_targetPos, selectRandom[300,350], ([_targetPos, _escapeMarkerPos] call BIS_fnc_dirTo) + (random 360)] call BIS_fnc_relPos;
		
		//find pos without water
		while {surfaceIsWater _spawnPosRaw} do {
			_spawnPosRaw = [_targetPos, selectRandom[300,350], ([_targetPos, _escapeMarkerPos] call BIS_fnc_dirTo) + (random 360)] call BIS_fnc_relPos;
		};
		
		_spawnPos = [_spawnPosRaw, 0, 100, 3, 0, 20, 0, [[_targetPos, 300]]] call BIS_fnc_findSafePos;
		
		_grp = createGroup [east, true];
		for '_i' from 1 to _x do {
			(selectRandom _enemies) createUnit [[(_spawnPos select 0) + random 5, (_spawnPos select 1) + random 5], _grp];
		};
		
		//[_grp, _targetPos getPos [selectRandom[50,100,150,200],selectRandom[45,90,135,180,225,270,315,360]], 50, []] call bis_fnc_taskPatrol;
		_formation = selectRandom["WEDGE","ECH LEFT","ECH RIGHT","LINE"];
		_biaWP1 = _grp addWaypoint [_targetPos, 10];
		_biaWP1 setWaypointType "MOVE";
		_biaWP1 setWaypointSpeed "NORMAL";
		_biaWP1 setWaypointFormation _formation;
		_biaWP1 setWaypointBehaviour "AWARE";
		_biaWP1 setWaypointCombatMode "YELLOW";
		
		//Set skill
		[_grp] remoteExec ["bia_set_skill", 0, true];
		
		//Make group patrol sector
		//[_grp, _missionAreaMarker, "MOVE"] remoteExec ["bia_give_to_gaia", 0, true];
		
		uiSleep 10;
	} forEach _grpSizeSpawn;
};

//Equip flashlights if appropriate
remoteExec ["bia_enemy_flashlights", 0, true];