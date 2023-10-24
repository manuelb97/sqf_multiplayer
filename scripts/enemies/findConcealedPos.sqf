// [units (group player), 1, 250, 350, true] call compileFinal preprocessFileLineNumbers "scripts\enemies\findConcealedPos.sqf";

//Paras
params [
"_missionLocation",
"_targetArr",
"_dist",
"_minDist",
"_maxDist"
];

_targetPosArr = _targetArr apply {getPos _x};
_safePos = [];
_visArr = [];

for "_i" from 0 to 100 do 
{
	{
		_targetPos 		= _x;
		_backupPos 		= _targetPos getPos [random[200,300,400], random 360];
		_safePos 		= [_missionLocation, _minDist, _maxDist, _dist, 0, 20, 0, [[]], [_targetPos, _targetPos]] call BIS_fnc_findSafePos;
		_aslPlayerPos 	= AGLToASL [_targetPos select 0, _targetPos select 1, 1.8];
		_visibility 	= [objNull, "VIEW"] checkVisibility [AGLToASL [_safePos select 0,_safePos select 1, 1.8], _aslPlayerPos];
		
		if (!surfaceIsWater _safePos) then 
		{
			_visArr pushBack [_visibility, _safePos];
		};
	} forEach _targetPosArr;
};

if (count _visArr > 0) then 
{
	_visArrSort = [_visArr, [], {_x select 0}, "ASCEND"] call BIS_fnc_sortBy;
	_safePos = _visArrSort select 0 select 1;
} else 
{
	_safePos = [];
};

_safePos

/*
_grp = createGroup [west, true];
_soldier = _grp createUnit ["rhsusf_army_ocp_driver_armored", _safePos, [], 0, "NONE"];

_aslSafePos 		= AGLToASL [_safePos select 0, _safePos select 1, 1.8];
_blockedLine 		= lineIntersects [_aslSafePos, _aslPlayerPos];
_terranBlock 		= terrainIntersect [_aslSafePos, _aslPlayerPos];
*/