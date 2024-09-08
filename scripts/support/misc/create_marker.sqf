//Params
params [
	"_parent",
	"_player",
	"_pos",
	["_txt", ""]
];

_valid = [_parent, _player, _pos, _txt] isEqualTypeParams ["", objNull, [], ""];
if !(_valid) exitWith
{
	["scripts\support\misc\create_marker.sqf", _parent, [_parent, _player, _pos, _txt]] spawn bia_input_msg;
};

_marker = "chatMarker_" + (str random [11111, 55555, 99999]);
createMarker [_marker, _pos];
_marker setMarkerTypeLocal "mil_dot_noShadow";
_marker setMarkerColorLocal "ColorRed";
_marker setMarkerTextLocal (_txt + format[" (%1)", [dayTime, "HH:MM:SS"] call BIS_fnc_timeToString]);
_marker setMarkerSize [0.25, 0.25];

// hint "Marker placed";
[format["Marker placed"]] remoteExec ["bia_spawn_text", _player];
uiSleep 3;

uiSleep 60;
deleteMarker _marker;