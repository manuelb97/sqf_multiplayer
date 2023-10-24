// [manu, manu, []] execVM "scripts\patrolsGuards\Supports\spawnGroundVehicle.sqf";

//Paras
params [
"_target",
"_player",
"_actionParams"
];

//Remove action
//[_player, 1, ["ACE_SelfActions", "BiA_Supports", "BiA_Ground_Support"]] call ace_interact_menu_fnc_removeActionFromObject;

_supportTime = 240;
_debug = true;

_tag = "SupportGroundSupport";

if (_debug) then 
{
	_text = format["Support Ground Script started"];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

_playerPos = getPos _player;
_supportPos = [_playerPos, 600, 250, 50] call BIS_fnc_findOverwatch;

if (!(_supportPos isEqualTo [_playerPos select 0, _playerPos select 1])) then
{
	/*
	"rhs_btr80_vdv", "rhsusf_stryker_m1126_m2_wd", "rhsusf_m1165a1_gmv_m134d_m240_socom_d", 
	"rhsusf_m1165a1_gmv_m2_m240_socom_d", rhs_gaz66_zu23_msv, "RHS_Ural_Zu23_MSV_01", 
	"rhs_tigr_sts_msv", "B_T_APC_Tracked_01_rcws_F", 
	"rhs_btr80a_vdv", "rhs_bmp3_late_msv", // "rhs_zsu234_aa", ,"rhs_brm1k_msv"
	
	//good but destroy buildings
	//,"rhs_btr80a_vdv"
	//,"rhs_bmp2k_vdv"
	//,"rhs_bmp3_late_msv"
	//,"rhs_zsu234_aa"
	*/
	_class = selectRandom 
	[
		"RHS_M2A2_wd"
		,"rhsusf_M1117_O"
	];
	_veh = createVehicle [_class, _supportPos, [], 0, "NONE"];
	[_veh, ["supportGround", true]] remoteExec ["setVariable", 0, true];
	_crewSeats = [_class, false] call BIS_fnc_crewCount;

	//Create Crew
	_grp = createGroup west;
	_grp deleteGroupWhenEmpty true;

	for "_i" from 1 to _crewSeats do 
	{
		_soldier = _grp createUnit ["rhsusf_army_ocp_driver_armored", getpos _veh, [], 0, "NONE"];
		[_soldier, ["supportGround", true]] remoteExec ["setVariable", 0, true];
		_soldier setSkill 1;
		_soldier moveInAny _veh;
	};
	
	// fix stuck at spawn
	sleep 1;
	{ moveOut _x; } forEach units _grp; 
	sleep 1;
	{ _x moveInAny _veh; } forEach units _grp; 
	sleep 1;
	{ moveOut _x; } forEach units _grp; 
	sleep 1;
	{ _x moveInAny _veh; } forEach units _grp; 
	sleep 1;

	//Reveal enemies once in AO
	_veh setFuel 0;
	//_veh forceSpeed 0;
	_veh setDir (_veh getDir _player);
	
	_enemyUnits = allUnits select 
	{
		_x getVariable ["patrolBool", false]
	};

	{
		_grp reveal [_x, 4];
	} forEach _enemyUnits;

	//Start support duration
	if (_debug) then 
	{
		_text = format["Ground Support Duration started: %1", _supportTime];
		[_tag, _text] remoteExec ["bia_to_log", 2, false];
	};

	[_supportTime, true] call BIS_fnc_countdown;

	while {([0] call BIS_fnc_countdown) > 0 && alive _veh} do
	{
		_enemyUnits = allUnits select 
		{
			_x getVariable ["patrolBool", false]
		};

		{
			_grp reveal [_x, 4];
		} forEach _enemyUnits;
		
		uiSleep 1;
	};

	//Stop support
	if (_debug) then 
	{
		_text = format["Stopping Ground Support"];
		[_tag, _text] remoteExec ["bia_to_log", 2, false];
	};
	
	_veh setDamage 1;
	uiSleep 2;
	
	_supportObjs = allUnits select {_x getVariable ["supportGround", false]};
	{
		deleteVehicle _x;
	} forEach _supportObjs; 

	deleteVehicle _veh;
} else
{
	"No suitable position to send ground Support" remoteExec ["hint", _player, false];
};