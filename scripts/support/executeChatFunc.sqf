//Params
params [
"_args"
];

// all funcs need to be listed in "scripts\support\readChat.sqf"
_player = _args select 0;
_func = _args select 1;
_parent = "scripts\support\executeChatFunc.sqf";

_cd = missionNamespace getvariable [format["%1SupportCD", _func], 60];
_lastExe = missionNamespace getvariable [format["Last%1Support", _func], serverTime - _cd];

if (servertime >= (_lastExe + _cd) || true) then 
{
	_lastExe = missionNamespace setvariable [format["Last%1Support", _func], serverTime, true];

	switch (_func) do
	{
		case "HE": 
		{
			_args params [
				"_player", "_func", "_dist", "_dir", ["_rounds", 1], ["_radiusX", 0], ["_radiusY", 0]
			];
			[
				[_dist, _dir, _rounds, _radiusX, _radiusY]
			] call bia_to_num params ["_dist", "_dir", "_rounds", "_radiusX", "_radiusY"];
			[_parent, _player, _dist, _dir, _rounds, _radiusX, _radiusY] spawn bia_he_artillery;
		};

		case "AT": 
		{
			_args params ["_player", "_func", "_dist", "_dir"];
			[[_dist, _dir]] call bia_to_num params ["_dist", "_dir"];
			_pos = _player getPos [_dist, _dir];
			[_parent, _player, _pos] spawn bia_at_artillery;
		};

		case "Smoke": 
		{
			_args params ["_player", "_func", "_dist", "_dir", "_strikeDir"];
			[[_dist, _dir, _strikeDir]] call bia_to_num params ["_dist", "_dir", "_strikeDir"];
			_pos = _player getPos [_dist, _dir];
			[_parent, _player, _pos, _strikeDir] spawn bia_smoke_artillery;
		};

		case "Flare": 
		{
			_args params ["_player", "_func", "_dist", "_dir", "_rounds"];
			[[_dist, _dir, _rounds]] call bia_to_num params ["_dist", "_dir", "_rounds"];
			_pos = _player getPos [_dist, _dir];
			[_parent, _player, _pos, _rounds] spawn bia_flare_artillery;
		};

		case "GunRun":
		{
			_args params ["_player", "_func", "_dist", "_dir", "_strikeDir"];
			[[_dist, _dir, _strikeDir]] call bia_to_num params ["_dist", "_dir", "_strikeDir"];
			_pos = _player getPos [_dist, _dir];
			[_parent, _player, _pos, _strikeDir] spawn bia_gunrun_cas;
		};

		case "RocketRun":
		{
			_args params ["_player", "_func", "_dist", "_dir", "_strikeDir"];
			[[_dist, _dir, _strikeDir]] call bia_to_num params ["_dist", "_dir", "_strikeDir"];
			_pos = _player getPos [_dist, _dir];
			[_parent, _player, _pos, _strikeDir] spawn bia_rocketrun_cas;
		};

		case "AC130":
		{
			_args params ["_player", "_func", "_dist", "_dir", ["_numStrikes", 3], ["_radiusX", 0], ["_radiusY", 0]];
			[
				[_dist, _dir, _numStrikes, _radiusX, _radiusY]
			] call bia_to_num params ["_dist", "_dir", "_numStrikes", "_radiusX", "_radiusY"];
			[_parent, _player, _dist, _dir, _numStrikes, _radiusX, _radiusY] spawn bia_ac130_cas;
		};

		case "Sniper":
		{
			_args params ["_player", "_func", "_dist", "_dir"];
			[[_dist, _dir]] call bia_to_num params ["_dist", "_dir"];
			_pos = _player getPos [_dist, _dir];
			[_parent, _player, _pos] spawn bia_sniper_assassination;
		};

		case "Marker": 
		{
			_args params ["_player", "_func", "_dist", "_dir", "_txt"];
			[[_dist, _dir]] call bia_to_num params ["_dist", "_dir"];
			_pos = _player getPos [_dist, _dir];
			[_parent, _player, _pos, _txt] spawn bia_create_tmp_marker;
		};

		case "Supply":
		{
			_args params ["_player", "_func", "_dist", "_dir"];
			[[_dist, _dir]] call bia_to_num params ["_dist", "_dir"];
			_pos = _player getPos [_dist, _dir];
			[_parent, _player, _pos] spawn bia_supply_box;
		};

		case "QRF":
		{
			_args params ["_player", "_func", "_dist", "_dir"];
			[[_dist, _dir]] call bia_to_num params ["_dist", "_dir"];
			_pos = _player getPos [_dist, _dir];
			[_parent, _player, _pos] spawn bia_qrf_support;
		};

		case "Kit":
		{
			_args params ["_player", "_func", "_kitName"];
			[_parent, _player, _kitName] spawn bia_change_kit;
		};
	};
} else 
{
	[
		format["%1 Support denied, remaining Cooldown: %2", _func, round((_lastExe + _cd) - serverTime)]
	] remoteExec ["bia_spawn_text", _player];
};

/* old code 

	case "Bomb": 
	{
		_args params ["_func", "_x", "_y"];
		_pos = [parseNumber _x, parseNumber _y, 300];
		_missile = createVehicle ["Bomb_03_F", _pos, [], 0, "CAN_COLLIDE"];  
		_missile setVectorDirAndUp [[0, 0, -1], [0, 1, -1]];  
		_missile setVelocity [0, 0, -50]; 
	};

	case "RocketRun":
	{
		_args params ["_func", "_x", "_y", "_dir", "_dist"];

		_ammo = "R_80mm_HE";
		_roundDist = 15;
		_pos = [parseNumber _x, parseNumber _y, 300];
		_dir = parseNumber _dir;
		_dist = selectMax[parseNumber _dist, _roundDist * 3];

		_startPos = _pos getPos [_dist / 2, _dir];
		_rounds = ceil(_dist / _roundDist);
		_steps = _dist / _rounds;

		_counter = 0; 

		for "_i" from 1 to _rounds do  
		{ 
			_pos = _startPos getPos [_steps * _counter, _dir + 180];
			_missile = createVehicle [_ammo, _pos vectorAdd [random[-3, 0, 3], random[-3, 0, 3], 300], [], 0, "CAN_COLLIDE"];
			_missile setVectorDirAndUp [[0, 0, -1], [0, 1, -1]];  
			_missile setVelocity [0, 0, -1000]; 

			_counter = _counter + 1; 
			uiSleep 0.1; 
		};
	};


		_onWater = surfaceIsWater [_pos select 0, _pos select 1, 0];
		if (_onWater) then 
		{
			_ammo = "Bomb_03_F";
		};

		//_missile setMissileTargetPos [_pos select 0, _pos select 1, 0]; //not sure if helpful

		//Rocket has to be perfect to destroy vehicle, AT mines explosion to make it reliable
		if (!_onWater) then 
		{
			while {alive _missile} do 
			{
				uiSleep 0.05;
			};

			for "_i" from 1 to 1 do 
			{
				_missile = createVehicle ["ammo_bomb_bia", [_pos select 0, _pos select 1, 2], [], 0, "CAN_COLLIDE"]; //ATMine_Range_Ammo
				_missile setDamage 1;
			};
		};




		_ammo = "B_30mm_HE";
		_roundDist = 2; //4

		
		_strikeDist = selectMax[_strikeDist, _roundDist * 5];
		_rounds = ceil(_strikeDist / _roundDist);
		_steps = _strikeDist / _rounds;
		_startPos = _pos getPos [_strikeDist / 2, _strikeDir];

		_counter = 0; 

		for "_i" from 1 to _rounds do  
		{ 
			_pos = _startPos getPos [_steps * _counter, _strikeDir + 180];
			_missile = createVehicle [_ammo, _pos vectorAdd [random[-3, 0, 3], random[-3, 0, 3], 300], [], 0, "CAN_COLLIDE"];
			_missile setVectorDirAndUp [[0, 0, -1], [0, 1, -1]];  
			_missile setVelocity [0, 0, -1000]; 

			_counter = _counter + 1; 
			uiSleep 0.1; 
		};

		uiSleep 1;
		// old method with exact position as input 
		_args params ["_func", "_x", "_y", "_dir", "_dist"];

		_ammo = "B_30mm_HE";
		_roundDist = 4;
		_pos = [parseNumber _x, parseNumber _y, 300];
		_dir = parseNumber _dir;
		_dist = selectMax[parseNumber _dist, _roundDist * 5];

		_startPos = _pos getPos [_dist / 2, _dir];
		_rounds = ceil(_dist / _roundDist);
		_steps = _dist / _rounds;
*/