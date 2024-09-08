//Paras
params [
"_resetMissionState",
"_debug"
];

_mission_f = "scripts\missions\training\";
[] execVM (_mission_f + "enemyKillCounter.sqf");
[] execVM (_mission_f + "enemySpawner.sqf");