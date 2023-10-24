//Paras
params [
"_player",
"_debug"
];

_remoteUnits = [];

while {true} do 
{
	_controlledUnits = allUnits select {};
};

// [player, true] execVM "scripts\support\commanderSupports.sqf";