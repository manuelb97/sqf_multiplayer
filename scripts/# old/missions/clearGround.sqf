params [
"_spawnLocation"
];

_radius = 6;
{
    _x switchLight "OFF";
    _x hideObjectGlobal true;
    _x allowDamage false;
} forEach (nearestTerrainObjects [_spawnLocation, [], _radius, false, true]);