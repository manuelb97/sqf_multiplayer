//Paras
params [
"_xpArray", // [10, 100, 1000]
"_lvlArray",
];

while {true} do 
{
	// check stats array
	_statsArr = missionNamespace getVariable ["PlayerStatsArr", []];
	_totalKills = 0;
	_totalDeaths = 0;

	{
		_player = _x;
		_playerUID = getPlayerUID _player;
		_statsArrIDs = _statsArr apply {_x select 0};
		_playerIdx = _statsArrIDs find _playerUID;
		_playerStats = _statsArr select _playerIdx;
		_oldPlayerArr params ["_uid", "_kills", "_deaths"];
		_totalKills = _totalKills + _kills;
		_totalDeaths = _totalDeaths + _deaths;
	} forEach allPlayers;
	
	// check total amount of cleared bases 
	_markerTypes = missionNamespace getVariable ["MarkerTypes", []]; //["loc_Ruin", "KIA"], true];
	_baseMarkers = allMapMarkers select {getMarkerType _x == (_markerTypes select 0)};
	_clearedMarkers = _baseMarkers select {getMarkerColor _x == "ColorWhite"};
	
	_xpArray params ["_killXP", "_deathXP", "_baseXP"];
	if (_deathXP > 0) then 
	{
		["XP_System", format["Death XP not negative: %1", _deathXP]] spawn bia_to_log;
	};
	_totalXP = (_totalKills * _killXP) + (_totalDeaths * _deathXP) + ((count _clearedMarkers) * _baseXP);
};