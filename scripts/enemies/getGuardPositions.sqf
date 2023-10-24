//Paras
params [
"_pos",
"_radius",
"_maxGuards",
"_debug"
];

_tag = "CompoundHouseGuardPositions";

_radius = _radius min 50;

//find buildings
_nearBuilds = _pos nearObjects ["Building", _radius];
[_tag, format["Compound contains %1 buildings", count _nearBuilds], _debug] spawn bia_to_log;

//_mainBuilding = [_nearBuilds, _pos] call BIS_fnc_nearestPosition;

//count positions for house guards 
_closeBuildPos = [];
{
	_posArr = ([_x] call BIS_fnc_buildingPositions) call BIS_fnc_arrayShuffle;
	_posArr resize 3;
	_closeBuildPos append _posArr;
} forEach _nearBuilds;
_closeBuildPos = _closeBuildPos arrayIntersect _closeBuildPos;
_closeBuildPos = _closeBuildPos call BIS_fnc_arrayShuffle;

_numBuildPos = count _closeBuildPos;
[_tag, format["Compound contains %1 building positions", count _closeBuildPos], _debug] spawn bia_to_log;

if (count _closeBuildPos > _maxGuards) then 
{
	_closeBuildPos resize _maxGuards;
};

_closeBuildPos