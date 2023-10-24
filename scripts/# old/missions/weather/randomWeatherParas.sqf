//Paras
_tier = param [0,""];
_missionType = param [1,""];

// preset structure = overcast, rain, fog, hour, min
_weatherPresets = [
	// Normal & Day
	[selectRandom [0.1, 0.2, 0.3, 0.4], 0, 0, round(random [7, 12, 18]), round((random 1)*60)],
	// Normal & Day
	[selectRandom [0.1, 0.2, 0.3, 0.4], 0, 0, round(random [7, 12, 18]), round((random 1)*60)],
	// Bright & Day
	[0, 0, 0, 17, 0],
	
	// Rainy & Day
	[selectRandom [0.5, 0.6, 0.7, 0.8, 0.9], selectRandom [0.2, 0.3, 0.4], 0, round(random [7, 12, 18]), round((random 1)*60)],
	// Foggy & Rainy & Day
	[selectRandom [0.5, 0.6, 0.7], selectRandom [0.2,0.3,0.4], selectRandom [0.2,0.3], round(random [7, 12, 18]), round((random 1)*60)],
	// Foggy & Twilight
	[0.7, 0, selectRandom [0.2, 0.3], 18, 0],
	
	// Normal & Night
	[selectRandom [0.1,0.2,0.3,0.4], 0, 0, round(random [19, 21, 23]), round((random 1)*60)],
	// Rainy & Night
	[selectRandom [0.5,0.6,0.7,0.8,0.9], selectRandom [0.2,0.3,0.4], 0, round(random [19, 21, 23]), round((random 1)*60)]
];

//Disable night missions when no nvgs are available
if (_tier == "Tier_4" && _missionType != "Zombie") then 
{
	_weatherPresets resize 6;
};

//Disable fog for sniper missions
if (_missionType == "Sniper") then 
{
	_weatherPresets deleteAt 5;
	_weatherPresets deleteAt 4;
};

//Only enable night missions when zombie mission
if (_missionType == "Zombie") then 
{
	_weatherPresets = _weatherPresets select [6, 2];
};

//select preset
_preset = selectRandom _weatherPresets;

_returnArray = [	_preset select 0,
							_preset select 1,
							[(_preset select 2),0,0],
							[3, (_preset select 3)],
							[4, (_preset select 4)]
				];
_returnArray