//Paras
params [
"_includeNight", 
"_includeFog", 
"_forceNight", 
"_forceFogTwilight",
"_forceSpecialWeather",
"_timeToChange"
];

_weatherParas = [_includeNight, _includeFog, _forceNight, _forceFogTwilight, _forceSpecialWeather, _timeToChange] call bia_weather_params;
_weatherParas remoteExec ["bia_apply_weather", 0, true];

_weatherParas params ["_overcast", "_rain", "_fog", "_hour", "_timeToChange"];
_text = format["overcast: %1, rain: %2, fog: %3, hour: %4", str _overcast, _rain, _fog, _hour];
["WeatherChange", _text] remoteExec ["bia_to_log", 2]; 