//Paras
_aggroManTag = "AggressionManager";

_playerStatsArr = missionNamespace getVariable ["PlayerStatsArr", []];
_killsArr = _playerStatsArr apply {_x select 1};
_totalStartKills = 0;
{
	_totalStartKills = _totalStartKills + _x;
} forEach _killsArr;

_relMarkerTypes = missionNamespace getVariable ["MarkerTypes", []];

while {true} do 
{
	_currAggro = missionNamespace getVariable ["Aggression", 0];

	_clearedVillages = allMapMarkers select {"village" in _x && markerColor _x == "colorBLUFOR"};
	_clearedMilBases = allMapMarkers select {"military" in _x && markerColor _x == "colorBLUFOR"};
	_clearedCities = allMapMarkers select {"city" in _x && markerColor _x == "colorBLUFOR"};

	_allCleared = _clearedVillages + _clearedMilBases + _clearedCities;
	_allOccupied = allMapMarkers select {markerColor _x == "colorOPFOR" && markerType _x in _relMarkerTypes};
	_percentCleared = (count _allCleared) / ((count _allCleared) + (count _allOccupied));
	
	_minAggroLevel = round
	(
		(_percentCleared * 100) 
		+ (count _clearedMilBases) * 1
		+ (count _clearedCities) * 2
	);

	if (_currAggro < _minAggroLevel) then 
	{
		missionNamespace setVariable ["Aggression", _minAggroLevel, true];
		["Aggression", _minAggroLevel] call bia_save_to_profile;
		
		[_aggroManTag, format["Aggro Level (%1) raised to Min Aggro (%2)", _currAggro, _minAggroLevel]] spawn bia_to_log;
		[_aggroManTag, format["Captured Sectors: Num Villages (%1), Num Mil Bases (%2), Num Cities (%3)", 
		count _clearedVillages, count _clearedMilBases, count _clearedCities]] spawn bia_to_log;
		
		_currAggro = _minAggroLevel;
	};

	_playerStatsArr = missionNamespace getVariable ["PlayerStatsArr", []];
	_killsArr = _playerStatsArr apply {_x select 1};
	_totalCurrKills = 0;
	{
		_totalCurrKills = _totalCurrKills + _x;
	} forEach _killsArr;

	if ((_totalCurrKills - 20) > _totalStartKills) then 
	{
		_newAggro = [_currAggro + ((_totalCurrKills - _totalStartKills) * 0.05), 2] call BIS_fnc_cutDecimals; // 1% raise per 20 kills
		missionNamespace setVariable ["Aggression", _newAggro, true]; 
		["Aggression", _newAggro] call bia_save_to_profile;
		_totalStartKills = _totalCurrKills;
		
		[_aggroManTag, format["Aggro Level (%1) raised to %2 due to kills", _currAggro, _newAggro]] spawn bia_to_log;
	};

	uiSleep 60;
};