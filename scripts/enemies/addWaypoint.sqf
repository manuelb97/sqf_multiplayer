//Paras
params [
"_grp",
"_wpPos",
["_wpRad", 0],
["_wpType", "MOVE"],
["_wpFormation", "COLUMN"],
["_wpSpeed", "NORMAL"],
["_wpBehavior", "AWARE"],
["_wpCombat", "YELLOW"],
["_wpCompletitionRad", 0],
["_wpTimeOut", [0,0,0]],
["_debug", true]
];

// MOVE", "NO CHANGE", "UNCHANGED", "UNCHANGED", "NO CHANGE

_formation = _wpFormation;
if (typeName _wpFormation == "ARRAY") then 
{
	_formation = selectRandom _wpFormation;
};

_wp = _grp addWaypoint [_wpPos, _wpRad];
_wp setWaypointType _wpType;
_wp setWaypointFormation _formation;
_wp setWaypointSpeed _wpSpeed;
_wp setWaypointBehaviour _wpBehavior;
_wp setWaypointCombatMode _wpCombat;
_wp setWaypointCompletionRadius _wpCompletitionRad;
_wp setWaypointTimeout _wpTimeOut;