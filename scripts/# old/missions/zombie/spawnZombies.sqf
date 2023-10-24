//Paras
_missionLocation	= param [0,[]];
_radius				= param [1,100];
_tier					= param [2,""];

//Max zombies
_maxZombies = 50;
switch _tier do {
    case "Tier_4": {_maxZombies = 60;};
    case "Tier_3": {_maxZombies = 80;};
    case "Tier_2": {_maxZombies = 100;};
    case "Tier_1": {_maxZombies = 120;};
};

//hint format["Total zombies to spawn: %1",_maxZombies]; uiSleep 3;
_zombieClasses = [
			"RyanZombie15Opfor",
			"RyanZombie16Opfor",
			"RyanZombie17Opfor",
			"RyanZombie18Opfor",
			"RyanZombie19Opfor",
			"RyanZombie20Opfor",
			"RyanZombie21Opfor",
			"RyanZombie22Opfor",
			"RyanZombie23Opfor",
			"RyanZombie24Opfor",
			"RyanZombie25Opfor",
			"RyanZombie26Opfor",
			"RyanZombie27Opfor",
			"RyanZombie28Opfor",
			"RyanZombie29Opfor",
			"RyanZombie30Opfor",
			"RyanZombie31Opfor",
			"RyanZombie32Opfor",
			"RyanZombie15mediumOpfor",
			"RyanZombie16mediumOpfor",
			"RyanZombie17mediumOpfor",
			"RyanZombie18mediumOpfor",
			"RyanZombie19mediumOpfor",
			"RyanZombie20mediumOpfor",
			"RyanZombie21mediumOpfor",
			"RyanZombie22mediumOpfor",
			"RyanZombie23mediumOpfor",
			"RyanZombie24mediumOpfor",
			"RyanZombie25mediumOpfor",
			"RyanZombie26mediumOpfor",
			"RyanZombie27mediumOpfor",
			"RyanZombie28mediumOpfor",
			"RyanZombie29mediumOpfor",
			"RyanZombie30mediumOpfor",
			"RyanZombie31mediumOpfor",
			"RyanZombie32mediumOpfor",
			"RyanZombieB_Soldier_02_fOpfor",
			"RyanZombieB_Soldier_02_f_1Opfor",
			"RyanZombieB_Soldier_02_f_1_1Opfor",
			"RyanZombieB_Soldier_03_fOpfor",
			"RyanZombieB_Soldier_03_f_1Opfor",
			"RyanZombieB_Soldier_03_f_1_1Opfor",
			"RyanZombieB_Soldier_04_fOpfor",
			"RyanZombieB_Soldier_04_f_1Opfor",
			"RyanZombieB_Soldier_04_f_1_1Opfor",
			"RyanZombieB_Soldier_lite_FOpfor",
			"RyanZombieB_Soldier_lite_F_1Opfor",
			"RyanZombieB_Soldier_02_fmediumOpfor",
			"RyanZombieB_Soldier_02_f_1mediumOpfor",
			"RyanZombieB_Soldier_02_f_1_1mediumOpfor",
			"RyanZombieB_Soldier_03_fmediumOpfor",
			"RyanZombieB_Soldier_03_f_1mediumOpfor",
			"RyanZombieB_Soldier_03_f_1_1mediumOpfor",
			"RyanZombieB_Soldier_04_fmediumOpfor",
			"RyanZombieB_Soldier_04_f_1mediumOpfor",
			"RyanZombieB_Soldier_04_f_1_1mediumOpfor",
			"RyanZombieB_Soldier_lite_FmediumOpfor",
			"RyanZombieB_Soldier_lite_F_1mediumOpfor"
];

//New zombie approach, spawn outside of zone, attack players once they entered the zone
_spawnedZombies = 0;
_maxAliveZombies = 40;
_zombieCount = 0;

while {_spawnedZombies < _maxZombies || _zombieCount != 0} do {
	_zombies = [];
	{if ((side _x) == east && _x distance _missionLocation < (_radius + 700)) then {_zombies pushBack _x}} forEach allUnits;
	_zombieCount = count _zombies;
	
	_zombieSlots = _maxAliveZombies - _zombieCount;
	//hint format["Zombies to spawn: %1",_zombieSlots]; uiSleep 3;
	
	//Spawn new zombies
	if (_zombieSlots > 0 && _spawnedZombies < _maxZombies) then {
		_grpSize = selectRandom [2,3,4,5,6];
		_spawnedZombies = _spawnedZombies + _grpSize;
		
		_bestPlaces = selectBestPlaces [(_missionLocation getPos [_radius + 300, random 360]), 100, "2*houses + 0*meadow + 4*forest - 10*sea", 1, 1];
		_bestPlace = _bestPlaces select 0 select 0;
		_spawnpos = [_bestPlace, 0, 50, 1, 0, 10, 0] call BIS_fnc_findSafePos;

		_grp = createGroup east;
		for "_i" from 1 to _grpSize do {
			_zombieClass = selectRandom _zombieClasses;
			_zombie = _grp createUnit [_zombieClass, _spawnpos, [], 0, "NONE"];
			_zombie setSkill 1;
		};

		//Disable VCOM
		_grp setVariable ["Vcm_Disable",true];
	};
	
	//Give zombies a target
	_zombies = [];
	{if ((side _x) == east && _x distance _missionLocation < (_radius + 700)) then {_zombies pushBack _x}} forEach allUnits;
	_zombieCount = count _zombies;
	if (_zombieCount > 0) then {
		_players = [];
		{ 
			if (side _x == west && _x inArea Flare_Trigger) then {_players pushBack _x};
		} forEach allPlayers;
		
		if (count _players > 0) then {
			{ 
				//hint format["Gave %1 zombies orders", _zombieCount]; uiSleep 3;
				_targetPlayer = selectRandom _players; 
				_x doTarget _targetPlayer; 
				_x doMove getPos _targetPlayer; 
			} forEach _zombies;
		};
	};
	
	//Add all zombies to zeus
	{
		[_x, [allUnits select {side _x == east}, true]] remoteExec ["addCuratorEditableObjects", 0, true];
	} forEach allCurators;
	
	uiSleep 5;
};

/*
//Get buildings in mission area
_houses = nearestObjects [_missionLocation, ["House","Building"], _radius];

//Find best positions
_housePosArrA = [];
{
	_house = _x;
	_positions = _house call BIS_fnc_buildingPositions;
	_positions = _positions select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 0, 3]]};
	_positions = _positions select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 2, 0]]};
	_positions = _positions select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [2, 0, 0]]};
	{ _housePosArrA pushBack _x; } forEach _positions;
} forEach _houses;

//Use best positions
_finalPosArrA = [];
for '_i' from 1 to _maxZombies do {
	_posToAdd = selectRandom _housePosArrA;
	if (!isNil "_posToAdd") then {
		if (_maxZombies > count _finalPosArrA) then {_housePosArrA deleteAt (_housePosArrA find _posToAdd);};
		_finalPosArrA pushBack _posToAdd;
	};
};
//[format ["Number of best Pos: %1", count _finalPosArrA]] remoteExec ["hint", 0, true];uiSleep 3;

//Spawn zombies
_grp = createGroup east;
{
	_zombieClass = selectRandom _zombies;
	_safeSpawn = [_x, 10, 200, 3, 0, 20, 0] call BIS_fnc_findSafePos;
	_zombie = _grp createUnit [_zombieClass, _safeSpawn, [], 0, "NONE"];
	_zombie allowDamage false;
	_zombie setPos _x;
	_zombie allowDamage true;
	_zombie setSkill 1;
	if (!(getPos _zombie isEqualTo _x)) then {_zombie setPos _x;};
} forEach _finalPosArrA;

//Set skill
[_grp,1] remoteExec ["bia_set_skill", 0, true];

//Give group to cqb script
//[units _grp, 20] execVM "scripts\missions\cqb\cqbUnitMovement.sqf";

//If not enough perfect house positions to spawn zombie amount, spawn at less optimal pos
_zombiesToSpawn = _maxZombies - (count _finalPosArrA);

if (_zombiesToSpawn > 0) then {
	_grp2 = createGroup east;
	_finalPosArrB = [];

	//Search for less surrounded positions
	_housePosArrB = [];
	if (_zombiesToSpawn > 0) then {
		_housePosArrB = [];
		{
			_house = _x;
			_positions = _house call BIS_fnc_buildingPositions;
			_positions = _positions select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 0, 3]]};
			_positions = _positions select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 2, 0]] or lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [2, 0, 0]]};
			{ _housePosArrB pushBack _x; } forEach _positions;
		} forEach _houses;
		
		//Use best positions
		for '_i' from 1 to _zombiesToSpawn do {
			_posToAdd = selectRandom _housePosArrB;
			if (!isNil "_posToAdd" && !(_posToAdd in _finalPosArrA)) then {
				if (_maxZombies > count _finalPosArrB) then {_housePosArrB deleteAt (_housePosArrB find _posToAdd);};
				_finalPosArrB pushBack _posToAdd;
			};
		};
		//[format ["Number of less optimal Pos: %1", count _finalPosArrB]] remoteExec ["hint", 0, true];uiSleep 3;
		
		//Spawn zombies
		_grpB = createGroup east;
		{
			_zombieClass = selectRandom _zombies;
			_safeSpawn = [_x, 10, 200, 3, 0, 20, 0] call BIS_fnc_findSafePos;
			_zombie = _grpB createUnit [_zombieClass, _safeSpawn, [], 0, "NONE"];
			_zombie allowDamage false;
			_zombie setPos _x;
			_zombie allowDamage true;
			if (!(getPos _zombie isEqualTo _x)) then {_zombie setPos _x;};
		} forEach _finalPosArrB;
	
		//Set skill
		[_grpB,1] remoteExec ["bia_set_skill", 0, true];

		//[units _grpB, 15] execVM "scripts\missions\cqb\cqbUnitMovement.sqf"; 
	};

	//Rest will be roamers
	_zombiesToSpawn = _maxZombies - (count _finalPosArrA) - (count _finalPosArrB);
	if (_zombiesToSpawn > 0) then {
		//[format ["Number of Roamers: %1", _zombiesToSpawn]] remoteExec ["hint", 0, true];//uiSleep 3;
		_fastZombies = [	"RyanZombie15Opfor",
								"RyanZombie16Opfor",
								"RyanZombie17Opfor",
								"RyanZombie18Opfor",
								"RyanZombie19Opfor",
								"RyanZombie20Opfor",
								"RyanZombie21Opfor",
								"RyanZombie22Opfor",
								"RyanZombie23Opfor",
								"RyanZombie24Opfor",
								"RyanZombie25Opfor",
								"RyanZombie26Opfor",
								"RyanZombie27Opfor",
								"RyanZombie28Opfor",
								"RyanZombie29Opfor",
								"RyanZombie30Opfor",
								"RyanZombie31Opfor",
								"RyanZombie32Opfor"];

		_grpC = createGroup east;
		for '_i' from 1 to _zombiesToSpawn do {
			_zombieClass = selectRandom _fastZombies;
			_safeSpawn = [_missionLocation, 10, round(_radius / 1.5), 3, 0, 20, 0] call BIS_fnc_findSafePos;
			_zombie = _grpC createUnit [_zombieClass, _safeSpawn, [], 0, "NONE"];
		};
		
		//Set skill
		[_grpC,1] remoteExec ["bia_set_skill", 0, true];
		
		//[_grpC, _missionLocation, selectRandom[_radius/5,_radius/4,_radius/3]] call BIS_fnc_taskPatrol;
	};
};
*/