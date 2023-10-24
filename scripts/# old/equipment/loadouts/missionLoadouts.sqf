//[hq_arsenal, false] spawn bia_mission_loadouts;

//Paras
params [
"_loadoutObj",
"_debug"
];

//Prep classes
_classes = [
	"Russian",
	"Modern Russian",
	"American",
	"Special"
];

//Add class actions
{
	_class = _x;
	_loadoutID = format["%1_Loadout", _class];
	_action =  [_loadoutID, _class, "", {_this spawn bia_class_arsenal;}, {true}, {}, [_loadoutObj, _class]] call ace_interact_menu_fnc_createAction;
	[_loadoutObj, 0, ["ACE_MainActions", "BiA_Loadouts"], _action] call ace_interact_menu_fnc_addActionToObject;
} forEach _classes;