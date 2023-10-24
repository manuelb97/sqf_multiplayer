/*
[[_missionLoc],"scripts\writeToDatabase.sqf"] remoteExecCall ["execVM", 2, false];
*/

params [
"_topLvl", //Buildings
"_subLvl", //Cleared
"_value",
"_type"
];

_debug = true;

_mission = "BiA_Patrol"; //[missionNamespace, "mission", "Test"] call BIS_fnc_getServerVariable;

if (_debug) then 
{
	[format["DB Name: %1", _mission]] remoteExec ["hint", 0, true]; 
	uiSleep 3;
};

_inidbi = ["new",_mission] call OO_INIDBI;
_priorValues = ["read", [_topLvl, _subLvl, []]] call _inidbi;

if (_debug) then 
{
	[format["Prior: %1", _priorValues]] remoteExec ["hint", 0, true]; 
	uiSleep 3;
};

if (_type == "append") then 
{
	["write", [_topLvl, _subLvl, _priorValues + [_value]]] call _inidbi;
};
	
if (_type == "replace") then 
{
	["write", [_topLvl, _subLvl, _value]] call _inidbi;
};
	
if (_type == "sum") then 
{
	if (typeName _priorValues != "SCALAR") then
	{
		_priorValues = 0;
	};
	["write", [_topLvl, _subLvl, _priorValues + _value]] call _inidbi;
};