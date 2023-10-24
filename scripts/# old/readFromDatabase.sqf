/*
[[_missionLoc],"scripts\writeToDatabase.sqf"] remoteExecCall ["execVM", 2, false];
*/

params [
"_topLvl", //Buildings
"_subLvl", //Cleared
"_defaultValue"
];

_mission = [missionNamespace, "mission", "Test"] call BIS_fnc_getServerVariable;
_inidbi = ["new", _mission] call OO_INIDBI;
_values = ["read", [_topLvl, _subLvl, _defaultValue]] call _inidbi;

_values