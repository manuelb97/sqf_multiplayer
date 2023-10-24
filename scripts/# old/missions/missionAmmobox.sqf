// [getPos manu] execVM "scripts\missions\missionAmmobox.sqf";

//Paras
params [
"_missionLocation"
];

//Create ammo crate
_spawnPos = [_missionLocation, 0, 50, 1, 0, 20, 0] call BIS_fnc_findSafePos;
_defenceArsenal = "Box_NATO_Ammo_F" createVehicle _spawnPos;
_defenceArsenal allowDamage false;
clearWeaponCargoGlobal	_defenceArsenal;
clearMagazineCargoGlobal 	_defenceArsenal;
clearItemCargoGlobal 		_defenceArsenal;
clearBackpackCargoGlobal 	_defenceArsenal;

/*
//Ammo crate final pos
_buildings = []; 
{ 
	if (str _x find ": i_" > -1 || str _x find "house" > -1 || str _x find "shed" > -1 || str _x find "building" > -1 || str _x find "addon" > -1) then { _buildings pushBack _x; };
} forEach nearestObjects [_missionLocation, [], 50];
_nearestHouse 	= _buildings select 0;
_housePosArray	= _nearestHouse call BIS_fnc_buildingPositions;
_possPosArray		= _housePosArray select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 0, 3]]};

while {count _possPosArray < 1 && count _buildings > 0} do {
	_buildings deleteAt (_buildings find _nearestHouse);
	
	_nearestHouse 	= _buildings select 0;
	_housePosArray	= _nearestHouse call BIS_fnc_buildingPositions;
	_possPosArray		= _housePosArray select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 0, 3]]};
};

_finalPos = selectRandom _housePosArray;
if (count (_possPosArray select 0) == 3) then {
	_finalPos = selectRandom _possPosArray;
};
_defenceArsenal setPos _finalPos;
*/
	
//Add smoke to crate
_smoke = "SmokeShellYellow" createVehicle [0,0,0];
_smoke attachTo [_defenceArsenal, [0, 0, 0]];

//Create marker on ammo box
_boxMarker = str random [11111, 55555, 99999];
createMarker [_boxMarker, getPos _defenceArsenal];
_boxMarker setMarkerType "mil_join";
_boxMarker setMarkerColor "ColorBlue";

//Add ammo crate to zeus
{ [_x, [[_defenceArsenal],false]] remoteExec ["addCuratorEditableObjects", 0, true]; } forEach allCurators;

//Init stuff
["AmmoboxInit",[_defenceArsenal,	false,{true}]] remoteExec ["BIS_fnc_arsenal", 0, true];

//Lists of items to include
_startGuns = [ "rhs_weap_m72a7" ];

_startMags = [
	//CQB
	"30Rnd_556x45_Stanag",
	"rhs_mag_30Rnd_556x45_M855A1_Stanag",
	"30Rnd_45ACP_Mag_SMG_01",
	//"rhssaf_30rnd_556x45_EPR_G36",
	"50Rnd_570x28_SMG_03",
	"rhsusf_mag_40Rnd_46x30_FMJ",
	"30Rnd_9x21_Mag_SMG_02",
	"rhs_20rnd_9x39mm_SP5",
	//"rhs_10rnd_9x39mm_SP5",
	//"rhsgref_20rnd_765x17_vz61",
	//"rhsgref_30rnd_1143x23_M1911B_SMG",
	
	//Rifleman
	"30Rnd_65x39_caseless_green",
	"10Rnd_50BW_Mag_F",
	"30Rnd_65x39_caseless_msbs_mag",
	"rhs_mag_20Rnd_SCAR_762x51_m80a1_epr_bk",
	"rhs_30Rnd_545x39_7N10_AK",
	"rhs_30Rnd_762x39mm_polymer",
	"rhs_mag_20Rnd_762x51_m80_fnfal",
	//"rhs_10Rnd_762x39mm",
	"rhsgref_8Rnd_762x63_M2B_M1rifle",
	//"rhsgref_5Rnd_792x57_kar98k",
	
	//GL
	"1Rnd_HE_Grenade_shell",
	"rhs_VOG25",
	
	//MG
	//"130Rnd_338_Mag",
	//"150Rnd_93x64_Mag",
	"rhsusf_100Rnd_762x51",
	"rhsusf_200rnd_556x45_mixed_box",
	"rhs_100Rnd_762x54mmR",
	"150Rnd_762x54_Box",
	"rhsgref_296Rnd_792x57_SmE_belt",
	//"rhsgref_50Rnd_792x57_SmE_drum",
	//"rhs_75Rnd_762x39mm",
	
	//DMR
	//"10Rnd_93x64_DMR_05_Mag",
	"rhsusf_20Rnd_762x51_SR25_mk316_special_Mag",
	"ACE_20Rnd_762x51_Mk316_Mod_0_Mag",
	"rhs_mag_20Rnd_SCAR_762x51_mk316_special_bk",
	"rhs_10Rnd_762x54mmR_7N1",
	"rhsgref_10Rnd_792x57_m76",
	
	//Sniper
	"7Rnd_408_Mag",
	"ACE_5Rnd_127x99_AMAX_Mag",
	"rhs_5Rnd_338lapua_t5000",
	"rhsusf_5Rnd_300winmag_xm2010",
	"rhsusf_5Rnd_762x51_m118_special_Mag",
	"rhsusf_5Rnd_762x51_AICS_m118_special_Mag",

	//AT
	"RPG32_F",
	"Titan_AT",
	"MRAWS_HEAT_F",
	"rhs_rpg7_PG7VL_mag",
	
	//Binos
	"Laserbatteries",
	
	//Grenades
	"HandGrenade",
	"rhs_mag_m18_green"
];

_startItems = [
	"ACE_fieldDressing",
	"ACE_morphine"
];

_startBackpacks = [];

//Populate with predefined items and whatever is already in the crate
[_defenceArsenal,(_startGuns), 			true, true] remoteExec ["BIS_fnc_addVirtualWeaponCargo", 0, true];
[_defenceArsenal,(_startMags), 			true, true] remoteExec ["BIS_fnc_addVirtualMagazineCargo", 0, true];
[_defenceArsenal,(_startItems), 		true, true] remoteExec ["BIS_fnc_addVirtualItemCargo", 0, true];
[_defenceArsenal,(_startBackpacks),	true, true] remoteExec ["BIS_fnc_addVirtualBackpackCargo", 0, true];

//Wait for mission to end
while {isNil "missionLoop"} do { uiSleep 2;};
while {missionLoop == 1} do {uiSleep 2;};
deleteMarker _boxMarker;