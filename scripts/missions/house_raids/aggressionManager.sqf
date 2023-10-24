//Paras
_aggroManTag = "AggressionManager";

while {true} do 
{
	_currAggro = missionNamespace getVariable ["Aggression", 0];

	_enemyBuildings = allMapMarkers select {"building" in _x && markerColor _x == "ColorRed"};
	_clearedBuildings = allMapMarkers select {"building" in _x && markerColor _x == "ColorGreen"};

	_percentCleared = (count _clearedBuildings) / ((count _clearedBuildings) + (count _enemyBuildings));
	_aggroLevel = round (_percentCleared * 100);

	_oldAggro = missionNamespace getVariable ["Aggression", 0];
	missionNamespace setVariable ["Aggression", _aggroLevel, true];

	if (abs(_oldAggro - _aggroLevel) > 1) then 
	{
		_text = format["Changed AggroLvl from %1 to %2", _oldAggro, _aggroLevel];
		["AggroManager", _text] remoteExec ["bia_to_log", 2]; 
	};

	uiSleep 60;
};