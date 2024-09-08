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
	["scripts\support\cas\gunrun_cas.sqf", _parent, [_parent, _player, _pos, _strikeDir]] spawn bia_input_msg;
};

[format["Executing Rocket Run, ETA 20 seconds"]] remoteExec ["bia_spawn_text", _player];
// uiSleep 3; // too much delay already

[_pos, _strikeDir, "B_Plane_CAS_01_F", "missilelauncher", true] spawn bia_zeus_cas;