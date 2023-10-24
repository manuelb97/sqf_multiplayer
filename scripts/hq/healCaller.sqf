//Paras
params [
"_target", 
"_caller", 
"_arguments"
];

[_caller, _caller] call ace_medical_treatment_fnc_fullHeal;
["You were healed to full HP", "center_top", 5, 0, 0, 85, "Green"] remoteExecCall ["bia_spawn_text", _caller];