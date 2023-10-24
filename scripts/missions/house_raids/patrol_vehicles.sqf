//Paras
params [
["_minSpawnDistance", 300],
["_maxSpawnDistance", 600],
["_maxVehicles", 1],
["_despawnDistance", 800],
"_baseDelay"
];

_patrolVehTag = "PatrolVehicles";

patrolVehiclesActive = true;
_spawnPosArr = [_minSpawnDistance, _minSpawnDistance + ((_maxSpawnDistance - _minSpawnDistance)/2),  _maxSpawnDistance];
private ["_oldPlayerPos","_newPlayerPos","_playerDistance"];
_oldDelay = _baseDelay;
_lastDisplayed = 0;

while {patrolVehiclesActive} do 
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

	_sideMissionActive = missionNamespace getVariable ["SideMissionActive", false];
	
	if (count _playerArray > 0 && !_sideMissionActive) then 
	{
		_targetPlayer = selectRandom _playerArray;
		_targetPos = getPos _targetPlayer;
		
		//Delete enemies who are out of place and are spawned by patrol script
		_deleteOpfor = [];
		{
			_unit = _x;
			_closestPlayer = [_unit, _playerArray] call bia_closest_obj;

			if (_x distance _closestPlayer > _despawnDistance) then 
			{
				_deleteOpfor pushBack _x;
			};
		} forEach (allUnits select {_x getVariable "patrolVehicleBool"});
		
		if (count _deleteOpfor > 0) then 
		{
			_text = format["Deleting too far away Patrol Vehicles"];
			[_patrolVehTag, _text] remoteExec ["bia_to_log", 2]; 
			
			{
				deleteVehicle _x;
			} forEach _deleteOpfor;
		};
		
		//Reset WPs for already spawned groups if player moved on
		_opforPatrolGroups = allGroups select {(leader _x) getVariable ["patrolVehicleBool", false]};
		
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
		
		//Spawn Vehicles
		_currentVehicles = vehicles select 
		{
			_x getVariable "patrolVehicleBool"
			&& count (crew _x) > 0
		};
		_vehicleCount = count _currentVehicles; 
		
		_currEnemies = count (allUnits select {side _x == east});
		_maxEnemies = missionNamespace getVariable ["MaxEnemies", 20];

		if (_vehicleCount < _maxVehicles && _currEnemies < _maxEnemies) then 
		{
			_vehiclesToSpawn = _maxVehicles - _vehicleCount;
			_loggedInfo = false;

			for "_i" from 1 to _vehiclesToSpawn do 
			{
				_targetPos = getPos (selectRandom _playerArray);
				_spawnPos = [_targetPos, _playerArray, 5, _minSpawnDistance, _maxSpawnDistance] call bia_concealed_pos;
				
				if (count _spawnPos > 0) then
				{
					if (!_loggedInfo) then 
					{
						_text = format["Spawning %1 new Patrol vehicles", _vehiclesToSpawn];
						[_patrolVehTag, _text] remoteExec ["bia_to_log", 2]; 
						_loggedInfo = true;
					};

					_factionInfo = [_spawnpos] call bia_house_raid_faction;
					_factionInfo params ["_tiers", "_infantry"];
					_vehicles = [_tiers, "ground_combat_vehicles"] call bia_faction_mix; 
					_vehicle = "rhsusf_m1025_w_m2"; //selectRandom _vehicles;

					[
						"Patrol", _spawnpos, _targetPos, 200, _infantry, _vehicle, "Combat", "patrolVehicleBool"
					] remoteExec ["bia_spawn_veh_group", missionNamespace getVariable ["BiA_Host", 2]];
				};
				
				uiSleep _delay;
			};
		} else 
		{
			if (serverTime > (_lastDisplayed + 120)) then 
			{
				_text = format["Max amount of Patrol Vehicles reached"];
				[_patrolVehTag, _text] remoteExec ["bia_to_log", 2]; 

				_lastDisplayed = serverTime;
			};
		};
	} else 
	{
		//Delete patrols if no players in combat zone
		_deleteOpfor = [];
		{
			_deleteOpfor pushBack _x;
		} forEach (allUnits select {_x getVariable "patrolVehicleBool"});

		{
			_deleteOpfor pushBack _x;
		} forEach (vehicles select {_x getVariable "patrolVehicleBool"});
		
		if (count _deleteOpfor > 0) then 
		{ 
			_text = format["Deleting Patrol Vehicles"];
			[_patrolVehTag, _text] remoteExec ["bia_to_log", 2]; 
			
			{
				deleteVehicle _x;
			} forEach _deleteOpfor; 
		};
	};
	
	uiSleep 5;
};