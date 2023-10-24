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

//[_tag, format["Loaded Variable %1 with Value: %2", _variableName, _value], _debug] spawn bia_to_log;

_value

//ClearedPosArr
//PlayerStatsArr