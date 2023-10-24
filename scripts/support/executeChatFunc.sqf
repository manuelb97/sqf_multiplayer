//Params
params [
"_args"
];

// all funcs need to be listed in "scripts\support\readChat.sqf"
_func = _args select 0;

//  ["Strike", 300], ["Smoke", 300], ["Supply", 600]

_supp = "Smoke";

if (_func in ["AT", "HE", "GunRun", "RocketRun", "AC130"]) then 
{
	_supp = "Strike";
} else 
{
	if (_func == "Supply") then 
	{
		_supp = "Supply";
	};
};

_cd = missionNamespace getvariable [format["%1SupportCD", _supp], 300];
_lastExe = missionNamespace getvariable [format["Last%1Support", _supp], serverTime - _cd];

if (servertime >= (_lastExe + _cd)) then 
{
	_lastExe = missionNamespace setvariable [format["Last%1Support", _supp], serverTime, true];

	switch (_func) do
	{
		case "AT": 
		{
			_args params ["_func", "_dist", "_dir"];

			_dist = parseNumber _dist;
			_dir = parseNumber _dir;
			_pos = (getPos player) getPos [_dist, _dir];

			_txt = format["Executing %1 Strike", _func];
			_radius = 0;
			_ammo = "ammo_bomb_bia"; //M_PG_AT M_Scalpel_AT Missile_AGM_02_F Rocket_04_AP_F M_Titan_AT ACE_Javelin_FGM148 ammo_Bomb_SDB M_Mo_120mm_AT
			_velocity = 50;
			_height = 400;

			[_txt, player, _pos, _radius, _ammo, _height, _velocity, true] spawn bia_drop_projectile;
		};

		case "HE": 
		{
			//_args params ["_func", "_x", "_y", "_rounds", "_radius"];
			_args params ["_func", "_dist", "_dir", "_rounds", "_radius"];

			if (isNil "_rounds") then 
			{
				_rounds = "1";
			};

			if (isNil "_radius") then 
			{
				_radius = "0";
			};

			_dist = parseNumber _dist;
			_dir = parseNumber _dir;
			_rounds = parseNumber _rounds;
			_radius = parseNumber _radius;
			_pos = (getPos player) getPos [_dist, _dir];

			_txt = format["Executing %1 Strike", _func];
			_ammo = "Sh_155mm_AMOS";
			_height = 400;
			_velocity = 50;
			
			for "_i" from 1 to _rounds do 
			{
				if (_i != 1) then 
				{
					_txt = "";
				};

				[_txt, player, _pos, _radius, _ammo, _height, _velocity, true] spawn bia_drop_projectile;
				uiSleep random[1,3,5];
			};
		};

		case "Smoke": 
		{
			_args params ["_func", "_dist", "_dir", "_strikeDir"];

			if (isNil "_strikeDir") then 
			{
				_strikeDir = "270";
			};
			
			_dist = parseNumber _dist;
			_dir = parseNumber _dir;
			_strikeDir = parseNumber _strikeDir;

			_txt = format["Deploying Smoke Screen"];
			_pos = (getPos player) getPos [_dist, _dir];
			_radius = 0;
			_ammo = "G_40mm_SmokeRed";
			_height = 400;
			_velocity = 50;

			_roundDist = 3;
			_rounds = 3;
			_strikeDist = _rounds * _roundDist;
			_startPos = _pos getPos [_strikeDist / 2, _strikeDir];

			_counter = 0;
			for "_i" from 1 to _rounds do 
			{
				if (_i != 1) then 
				{
					_txt = "";
				};

				_pos = _startPos getPos [_roundDist * _counter, _strikeDir + 180];
				[_txt, player, _pos, _radius, _ammo, _height, _velocity, true] spawn bia_drop_projectile;
				_counter = _counter + 1;
				uiSleep random[1,2,3];
			};
		};

		case "Flare": 
		{
			//_args params ["_func", "_x", "_y", "_rounds", "_radius"];
			_args params ["_func", "_dist", "_dir", "_rounds"];

			if (isNil "_rounds") then 
			{
				_rounds = "1";
			};

			_dist = parseNumber _dist;
			_dir = parseNumber _dir;
			_rounds = parseNumber _rounds;
			_pos = (getPos player) getPos [_dist, _dir];
			_radius = 0;

			_txt = format["Executing %1 Strike", _func];
			_ammo = selectRandom["ACE_40mm_flare_white", "ACE_40mm_flare_red", "ACE_40mm_flare_green"];
			_height = 150;
			_velocity = 6;
			
			for "_i" from 1 to _rounds do 
			{
				if (_i != 1) then 
				{
					_txt = "";
				};

				[_txt, player, _pos, _radius, _ammo, _height, _velocity, true] spawn bia_drop_projectile;
				uiSleep 45;
			};
		};

		case "GunRun":
		{
			_args params ["_func", "_dist", "_dir", "_strikeDir"];

			if (isNil "_strikeDir") then 
			{
				_strikeDir = "270";
			};

			_dist = parseNumber _dist;
			_dir = parseNumber _dir;
			_strikeDir = parseNumber _strikeDir;
			_pos = (getPos player) getPos [_dist, _dir];

			// hint format["Executing Gun Run, ETA 20 seconds"];
			[format["Executing Gun Run, ETA 20 seconds"]] spawn bia_spawn_text;

			// [_pos, _strikeDir, "B_Plane_CAS_01_F", "machinegun", true] spawn bia_zeus_cas;
			[_pos, _strikeDir, "B_Plane_CAS_01_F", true] spawn bia_cas_variable_weap;
		};

		case "RocketRun":
		{
			_args params ["_func", "_dist", "_dir", "_strikeDir"];

			if (isNil "_strikeDir") then 
			{
				_strikeDir = "270";
			};

			_dist = parseNumber _dist;
			_dir = parseNumber _dir;
			_strikeDir = parseNumber _strikeDir;
			_pos = (getPos player) getPos [_dist, _dir];

			// hint format["Executing Rocket Run, ETA 20 seconds"];
			[format["Executing Rocket Run, ETA 20 seconds"]] spawn bia_spawn_text;

			[_pos, _strikeDir, "B_Plane_CAS_01_F", "missilelauncher", true] spawn bia_zeus_cas;
		};

		case "AC130":
		{
			_args params ["_func", "_dist", "_dir", "_numStrikes"];

			if (isNil "_numStrikes") then 
			{
				_strikeDir = "1";
			};

			_dist = parseNumber _dist;
			_dir = parseNumber _dir;
			_numStrikes = parseNumber _numStrikes;
			_pos = (getPos player) getPos [_dist, _dir];

			// hint format["Calling AC130 Support, ETA 20 seconds"];
			[format["Calling AC130 Support, ETA 20 seconds"]] spawn bia_spawn_text;

			[_pos, _numStrikes, true] spawn bia_ac130_support;
		};

		case "Sniper":
		{
			_args params ["_func", "_dist", "_dir"];

			_dist = parseNumber _dist;
			_dir = parseNumber _dir;
			_pos = (getPos player) getPos [_dist, _dir];
			_targets = nearestObjects [_pos, ["Man"], 10, true];
			_targets = _targets select {side _x != west && vehicle _x == _x};
			//allUnits select {_x distance2D _pos < 2 && };

			if ((count _targets) > 0) then 
			{	
				_target = _targets select 0;
				uiSleep 1;
				// hint format["Sniper found Target"];
				[format["Sniper found Target"]] spawn bia_spawn_text;

				_delay = random[2,3,4];
				// hint format["Sniper taking Shot, ETA %1 seconds", round(_delay)];
				[format["Sniper taking Shot, ETA %1 seconds", round(_delay)]] spawn bia_spawn_text;
				uiSleep _delay;

				_target animate ["death", 0, false];
				_target setDamage 1;

				uiSleep random[1, 1.5, 2];
				playSound3D ["\jsrs_soundmod_complete\JSRS_Soundmod_Soundfiles\weapons\Shot\Distance\cannon\shot_very_far_1.ogg", player, false, getPos player, 1, 1, 0, 0, true];
			} else 
			{
				// hint format["Sniper unable to find suitable Target"];
				[format["Sniper unable to find suitable Target"]] spawn bia_spawn_text;
			};
		};

		case "Marker": 
		{
			_args params ["_func", "_dist", "_dir", "_txt"];

			if (isNil "_txt") then 
			{
				_txt = "";
			};
			
			_dist = parseNumber _dist;
			_dir = parseNumber _dir;

			_marker = "chatMarker_" + (str random [11111, 55555, 99999]);
			createMarker [_marker, (getPos player) getPos [_dist, _dir]];
			_marker setMarkerTypeLocal "mil_dot_noShadow";
			_marker setMarkerColorLocal "ColorRed";
			_marker setMarkerTextLocal (_txt + format[" (%1)", [dayTime, "HH:MM:SS"] call BIS_fnc_timeToString]);
			_marker setMarkerSize [0.25, 0.25];

			// hint "Marker placed";
			[format["Marker placed"]] spawn bia_spawn_text;

			uiSleep 60;
			deleteMarker _marker;
		};

		case "Supply":
		{
			_args params ["_func", "_dist", "_dir"];
			
			_dist = parseNumber _dist;
			_dir = parseNumber _dir;
			_pos = (getPos player) getPos [_dist, _dir];

			_box = createVehicle ["Box_Syndicate_Ammo_F", _pos, [], 1, "NONE"];
			clearItemCargoGlobal _box;
			clearMagazineCargoGlobal _box;
			clearWeaponCargoGlobal _box;
			clearBackpackCargoGlobal _box;

			_action = ["BiA_Arsenal", "Mission Arsenal", "", {_this spawn bia_adaptive_arsenal;}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
			[_box, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
			
			[format["Supply Box dropped off"]] spawn bia_spawn_text;

			// _signal = createVehicle ["G_40mm_SmokeBlue", getPos _box, [], 0, "CAN_COLLIDE"];
			// _signal = createVehicle ["ACE_G_Chemlight_HiRed", getPos _box, [], 0, "CAN_COLLIDE"];

			// uiSleep 20;
			// deletevehicle _signal;
		};

		case "QRF":
		{
			_args params ["_func"];
			
			_pos = getPos player;
			[_pos] remoteExec ["bia_support_qrf", missionNamespace getVariable ["BiA_Host", 2]];
			
			[format["QRF requested"]] spawn bia_spawn_text;
		};

		case "Kit":
		{
			_args params ["_func", "_kitName"];

			_pistolMag = "rhsusf_mag_15Rnd_9x19_FMJ";
			_frag = "HandGrenade";
			_smoke = "rhs_mag_m18_green";

			_loadout = 
			[
				[], [], 
				["rhsusf_weap_m9", "","","", [_pistolMag, [_pistolMag] call bia_mag_bullets], ["", 0], ""],
				["U_BG_Guerrilla_6_1", [["ACE_EarPlugs", 1], ["ACE_Flashlight_XL50", 1], ["ACE_fieldDressing", 30], ["ACE_morphine", 10], ["ACE_personalAidKit", 1]]],
				["rhs_6b3", [[_pistolMag, 3, [_pistolMag] call bia_mag_bullets], [_frag, 2, [_frag] call bia_mag_bullets], [_smoke, 2, [_smoke] call bia_mag_bullets]]], 
				["rhs_sidor", [["rhs_rpg7_OG7V_mag", 1], ["rhs_rpg7_PG7VM_mag", 1]]],
				"rhs_6b7_1m_olive", 
				"G_Balaclava_TI_blk_F",
				["rhs_pdu4", "", "", "", ["", 0], [], ""],
				["ItemMap", "ItemGPS", "ItemRadio", "ItemCompass", "ACE_Altimeter", "rhs_1PN138"] // O_NVGoggles_ghex_F O_NVGoggles_hex_F
			];

			switch (_kitName) do 
			{
				case "AK": 
				{
					_primMag = "rhs_30Rnd_545x39_7N10_camo_AK";
					_primSecMag = "";
					_atMag = "rhs_rpg7_OG7V_mag";
					_vestMags = [[_primMag, 15, [_primMag] call bia_mag_bullets]];
					_backMags = [[_atMag, 1, 1], ["rhs_rpg7_PG7VM_mag", 1, 1]];

					_loadout set [0, ["rhs_weap_ak74m_camo", "rhs_acc_dtk", "", "", [_primMag, [_primMag] call bia_mag_bullets], [_primSecMag, [_primMag] call bia_mag_bullets], ""]];
					_loadout set [1, ["rhs_weap_rpg7", "","","", [_atMag, [_atMag] call bia_mag_bullets], ["", 0], ""]];
					(_loadout select 4 select 1) append _vestMags;
					(_loadout select 5 select 1) append _backMags;
				};
				case "AKGP": 
				{
					_primMag = "rhs_30Rnd_545x39_7N10_camo_AK";
					_primSecMag = "rhs_VOG25";
					_vestMags = [[_primMag, 15, [_primMag] call bia_mag_bullets], [_primSecMag, 20, [_primSecMag] call bia_mag_bullets]];

					_loadout set [0, ["rhs_weap_ak74m_gp25", "rhs_acc_dtk", "", "", [_primMag, [_primMag] call bia_mag_bullets], [_primSecMag, [_primMag] call bia_mag_bullets], ""]];
					(_loadout select 4 select 1) append _vestMags;
				};
				case "PKM": 
				{
					_primMag = "rhssaf_250Rnd_762x54R";
					_vestMags = [[_primMag, 2, [_primMag] call bia_mag_bullets]];

					_loadout set [0, ["rhs_weap_pkm", "", "", "", [_primMag, [_primMag] call bia_mag_bullets], [], ""]];
					(_loadout select 4 select 1) append _vestMags;
				};
				case "SVD": 
				{
					_primMag = "ACE_10Rnd_762x54_Tracer_mag";
					_vestMags = [[_primMag, 2, [_primMag] call bia_mag_bullets]];

					_loadout set [0, ["rhs_weap_svdp", "", "", "rhs_acc_pso1m2", [_primMag, [_primMag] call bia_mag_bullets], [], ""]];
					(_loadout select 4 select 1) append _vestMags;
				};
			};
			
			player setUnitLoadout _loadout;
			[player] join grpNull;
			(group player) setVariable ["Vcm_Disable", true, true];
			player disableAI "SUPPRESSION";
		};
	};
} else 
{
	[
		format["%1 Support denied, remaining Cooldown: %2", _supp, round((_lastExe + _cd) - serverTime)]
	] remoteExec ["bia_spawn_text", player];
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