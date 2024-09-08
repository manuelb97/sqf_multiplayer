//Paras
params [
["_minSpawnDistance",300],
["_maxSpawnDistance",600],
["_maxEnemies",15],
["_despawnDistance",800],
"_delay",
"_infantry",
"_debug"
];

private [
	"_tag", "_infantry", "_vehicles", "_grpSizes", "_spawnPosArr", "_playerArr", "_playerCount", 
	"_targetPos", "_deleteOpfor", "_opforPatrolGroups", "_patrolOpfor", "_patrolEnemyCount", "_enemiesToSpawn", "_enemiesForSpawn",
	"_size", "_spawnPos", "_oldPlayerPos","_newPlayerPos","_playerDistance", "_trainingArr"
];

_patrolTag = "PatrolLoop";
[_patrolTag, "Patrol Script started"] spawn bia_to_log;

_initialMax = _maxEnemies;
_grpSizes = [1, 2, 3, 4, 5];
_spawnPosArr = [_minSpawnDistance, _minSpawnDistance + ((_maxSpawnDistance - _minSpawnDistance)/2), _maxSpawnDistance];
_nextSpawnTime = serverTime + _delay ;//random [_delay / 2, _delay, _delay + (_delay / 2)];
_lastInfoDisplayed = 0;
_patrolVariable = "patrolBool";
_infoBreak = 60;
_lastPlayerCount = 0;

while {true} do 
{
	//get current relevant players
	_trainingArr = missionNamespace getVariable ["Training_Arr", []];
	_overwatchArr = missionNamespace getVariable ["Overwatch_Arr", []];
	_playerArr = allPlayers select 
	{
		_x distance2D hq_pos > 200
		&& !(_x in _trainingArr)
		&& !(_x in _overwatchArr)
		&& (vehicle _x == _x || typeOf (vehicle _x) == "B_Parachute") 
	};
	_playerCount = count _playerArr;

	_maxEnemies = _initialMax * count(allPlayers);
	_maxTotal = missionNamespace getVariable ["MaxEnemies", 30];
	
	//procede if relevent players around
	if (_playerCount > 0 && !(missionNamespace getVariable ["SideMissionActive", false])) then 
	{
		//Delete far patrol enemies
		_deleteOpfor = allUnits select 
		{
			_unit = _x;
			_closestDist = [_unit, _playerArr] call bia_closest_dist;

			_x getVariable [_patrolVariable, false] &&
			_closestDist > _despawnDistance
		};
		
		if (count _deleteOpfor > 0) then 
		{
			[_patrolTag, "Deleting far away Patrols"] spawn bia_to_log;
			
			{
				deleteVehicle _x;
			} forEach _deleteOpfor;
		};
		
		//Reset WPs for already spawned groups if player moved on
		_targetPos = getPos (selectRandom _playerArr);

		if (isNil "_oldPlayerPos") then 
		{
			_oldPlayerPos = _targetPos;
			_newPlayerPos = nil;
			_playerDistance = 0;
		} else 
		{
			_newPlayerPos = _targetPos;
			_playerDistance = _newPlayerPos distance _oldPlayerPos;
		};
		
		_opforPatrolGroups = allGroups select {(side _x) == east && (leader _x) getVariable _patrolVariable};
		
		if (!isNil "_newPlayerPos" && _playerDistance > 50 && count _opforPatrolGroups > 0) then 
		{
			// [_patrolTag, "Giving new WPs to existing Patrols"] spawn bia_to_log;
			
			{
				for "_i" from (count waypoints _x - 1) to 0 step -1 do 
				{
					deleteWaypoint [_x, _i];
				};
				
				["Patrol", _x, getPos leader _x, _targetPos, 150, _debug] spawn bia_group_patrol;
			} forEach _opforPatrolGroups;
			
			//Reset for future evaluation
			_oldPlayerPos = nil;
		};
		
		_patrolOpfor = allUnits select {(side _x) == east && _x getVariable [_patrolVariable, false]};
		_patrolEnemyCount = count _patrolOpfor;
		
		//Spawn new groups
		_enemyUnits = allUnits select {side _x == east};
		if 
		(
			_patrolEnemyCount < _maxEnemies 
			&& count _enemyUnits < _maxTotal 
			&& !(missionNamespace getVariable ["SideMissionActive", false])
			&& !(missionNamespace getVariable ["ReduceEnemies", false])
		) then 
		{
			// [_patrolTag, "Trying to spawn new Patrols"] spawn bia_to_log;
			
			_enemiesToSpawn = selectMin[_maxEnemies - _patrolEnemyCount, _maxTotal - (count _enemyUnits)];
			_grpSizes = [];
			_enemiesForSpawn = 0;
			
			while {_enemiesForSpawn < _enemiesToSpawn} do
			{
				_size = selectRandomWeighted 
				[
					1, 1,
					2, 3.5,
					3, 4,
					4, 2,
					5, 1
				];
				
				if ((_enemiesForSpawn + _size) <= _enemiesToSpawn) then
				{
					_grpSizes pushBack _size;
					_enemiesForSpawn = _enemiesForSpawn + _size;
				};
			};

			// hint str [_enemiesToSpawn, _enemiesForSpawn, _grpSizes];
			
			{
				_size = _x;
				_spawnPos = [getPos (selectRandom _playerArr), allPlayers, 1, _minSpawnDistance, _maxSpawnDistance, _debug] call bia_concealed_pos;
				
				_wpPosArr = []; //currently we use bis patrol
				// for "_i" from 1 to 4 do 
				// {
				// 	_wpPosArr pushBack ((getPos (selectRandom _playerArr)) getPos [random [100,150,200], random 360]);
				// };

				if (count _spawnPos > 0) then 
				{
					if (_spawnPos distance2D hq_pos > _minSpawnDistance && serverTime > _nextSpawnTime) then 
					{
						[
							["Patrol", _size, _spawnPos, _targetPos, _wpPosArr, _infantry, _patrolVariable, 50, _debug]
						] remoteExec ["bia_spawn_group", missionNamespace getVariable ["BiA_Host", 2]]; //spawn bia_spawn_group; //
						// [["Patrol", _size, _spawnPos, _targetPos, _wpPosArr, _infantry, _patrolVariable, 50, _debug]] spawn bia_spawn_group;
						
						[_patrolTag, "Spawning new Patrols"] spawn bia_to_log;
			
						_nextSpawnTime = serverTime + _delay; //random [_delay / 2, _delay, _delay + (_delay / 2)];
					};
				};
			} forEach _grpSizes;
		} else 
		{

			if (_patrolEnemyCount >= _maxEnemies && serverTime > (_lastInfoDisplayed + _infoBreak)) then 
			{
				[_patrolTag, "Max amount of Patrols reached"] spawn bia_to_log;
				_lastInfoDisplayed = serverTime;
			};

			if (count _enemyUnits >= _maxTotal && serverTime > (_lastInfoDisplayed + _infoBreak)) then 
			{
				[_patrolTag, "Max amount of active Enemies reached"] spawn bia_to_log;
				_lastInfoDisplayed = serverTime;
			};

			if (missionNamespace getVariable ["SideMissionActive", false] && serverTime > (_lastInfoDisplayed + _infoBreak)) then 
			{
				[_patrolTag, "Patrols deactivated due to active SideMission"] spawn bia_to_log;
				_lastInfoDisplayed = serverTime;
			};
		};
	} else 
	{
		//delete all patrols as no player outside of hq 
		{
			deleteVehicle _x;
		} forEach (allUnits select {_x getVariable [_patrolVariable, false]});

		if (serverTime > (_lastInfoDisplayed + _infoBreak) && _lastPlayerCount != count _playerArr) then 
		{
			_lastPlayerCount = count _playerArr;
			[_patrolTag, "No players outside of HQ"] spawn bia_to_log;
			_lastInfoDisplayed = serverTime;
		};
	};
	
	uiSleep 5;
};