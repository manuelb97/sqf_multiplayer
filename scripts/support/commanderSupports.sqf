//Paras
params [
"_player"
];

//teleport to HQ
_biaSupport = ["BiA_Supports", "BiA Support", "", {}, {true}] call ace_interact_menu_fnc_createAction; 
[_player, 1, ["ACE_SelfActions", "BiA_Actions"], _biaSupport] call ace_interact_menu_fnc_addActionToObject;

_teleToBase = ["BiA_TeleToBase", "Teleport to HQ", "", {_this spawn bia_tele_to_base;}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
[_player, 1, ["ACE_SelfActions", "BiA_Actions"], _teleToBase] call ace_interact_menu_fnc_addActionToObject;

//set cooldowns
{
	_x params ["_supp", "_cd"];
	missionNamespace setvariable [format["%1.supportcd", _supp], _cd, true];
	missionNamespace setvariable [format["last.%1.support", _supp], serverTime - _cd, true];
} forEach [["Overwatch", 600], ["Precision_Strike", 300], ["AoE_Strike", 600], ["Smoke", 300], ["Supply", 600]]; // , ["Infantry", 600]

//add cool down info action 
_cdInfo = ["BiA_CDInfo", "CD Info", "", 
{
	_cdVars = (allVariables missionNamespace) select {"supportcd" in _x};
	_cdVars sort true;
	_cdNames = _cdVars apply {(_x splitString ".") select 0};

	_infoMsg = [];

	_cds = _cdNames apply 
	{
		_supp = _x;
		_cd = missionNamespace getVariable format["%1.supportcD", _supp];
		_lastSupp = missionNamespace getVariable format["last.%1.support", _supp];
		_nextPossSupp = _lastSupp + _cd - serverTime;
		_timeTillNxtSupp = [_nextPossSupp, 0] call BIS_fnc_cutDecimals;

		if (_timeTillNxtSupp < 0) then 
		{
			_timeTillNxtSupp = "Support available"
		} else 
		{
			format["%1 sec.", _timeTillNxtSupp];
		};

		_infoMsg append [_supp, ": ", _timeTillNxtSupp, lineBreak];
	};

	[composeText _infoMsg] remoteExec ["hint", _player];
}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
[_player, 1, ["ACE_SelfActions", "BiA_Actions", "BiA_Supports"], _cdInfo] call ace_interact_menu_fnc_addActionToObject;

//Precision Chat Support
[] execVM "scripts\support\readChat.sqf";

//Spawn Helis
_heliActions = ["BiA_Helis", "Heli Actions", "", {}, {true}] call ace_interact_menu_fnc_createAction; // _player distance2D hq_pos < 100
[_player, 1, ["ACE_SelfActions", "BiA_Actions"], _heliActions] call ace_interact_menu_fnc_addActionToObject;

_spawnHeli = ["BiA_Heli_Spawn", "Spawn Helis", "", {}, {true}] call ace_interact_menu_fnc_createAction; 
[_player, 1, ["ACE_SelfActions", "BiA_Actions", "BiA_Helis"], _spawnHeli] call ace_interact_menu_fnc_addActionToObject;

_classes = 
[
	["B_Heli_Light_01_dynamicLoadout_F",""]
	,["O_Heli_Light_02_dynamicLoadout_F","Black"]
	,["I_Heli_light_03_dynamicLoadout_F","Green"]
	,["B_Heli_Attack_01_dynamicLoadout_F", ""]
	,["O_Heli_Attack_02_dynamicLoadout_F","Black"]
	,["O_T_VTOL_02_infantry_dynamicLoadout_F","Grey"]
	,["RHS_AH64D_wd","Grey"]
	,["RHS_AH1Z",""]
	,["RHS_Ka52_vvsc",""]
	//,["rhs_mi28n_vvsc",""]
	//,["RHS_MELB_AH6M",""]
	//,["RHS_Mi8MTV3_heavy_vdv",""]
	//,["RHS_Mi24V_vdv",""]
	// [test] call BIS_fnc_getVehicleCustomization
	// [test,""] call BIS_fnc_exportVehicle
];

{
	_x params ["_class", "_tex"];
	_displayName = getText(configFile >> "CfgVehicles" >> _class >> "displayName");

	_action = [format["BiA_%1", _displayName], _displayName, "", {_this spawn bia_supp_spawn_heli;}, {true}, {}, [_class, _tex]] call ace_interact_menu_fnc_createAction;
	[_player, 1, ["ACE_SelfActions", "BiA_Actions", "BiA_Helis", "BiA_Heli_Spawn"], _action] call ace_interact_menu_fnc_addActionToObject;
} forEach _classes;

//Heli Loadout 
_heliLoadout = ["BiA_Heli_Loadout", "Select Heli Loadout", "", {_this spawn bia_supp_veh_loadout;}, {true}, {}, [""]] call ace_interact_menu_fnc_createAction; 
_rearm = ["BiA_Rearm", "Rearm Vehicle", "", {_this spawn bia_rearm_vehicle;}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
{
	[_player, 1, ["ACE_SelfActions", "BiA_Actions", "BiA_Helis"], _x] call ace_interact_menu_fnc_addActionToObject;
} forEach [_heliLoadout, _rearm];

//Map supports
_map = ["BiA_Map_Support", "Map Support", "", {}, {true}] call ace_interact_menu_fnc_createAction; 
[_player, 1, ["ACE_SelfActions", "BiA_Actions", "BiA_Supports"], _map] call ace_interact_menu_fnc_addActionToObject;

_uav = ["BiA_UAV", "UAV", "", {}, {true}] call ace_interact_menu_fnc_createAction; 
[_player, 1, ["ACE_SelfActions", "BiA_Actions", "BiA_Supports"], _uav] call ace_interact_menu_fnc_addActionToObject; // , "BiA_Map_Support"

_uavSpawn = ["BiA_Spawn_UAV", "Spawn UAV Overwatch", "", {_this spawn bia_supp_spawn_drone;}, {true}, {}, [_player]] call ace_interact_menu_fnc_createAction;
_uavControl = ["BiA_UAV", "UAV Overwatch", "", {_this spawn bia_supp_control_drone;}, {true}, {}, [_player]] call ace_interact_menu_fnc_createAction;
_droneStrike = ["BiA_DroneStrike", "Missile Strike", "", {_this spawn bia_supp_drone_strike;}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
_droneMarker = ["BiA_DroneMarker", "Drone Marker", "", {_this spawn bia_supp_drone_marker;}, {true}, {}, []] call ace_interact_menu_fnc_createAction;

{
	[_player, 1, ["ACE_SelfActions", "BiA_Actions", "BiA_Supports", "BiA_UAV"], _x] call ace_interact_menu_fnc_addActionToObject; // , "BiA_Map_Support"
} forEach [_uavSpawn, _uavControl, _droneMarker]; //_droneStrike, 

/*
//Add support types
_infantryTeam = ["BiA_Infantry", "Infantry Team", "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
[_player, 1, ["ACE_SelfActions", "BiA_Supports", "BiA_Combat_Support"], _infantryTeam] call ace_interact_menu_fnc_addActionToObject;

{
	_x params ["_grpName", "_grpArr"];
	_idx = _forEachIndex;

	_infantryTeam = [format["BiA_Infantry_%1", _idx], _grpName, "", { _this spawn bia_supp_infantry_team; }, {true}, {}, [_grpArr]] call ace_interact_menu_fnc_createAction;
	[_player, 1, ["ACE_SelfActions", "BiA_Supports", "BiA_Combat_Support", "BiA_Infantry"], _infantryTeam] call ace_interact_menu_fnc_addActionToObject;
} forEach 
[
	[
		"Fireteam",
		[
			"rhsusf_army_ocp_rifleman",
			"rhsusf_army_ocp_grenadier",
			"rhsusf_army_ocp_autorifleman",
			"rhsusf_army_ocp_autoriflemana"
		]
	],
	[
		"Fireteam (AT)",
		[
			"rhsusf_army_ocp_rifleman",
			"rhsusf_army_ocp_maaws",
			"rhsusf_army_ocp_autorifleman",
			"rhsusf_army_ocp_autoriflemana"
		]
	]
	// rhsusf_army_ocp_machinegunner rhsusf_army_ocp_machinegunnera rhsusf_army_ocp_javelin rhsusf_army_ocp_javelin_assistant rhsusf_army_ocp_marksman
];

////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
//HQ Support
// _teleMates = ["BiA_Teleport", "Teleport to HQ", "", {_this spawn bia_to_hq;}, {true}, {}, [_player]] call ace_interact_menu_fnc_createAction;
// _hqFlares = ["BiA_Flares", "HQ Flares", "", {_this spawn bia_hq_flares;}, {true}, {}, [_player]] call ace_interact_menu_fnc_createAction;

//Arsenal
_arsenal = ["BiA_Arsenal", "Select Arsenal", "", {}, {true}, {}, [_player]] call ace_interact_menu_fnc_createAction;
[_player, 1, ["ACE_SelfActions", "BiA_Supports", "BiA_HQ_Support"], _arsenal] call ace_interact_menu_fnc_addActionToObject;

_hqArsenals = missionNamespace getVariable ["ArsenalBoxes", []];
_ruArsenal = ["BiA_RU_Arsenal", "Russian", "", 				{_this spawn bia_set_arsenal_theme;}, {true}, {}, [_hqArsenals, "Russian", true]] call ace_interact_menu_fnc_createAction;
_ruMoArsenal = ["BiA_MRU_Arsenal", "Modern Russian", "", 	{_this spawn bia_set_arsenal_theme;}, {true}, {}, [_hqArsenals, "Modern Russian", true]] call ace_interact_menu_fnc_createAction;
_usArsenal = ["BiA_US_Arsenal", "American", "",	 			{_this spawn bia_set_arsenal_theme;}, {true}, {}, [_hqArsenals, "American", true]] call ace_interact_menu_fnc_createAction;
_spcArsenal = ["BiA_Special_Arsenal", "Special", "", 		{_this spawn bia_set_arsenal_theme;}, {true}, {}, [_hqArsenals, "Special", true]] call ace_interact_menu_fnc_createAction;

{
	[_player, 1, ["ACE_SelfActions", "BiA_Supports", "BiA_HQ_Support", "BiA_Arsenal"], _x] call ace_interact_menu_fnc_addActionToObject;
} forEach [_ruArsenal, _ruMoArsenal, _usArsenal, _spcArsenal];

//Sniper Loadouts 
// [hq_arsenal, _debug] execVM "scripts\equipment\loadouts\addSniperLoadouts.sqf";

//Smoke Support 
[_player, _debug] execVM "scripts\support\supportOnSmoke.sqf";

//Fast Map Supports
{
	_x params ["_ammo", "_rounds", "_xStart", "_yDisp", "_dist", "_speed", "_height", "_directional"];
	_artiAct = [format["BiA_%1", _ammo], format["%1", _ammo], "", {_this spawn bia_supp_map;}, {true}, {}, [_ammo, _rounds, _xStart, _yDisp, _dist, _speed, _height, _directional]] call ace_interact_menu_fnc_createAction;
	[_player, 1, ["ACE_SelfActions", "BiA_Supports", "BiA_Combat_Support", "BiA_Artillery"], _artiAct] call ace_interact_menu_fnc_addActionToObject;
} forEach 
[
	//class, maxRounds, _xStart", "_yDisp", "_dist", "_speed", "_height", "_directional"
	["B_30mm_HE", 20, 0, 0, 5, 1000, 300, "directional"],
	["Sh_155mm_AMOS", 1, 0, 0, 0, 50, 300, ""],
	["G_40mm_SmokeRed", 3, -4, 2, 4, 50, 300, ""],
	["ACE_40mm_Flare_white", 1, 0, 0, 0, 6, 160, ""]

	//["R_80mm_HE", 6, 0, 0, 10, 1000, 300, "directional"],
	//["Bomb_03_F", 1, 0, 0, 0, 50, 300, ""],
	// B_20mm, B_25mm, B_30mm_HE, B_30mm_AP, B_30mm_MP, B_30mm_APFSDS, B_40mm_GPR, 	B_40mm_APFSDS, R_80mm_HE, R_230mm_HE, Sh_155mm_AMOS, Bo_Mk82, Bomb_03_F
];

//Resupply Support // disabled since covered by chat support
// _supplyDrop = ["BiA_Supply", "Spawn Supply Box", "", {_this spawn bia_cursor_support;}, {true}, {}, ["Supply"]] call ace_interact_menu_fnc_createAction;
// [_player, 1, ["ACE_SelfActions", "BiA_Supports", "BiA_Combat_Support"], _supplyDrop] call ace_interact_menu_fnc_addActionToObject;

_hq = ["BiA_HQ_Support", "HQ Support", "", {}, {true}] call ace_interact_menu_fnc_createAction; 

{
	[_player, 1, ["ACE_SelfActions", "BiA_Supports"], _x] call ace_interact_menu_fnc_addActionToObject;
} forEach [_combat, _hq];

_artillery = ["BiA_Artillery", "Artillery", "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
_uav = ["BiA_UAV", "UAV", "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
{
	[_player, 1, ["ACE_SelfActions", "BiA_Supports", "BiA_Combat_Support"], _x] call ace_interact_menu_fnc_addActionToObject;
} forEach [_artillery, _uav];


{
	_loadoutType = _x;
	_action = [format["BiA_%1", _loadoutType], _loadoutType, "", {_this spawn bia_veh_loadout;}, {true}, {}, [_loadoutType]] call ace_interact_menu_fnc_createAction;
	[_player, 1, ["ACE_SelfActions", "BiA_Supports", "BiA_HQ_Support", "BiA_Helis", "BiA_Heli_Loadout"], _action] call ace_interact_menu_fnc_addActionToObject;
} forEach ["Anti Infantry", "Anti Vehicle", "Universal"];
*/