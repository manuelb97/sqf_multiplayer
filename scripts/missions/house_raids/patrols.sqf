//Paras
params [
["_minSpawnDistance",300],
["_maxSpawnDistance",600],
"_maxWaveSize",
["_despawnDistance",800],
"_baseDelay"
];

_patrolTag = "Patrols";
_grpSizes = [1,2,3,4,5];
_spawnPosArr = [_minSpawnDistance, _minSpawnDistance + ((_maxSpawnDistance - _minSpawnDistance)/2),  _maxSpawnDistance];
private ["_oldPlayerPos","_newPlayerPos","_playerDistance"];
_oldDelay = _baseDelay;
_lastDisplayed = 0;

while {true} do 
{
	_currAggro = missionNamespace getVariable ["Aggression", 0];
	_aggroCoef = 1 - (_currAggro / 100);
	_delay = selectMax [_baseDelay / 4, _baseDelay * _aggroCoef];

	_playerArray = [];
	{
		if (isNil "Training_Arr") then 
		{
			Training_Arr = [];
		};
		
		if 
		(
			_x distance2D hq_pos > 100  
			&& !(_x in Training_Arr)
			&& !(surfaceIsWater getPos _x)
		) then 
		{
			_playerArray pushBack _x;
		};
	} forEach allPlayers;
	
	_maxEnemies = missionNamespace getVariable ["MaxEnemies", 20];
	_maxPatrols = round (_maxEnemies / 2);
	_sideMissionActive = missionNamespace getVariable ["SideMissionActive", false];
	
	if (count _playerArray > 0 && !_sideMissionActive) then 
	{
		//Delete enemies who are out of place and are spawned by patrol script
		_deleteOpfor = [];
		{
			if (([_x, _playerArray] call bia_closest_dist) > _despawnDistance && _x getVariable "patrolBool") then 
			{
				_deleteOpfor pushBack _x;
			};
		} forEach allUnits;
		
		if (count _deleteOpfor > 0) then 
		{
			_text = format["Deleting too far away patrols"];
			[_patrolTag, _text] remoteExec ["bia_to_log", 2]; 
			
			{
				deleteVehicle _x;
			} forEach _deleteOpfor;
		};
		
		//Reset WPs for already spawned groups if player moved on
		_opforPatrolGroups = [];
		{
			if ((leader _x) getVariable ["patrolBool", false]) then 
			{
				_opforPatrolGroups pushBack _x;
			};
		} forEach allGroups;
		
		{
			_grp = _x;
			_grpPos = getPos (leader _grp);
			_wpPos = getWPPos [_grp, 1];
			_closestPlayer = [_grpPos, _playerArray] call bia_closest_obj;

			if (_wpPos distance _closestPlayer > 100) then 
			{
				for "_i" from (count waypoints _x - 1) to 0 step -1 do 
				{
					deleteWaypoint [_x, _i];
				};
				
				["Patrol", _grp, getPos leader _grp, getPos _closestPlayer, 100] call bia_group_patrol;
			};
		} forEach _opforPatrolGroups;
		
		//Spawn new groups
		_patrolOpfor = [];
		{
			if (_x getVariable "patrolBool") then 
			{
				_patrolOpfor pushBack _x;
			};
		} forEach allUnits;
		_patrolEnemyCount = count _patrolOpfor;
		
		_currEnemies = count (allUnits select {side _x == east});
		
		if (_patrolEnemyCount < _maxPatrols && _currEnemies < _maxEnemies) then 
		{
			_enemiesToSpawn = selectMin [_maxPatrols - _patrolEnemyCount, _maxWaveSize];

			if ((_enemiesToSpawn + _currEnemies) > _maxEnemies) then 
			{
				_enemiesToSpawn = selectMin [_maxEnemies - _currEnemies, _maxPatrols - _patrolEnemyCount];
			};

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
			
			_loggedInfo = false;

			{
				_targetPos = getPos (selectRandom _playerArray);
				_size = _x;
				_spawnPos = [_targetPos, _playerArray, 1, _minSpawnDistance, _maxSpawnDistance] call bia_concealed_pos;
				
				if (count _spawnPos > 0) then
				{
					if (!_loggedInfo) then 
					{
						_text = format["Spawning new Patrols"];
						[_patrolTag, _text] remoteExec ["bia_to_log", 2]; 
						_loggedInfo = true;
					};

					_wpPosArr = [];
					{
						_player = _x;
						for "_i" from 1 to 3 do 
						{
							_wpPosArr pushBack (_player getPos [random 50, random 360]);
						};
					} forEach _playerArray;

					_factionInfo = [_spawnpos] call bia_house_raid_faction;
					_factionInfo params ["_tiers", "_infantry"];

					[
						["Patrol", _size, _spawnPos, _targetPos, _wpPosArr, _infantry, "patrolBool", random [50, 75,100]]
					] remoteExec ["bia_spawn_group", missionNamespace getVariable ["BiA_Host", 2]];
				};
			} forEach _grpSizes;
			
			uiSleep _delay;
		} else 
		{
			if (serverTime > (_lastDisplayed + 120)) then 
			{
				_text = format["Max amount of Patrols reached"];
				[_patrolTag, _text] remoteExec ["bia_to_log", 2]; 

				_lastDisplayed = serverTime;
			};
		};
	} else 
	{
		//Delete patrols if no players in combat zone
		_deleteOpfor = [];
		{
			if (_x getVariable "patrolBool") then 
			{
				_deleteOpfor pushBack _x;
				
				if (vehicle _x != _x) then {
					_deleteOpfor pushBack (vehicle _x);
				};
			};
		} forEach allUnits;
		
		if (count _deleteOpfor > 0) then 
		{ 
			_text = format["Deleting %1 patrols", count _deleteOpfor];
			[_patrolTag, _text] remoteExec ["bia_to_log", 2]; 

			{
				deleteVehicle _x;
			} forEach _deleteOpfor; 
		};
	};
	
	uiSleep 5;
};