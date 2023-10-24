//Paras
params [
"_player"
];

_action = 
[
	"BiA_Spawn_UAV",
	"Spawn UAV Overwatch",
	"", 
	{_this spawn bia_spawn_drone;}, 
	{true},
	{},
	[_player]
] call ace_interact_menu_fnc_createAction;

[_player, 1, ["ACE_SelfActions", "BiA_Supports"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = 
[
	"BiA_UAV",
	"UAV Overwatch",
	"", 
	{_this spawn bia_control_drone;}, 
	{true},
	{},
	[_player]
] call ace_interact_menu_fnc_createAction;

[_player, 1, ["ACE_SelfActions", "BiA_Supports"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = 
[
	"BiA_Sniper",
	"Sniper Kill",
	"", 
	{_this spawn bia_order_sniper;}, 
	{true},
	{},
	[_player]
] call ace_interact_menu_fnc_createAction;

[_player, 1, ["ACE_SelfActions", "BiA_Supports"], _action] call ace_interact_menu_fnc_addActionToObject;