//Params
params [
	"_parent",
	"_player",
	"_pos",
	["_strikeDir", 270]
];

_valid = [_parent, _player, _pos, _strikeDir] isEqualTypeParams ["", objNull, [], 0];
if !(_valid) exitWith
{
	["scripts\support\artillery\smoke_artillery.sqf", _parent, [_parent, _player, _pos, _strikeDir]] spawn bia_input_msg;
};

_radius = 0;
_ammo = "Smoke_120mm_AMOS_White"; // G_40mm_SmokeRed Smoke_82mm_AMOS_White
_height = 400;
_velocity = 50;
_roundDist = 3;
_rounds = 3;
_strikeDist = _rounds * _roundDist;
_startPos = _pos getPos [_strikeDist / 2, _strikeDir];

_delay = round(random[2, 5, 10]);
[
	format[
		"Deploying Smoke Screen, ETA %1 seconds", 
		_delay + round(_height / _velocity)
	]
] remoteExec ["bia_spawn_text", _player];
uiSleep 3;

for "_i" from 1 to _rounds do 
{
	_pos = _startPos getPos [_roundDist * (_i - 1), _strikeDir + 180];
	[_delay, _pos, _radius, _ammo, _height, _velocity, true] spawn bia_drop_projectile;
	uiSleep random[1,2,3];
};