//Params
params [
"_debug"
];

//file, repetitions, delay after sound
_sounds = 
[
	["\jsrs_soundmod_complete\JSRS_Soundmod_Soundfiles\weapons\Shot\Distance\cannon\shot_very_far_1.ogg", 1, [0, 10]],
	["\jsrs_soundmod_complete\JSRS_Soundmod_Soundfiles\weapons\Shot\GM6\Medium_Distance.ogg", 1, [0, 10]]
];

while {true} do 
{
	_playSounds = missionNamespace getVariable ["BackgroundFights", true];

	if (_playSounds) then 
	{
		_sound = selectRandom _sounds;
		_sound params ["_file", "_repetitions", "_delay"];
		_player = selectRandom allPlayers;

		for "_i" from 1 to _repetitions do 
		{
			// [_missile, _sound] remoteExec ["say3D"]; //only for cfg sounds
			playSound3D [_file, _player, false, getPos _player, 1, 1, 0, 0, true];
		};

		_delay params ["_minDelay", "_maxDelay"];
		uiSleep random[_minDelay, _minDelay + (_maxDelay / 2), _maxDelay];
	};
};

//maybe not good enough / too hard to create good firefights
//in that case spawn stuff in the distance that fights each other