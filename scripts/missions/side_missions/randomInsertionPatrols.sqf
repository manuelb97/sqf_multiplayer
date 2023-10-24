//Paras
params [
["_minSpawnDistance",300],
["_maxSpawnDistance",600],
["_maxEnemies",15],
["_despawnDistance",800],
"_delay",
"_dir",
"_infantry",
"_debug"
];

private [
	"_tag", "_infantry", "_vehicles", "_grpSizes", "_spawnPosArr", "_playerArr", "_playerCount", 
	"_targetPos", "_deleteOpfor", "_opforPatrolGroups", "_patrolOpfor", "_patrolEnemyCount", "_enemiesToSpawn", "_enemiesForSpawn",
	"_size", "_spawnPos", "_oldPlayerPos","_newPlayerPos","_playerDistance", "_trainingArr"
];

_patrolTag = "RandomInsertionEnemies";
_grpSizes = [1, 2, 3, 4, 5];
_spawnPosArr = [_minSpawnDistance, _minSpawnDistance + ((_maxSpawnDistance - _minSpawnDistance)/2), _maxSpawnDistance];
_nextSpawnTime = 0; //serverTime + random [_delay / 2, _delay, _delay + (_delay / 2)]; // enable insta spawn
_lastInfoDisplayed = 0;
_maxNotReached = true;

while {missionNamespace getVariable ["SideMissionActive", false]} do 
{
	//get current relevant players
	_playerArr = allPlayers; // select {_x distance2D hq_pos > 200};
	_playerCount = count _playerArr;
	
	//procede if relevent players around
	if (_playerCount > 0) then 
	{
		//Delete far patrol enemies
		_deleteOpfor = [];
		{
			_unit = _x;
			_closestDist = [_unit, _playerArr] call bia_closest_dist;

			if (_closestDist > _despawnDistance && _unit getVariable ["huntBool", false]) then 
			{
				_deleteOpfor pushBack _unit;
			};
		} forEach allUnits select {side _x != west};
		
		if (count _deleteOpfor > 0) then 
		{
			[_patrolTag, "Deleting far away Patrols", _debug] spawn bia_to_log;
			
			{
				deleteVehicle _x;
			} forEach _deleteOpfor;
		};
		
		//Spawn new groups
		_patrolOpfor = allUnits select {(side _x) == east && _x getVariable ["huntBool", false]};
		_patrolEnemyCount = count _patrolOpfor;
		_enemyUnits = allUnits select {(side _x) == east};
		
		if (_patrolEnemyCount < _maxEnemies) then 
		{
			[_patrolTag, "Spawning new Patrols", _debug] spawn bia_to_log;
			
			_enemiesToSpawn = _maxEnemies - _patrolEnemyCount;
			_grpSizes = [];
			_enemiesForSpawn = 0;
			
			while {_enemiesForSpawn < _enemiesToSpawn} do
			{
				_size = selectRandomWeighted 
				[
					1, 1
					,2, 3.5
					,3, 4
					// ,4, 2
					// ,5, 1
				];
				
				if ((_enemiesForSpawn + _size) <= _enemiesToSpawn) then
				{
					_grpSizes pushBack _size;
					_enemiesForSpawn = _enemiesForSpawn + _size;
				};
			};
			
			{
				_size = _x;
				_spawnPos = [getPos (selectRandom _playerArr), allPlayers, 1, _minSpawnDistance, _maxSpawnDistance, _debug] call bia_concealed_pos;
				_posCandidateDir = (selectRandom _playerArr) getDir _spawnPos;

				if (count _spawnPos > 0) then  // && (abs(_posCandidateDir - _dir) < 90)
				{
					if (_spawnPos distance2D hq_pos > _minSpawnDistance && (serverTime > _nextSpawnTime || _maxNotReached)) then 
					{
						// [_patrolTag, format["%1: %2 accepted", _dir, _posCandidateDir], _debug] spawn bia_to_log;

						[
							["Hunt", _size, _spawnPos, selectRandom _playerArr, _infantry, "huntBool", _debug]
						] remoteExec ["bia_spawn_group", missionNamespace getVariable ["BiA_Host", 2]];

						_nextSpawnTime = serverTime + random [_delay / 2, _delay, _delay + (_delay / 2)];
					};
				};
			} forEach _grpSizes;
		} else 
		{
			if (_patrolEnemyCount >= _maxEnemies && serverTime > (_lastInfoDisplayed + 60)) then 
			{
				[_patrolTag, "Max amount of Patrols reached", _debug] spawn bia_to_log;
				_lastInfoDisplayed = serverTime;
				_maxNotReached = false;
			};

			if (count _enemyUnits >= _maxEnemies && serverTime > (_lastInfoDisplayed + 60)) then 
			{
				[_patrolTag, "Max amount of active Enemies reached", _debug] spawn bia_to_log;
				_lastInfoDisplayed = serverTime;
			};
		};
	};
	
	uiSleep 5;
};