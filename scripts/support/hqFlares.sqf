//Params
params [
"_target", 
"_caller", 
"_arguments"
];

_hq_pos = getPos hq_pos;
_distance = 300;

_posArr = 
[
	_hq_pos getPos [_distance, 0],
	_hq_pos getPos [_distance, 90],
	_hq_pos getPos [_distance, 180],
	_hq_pos getPos [_distance, 270]
];

_ammo = selectRandom ['ACE_40mm_Flare_white'];
_radius = 0;
_numRounds = 1;
_delay = 10;
_safezone = 0;
_height = 150;
_velocity = 6;

{
	_pos = _x;
	[_pos, _ammo, _radius, _numRounds, _delay, nil, _safezone, _height, _velocity, []] remoteExec ["BIS_fnc_fireSupportVirtual", missionNamespace getVariable ["BiA_Host", manu]];
} forEach _posArr;