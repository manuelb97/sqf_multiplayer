//[] call compile preprocessFileLineNumbers "scripts\test.sqf";
_missionLocation = getPos manu;

_grp = createGroup east;
_hvtClass = "LOP_TKA_Infantry_Officer";//_unitsArray select 1;
_hvtPos = [_missionLocation, 0, 30, 5, 0, 5, 0] call BIS_fnc_findSafePos;
_hvt = _grp createUnit [_hvtClass, _hvtPos, [], 0, "NONE"];
_hvt setSkill 1;
_hvt disableAI "PATH";
removeAllWeapons _hvt;

//find out if buildings nearby
_objects = getPos _hvt nearObjects 100;
_houses = [];
{ 
	if (count (_x call BIS_fnc_buildingPositions) > 0 && !("scaffolding" in str _x) && !("ruin" in str _x)) then { _houses pushBack _x; };
} forEach _objects;

private ["_allPos"];
if (count _houses > 0) then {
	//find building with most covered positions
	_suitablePosPerHouse = [];
	{
		_positions = _x call BIS_fnc_buildingPositions;
		_positions = _positions select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 2, 3]]};
		_positions = _positions select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, -2, 3]]};
		_positions = _positions select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [2, 0, 3]]};
		_positions = _positions select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [-2, 0, 3]]};
		
		_suitablePosPerHouse pushBack (count _positions);
	} forEach _houses;

	//if no perfect positions found, search at least positions with roof
	if (selectMax _suitablePosPerHouse < 1) then {
		_suitablePosPerHouse = [];
		{
			_positions = _x call BIS_fnc_buildingPositions;
			_positions = _positions select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 0, 3]]};
			_suitablePosPerHouse pushBack (count _positions);
		} forEach _houses;
	};

	//select best house
	_maxPos = selectMax _suitablePosPerHouse;
	_idx = _suitablePosPerHouse find _maxPos;
	_finalHouse = _houses select _idx;

	_allPos = _finalHouse call BIS_fnc_buildingPositions;
	_hvtPossPos = _allPos select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 2, 3]]};
	_hvtPossPos = _hvtPossPos select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, -2, 3]]};
	_hvtPossPos = _hvtPossPos select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [2, 0, 3]]};
	_hvtPossPos = _hvtPossPos select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [-2, 0, 3]]};
	
	if (count _hvtPossPos < 1) then {
		_hvtPossPos = _allPos select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 0, 3]]};
	};

	//set hvt pos
	if (count _hvtPossPos > 0) then {
		_finalPos = selectRandom _hvtPossPos;
		_allPos deleteAt (_allPos find _finalPos);
		_hvt setPos _finalPos;
		hint "Good Pos found";
	} else {
		_closestHouse = nearestBuilding getPos _hvt;
		if (_closestHouse distance _missionLocation < 150) then {
			_allPos = _closestHouse call BIS_fnc_buildingPositions;
			_finalPos = selectRandom _allPos;
			_allPos deleteAt (_allPos find _finalPos);
			_hvt setPos _finalPos;
			hint "Random Pos used";
		} else {
			hint "Closest house too far";
		};
	};
};