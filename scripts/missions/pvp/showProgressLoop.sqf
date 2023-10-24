_tag = "ProgressUI";
_layer = 90;
_dur = 2;
_fade = 0;
_delta = 0;

while {true} do
{
	_playerStatsArr = missionNamespace getVariable ["PlayerStatsArr", []];
	_playerArray = allPlayers select {_x distance2D hq_pos < 100};
	_playerCount = count _playerArray;
	
	if (_playerCount > 0) then
	{
		{
			_player = _x;
			_uid = getPlayerUID _player;
			_statsArrIDs = _playerStatsArr apply {_x select 0};
			_arrIdx = _statsArrIDs find _uid;

			_statsArr = [];
			
			if (_arrIdx != -1) then
			{
				_statsArr = _playerStatsArr select _arrIdx;
			};
			
			_statsArr params [
				["_retUID", ""],
				["_kills", 0],
				["_deaths", 0],
				["_playerKills", 0],
				["_attackerWins", 0],
				["_defenseWins", 0]
			];
			
			//texts
			_awText = format["Wins as attacker: %1", _attackerWins];
			_dwText = format["Wins as defender: %1", _defenseWins];
			_pkText = format["Enemy Players Killed: %1", _playerKills];
			_dText = format["Times Died: %1", _deaths];
			_texts = [_awText, _dwText, _pkText, _dText];
			
			//Show Stats
			{
				_text = _x;
				_color = "Green";

				if (_text == _dText) then 
				{
					_color = "Red";
				};

				[_text, format["left_%1", _forEachIndex + 1], _dur, _fade, _delta, _layer + _forEachIndex, _color] remoteExec ["bia_spawn_text", _player];
			} forEach _texts;
		} forEach _playerArray;
	};
	
	uiSleep 1;
};