//Params
params [
	"_parent",
	"_player",
	"_pos"
];

_valid = [_parent, _player, _pos] isEqualTypeParams ["", objNull, []];
if !(_valid) exitWith
{
	["scripts\support\infantry_support\qrf_support.sqf", _parent, [_parent, _player, _pos]] spawn bia_input_msg;
};
			
[_pos] remoteExec ["bia_support_qrf", missionNamespace getVariable ["BiA_Host", 2]];
[format["QRF requested"]] remoteExec ["bia_spawn_text", _player];