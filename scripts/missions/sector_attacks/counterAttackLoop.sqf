//Paras
params [
"_minAggro",
"_minStartTime", //avoids counter attack at mission start
"_minBreakTime",
"_hqChance",
"_debug"
];

//25, 600, 2700, 60, _debug

_tag = "CounterAttackLoop";
_lastCounterAttack = missionNamespace getVariable ["LastCounterAttack", -1 * _minBreakTime];
_relevantMarkerTypes = missionNamespace getVariable ["MarkerTypes", []];
_earliestStartTime = serverTime + _minStartTime;

while {true} do 
{
	_currAggro = missionNamespace getVariable ["Aggression", 0];
	_counterAttackOngoing = missionNamespace getVariable ["CounterAttackOngoing", false];
	_nextPossCounterAttack = _lastCounterAttack + _minBreakTime;

	_maxTotalEnemies = missionNamespace getVariable ["MaxEnemies", 30];
	_currTotalEnemies = count(allUnits select {side _x == east});

	if 
	(
		_currAggro >= _minAggro 
		&& !_counterAttackOngoing
		&& serverTime > _nextPossCounterAttack
		&& serverTime > _earliestStartTime
		&& (_currTotalEnemies + 20) <= _maxTotalEnemies
	) then 
	{
		[_tag, "Starting Counter Attack"] spawn bia_to_log;

		_lastCounterAttack = missionNamespace setVariable ["LastCounterAttack", serverTime, true];

		_clearedMarkers = allMapMarkers select 
		{
			markerColor _x == "colorBLUFOR"
			&& (markerType _x) in _relevantMarkerTypes
		};
		_attackHQChance = random[0, 0.5, 1];// * _currAggro;
		_isHQ = false;

		// _counterAttackMarker = "";
		// if (count _clearedMarkers < 1 || _attackHQChance > _hqChance) then 
		// {
		// 	[_tag, "Counter Attack targets HQ"] spawn bia_to_log;

		// 	_counterAttackMarker = "hq_marker";
		// 	_isHQ = true;
		// } else 
		// {
		_clearedMarkers = [_clearedMarkers, [], 
		{
			_retValue = 1;

			if ("military" in _x) then 
			{
				_retValue = 2;
			};
			if ("city" in _x) then 
			{
				_retValue = 3;
			};
			
			_retValue
		}, "DESCEND"] call BIS_fnc_sortBy;

		_counterAttackMarker = _clearedMarkers select 0;
		// };

		[_counterAttackMarker, _isHQ, _debug] spawn bia_sectors_counter_attack;
	};

	uiSleep 10;
};