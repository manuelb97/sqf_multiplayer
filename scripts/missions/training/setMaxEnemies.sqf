//Params
params [
"_target", 
"_caller", 
"_arguments"
];

_maxEnemies = _arguments select 0;
missionNamespace setVariable ["MaxEnemies", _maxEnemies, true];

[
	format["Max enemies set to: %1", _maxEnemies], "center_top", 5, 0, 0, 100, "Green"
] remoteExec ["bia_spawn_text", _caller];