//Params
params [
	"_parent",
	"_player",
	"_dist",
	"_dir",
	["_numStrikes", 3],
	["_radiusX", 0],
	["_radiusY", 0]
];

_valid = [
	_parent, _player, _dist, _dir, _numStrikes, _radiusX, _radiusY
] isEqualTypeParams ["", objNull, 0, 0, 0, 0, 0];
if !(_valid) exitWith
{
	[
		"scripts\support\cas\ac130_cas.sqf", 
		_parent, 
		[_parent, _player, _dist, _dir, _numStrikes, _radiusX, _radiusY]
	] spawn bia_input_msg;
};

[format["Calling AC130 Support, ETA 20 seconds"]] remoteExec ["bia_spawn_text", _player];
// uiSleep 3; // too much delay already

[_player, _dist, _dir, _numStrikes, _radiusX, _radiusY] spawn bia_ac130_support;