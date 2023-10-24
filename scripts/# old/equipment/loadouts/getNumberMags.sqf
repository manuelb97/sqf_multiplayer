//Paras
params [
"_magClass",
"_desiredNumBullets"
];

private _numPerMag = [_magClass] call bia_mag_bullets;
round ((_desiredNumBullets - _numPerMag) / _numPerMag)