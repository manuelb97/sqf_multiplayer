//Paras
params [
"_overcast", 
"_rain", 
"_fog", 
"_hour", 
"_min", 
["_debug",true]
];

//apply preset
0 setOvercast _overcast;
0 setRain _rain;
0 setFog _fog;
forceWeatherChange;

_now = date;
_now set _hour;
_now set _min;
setDate _now;