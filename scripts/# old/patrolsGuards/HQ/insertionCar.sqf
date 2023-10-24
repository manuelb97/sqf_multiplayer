/*
transportsActive = false;
[] call compile preprocessFileLineNumbers "scripts\patrolsGuards\missionCar.sqf";
*/

//Paras
params [
"_carClasses",
"_carPosArr",
"_debug"
];

_tag = "InsertionVehicleLoop";

if (_debug) then 
{
	_text = format["Loop started"];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

transportsActive = true;
_initialSpawn = false;
_activeCars = [];
_carDir = ((getDir hq_building) + 180);

while {transportsActive} do 
{
	if (_debug) then 
	{
		_text = format["New Cycle"];
		[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
	};
	
	//Initial Car Spawn
	if (!_initialSpawn) then 
	{
		if (_debug) then 
		{
			_text = format["Initial Car Spawn"];
			[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
		};
		
		_initialSpawn = true;
		
		{
			_spawnPos = (getPosATL _x) vectorAdd [0, 0, 0]; //1
			
			if (_debug) then 
			{
				_text = format["Car Spawn Pos: %1",_spawnPos];
				[_tag, _text] remoteExec ["bia_to_log", 2, false];
			};
			
			_vehClass = selectRandom _carClasses;
			_newvehicle = _vehClass createVehicle ([_spawnPos, 0, 100, 5, 0, 20, 0] call BIS_fnc_findSafePos);
			
			_newvehicle allowdamage false;
			uiSleep 0.1;
			_newvehicle setPosATL _spawnpos;
			_newvehicle setDir _carDir;
			uiSleep 0.1;
			_newvehicle allowdamage true;
			
			clearWeaponCargoGlobal 	_newvehicle;
			clearMagazineCargoGlobal 	_newvehicle;
			clearItemCargoGlobal 		_newvehicle;
			clearBackpackCargoGlobal	_newvehicle;
			
			_newvehicle addAction ["Equip Vehicle with Supplies","scripts\patrolsGuards\HQ\equipInsertionCar.sqf",[_newvehicle,_debug],3,true,false,"","true",5,false,"",""]; 
			_newvehicle setVehicleLock "LOCKED";
			{
				[_x, _newvehicle, false] call ace_vehiclelock_fnc_addKeyForVehicle;
			} forEach allPlayers;
			
			_activeCars pushBack _newvehicle;
		} forEach _carPosArr;
	} else
	{
		//Spawn Cars if cars lost
		if (_debug) then 
		{
			_text = format["Checking Cars"];
			[_tag, _text] remoteExec ["bia_to_log", 2, false];
		};
		
		_numActiveCars = 0;
		{
			_car = _x;
			if (alive _car) then 
			{
				_numActiveCars = _numActiveCars + 1;
			};
		} forEach _activeCars;
		
		if (_debug) then 
		{
			if (_numActiveCars == count _carPosArr) then 
			{
				_text = format["Max active Cars reached"];
				[_tag, _text] remoteExec ["bia_to_log", 2, false];
			} else
			{
				_text = format["Num Active Cars: %1",_numActiveCars];
				[_tag, _text] remoteExec ["bia_to_log", 2, false];
			};
		};
		
		if (_numActiveCars < count _carPosArr) then 
		{
			{
				_posCar = (getPosATL _x) nearObjects ["car",3];
				
				if (count _posCar < 1) then 
				{
					if (_debug) then 
					{
						_text = format["Spawning additional Car"];
						[_tag, _text] remoteExec ["bia_to_log", 2, false];
					};
					
					_spawnPos = getPosATL _x;
					_vehClass = selectRandom _carClasses;
					_newvehicle = _vehClass createVehicle _spawnpos;
					
					_newvehicle allowdamage false;
					_newvehicle setPosATL _spawnpos;
					_newvehicle setDir _carDir;
					uiSleep 0.1;
					_newvehicle allowdamage true;
					
					clearWeaponCargoGlobal 	_newvehicle;
					clearMagazineCargoGlobal 	_newvehicle;
					clearItemCargoGlobal 		_newvehicle;
					clearBackpackCargoGlobal	_newvehicle;
					
					_newvehicle addAction ["Equip Vehicle with Supplies","scripts\patrolsGuards\HQ\equipInsertionCar.sqf",[_newvehicle,_debug],3,true,false,"","true",5,false,"",""]; 
					_newvehicle setVehicleLock "LOCKED";
					{
						[_x, _newvehicle, false] call ace_vehiclelock_fnc_addKeyForVehicle;
					} forEach allPlayers;
					
					_activeCars pushBack _newvehicle;
				};
			} forEach _carPosArr;
		};
	};
	
	//Check for abandoned cars
	if (_debug) then 
	{
		_text = format["Checking for abandoned Cars"];
		[_tag, _text] remoteExec ["bia_to_log", 2, false];
	};
	
	_remainingCars = [];
	{
		_car = _x;
		_players = allPlayers;
		_numClosePlayers = 0;
		{
			_player = _x;
			if (_car distance _player < 500 || _car distance (_carPosArr select 0) < 100) then
			{
				_numClosePlayers = _numClosePlayers + 1;
			};
		} forEach _players;
		
		if (_numClosePlayers > 0) then 
		{
			_remainingCars pushBack _car;
		} else
		{
			if (_debug) then 
			{
				_text = format["Deleting abandoned Car"];
				[_tag, _text] remoteExec ["bia_to_log", 2, false];
			};
			
			deleteVehicle _car;
		};
	} forEach _activeCars;
	
	if (_debug && count _activeCars == count _remainingCars) then 
	{
		_text = format["No abandoned Cars"];
		[_tag, _text] remoteExec ["bia_to_log", 2, false];
	};
	
	_activeCars = _remainingCars;
	
	uiSleep 5;
};

if (_debug) then 
{
	_text = format["Loop terminated"];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

_host = selectRandom allPlayers;
[_carClasses,_carPosArr,_debug] remoteExec ["bia_car",_host, false];
