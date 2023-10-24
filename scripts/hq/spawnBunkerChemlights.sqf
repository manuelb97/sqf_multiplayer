//Params
params [
"_debug"
];

_grasCutters = vehicles select {"cutter" in (str _x) && _x != hq_pos};
_posArr = _grasCutters apply {getPosATL _x};

{
	_pos = _x;
	_light = "ACE_G_Chemlight_HiRed" createVehicle _pos;
} forEach _posArr;