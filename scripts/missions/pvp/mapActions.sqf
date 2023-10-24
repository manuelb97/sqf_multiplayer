//Params
params [
"_obj"
];

//PvP Actions
_action = ["PvP",  "PvP",  "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction; 
[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_pvpMissions = 
[
	["PvPDefense", "Defense",  "", { _this spawn bia_pvp_mission; }, {true}, {}, ["defense"]] call ace_interact_menu_fnc_createAction, 
	["PvPDefense", "Conquest",  "", { _this spawn bia_pvp_mission; }, {true}, {}, ["conquest"]] call ace_interact_menu_fnc_createAction
];

{
	_action = _x;
	[_obj, 0, ["ACE_MainActions", "PvP"], _action] call ace_interact_menu_fnc_addActionToObject;
} forEach _pvpMissions;

//Heal yourself
_action = ["HealSelf", "Heal yourself",  "", { _this spawn bia_heal_caller; }, {true}, {}, []] call ace_interact_menu_fnc_createAction; 
[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;