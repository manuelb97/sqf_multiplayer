//Params
params [
"_target", 
"_caller", 
"_arguments"
];

_arguments params ["_type"];

_pos = screenToWorld [0.5,0.5];
//_z = getTerrainHeightASL _pos;
_pos set [2, 0];
_serverTime = serverTime;
_suppAvailable = missionNamespace getVariable [format["Next_%1", _type], 0];
_cooldown = 600;

if (_type == "Supply" && _serverTime > _suppAvailable) then 
{
	_box = createVehicle ["Box_Syndicate_Ammo_F", _pos, [], 1, "NONE"];
	[_box, _box] call ace_common_fnc_claim; uiSleep 1;
	// _action = ["BiA_Loadouts", "Arsenal", "", {}, {true}] call ace_interact_menu_fnc_createAction; 
	// [_box, 0, ["ACE_MainActions"], _action] remoteExec ["ace_interact_menu_fnc_addActionToObject", 0];

	_theme = missionNamespace getVariable ["ArsenalTheme", ""];

	if (_theme != "") then 
	{
		_loadoutID = format["%1_Loadout", _theme];
		_action =  [_loadoutID, _theme, "", {_this spawn bia_class_arsenal;}, {true}, {}, [_box, _theme]] call ace_interact_menu_fnc_createAction;
		[_box, 0, ["ACE_MainActions", "BiA_Loadouts"], _action] remoteExec ["ace_interact_menu_fnc_addActionToObject", 0];
	} else 
	{
		"No theme defined in missionNamespace" remoteExec ["hint", _caller];
		[_box, true] call ace_arsenal_fnc_initBox;
	};

};

/*
// Sh_82mm_AMOS Sh_120mm_HE Sh_155mm_AMOS Smoke_120mm_AMOS_White R_80mm_HE R_230mm_HE Bo_Mk82 Missile_AGM_02_F 
_type = _arguments select 0;

_shellName = "";
if ("smoke" in (toLower _type)) then 
{
	_shellName = "Smoke";
} else 
{
	_shellName = "HE";
};

_serverTime = serverTime;
_suppAvailable = missionNamespace getVariable [format["Next_%1", _type], 0];
_channelID = missionNamespace getVariable ["SupportChannel", 0];
_cooldown = 600;

_spawnHeight = 600;
_speed = -50;

if (_serverTime > _suppAvailable) then
{
	_caller customChat [_channelID, format["Artillery %1 Support requested", _shellName]];

	//Delay
	_delay = round(random [5, 10, 15]);
	_caller customChat [_channelID, format["%1 inbound in %2 seconds", _shellName, _delay]];
	//hint format["Support inbound, %1 seconds", _delay];
	uiSleep _delay;

	_pos = screenToWorld [0.5,0.5];
	_z = getTerrainHeightASL _pos;
	_pos set [2, _z];

	_missile = createVehicle [_type, _pos vectorAdd [0, 0, _spawnHeight], [], 0, "CAN_COLLIDE"]; 
	_missile setVectorDirAndUp [[0, 0, -1], [0, 1, -1]]; 
	_missile setVelocity [0, 0, _speed];

	uiSleep (_spawnHeight / abs(_speed));
	_caller customChat [_channelID, format["Artillery Support successfully executed"]];

	// Server time (time in sec since server restart)
	_caller customChat [_channelID, format["Next Artillery Support available in %1 minutes", round(_cooldown / 60)]];
	missionNamespace setVariable [format["Next_%1", _type], serverTime + _cooldown, true];
} else
{
	_caller customChat [_channelID, format["Next Artillery Support available in %1 seconds", round(_suppAvailable - serverTime)]];
	//hintSilent format["Available in %1 seconds", _suppAvailable - _serverTime];
};
*/