//Paras
params [
"_missionLocation",
"_missionMarkers",
["_radius",100],
["_mobileEnemies",14],
"_unitsArray"
];

//Prep stuff
_missionAreaMarker = _missionMarkers select 0;
_infantry = (_unitsArray select 3) + (_unitsArray select 4) + (_unitsArray select 5);
_grpSizes = [1,2,3,4,5,6,7,8,2,3,4,5,6,7,8]; //1 only included to fill last spot if necessary
_sectorDefenderCount = 0;

//Spawn mobile defenders
while {_sectorDefenderCount < _mobileEnemies} do {
	//Generate spawn pos for individual group
	_spawnPosRaw = _missionLocation getPos[	selectRandom[_radius / 4, _radius / 2, _radius/1.5],
											selectRandom[0,45,90,135,180,225,270,315]];
	_spawnPos = [_spawnPosRaw, 10, 200, 3, 0, 20, 0] call BIS_fnc_findSafePos;
	while {surfaceIsWater _spawnPos} do {
		_spawnPos = _missionLocation getPos[	selectRandom[_radius / 4, _radius / 2, _radius/1.5],
												selectRandom[0,45,90,135,180,225,270,315]];
		_spawnPos = [_spawnPosRaw, 10, 200, 3, 0, 20, 0] call BIS_fnc_findSafePos;
	};
	
	//Determine group size
	_grpSize = selectRandom _grpSizes;
	_freeSlots = _mobileEnemies - _sectorDefenderCount;
	while {_grpSize > _freeSlots} do {_grpSize = selectRandom _grpSizes;};
	_sectorDefenderCount = _sectorDefenderCount + _grpSize;
	
	//Create group
	_grp = createGroup east;
	for '_i' from 1 to _grpSize do 
	{
		_infantryClass = selectRandom _infantry;
		_patrolSoldier = _grp createUnit [_infantryClass, _spawnPos, [], 0, "NONE"];
	};
	
	//Make group patrol sector
	[_grp, _missionAreaMarker, "NOFOLLOW"] remoteExec ["bia_give_to_gaia", 0, true];
	
	//Set skill
	[_grp] remoteExec ["bia_set_skill", 0, true];
};