//Paras
params [
"_includeNight", 
"_includeFog", 
"_forceNight",
"_forceFogTwilight",
"_forceSpecialWeather",
"_timeToChange"
];

// preset structure = overcast, rain, fog, hour, min
_dayPresets = 
[
	// Normal & Day
	[
		selectRandom [0.1, 0.2, 0.3, 0.4], 
		0, 
		0, 
		round(random [7, 12, 18]), 
		round((random 1)*60)
	],
	
	// Bright & Day
	[
		0, 
		0, 
		0, 
		17, 
		0
	],
	
	// Rainy & Day
	[
		selectRandom [0.5, 0.6, 0.7, 0.8, 0.9], 
		selectRandom [0.2, 0.3, 0.4], 
		0, 
		round(random [7, 12, 18]), 
		round((random 1)*60)
	]
];

_nightPresets =
[
	// Normal & Night
	[
		selectRandom [0.1,0.2,0.3,0.4], 
		0, 
		0, 
		round(random [19, 21, 23]), 
		round((random 1)*60)
	],
	
	// Rainy & Night
	[
		selectRandom [0.5,0.6,0.7,0.8,0.9], 
		selectRandom [0.2,0.3,0.4], 
		0, 
		round(random [19, 21, 23]), 
		round((random 1)*60)
	]
];

_fogPresets =
[
	// Foggy & Rainy & Day
	[
		selectRandom [0.5, 0.6, 0.7], 
		selectRandom [0.2,0.3,0.4], 
		selectRandom [0.2, 0.25], 
		round(random [7, 12, 18]), 
		round((random 1)*60)
	],
	
	// Foggy & Twilight
	[
		0.7, 
		0, 
		selectRandom [0.2, 0.25], 
		19, 
		40
	]
];

//build finall preset array
_weatherPresets = _dayPresets;

if (_includeNight) then
{
	_weatherPresets append _nightPresets;
};

if (_includeFog) then
{
	_weatherPresets append _fogPresets;
	_weatherPresets append _fogPresets;
};

if (_forceNight && !_forceFogTwilight) then
{
	_weatherPresets = _nightPresets;
};

if (_forceFogTwilight && !_forceNight) then 
{
	_weatherPresets = [_fogPresets select 1];
};

if (_forceFogTwilight && _forceNight) then 
{
	if (selectRandom[true,false]) then 
	{
		_weatherPresets = [_fogPresets select 1];
	} else 
	{
		_weatherPresets = _nightPresets;
	};
};

if (_forceSpecialWeather) then 
{
	_weatherPresets = [_dayPresets select 2] + _nightPresets + _fogPresets + _fogPresets;
};

//select preset
_preset = selectRandom _weatherPresets;

[
	_preset select 0,
	_preset select 1,
	[(_preset select 2),0,0],
	[3, (_preset select 3)],
	[4, (_preset select 4)],
	_timeToChange
]