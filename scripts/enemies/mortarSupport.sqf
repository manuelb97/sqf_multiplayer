//Paras
private _artilleryFired = false;

while {true} do 
{
	_trainingArr = missionNamespace getVariable ["TrainingArr", []];
	_playerArr = allPlayers select 
	{
		_x distance2D hq_pos > 100
		&& !(_x in _trainingArr) 
		&& (vehicle _x == _x || typeOf (vehicle _x) == "B_Parachute") 
		&& side _x == west
	};

	if (
		!(missionNamespace getVariable ["SideMissionActive", false])
		&& count _playerArr > 0
	) then 
	{
		_playerArr = [selectRandom _playerArr]; // perform it only on 1 player, before evaluation for every player

		{
			_player = _x;

			if (!_artilleryFired) then
			{
				_infoVal = east knowsAbout _player;
				
				if (_infoVal == 4 && selectRandom[true,false]) then 
				{
					["Enemy Artillery fired", "center_upper", 5, 0, 0, 85, "Red"] remoteExecCall ["bia_spawn_text", 0];

					_rounds = selectRandom[1,2,3,4]; //,4,5,6,7,8
					_targetPos = getPos _player;// getPos[random[20,35,50],random 360];
					_safeZone = 50; //55 60
					_radius = _safeZone +selectRandom[5,15,20,20,20]; // 75 50/50
					_blacklistPos = allPlayers apply {[_x, _safeZone]};

					_txt = "";
					_ammo = "Sh_82mm_AMOS";
					_altitude = 400;
					_speed = 50;

					for "_i" from 1 to _rounds do 
					{
						_impactPos = [_targetPos, _safeZone, _radius, 0, 0, 0, 0, _blacklistPos, []] call BIS_fnc_findSafePos;
						[_txt, _player, _impactPos, 0, _ammo, _altitude, _speed, true] spawn bia_drop_projectile;
						uiSleep selectRandom[3,5,7,9];
					};

					_artilleryFired = true;
					["EnemyMortarSupport", format["Enemy Mortar Support fired"]] remoteExec ["bia_to_log", 2]; 
				};
			};
		} forEach _playerArr;
		
		if (_artilleryFired) then
		{		
			uiSleep 240;
			_artilleryFired = false;
		};
	};
	
	uiSleep 60;
};