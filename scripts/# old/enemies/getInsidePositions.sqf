//Paras
params [
"_possArr",
"_maxPositions",
"_debug"
];

_newPosArr1= _possArr select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 0, 3]]};

if (count _newPosArr1 > 0) then
{
	_possArr = _newPosArr1;
};

_newPosArr2 = _possArr select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 2, 3]]};
_newPosArr2 = _newPosArr2 select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, -2, 3]]};

if (count _newPosArr2 > 0) then
{
	_possArr = _newPosArr2;
};

_newPosArr3 = _possArr select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [2, 0, 3]]};
_newPosArr3 = _newPosArr3 select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [-2, 0, 3]]};

if (count _newPosArr3 > 0) then
{
	_possArr = _newPosArr3;
};

if (count _possArr > _maxPositions) then
{
	_possArr = _possArr call BIS_fnc_arrayShuffle;
	_possArr resize _maxPositions;
};

_possArr