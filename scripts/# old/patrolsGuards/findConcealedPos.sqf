// [getPos manu, 250, 350, true] execVM "scripts\patrolsGuards\findConcealedPos.sqf";

//Paras
params [
"_targetPos",
"_dist",
"_minDist",
"_maxDist",
"_debug"
];

_tag = "ConcealedPos";

_safePos 				= [_targetPos, _minDist, _maxDist, _dist, 0, 20, 0, [[]], [_targetPos, _targetPos]] call BIS_fnc_findSafePos;
_aslSafePos 			= AGLToASL [_safePos select 0, _safePos select 1, 1];
_aslPlayerPos 		= AGLToASL [_targetPos select 0, _targetPos select 1, 1];
_blockedLine 		= lineIntersects [_aslSafePos, _aslPlayerPos];
_terranBlock 			= terrainIntersect [_aslSafePos, _aslPlayerPos];
_visibility 				= [objNull, "VIEW"] checkVisibility [AGLToASL [_safePos select 0,_safePos select 1, 0], _aslPlayerPos];

while {_visibility > 0.1} do
{
	_safePos 				= [_targetPos, _minDist, _maxDist, _dist, 0, 20, 0, [[]], [_targetPos, _targetPos]] call BIS_fnc_findSafePos;
	_aslSafePos 			= AGLToASL [_safePos select 0, _safePos select 1, 1];
	_aslPlayerPos 		= AGLToASL [_targetPos select 0, _targetPos select 1, 1];
	_blockedLine 		= lineIntersects [_aslSafePos, _aslPlayerPos];
	_terranBlock 			= terrainIntersect [_aslSafePos, _aslPlayerPos];
	_visibility 				= [objNull, "VIEW"] checkVisibility [AGLToASL [_safePos select 0,_safePos select 1, 0], _aslPlayerPos];
};

/*
_grp = createGroup [east, true];
_soldier = _grp createUnit ["rhsusf_army_ocp_driver_armored", _safePos, [], 0, "NONE"];
*/

_ret = [];

if (!(_safePos isEqualTo _targetPos)) then
{
	_ret = _safePos;
};

_ret