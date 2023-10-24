//Paras
params [
"_debug"
];

_debug = true;

weatherChanges = true;
_weatherChanged = false;
_tag = "WeatherLoop";

while {weatherChanges} do
{
	if (isNil "Training_Arr") then 
	{
		Training_Arr = [];
	};
	
	_playerArr = [];
	{
		_player = _x;
		if (_player distance hq_pos < 50 || _player in Training_Arr) then 
		{
			_playerArr pushBack _player;
		};
	} forEach allPlayers;
	
	//Only make weather change possible when all are in base
	if (count _playerArr == count allPlayers && _weatherChanged) then
	{
		_weatherChanged = false;
		
		if (_debug) then 
		{
			_text = format["Weather change possibility enabled"];
			[_tag, _text] remoteExec ["bia_to_log", 2, false];
		};
	};
	
	if (count _playerArr < 1 && !_weatherChanged) then
	{
		if (_debug) then 
		{
			_text = format["Changing Weather"];
			[_tag, _text] remoteExec ["bia_to_log", 2, false];
		};
		
		_weatherParas = ["Tier_1", "Liberation"] call bia_weather_params; //compile preprocessFileLineNumbers "scripts\missions\weather\randomWeatherParas.sqf";
		//[[_weatherParas],"scripts\missions\weather\randomWeatherTime.sqf"] remoteExec ["execVM", 0, true];
		[_weatherParas] remoteExec ["bia_change_weather", 0, true];
		
		_weatherChanged = true;
		
		if (_debug) then 
		{
			_text = format["Weather change possibility disabled"];
			[_tag, _text] remoteExec ["bia_to_log", 2, false];
		};
	};
	
	uiSleep 5;
};

if (_debug) then 
{
	_text = format["Loop terminated"];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

[_debug] execVM "scripts\patrolsGuards\HQ\changeWeatherLoop.sqf";