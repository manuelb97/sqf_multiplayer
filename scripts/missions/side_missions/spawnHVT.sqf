/*
_unitsArray = [_tier] call bia_faction_units;
[getPos manu, false, _unitsArray, true] execVM "scripts\missions\hvt\spawnHVT.sqf";
*/

//Paras
params [
"_missionLocation",
"_hideInBuilding",
"_officerClasses",
"_radius",
"_varName",
"_debug"
];

_tag = "HVT";

//create hvt
_grp = createGroup east;
_officerClass = selectRandom _officerClasses;
_hvtPos = [_missionLocation, 0, 30, 1, 0, 20, 0] call BIS_fnc_findSafePos;
_hvt = _grp createUnit [_officerClass, _hvtPos, [], 0, "NONE"];

removeAllWeapons _hvt;
_hvt setSkill 1;
_hvt disableAI "PATH";
_hvt setVariable ["HVT", true, true];
_hvt setVariable [_varName, true, true];
_hvt addMPEventHandler ["MPKilled", { _nul = _this call killedManInfo; }];

_hvt setBehaviour "SAFE";
_hvt setCombatMode "WHITE";

if (_hideInBuilding) then
{
	//find out if buildings nearby
	_builds = _missionLocation nearObjects ["Building", _radius];
	_houses = _builds select {count([_x] call BIS_fnc_buildingPositions) > 0};
	
	if (count _houses > 0) then 
	{
		//find building with most covered positions
		_suitablePosPerHouse = [];
		_posPerHouse = [];
		{
			_positions = [_x] call BIS_fnc_buildingPositions;
			_positions = _positions select {lineIntersects [(AGLToASL _x) vectorAdd [0, 0, 1.8], (AGLToASL _x) vectorAdd [0, 3, 0]]};
			_positions = _positions select {lineIntersects [(AGLToASL _x) vectorAdd [0, 0, 1.8], (AGLToASL _x) vectorAdd [0, -3, 0]]};
			_positions = _positions select {lineIntersects [(AGLToASL _x) vectorAdd [0, 0, 1.8], (AGLToASL _x) vectorAdd [3, 0, 0]]};
			_positions = _positions select {lineIntersects [(AGLToASL _x) vectorAdd [0, 0, 1.8], (AGLToASL _x) vectorAdd [-3, 0, 0]]};
			
			_posPerHouse pushBack _positions;
			_suitablePosPerHouse pushBack (count _positions);
		} forEach _houses;

		//if no perfect positions found, search at least positions with roof
		if (selectMax _suitablePosPerHouse < 1) then 
		{
			_suitablePosPerHouse = [];
			_posPerHouse = [];
			{
				_positions = [_x] call BIS_fnc_buildingPositions;
				_positions = _positions select {lineIntersects [(AGLToASL _x) vectorAdd [0, 0, 1.8], (AGLToASL _x) vectorAdd [0, 0, 3]]};

				_posPerHouse pushBack _positions;
				_suitablePosPerHouse pushBack (count _positions);
			} forEach _houses;
		};

		//select best house
		_idx = _suitablePosPerHouse find (selectMax _suitablePosPerHouse);
		_finalHouse = _houses select _idx;
		_hvtPossPos = _posPerHouse select _idx;

		//set hvt pos
		if (count _hvtPossPos > 0) then 
		{
			_finalPos = selectRandom _hvtPossPos;
			_hvt setPos (_finalPos vectorAdd [0, 0, 0.3]);
		};
	};
};