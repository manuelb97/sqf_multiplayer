//Params
params [
	"_parent",
	"_player",
	"_pos"
];

_valid = [_pos, ["SCALAR", "SCALAR", "SCALAR"]] call bia_check_input;

if !(_valid) exitWith
{
	["at_precision_artillery", format["%1: input validation failed", _parent]] call bia_to_log;
};

_radius = 0;
_ammo = "ammo_bomb_bia"; //M_PG_AT M_Scalpel_AT Missile_AGM_02_F Rocket_04_AP_F M_Titan_AT A CE_Javelin_FGM148 ammo_Bomb_SDB M_Mo_120mm_AT
_velocity = 50;
_height = 400;

//set delay and give notification
_delay = round(random[2, 5, 10]);
[
	format[
		"Executing AT Strike, ETA %1 seconds", 
		_delay + round(_height / _velocity)
	]
] remoteExec ["bia_spawn_text", _player];

uiSleep 3;

[_delay, _pos, _radius, _ammo, _height, _velocity, true] spawn bia_drop_projectile;