//Params
params [
"_breakTime", 
"_timeToChange",
"_timeMultiplier",
"_includeNight"
];

_weatherChangeTag = "WeatherChanger";

_nxtPoss = 0;

while {true} do 
{
	_playersInHQ = allPlayers select {_x distance2D hq_pos < 100};

	if (serverTime > _nxtPoss && count _playersInHQ == count allPlayers) then
	{
		[_weatherChangeTag, format["Changing weather in the next %1 seconds", _timeToChange]] spawn bia_to_log;
		//[format["Weather Change in: %1", _timeToChange / 60]] remoteExec ["hint", -2];
		//hint "Change weather";

		_includeFog = true;
		_forceNight = false;
		_forceFogTwilight = false;
		_forceSpecialWeather = false;

		[_includeNight, _includeFog, _forceNight, _forceFogTwilight, _forceSpecialWeather, _timeToChange] spawn bia_change_weather;

		_nxtPoss = serverTime + _breakTime;
	};

	setTimeMultiplier _timeMultiplier; //somehow gets reset if not called repeadately, probably setWeather cmds
	uiSleep 10;
};

	/*
	_playersInBase = allPlayers select {_x distance2D hq_pos < 100};
	_closeHQEnemies = allUnits select {side _x != west && _x distance2D hq_pos < 1000};

	if 
	(
		serverTime > _nxtPoss 
		&& count _playersInBase == count allPlayers 
		&& count _closeHQEnemies == 0
	) then 
	{
		_nxtPoss = serverTime + _breakTime;

		[_weatherChangeTag, "Changing weather", _debug] spawn bia_to_log;

		_includeNight = true;
		_includeFog = true;
		_forceNight = false;
		_forceFogTwilight = false;

		[_includeNight, _includeFog, _forceNight, _forceFogTwilight, _debug] spawn bia_change_weather;
	};
	*/