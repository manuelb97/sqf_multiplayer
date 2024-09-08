//Params
params [
	"_parent",
	"_player",
	"_pos"
];

_valid = [_parent, _player, _pos] isEqualTypeParams ["", objNull, []];
if !(_valid) exitWith
{
	["scripts\support\misc\supply_box.sqf", _parent, [_parent, _player, _pos]] spawn bia_input_msg;
};


[format["Spawning supply box"]] remoteExec ["bia_spawn_text", _player];
uiSleep 3;

_box = createVehicle ["Box_Syndicate_Ammo_F", _pos, [], 1, "NONE"];
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearBackpackCargoGlobal _box;

[_box, true, true] call ace_arsenal_fnc_initBox;

// _action = ["BiA_Arsenal", "Mission Arsenal", "", {_this spawn bia_adaptive_arsenal;}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
// [_box, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

// _signal = createVehicle ["G_40mm_SmokeBlue", getPos _box, [], 0, "CAN_COLLIDE"];
// _signal = createVehicle ["ACE_G_Chemlight_HiRed", getPos _box, [], 0, "CAN_COLLIDE"];

// uiSleep 20;
// deletevehicle _signal;