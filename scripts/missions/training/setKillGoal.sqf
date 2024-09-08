//Params
params [
"_target", 
"_caller", 
"_arguments"
];

_killGoal = _arguments select 0;
missionNamespace setVariable ["KillGoal", _killGoal, true];

[
	format["Kill goal set to: %1 kills", _killGoal], "center_top", 5, 0, 0, 100, "Green"
] remoteExec ["bia_spawn_text", _caller];