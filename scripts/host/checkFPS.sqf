//Paras
params [
"_locality",
"_debug"
];

_currFPS = diag_fps;
missionNamespace setVariable [format["%1_fps", _locality], _currFPS, true];