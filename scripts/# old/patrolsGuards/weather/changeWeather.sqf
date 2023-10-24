//Paras
params [
"_includeNight", 
"_includeFog", 
"_debug"
];

_weatherParas = [_includeNight, _includeFog, _debug] call bia_weather_params;
_weatherParas remoteExec ["bia_apply_weather", 0, true];