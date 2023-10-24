//Params
params [
"_obj"
];

//PvP Actions
_action = ["Loadouts",  "Loadouts",  "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction; 
[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_loadouts = 
[
	["Random_Kit", "Random Kit",  "", { _this spawn bia_random_loadout; }, {true}, {}, [""]] call ace_interact_menu_fnc_createAction, 
	["Rifle_Kit", "Rifle Kit",  "", { _this spawn bia_random_loadout; }, {true}, {}, ["Rifle"]] call ace_interact_menu_fnc_createAction, 
	["Grenadier_Kit", "Grenadier Kit",  "", { _this spawn bia_random_loadout; }, {true}, {}, ["Grenadier"]] call ace_interact_menu_fnc_createAction, 
	["Rifle_AT_Kit", "Rifle AT Kit",  "", { _this spawn bia_random_loadout; }, {true}, {}, ["Rifle_AT"]] call ace_interact_menu_fnc_createAction, 
	["MG_Kit", "MG Kit",  "", { _this spawn bia_random_loadout; }, {true}, {}, ["MG"]] call ace_interact_menu_fnc_createAction, 
	["DMR_Kit", "DMR Kit",  "", { _this spawn bia_random_loadout; }, {true}, {}, ["DMR"]] call ace_interact_menu_fnc_createAction, 
	["Sniper_Kit", "Sniper Kit",  "", { _this spawn bia_random_loadout; }, {true}, {}, ["Sniper"]] call ace_interact_menu_fnc_createAction
];

{
	_action = _x;
	[_obj, 0, ["ACE_MainActions", "Loadouts"], _action] call ace_interact_menu_fnc_addActionToObject;
} forEach _loadouts;

//full arsenal for new testing
[_obj, true, true] call ace_arsenal_fnc_initBox;