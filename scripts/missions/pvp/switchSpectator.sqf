// [player, true] call compileFinal preprocessFileLineNumbers "scripts\missions\pvp\switchSpectator.sqf";

//Paras
params [
"_player",
"_spectator",
"_pos",
"_dir"
];

[_spectator] remoteExec ["ace_spectator_fnc_setSpectator", _player];
[0, objNull, 2, _pos, _dir] remoteExec ["ace_spectator_fnc_setCameraAttributes", _player];