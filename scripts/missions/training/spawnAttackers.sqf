//Paras
params [
"_attackerOrigin",
"_defenceCenter",
"_enemiesToSpawn",
"_totalMax"
];

_grpSizes = [1,2,3,4,5];
_attackerGrpSizes = [];
_enemiesToSpawnSubtract = _enemiesToSpawn;

while {_enemiesToSpawnSubtract > 0} do 
{
	_grpSize = selectRandom _grpSizes;
	if (_grpSize <= _enemiesToSpawnSubtract) then 
	{
		_enemiesToSpawnSubtract = _enemiesToSpawnSubtract - _grpSize;
		_attackerGrpSizes pushBack _grpSize;
	};
};

_defender = allPlayers select {_x distance2D _defenceCenter < 1000};
_minDist = 0;
_maxDist = 200;
_faction = missionNamespace getVariable ["TrainingFaction", "Tier_4"];
_classes = [[_faction], ""] call bia_faction_mix;
_attackerSearchRadius = 100;

_actualNumberOfSpawns = 0;
_actualNumberOfGrps = 0;
{
	_size = _x;
	_currentEnemies = count (allUnits select {_x getVariable ["TrainingEnemy", false]});

	if ((_currentEnemies + _size) <= _totalMax) then
	{
		_spawnPos = [];

		while {count _spawnPos == 0} do 
		{
			_spawnPos = [_attackerOrigin, _defender, 1, _minDist, _maxDist] call bia_concealed_pos;

			if (count _spawnPos < 1) then 
			{
				_fallBackPos = _attackerOrigin getPos [selectRandom [_minDist, _maxDist], random 360];
				_spawnPos = [_attackerOrigin, _minDist, _maxDist, 1, 1, 20, 0, [], [_fallBackPos, _fallBackPos]] call BIS_fnc_findSafePos;
			};
		};

		[
			["QRF", _size, _spawnPos, _defenceCenter, [], _classes, "TrainingEnemy", _attackerSearchRadius]
		] remoteExec ["bia_spawn_group", missionNamespace getVariable ["BiA_Host", 2]];

		_actualNumberOfSpawns = _actualNumberOfSpawns + _size;
		_actualNumberOfGrps = _actualNumberOfGrps + 1;
	};
	
	uiSleep 1;
} forEach _attackerGrpSizes;

_text = format["Spawned a total of %1 enemies across %2 groups", _actualNumberOfSpawns, _actualNumberOfGrps];
["Training", _text] spawn bia_to_log;