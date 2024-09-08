// [[player, "Sniper", "1136", "32"]] spawn compileFinal preprocessFileLineNumbers "scripts\support\infantry_support\sniper_assassination.sqf";

//Params
params [
	"_parent",
	"_player",
	"_pos"
];

_valid = [_parent, _player, _pos] isEqualTypeParams ["", objNull, []];
if !(_valid) exitWith
{
	["scripts\support\infantry_support\sniper_assassination.sqf", _parent, [_parent, _player, _pos]] spawn bia_input_msg;
};

_targets = nearestObjects [_pos, ["Man"], 10, true];
_targets = _targets select {side _x != west && vehicle _x == _x};
//allUnits select {_x distance2D _pos < 2 && };

if ((count _targets) > 0) then 
{	
	_target = _targets select 0;
	uiSleep 1;
	// hint format["Sniper found Target"];
	["Sniper found Target"] remoteExec ["bia_spawn_text", _player];

	_delay = random[2,3,4];
	// hint format["Sniper taking Shot, ETA %1 seconds", round(_delay)];
	[format["Sniper taking Shot, ETA %1 seconds", round(_delay)]] remoteExec ["bia_spawn_text", _player];
	uiSleep _delay;

	_target animate ["death", 0, false];
	_target setDamage 1;

	uiSleep random[1, 1.5, 2];
	playSound3D [
		"\jsrs_soundmod_complete\JSRS_Soundmod_Soundfiles\weapons\Shot\Distance\sniper_big\shot_1.ogg",
		_player, false, getPos _player, 1, 1, 0, 0, true
	];
} else 
{
	// hint format["Sniper unable to find suitable Target"];
	["Sniper unable to find suitable Target"] remoteExec ["bia_spawn_text", _player];
};