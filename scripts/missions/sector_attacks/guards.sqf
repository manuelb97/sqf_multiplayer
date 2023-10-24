//Paras
params [
["_minSpawnDistance",100],
["_maxSpawnDistance",300],
["_maxPerHouse",3],
["_despawnDistance",800],
"_cqbDist"
];

_guardTag = "Guards";
private ["_nearBuildings", "_targetPos"];
_populatedBuildings = [];

while {true} do 
{
	//Get players in enemy area
	_playerArray = [];
	{
		if (isNil "Training_Arr") then 
		{
			Training_Arr = [];
		};
		
		if (_x distance hq_pos > 100  && !(_x in Training_Arr)) then 
		{
			_playerArray pushBack _x; 
		}; 
	} forEach allPlayers;

	_maxEnemies = missionNamespace getVariable ["MaxEnemies", 20];
	_maxGuards = round(_maxEnemies / 2);
	_sideMissionActive = missionNamespace getVariable ["SideMissionActive", false];
	
	if (count _playerArray > 0 && !_sideMissionActive) then 
	{
		//Count near markers
		_allCloseMarkers = [];
		{
			_playerPos  = getPos _x;
			_closeMarkers = allMapMarkers select 
			{
				(getMarkerPos _x) distance _playerPos >= _minSpawnDistance 
				&& (getMarkerPos _x) distance _playerPos <= _maxSpawnDistance
				&& (markerColor _x) == "ColorRed"
			};
			_allCloseMarkers = _allCloseMarkers + _closeMarkers;
		} forEach _playerArray;
		
		//since we do it for every player, the same markers can occur playerAmount times in array
		_allCloseMarkers = _allCloseMarkers arrayIntersect _allCloseMarkers;
		
		if (count _allCloseMarkers > 0) then 
		{
			//Count current guards
			_totalGuards = count (allUnits select {_x getVariable "guardBool"});
			_currEnemies = count (allUnits select {side _x == east});

			if (_totalGuards < _maxGuards && _currEnemies < _maxEnemies) then 
			{
				//Get buildings close to relevant markers
				_nearBuildings = [];
				{
					_markerPos = getMarkerPos _x;
					_buildings = _markerPos nearObjects ["Building", 5];
					_nearBuildings = _nearBuildings + _buildings;
				} forEach _allCloseMarkers;

				_nearBuildings = _nearBuildings arrayIntersect _nearBuildings;
				
				//remove buildings which were used during this attack
				_nearBuildings = _nearBuildings select {!(_x in _populatedBuildings)};
				
				//Reinforce existing guards
				if (count _nearBuildings > 0) then
				{
					_guardsToSpawn = _maxGuards - _totalGuards;

					if ((_guardsToSpawn + _currEnemies) > _maxEnemies) then 
					{
						_guardsToSpawn = selectMin [_maxEnemies - _currEnemies, _maxGuards - _totalGuards];
					};

					_ratio = _guardsToSpawn / (count _nearBuildings);

					if (_ratio < 1) then
					{
						_nearBuildings = _nearBuildings call BIS_fnc_arrayShuffle;
						_nearBuildings resize _guardsToSpawn;
					};
					
					_posArr = [];
					{
						_building = _x;
						
						_currentGuards = [];
						{ 
							if (_x distance (getPos _building) < 10) then 
							{ 
								_currentGuards pushBack _x; 
							}; 
						} forEach (allUnits select {_x getVariable "guardBool"});
						
						if (count _currentGuards < 1) then
						{
							_possPosArr = [_building] call BIS_fnc_buildingPositions; //[_building, _maxPerHouse] call BIS_fnc_buildingPositions;
							_possPosArr = [_possPosArr, _maxPerHouse] call bia_inside_positions;

							if (count _possPosArr > 2) then
							{
								_possPosArr resize (selectRandom[1, 2, count _possPosArr]);
							} else
							{
								_possPosArr resize (selectRandom[1, count _possPosArr]);
							};
							
							//allow more than 1 per building if enough guards to spawn
							if (_ratio > 1 && (_guardsToSpawn - (count _possPosArr)) >= 0) then
							{
								_posArr = _posArr + _possPosArr;
								_guardsToSpawn = _guardsToSpawn - (count _possPosArr);
								_populatedBuildings pushBack _building;
							} else
							{
								if ((_guardsToSpawn - 1) >= 0) then
								{
									_possPosArr resize 1;
									_posArr = _posArr + _possPosArr;
									_guardsToSpawn = _guardsToSpawn - (count _possPosArr);
									_populatedBuildings pushBack _building;
								};
							};
						};
					} forEach _nearBuildings;
					
					if (count _posArr > 0) then 
					{
						_text = format["Spawning %1 new guards", count _posArr];
						[_guardTag, _text] remoteExec ["bia_to_log", 2];
					};

					{
						_spawnPos = _x;
						_minPlayerDist = [_spawnPos, allPlayers] call bia_closest_dist;

						if (_minPlayerDist >= _minSpawnDistance) then 
						{
							_factionInfo = [_spawnpos] call bia_house_raid_faction;
							_factionInfo params ["_tiers", "_infantry"];

							[
								["Guard", [_spawnPos], _cqbDist, 0.5, _infantry, "guardBool"]
							] remoteExec ["bia_spawn_group", missionNamespace getVariable ["BiA_Host", 2]];
							// "_grpType", "_posArr", "_cqbDist", "_chanceToLeaveBuilding", "_infantry", "_varName"
						};
					} forEach _posArr;
				};
			};
		};

		//Check for despawns
		_farGuards = [];
		{
			_unit = _x;
			_closestPlayer = [_unit, _playerArray] call bia_closest_obj;

			if (_unit distance _closestPlayer > _despawnDistance) then 
			{ 
				_farGuards pushBack _unit; 
			}; 
		} forEach (allUnits select {_x getVariable "guardBool"});
		
		if (count _farGuards > 0) then 
		{
			_text = format["Deleting far Guards"];
			[_guardTag, _text] remoteExec ["bia_to_log", 2];
			
			_usedBuildings = [];
			{
				_unitPos = getPos _x;
				_buildings = _unitPos nearObjects ["Building", 5];
				_usedBuildings = _usedBuildings + _buildings;
			} forEach _farGuards;
			
			//Delete guards
			{
				deleteVehicle _x;
			} forEach _farGuards;
			
			//Make buildings of deleted guards usable again
			_populatedBuildings = _populatedBuildings - _usedBuildings;
		};
	} else
	{

		_guardUnits = allUnits select {_x getVariable "guardBool"};

		if (count _guardUnits > 0) then 
		{
			_text = format["Deleting %1 guard units", count _guardUnits];
			[_guardTag, _text] remoteExec ["bia_to_log", 2];

			{
				deleteVehicle _x;
			} forEach _guardUnits;
		};
		
		//Reset so buildings can be used again
		_populatedBuildings = [];
	};
	
	uiSleep 1;
};