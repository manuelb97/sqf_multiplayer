//Params
params [
"_target", 
"_caller", 
"_arguments"
];

_missionRunning = _arguments select 0;
missionNamespace setVariable ["MissionRunning", _missionRunning, true];

[
	format["Mission running: %1", _missionRunning], "center_top", 5, 0, 0, 100, "Green"
] remoteExec ["bia_spawn_text", _caller];