//Params
params [
	"_parent",
	"_player",
	"_pos",
	["_rounds", 1]
];

_valid = [_parent, _player, _pos, _rounds] isEqualTypeParams ["", objNull, [], 0];
if !(_valid) exitWith
{
	["scripts\support\artillery\flare_artillery.sqf", _parent, [_parent, _player, _pos, _rounds]] spawn bia_input_msg;
};

_radius = 0;
_ammo = selectRandom["ACE_40mm_flare_white", "ACE_40mm_flare_red", "ACE_40mm_flare_green"]; // Flare_82mm_AMOS_White
_height = 150;
_velocity = 6;

_delay = round(random[2, 5, 10]);
[
	format["Executing Flare Strike, ETA %1 seconds", _delay]
] remoteExec ["bia_spawn_text", _player];
uiSleep 3;

for "_i" from 1 to _rounds do 
{
	if (_i != 1) then 
	{
		_txt = "";
	};

	[_delay, _player, _pos, _radius, _ammo, _height, _velocity, true] spawn bia_drop_projectile;
	uiSleep 45;
};