//Paras
params [
"_cooldown"
];

_nextFlare = missionNamespace getVariable ["FlareCooldown", 0];
_sunriseSunsetTime = date call BIS_fnc_sunriseSunsetTime;
_sunRiseHour = _sunriseSunsetTime select 0;
_sunSetHour = _sunriseSunsetTime select 1;

_radius = 0;
_numRounds = 1;
_delay = 60;
_safezone = 0;
_height = 150;
_velocity = 1;

while {true} do 
{
	_players = allPlayers select {_x distance2D hq_pos > 100 && (vehicle _x == _x || typeOf (vehicle _x) == "B_Parachute") };

	if !(missionNamespace getVariable ["SideMissionActive", false]) then 
	{
		if ((daytime < _sunRiseHour || daytime > _sunSetHour) && count _players > 0) then 
		{
			_nextFlare = missionNamespace getVariable ["FlareCooldown", 0];
			_infoVals = _players apply {east knowsAbout _x;};
			_highestNum = selectMax _infoVals;

			if (count _players > 0 && serverTime > _nextFlare && _highestNum == 4) then 
			{
				_idx = _infoVals find _highestNum;
				_targetPlayer = _players select _idx;

				_playerPos = _targetPlayer getPos [random [50, 100, 150], random 360];
				_ammo = selectRandom ['ACE_40mm_Flare_red']; //'ACE_40mm_Flare_green', 
				[_playerPos, _ammo, _radius, _numRounds, _delay, nil, _safezone, _height, _velocity, []] remoteExec ["BIS_fnc_fireSupportVirtual", missionNamespace getVariable ["BiA_Host", manu]];
				missionNamespace setVariable ["FlareCooldown", serverTime + _cooldown, true];
				
				["EnemyFlares", format["Launching Flares at %1 oclock", daytime]] remoteExec ["bia_to_log", 2]; 
			};
		};
	};

	uiSleep 5;
};