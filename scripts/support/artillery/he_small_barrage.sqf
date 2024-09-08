// [[player, "HE", 1181, "40", "1", "0"]] spawn compileFinal preprocessFileLineNumbers "scripts\support\artillery\he_small_barrage.sqf";

//Params
params [
	"_parent",
	"_player",
	"_dist",
	"_dir",
	["_rounds", 1], 
	["_radiusX", 0], 
	["_radiusY", 0]
];

_valid = [_parent, _player, _dist, _dir, _rounds, _radiusX, _radiusY] isEqualTypeParams ["", objNull, 0, 0, 0, 0, 0];
if !(_valid) exitWith
{
	[
		"scripts\support\artillery\he_small_barrage.sqf", 
		_parent, 
		[_player, _dist, _dir, _rounds, _radiusX, _radiusY]
	] spawn bia_input_msg;
};

_ammo = "Sh_155mm_AMOS";
_height = 400;
_velocity = 50;

_delay = round(random[2, 5, 10]);
[
	format[
		"Executing HE Strike, ETA %1 seconds", 
		_delay + round(_height / _velocity)
	]
] remoteExec ["bia_spawn_text", _player];
uiSleep 3;

for "_i" from 1 to _rounds do 
{
	[_delay, _player, _dist, _dir, _radiusX, _radiusY, _ammo, _height, _velocity, true] spawn bia_drop_projectile;
	uiSleep random[3,5,7];
};