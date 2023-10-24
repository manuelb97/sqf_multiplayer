//Paras
params [
"_missionLocation",
"_radius",
"_debug"
];

//Spawn sabotage obj
_classArr = ["rhs_p37","rhs_prv13","Land_Communication_F"];
_numTrees = count (nearestTerrainObjects [_missionLocation, ["TREE"], _radius, true]);
_sabPos = [];

[_missionLocation, 25, false] remoteExec ["bia_clear_ground", 0, true];
if (_numTrees > 100) then 
{
	_sabPos = [_missionLocation, 0, 20, 1, 0, 2, 0, [], [_missionLocation, _missionLocation]] call BIS_fnc_findSafePos;
} else 
{
	_sabPos = [_missionLocation, 0, (_radius / 4), 3, 0, 2, 0, [], [_missionLocation, _missionLocation]] call BIS_fnc_findSafePos;
};
_obj = createVehicle [selectRandom _classArr, _sabPos, [], 0, "NONE"];
_obj setVariable ["Sabotage", true, true];

//Make Obj only destroyable by C4
[_obj, _debug] spawn bia_obj_destroyable;