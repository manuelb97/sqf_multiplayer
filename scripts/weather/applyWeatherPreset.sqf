//Paras
params [
//"_weatherParams",
"_overcast", 
"_rain", 
"_fog", 
"_hour", 
"_min", 
"_timeToChange", 
["_debug",true]
];

//apply preset
_timeToChange setOvercast _overcast;
_timeToChange setRain _rain;
_timeToChange setFog _fog;
//forceWeatherChange;

_now = date;
_now set _hour;
_now set _min;
setDate _now;