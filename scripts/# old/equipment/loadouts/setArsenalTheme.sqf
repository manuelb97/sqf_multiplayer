//Params
params [
"_target", 
"_caller", 
"_arguments"
];

_arguments params ["_loadoutObjArr", "_theme", "_removeOthers"];

//remove current themes 
if (_removeOthers) then 
{
	{
		_arsenal = _x;
		{
			_loadoutID = format["%1_Loadout", _x];
			[_arsenal, 0, ["ACE_MainActions","BiA_Loadouts", _loadoutID]] remoteExec ["ace_interact_menu_fnc_removeActionFromObject", 0];
		} forEach ["Russian", "Modern Russian", "American", "Special"];
	} forEach _loadoutObjArr;
};

uiSleep 1; //needed cuz remoteExec removal of arsenals takes time

//Add new action
{
	_arsenal = _x;
	_loadoutID = format["%1_Loadout", _theme];
	_action =  [_loadoutID, _theme, "", {_this spawn bia_class_arsenal;}, {true}, {}, [_arsenal, _theme]] call ace_interact_menu_fnc_createAction;
	_ret = [_arsenal, 0, ["ACE_MainActions", "BiA_Loadouts"], _action] remoteExec ["ace_interact_menu_fnc_addActionToObject", 0];
} forEach _loadoutObjArr;

missionNamespace setVariable ["ArsenalTheme", _theme, true];