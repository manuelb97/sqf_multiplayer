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
			
			//Buildings Cleared
			_clearedBuildings = count(allMapMarkers select {markerColor _x == "colorGreen" && markerType _x == "mil_dot"});
			_occupiedBildungs = count(allMapMarkers select {markerColor _x == "colorRed" && markerType _x == "mil_dot"});
			_progress = _clearedBuildings / ((_clearedBuildings + _occupiedBildungs) max 1);

			missionNamespace setVariable ["Progress", _progress, true];

			//Aggression
			_currAggro = round(missionNamespace getVariable ["Aggression", 0]);
			
			//texts
			_cbText = format["Cleared Buildings: %1",_clearedBuildings];
			_obText = format["Occupied Buildings: %1",_occupiedBildungs];
			_cText = format["Mission Progress: %1%2",[_progress * 100, 0] call BIS_fnc_cutDecimals,"%"];
			_agText = format["Aggression: %1", _currAggro];
			_ekText = format["Enemies Killed: %1",_kills];
			_dText = format["Times Died: %1",_deaths];
			// _rText = format["KD: %1", _kills / (_deaths max 1)];
			_texts = [_cbText, _obText, _cText, _agText, _ekText, _dText];
			
			//Show Stats
			{
				_text = _x;
				_color = "Green";

				if (_text in [_obText, _agText, _dText]) then 
				{
					_color = "Red";
				};

				[_text, format["left_%1", _forEachIndex + 1], _dur, _fade, _delta, _layer + _forEachIndex, _color] remoteExecCall ["bia_spawn_text", _player];
			} forEach _texts;
		} forEach _playerArray;
	};
	
	uiSleep 1;
};