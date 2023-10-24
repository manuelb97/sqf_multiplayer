// [player, test, 50] call compileFinal preprocessFileLineNumbers "scripts\sniping\path_wind_vals.sqf"
params [
"_player",
"_target",
"_numPositions"
];

_distance = _player distance _target;
_step = _distance / _numPositions;
_positions = [];

for "_i" from 0 to _numPositions do 
{
	_positions pushBack (_player getPos [_step * _i, _player getDir _target]);
};

_winds = _positions apply 
{
	[eyePos _player, true, true, true] call ace_weather_fnc_calculatewindspeed
};

_winds

// [wind, windDir]
// 

// ["_position", "_windGradientEnabled", "_terrainEffectEnabled", "_obstacleEffectEnabled"];
