//Paras
params [
"_player",
"_name",
"_displayName",
"_code",
"_cond",
"_actionTreeArr",
"_debug"
];

_tag = "Support_AddToACE";

if (_debug) then 
{
	_text = format["Support added"];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

if ([_player, objNull, []] call ace_common_fnc_canInteractWith) then
{
	_action = 
	[
		_name,
		_displayName,
		"", 
		_code, 
		_cond
	] call ace_interact_menu_fnc_createAction;
	
	[_player, 1, _actionTreeArr, _action] call ace_interact_menu_fnc_addActionToObject;	//ace_interact_menu_fnc_addActionToClass; (typeOf _player)
};

/*
//CAS Helicopter
[
	manu, 
	"BiA_CAS_Helicopter", 
	"CAS (Helicopter)", 
	{[nil, manu, []] remoteExec ["bia_cas", selectRandom allPlayers, false];}, 
	{true}, 
	["ACE_SelfActions", "BiA_Supports"], 
	true
] execVM "scripts\patrolsGuards\Supports\addAceInteraction.sqf";

[manu, 1, ["ACE_SelfActions", "BiA_Supports", "BiA_CAS_Helicopter"]] call ace_interact_menu_fnc_removeActionFromObject;


//Ground Support
[
	manu, 
	"BiA_Ground_Support", 
	"Ground Support", 
	{[nil, manu, []] remoteExec ["bia_ground_support", selectRandom allPlayers, false];}, 
	{true}, 
	["ACE_SelfActions", "BiA_Supports"], 
	true
] execVM "scripts\patrolsGuards\Supports\addAceInteraction.sqf";

[manu, 1, ["ACE_SelfActions", "BiA_Supports", "BiA_Ground_Support"]] call ace_interact_menu_fnc_removeActionFromObject;


//AC130
[
	manu, 
	"BiA_CAS_AC130", 
	"AC130", 
	{[nil, manu, []] remoteExec ["bia_ac130", selectRandom allPlayers, false];}, 
	{true}, 
	["ACE_SelfActions", "BiA_Supports"], 
	true
] execVM "scripts\patrolsGuards\Supports\addAceInteraction.sqf";

[manu, 1, ["ACE_SelfActions", "BiA_Supports", "BiA_CAS_AC130"]] call ace_interact_menu_fnc_removeActionFromObject;


//Artillery
[
	manu, 
	"BiA_Artillery", 
	"Artillery", 
	{[nil, manu, []] remoteExec ["bia_artillery_support", selectRandom allPlayers, false];}, 
	{true}, 
	["ACE_SelfActions", "BiA_Supports"], 
	true
] execVM "scripts\patrolsGuards\Supports\addAceInteraction.sqf";

[manu, 1, ["ACE_SelfActions", "BiA_Supports", "BiA_Artillery"]] call ace_interact_menu_fnc_removeActionFromObject;
*/