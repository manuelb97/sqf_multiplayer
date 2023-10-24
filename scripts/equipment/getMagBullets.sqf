//Paras
params [
"_magClass"
];

getNumber(configFile >> "CfgMagazines" >> _magClass >> "count")