/*
["ClearedPosArr",[]] execVM "scripts\patrolsGuards\NewSaving\saveToProfile.sqf";

["ClearedPosArr",[getPos manu]] execVM "scripts\patrolsGuards\NewSaving\saveToProfile.sqf";;

["PlayerStatsArr",[]] call compile preprocessFileLineNumbers "scripts\patrolsGuards\NewSaving\loadFromProfile.sqf";
*/

params [
"_variableName", 
"_default",
["_debug",false]
];

_debug = false;
_tag = "LoadFromProfile";
_value = profileNamespace getVariable ["BIA_" + (toUpper worldName) + "_" + _variableName, _default];

if (_debug) then
{
	_text = format["Loaded Variable %1 with Value: %2", _variableName, _value];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

_value

//ClearedPosArr
//PlayerStatsArr