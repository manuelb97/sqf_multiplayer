//Paras
params [
"_baseMax",
"_perPlayer",
"_debug"
];

_maxEnemiesTag = "MaxEnemySetter";
_numPlayers = 0;
_lastDiff = 0;

while {true} do 
{
	_numPlayers = selectMax [(count allPlayers) - 1, 0]; // this way base max for solo play
	_maxEnemies = _baseMax + (_perPlayer * _numPlayers);

	if (_maxEnemies != (missionNamespace getVariable ["MaxEnemies", 0])) then 
	{
		missionNamespace setVariable ["MaxEnemies", _maxEnemies, true];
		[_maxEnemiesTag, format["Current max Enemies: %1 (Num Players: %2)", _maxEnemies, _numPlayers], _debug] spawn bia_to_log;
	};

	_enemyUnits = allUnits select {side _x == east};
	_diff = (count _enemyUnits - _maxEnemies) max 0;

	if (_diff != _lastDiff && _diff > 0) then 
	{
		_lastDiff = _diff;
		[_maxEnemiesTag, format["Enemies exceed limit by %1", _diff], _debug] spawn bia_to_log;
	};
	
	uiSleep 60;
};