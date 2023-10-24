/*
["ClearedPosArr",[getPos manu]] execVM "scripts\patrolsGuards\NewSaving\saveToProfile.sqf";

 profileNamespace getVariable "Test";
 
["PlayerStatsArr",[[manu,10,[1,2,3],5]]] execVM "scripts\patrolsGuards\NewSaving\saveToProfile.sqf";
*/

params [
"_variableName", 
"_value",
["_append",false],
["_debug",true]
];

if (!_append) then
{
	profileNamespace setVariable ["BIA_" + (toUpper worldName) + "_" + _variableName, _value];
} else
{
	_currentVal = [_variableName,[]] call compile preprocessFileLineNumbers "scripts\patrolsGuards\NewSaving\loadFromProfile.sqf";
	profileNamespace setVariable ["BIA_" + (toUpper worldName) + "_" + _variableName, _currentVal + _value];
};

saveProfileNamespace;

//ClearedPosArr
//PlayerStatsArr