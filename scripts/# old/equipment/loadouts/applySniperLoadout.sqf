//Params
params [
"_target", 
"_caller", 
"_arguments"
];

_arguments params 
[
	"_primWeapArr",
	"_numPrimMags",
	"_sniperWeapArr",
	"_numSniperMags",
	"_debug"
];

//Get current loadout
_currLoadout = getUnitLoadout _caller;

//Add new primary weapon
_currLoadout set [0, _primWeapArr];

//Add mags of primary and sniper to vest
_primMagType = _primWeapArr select 4 select 0;
_snipMagType = _sniperWeapArr select 4 select 0;
{
	_magType = _x select 0;
	_magCount = _x select 1;

	(_currLoadout select 4 select 1) pushBack [_magType, _magCount, [_magType] call bia_mag_bullets];
} forEach [[_primMagType, _numPrimMags], [_snipMagType, _numSniperMags]];

// adding mags dont work yet 

//Apply loadout before adding sniper
_caller setUnitLoadout _currLoadout;

//Add sniper to gunbag
[_caller, _caller] call ace_gunbag_fnc_toGunbagCallback; //remove current primary weapon

_sniperClass = _sniperWeapArr select 0;
_sniperWeapInfo = _sniperWeapArr select [1, count(_sniperWeapArr) - 1];

_sniperAccs = (_sniperWeapInfo select {_x isEqualType ""}) + [_snipMagType]; //get info as strs

_caller addWeapon _sniperClass;
{
	_caller addPrimaryWeaponItem _x;
} forEach _sniperAccs;

[_caller, _caller] call ace_gunbag_fnc_swapGunbag;

/*
[
	["arifle_MXC_Holo_pointer_F", "", "acc_pointer_IR", "optic_Holosight", ["30Rnd_65x39_caseless_mag", 30], [], ""],
	["launch_B_Titan_short_F", "", "", "", ["Titan_AT", 1], [], ""],
	["hgun_P07_F", "", "", "", ["16Rnd_9x21_Mag", 16], [], ""],
 	["U_B_CombatUniform_mcam", [["FirstAidKit", 1], ["30Rnd_65x39_caseless_mag", 2, 30], ["Chemlight_green", 1, 1]]],
 	["V_PlateCarrier1_rgr", [["30Rnd_65x39_caseless_mag", 3, 30], ["16Rnd_9x21_Mag", 2, 16], ["SmokeShell", 1 ,1], ["SmokeShellGreen", 1, 1], ["Chemlight_green", 1, 1]]],
 	["B_AssaultPack_mcamo_AT",[["Titan_AT", 2, 1]]],
 	"H_HelmetB_light_desert", "G_Bandanna_tan",[],
	["ItemMap", "", "ItemRadio", "ItemCompass", "ItemWatch", "NVGoggles"]
]
*/