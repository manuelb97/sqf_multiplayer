//Paras
params [
["_minSpawnDistance",100],
["_maxSpawnDistance",300],
["_guardsPerPlayer",2],
["_maxPerHouse",3],
["_despawnDistance",800],
"_cqbDist",
"_chanceToLeaveBuilding",
"_unitArray",
"_debug"
];

_guardsTag = "GuardLoop";
_infantry = _unitArray;//(_unitArray select 3) + (_unitArray select 4) + (_unitArray select 5);
private ["_nearBuildings", "_targetPos"];
_populatedBuildings = [];
_guardVariable = "guardBool";
_relMarkerTypes = missionNamespace getVariable ["MarkerTypes", []];

_lastInfoDisplayed = 0;
_infoBreak = 60;

while {true} do 
{
	//Get players in enemy area
	_trainingArr = missionNamespace getVariable ["Training_Arr", []];
	_overwatchArr = missionNamespace getVariable ["Overwatch_Arr", []];

	_playerArray = allPlayers select 
	{
		_x distance2D hq_pos > 200
		&& !(_x in _trainingArr)
		&& !(_x in _overwatchArr)
		&& (vehicle _x == _x || typeOf (vehicle _x) == "B_Parachute") 
	};
	_playerCount = count _playerArray;
	
	if (_playerCount > 0 && !(missionNamespace getVariable ["SideMissionActive", false])) then 
	{
		//Despawn far guards
		_farGuards = allUnits select 
		{
			_unit = _x;
			_dists = _playerArray apply {_x distance2D _unit};
			// _closestDistToPlayer = [getPos _unit, _playerArray] call bia_closest_dist;

			_unit getVariable [_guardVariable, false] &&
			(selectMin _dists) > _despawnDistance
		};

		if (count _farGuards > 0) then 
		{
			[_guardsTag, "Deleting far guards"] spawn bia_to_log;

			{
				deleteVehicle _x;
			} forEach _farGuards;
		};

		//check if guards are needed 
		_maxGuards = _guardsPerPlayer * _playerCount;
		_currGuards = allUnits select {_x getVariable [_guardVariable, false]};

		if (count _currGuards < _maxGuards && !(missionNamespace getVariable ["ReduceEnemies", false])) then 
		{
			//Check for buildings close to players
			_nearBuildings = [];
			{
				_player = _x;
				_buildings = _player nearObjects ["Building", _maxSpawnDistance];

				_buildings = _buildings select 
				{
					_building = _x;

					_closeMarkers = allMapMarkers select 
					{
						markerType _x in _relMarkerTypes
						&& (getMarkerPos _x) distance2D _building < 100
					};

					_closePlayers = _playerArray select 
					{
						_x distance2D _building < _minSpawnDistance
					};

					_ret = false;
					if (count _closeMarkers < 1 && count _closePlayers < 1) then 
					{
						_ret = true;
					};

					_ret
				};

				_nearBuildings = _nearBuildings + _buildings;
			} forEach _playerArray;
			
			//avoid duplicates
			_nearBuildings = _nearBuildings arrayIntersect _nearBuildings;

			//remove buildings which were used during this attack
			_nearBuildings = _nearBuildings select {!(_x in _populatedBuildings)};

			// [_guardsTag, format["%1 close Buildings outside of sectors found", count _nearBuildings]] spawn bia_to_log;
			
			//spawn guards
			if (count _nearBuildings > 0) then
			{
				_posArr = [];
				{
					_building = _x;
					_buildingGuards = _currGuards select {_x distance2D _building < 10};

					_posArrAdd = [_building] call BIS_fnc_buildingPositions;
					_posArrAdd = _posArrAdd call BIS_fnc_arrayShuffle;

					if (count _buildingGuards < 1) then 
					{
						if (count _posArrAdd > 2) then
						{
							_posArrAdd resize ceil(random 3);
						} else
						{
							_posArrAdd resize ceil(random count _posArrAdd);
						};

						_posArr append _posArrAdd;
					};
				} forEach _nearBuildings;

				if (count _posArr > 0) then 
				{
					//sort to get closest positions to players
					_posArr = [_posArr, [], 
					{
						_pos = _x;
						_nearestPlayer = ([_playerArray, [], {_x distance2D _pos}, "ASCEND"] call BIS_fnc_sortBy) select 0;
						_pos distance2D _nearestPlayer
					}, "ASCEND"] call BIS_fnc_sortBy;

					//get closest positions which are far enough apart from another 
					_guardsToSpawn = _maxGuards - (count _currGuards);
					_ratio = _guardsToSpawn / (count _nearBuildings);
					_finalPositions = [];

					for "_i" from 1 to _guardsToSpawn do 
					{
						if (_i == 1) then 
						{
							_closestPos = _posArr select 0;
							_finalPositions pushBack _closestPos;
							_posArr deleteAt (_posArr find _closestPos);
						} else 
						{
							_posAdded = false;
							{
								_pos = _x;
								if (!_posAdded) then 
								{	
									_dists = _finalPositions apply {_pos distance2D _x};
									// _closestDisToSelPos = [_pos, _finalPositions] call bia_closest_dist;

									if ((selectMin _dists) > 10) then 
									{
										_finalPositions pushBack _pos;
										_posArr deleteAt (_posArr find _pos);
										_posAdded = true;
									};
								};
							} forEach _posArr;
						};
					};
					
					// [_guardsTag, format["%1 final house positions found for %2 potential guards", count _finalPositions, _guardsToSpawn]] spawn bia_to_log;

					//Populate selected positions
					if (count _finalPositions > 0) then 
					{
						_chosenBuildings = _finalPositions apply {nearestBuilding _x};
						_chosenBuildings = _chosenBuildings arrayIntersect _chosenBuildings;
						_populatedBuildings append _chosenBuildings;
						_targetPos = getPos (selectRandom _playerArray);
						[["Guard", _finalPositions, _cqbDist, _chanceToLeaveBuilding, _infantry, _guardVariable, _debug]] remoteExec ["bia_spawn_group", missionNamespace getVariable ["BiA_Host", 2]];
					};
				};
			};
		};
	} else 
	{
		//Reset so buildings can be used again
		if (count _populatedBuildings > 0) then 
		{
			[_guardsTag, format["Resetting available buildings as no players outside of HQ"]] spawn bia_to_log;
			_populatedBuildings = [];
		};

		//Despawn all guards
		_guards = allUnits select {_x getVariable [_guardVariable, false]};

		if (count _guards > 0) then 
		{
			[_guardsTag, format["Deleting all guards as no players outside of HQ"]] spawn bia_to_log;

			{
				deleteVehicle _x;
			} forEach _guards;
		};
	};
	
	uiSleep 1;
};