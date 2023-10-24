//Paras
params [
"_missionLocation",
"_minSpawnDistance",
"_maxSpawnDistance",
"_enemiesToSpawn",
"_positions",
"_infantry",
"_varName",
"_radius",
"_debug"
];

_tag = "CompoundPatrolGuards";

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

{
	_size = _x;
	_spawnPos = [_missionLocation, 0, 50, 1, 0, 20, 0, [], [_missionLocation, _missionLocation]] call BIS_fnc_findSafePos;

	[
		["Patrol", _size, _spawnPos, _missionLocation, _positions, _infantry, _varName, _radius, _debug]
	] remoteExec ["bia_spawn_group", missionNamespace getVariable ["BiA_Host", 2]]; //spawn bia_spawn_group; //
} forEach _grpSizes;

[_tag, "Spawned patrol guards", _debug] spawn bia_to_log;