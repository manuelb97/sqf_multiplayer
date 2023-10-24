//Paras
params [
"_player"
];

_overwatchCD = 600;
_strikeCD = 600;
_smokeCD = 600;
_supplyCD = 600;
_infantryCD = 600;

//set cooldowns
{
	_x params ["_supp", "_cd"];
	missionNamespace setvariable [format["%1SupportCD", _supp], _cd, true];
	missionNamespace setvariable [format["Last%1Support", _supp], serverTime - _cd, true];
} forEach [["Overwatch", _overwatchCD], ["Strike", _strikeCD], ["Smoke", _smokeCD], ["Supply", _supplyCD], ["Infantry", _infantryCD]];

//Precision Chat Support
[] execVM "scripts\support\readChat.sqf";