// [test, 15, true] execVM "scripts\missions\clearGround.sqf"

params [
"_spawnLocation",
"_radius",
"_debug"
];

{
    _x switchLight "OFF";
    _x hideObjectGlobal true;
    _x allowDamage false;
} forEach (nearestTerrainObjects [_spawnLocation, [], _radius, false, true]);