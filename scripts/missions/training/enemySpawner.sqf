while {true} do 
{
	_text = format["Enemy spawner waiting for parameters to be set"];
	["Training", _text] spawn bia_to_log;

	while 
	{
		_allSet = true;
		if 
		(
			(
				count (missionNamespace getVariable ["DefenceCenter", []]) != 0 ||
				count (missionNamespace getVariable ["AttackerOrigin", []]) != 0
			)
			&& missionNamespace getVariable ["MissionRunning", false]
		) then {_allSet = false};
		_allSet
	} do {uiSleep 1;};

	_text = format["Enabling enemy spawner"];
	["Training", _text] spawn bia_to_log;

	_killGoal = missionNamespace getVariable ["KillGoal", 9999];  // infinite mission if not set
	_initialKills = [] call bia_training_get_initial_kills;

	while {[_initialKills] call bia_training_get_total_kills < _killGoal} do 
	{
		_currentEnemies = allUnits select {_x getVariable ["TrainingEnemy", false]};
		_maxEnemies = missionNamespace getVariable ["MaxEnemies", 20];
		_attackerOrigin = missionNamespace getVariable ["AttackerOrigin", []];
		_defenceCenter = missionNamespace getVariable ["DefenceCenter", []];

		// Despawn enemies which are too far from defence center or incapacitated
		_enemiesToDespawn = _currentEnemies select {_x distance2D _attackerOrigin > 1000 && _x distance2D _defenceCenter > 1000};
		[_enemiesToDespawn] spawn bia_despawn_units;

		// Spawn enemies
		if (count _currentEnemies < _maxEnemies) then 
		{
			_text = format["Enemies to spawn: %1", _maxEnemies - count _currentEnemies];
			["Training", _text] spawn bia_to_log;

			[_attackerOrigin, _defenceCenter, _maxEnemies - count _currentEnemies, _maxEnemies] spawn bia_training_spawn_attackers;
		};

		// if (missionNamespace getVariable ["MissionRunning", false]) then
		// {
			// 	_text = format["Training manually interrupted"];
			// 	["Training", _text] spawn bia_to_log;

			// 	break
		// };
		uiSleep 5;
	};

	_text = format["Current kills: %1, kills to achieve: %2", [_initialKills] call bia_training_get_total_kills, _killGoal];
	["Training", _text] spawn bia_to_log;

	_text = format["Disabling enemy spawner"];
	["Training", _text] spawn bia_to_log;

	//stop mission
	[allUnits select {_x getVariable ["TrainingEnemy", false]}] spawn bia_despawn_units;
	_tmpMarkers = allMapMarkers select {"training" in _x};
	{deleteMarker _x} forEach _tmpMarkers;
	missionNamespace setVariable ["MissionRunning", _missionRunning, false];
	[
		format["Mission finished"], "center_top", 5, 0, 0, 100, "Green"
	] remoteExec ["bia_spawn_text", _caller];

	uiSleep 1;
};