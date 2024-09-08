//Params
params [
"_target", 
"_caller", 
"_arguments"
];

_faction = _arguments select 0;
missionNamespace setVariable ["TrainingFaction", _faction, true];

[
	format["Faction set to: %1", _faction], "center_top", 5, 0, 0, 100, "Green"
] remoteExec ["bia_spawn_text", _caller];