params [
"_players",
"_defence"
];

{
	_player = _x;
	_playerUID = getPlayerUID _player;

	_statsArr = missionNamespace getVariable ["PlayerStatsArr", []];
	_savedUIDs = _statsArr apply {_x select 0};
	_arrIdx = _savedUIDs find _playerUID;

	if (_arrIdx != -1) then
	{
		_playerArr = _statsArr select _arrIdx;
		_playerArr params ["_uid", "_oldKills", "_oldDeaths", "_oldPlayerKills", "_oldAttackWins", "_oldDefenseWins"];

		// ["AddWin", str [_uid, _oldKills, _oldDeaths, _oldPlayerKills, _oldAttackWins, _oldDefenseWins]] spawn bia_to_log;

		if (_defence) then 
		{
			_statsArr set [_arrIdx, [_playerUID, _oldKills, _oldDeaths, _oldPlayerKills, _oldAttackWins, _oldDefenseWins + 1]];
		} else 
		{
			_statsArr set [_arrIdx, [_playerUID, _oldKills, _oldDeaths, _oldPlayerKills, _oldAttackWins + 1, _oldDefenseWins]];
		};
	} else 
	{
		if (_defence) then 
		{
			_statsArr pushBack [_playerUID, 0, 0, 0, 0, 1];
		} else 
		{
			_statsArr pushBack [_playerUID, 0, 0, 0, 1, 0];
		};
	};

	missionNamespace setVariable ["PlayerStatsArr", _statsArr, true];
} forEach _players;