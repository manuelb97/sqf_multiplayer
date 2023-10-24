//Paras
_weatherParas = param [0,[]];
_overcast =	_weatherParas select 0;
_rain =		_weatherParas select 1;
_fog = 		_weatherParas select 2;
_hour =		_weatherParas select 3;
_min = 		_weatherParas select 4;

//apply preset
0 setOvercast _overcast;
0 setRain _rain;
0 setFog _fog;
forceWeatherChange;

_now = date;
_now set _hour;
_now set _min;
setDate _now;