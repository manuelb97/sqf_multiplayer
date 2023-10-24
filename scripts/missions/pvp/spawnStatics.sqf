//Paras
params [
"_defenderFaction",
"_loc"
];

//spawn defender statics 
_valuesWeights = [
	// 0,1,
	1,1,
	2,0.33
	// , 3,1
];
_numberOfStatics = selectRandomWeighted _valuesWeights;

_mortars = ["rhs_2b14_82mm_msv", "RHS_M252_D"];
_possibleStatics = [
	"rhsgref_cdf_b_DSHKM",
	"rhsgref_cdf_b_DSHKM_Mini_TriPod"//, _mortars select 0
];

if (_defenderFaction == "US") then 
{
	_possibleStatics = [
		// "RHS_M2StaticMG_D", //zoom stuck in max zoom
		// "RHS_M2StaticMG_MiniTripod_D",
		"B_G_HMG_02_F",
		"B_G_HMG_02_high_F"//, _mortars select 1
	];
};

_availableStatics = [];
_statics = [];

if (_numberOfStatics > 0) then 
{
	for "_i" from 1 to _numberOfStatics do 
	{
		_staticClass = selectRandom _possibleStatics;
		_staticPos = [_loc, 0, 10, 2, 0, 20, 0, [], [_loc, _loc]] call BIS_fnc_findSafePos;
		_static = createVehicle [_staticClass, _staticPos vectorAdd [0,0,0.5], [], 1, "NONE"];

		_availableStatics pushBack _staticClass;
		_statics pushBack _static;

		if (_staticClass in _mortars) then 
		{
			_possibleStatics = _possibleStatics - _mortars;
		};

		_static allowDamage false;
	};
};

_text = format["Defender have %1 statics of the types: %2", _numberOfStatics, _availableStatics];
["PvP_Defense", _text] spawn bia_to_log;

_signals = [];
{
	_signal = createVehicle ["G_40mm_SmokeBlue", getPos _x, [], 0, "CAN_COLLIDE"];
	// _signal = createVehicle ["ACE_G_Chemlight_HiRed", getPos _box, [], 0, "CAN_COLLIDE"];
	_signals pushBack _signal;
} forEach _statics;

uiSleep 15;

{
	deletevehicle _x;
} forEach _signals;