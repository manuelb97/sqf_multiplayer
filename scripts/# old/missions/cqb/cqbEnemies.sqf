//Paras
params [
"_missionLocation",
"_missionMarkers",
["_radius",100],
["_cqbEnemies",0],
"_unitsArray"
];

//Enemy Array
_enemies = (_unitsArray select 3) + (_unitsArray select 4);

//find out if buildings nearby
_objects = _missionLocation nearObjects _radius;
_houses = [];
{ if (count (_x call BIS_fnc_buildingPositions) > 0 && !("scaffolding" in str _x)) then {
	_houses pushBack _x;
	};
} forEach _objects;

//find usable positions
_suitablePosPerHouse = [];
if (count _houses > 0) then {
	//find building with most covered positions
	{
		_positions = _x call BIS_fnc_buildingPositions;
		_maxPos = 1;//selectRandom[1,2,3];
		if (count _positions > _maxPos) then {
			_reducedPositions = [];
			
			for '_i' from 1 to _maxPos do {
				_reducedPositions pushBack selectRandom _positions;
			};
			
			_positions = _reducedPositions;
		};
		_suitablePosPerHouse append _positions;
	} forEach _houses;
};

//Spawn house defenders
_grp = createGroup east;
_cqbUnitsArray = [];
for '_i' from 1 to _cqbEnemies do 
{
	_unitClass = selectRandom _enemies;
	_spawnPos = [];
	if (count _suitablePosPerHouse > 0) then {
		_spawnPos = selectRandom _suitablePosPerHouse;
		if (count _suitablePosPerHouse > 1) then {_suitablePosPerHouse = _suitablePosPerHouse - _spawnPos;};
	} else {
		_spawnPos = [_missionLocation, 0, _radius, 1, 0, 20, 0] call BIS_fnc_findSafePos;
	};
	
	_houseDefender = _grp createUnit [_unitClass, _spawnPos, [], 0, "NONE"];
	
	//Add unit to array to execute script for them as a group
	_cqbUnitsArray pushBack _houseDefender;
};

//Set skill
[_grp] remoteExec ["bia_set_skill", 0, true];

//use cqb movement if buildings available or just give them to GAIA aswell
if (count _suitablePosPerHouse > 0) then {
	[_cqbUnitsArray] execVM "scripts\missions\cqb\cqbUnitMovement.sqf";
} else {
	[_grp, _missionMarkers select 0, "NOFOLLOW"] remoteExec ["bia_give_to_gaia", 0, true];
};