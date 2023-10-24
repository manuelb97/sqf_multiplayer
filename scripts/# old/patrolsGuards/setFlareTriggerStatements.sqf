//'ACE_40mm_Flare_white',

_sunriseSunsetTime = date call BIS_fnc_sunriseSunsetTime;
_sunRiseHour = _sunriseSunsetTime select 0;
_sunSetHour = _sunriseSunsetTime select 1;

Flare_Trigger setTriggerStatements 
[
	"this","
		if (daytime < _sunRiseHour || daytime > _sunSetHour) then 
		{
			_players = thisList;
			_playerPos = (selectRandom _players) getPos [random [50, 100, 150], random 360];
			[_playerPos, selectRandom ['ACE_40mm_Flare_green', 'ACE_40mm_Flare_red'], 0, 2, 60, nil, 0, 150, 1, []] remoteExec ['BIS_fnc_fireSupportVirtual', selectRandom allPlayers, false];
		};
	", ""
];

/*
"this","
		if (daytime < _sunRiseHour || daytime > _sunSetHour) then 
		{
			_players = thisList;
			_playerPos = (selectRandom _players) getPos [random [50, 100, 150], random 360];
			[_playerPos, selectRandom ['ACE_40mm_Flare_green', 'ACE_40mm_Flare_red'], 0, 2, 60, nil, 0, 150, 1, []] remoteExec ['BIS_fnc_fireSupportVirtual', selectRandom allPlayers, false];
		};
	", ""
	*/