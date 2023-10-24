//Paras
params [
"_missionLocation",
"_missionMarkers",
["_radius",100],
["_mobileEnemies",14],
["_cqbEnemies",6],
"_unitsArray"
];

//Spawn Sector Patrols
[_missionLocation,_missionMarkers,_radius,_mobileEnemies,_unitsArray] execVM "scripts\missions\defence\biaMobileDefenders.sqf";

//Spawn CQB Units
[_missionLocation,_missionMarkers,_radius,_cqbEnemies,_unitsArray] execVM "scripts\missions\cqb\cqbEnemies.sqf";