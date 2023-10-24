//Paras
params [
"_missionLocation",
"_compoundRadius",
"_defenderFaction",
"_attackerFaction"
];

//spawn defender arsenal
_commonItems = [
	"ItemMap", "ItemGPS", "ItemRadio", "ItemCompass", "ItemWatch",
	"ACE_EarPlugs", "ACE_fieldDressing", "ACE_morphine", 
	"ACE_Flashlight_XL50", "ACE_RangeCard"
];//"ACE_personalAidKit", 

_spcDefenderItems = [
	"ACE_EntrenchingTool", "ACE_Fortify", "ACE_Clacker", "ACE_Tripod",
	"APERSMine_Range_Mag", "APERSTripMine_Wire_Mag", "APERSBoundingMine_Range_Mag", "ClaymoreDirectionalMine_Remote_Mag", "rhsusf_m112_mag"
];

_usItems = [
	"rhs_weap_m4a1", "rhs_weap_m4a1_m320", "rhs_weap_m16a4_imod", 
	"rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", "1Rnd_HE_Grenade_shell", "UGL_FlareWhite_F", //ACE_30Rnd_556x45_Stanag_M995_AP_mag

	"rhs_weap_m249_pip_L", "rhsusf_200rnd_556x45_mixed_box", //"rhsusf_100Rnd_556x45_M995_soft_pouch_coyote", 
	"rhs_weap_m240B", "rhsusf_100Rnd_762x51_m80a1epr", //rhsusf_100Rnd_762x51_m61_ap "rhsusf_100Rnd_762x51_m62_tracer", 
	"rhs_weap_m14ebrri", "rhsusf_20Rnd_762x51_m118_special_Mag", "rhsusf_20Rnd_762x51_m62_Mag", "rhsusf_acc_LEUPOLDMK4", //rhsusf_20Rnd_762x51_m993_Mag
	// "rhs_weap_XM2010", "rhsusf_5Rnd_300winmag_xm2010", "rhsusf_acc_LEUPOLDMK4_2", "rhsusf_acc_harris_bipod", 
	"rhs_weap_maaws", "rhs_mag_maaws_HE", //"rhs_mag_maaws_HEDP", //"rhs_mag_maaws_HEAT",
	
	"rhs_uniform_cu_ocp", "rhsusf_iotv_ocp_Rifleman", "B_AssaultPack_mcamo", "rhsusf_ach_helmet_headset_ocp_alt", "rhs_googles_black", //rhsusf_assault_eagleaiii_ocp
	"rhssaf_zrak_rd7j", "rhsusf_ANPVS_14", //rhsusf_bino_lrf_Vector21
	"rhsusf_acc_compm4", "rhsusf_acc_eotech_552", "rhsusf_acc_wmx_bk", 
	"rhs_mag_m67", "SmokeShellBlue", "rhs_mag_mk84"
];

_ruItems = [
	"rhs_weap_ak74m", "rhs_weap_ak74m_gp25", "rhs_30Rnd_545x39_7N10_plum_AK", "rhs_30Rnd_545x39_AK_green", "rhs_VOG25", "rhs_VG40OP_white", //rhs_30Rnd_545x39_7N22_AK
	"rhs_weap_ak103", "rhs_weap_ak103_gp25", "rhs_30Rnd_762x39mm_polymer", "rhs_30Rnd_762x39mm_polymer_tracer",
	"rhs_weap_pkm", "rhs_100Rnd_762x54mmR", //rhs_weap_pkp  rhs_100Rnd_762x54mmR_7N26 "rhs_100Rnd_762x54mmR_green", 
	"rhs_weap_svds", "rhs_10Rnd_762x54mmR_7N1", "ACE_10Rnd_762x54_Tracer_mag", "rhs_acc_pso1m2", // rhs_10Rnd_762x54mmR_7N14
	// "rhs_weap_t5000", "rhs_5Rnd_338lapua_t5000", "rhs_acc_dh520x56", "rhs_acc_harris_swivel",
	"rhs_weap_rpg7", "rhs_rpg7_OG7V_mag", //"rhs_rpg7_PG7V_mag", 

	"rhs_uniform_vkpo_gloves", "rhs_6b23_6sh116", "rhs_sidor", "rhs_6b7_1m_bala1_emr", //rhs_rd54_emr1
	"rhssaf_zrak_rd7j", "rhs_1PN138", //rhs_pdu4
	"rhs_acc_1p63", "rhs_acc_pkas", "rhs_acc_dtk", "rhs_acc_2dpZenit", 
	"rhs_mag_rgd5", "SmokeShellRed", "rhs_mag_zarya2"
];

_defenderArsenalPos = [_missionLocation, 0, _compoundRadius / 4, 2, 0, 20, 0, [], [_missionLocation, _missionLocation]] call BIS_fnc_findSafePos;
_defenderArsenal = createVehicle ["Box_FIA_Support_F", _defenderArsenalPos vectorAdd [0,0,0.5], [], 1, "NONE"]; //BiA_EFT_Box
_defenderArsenal allowDamage false;

clearItemCargoGlobal 		_defenderArsenal;
clearMagazineCargoGlobal 	_defenderArsenal;
clearWeaponCargoGlobal 		_defenderArsenal;
clearBackpackCargoGlobal	_defenderArsenal;

_defenderItems = _ruItems;

if (_defenderFaction == "US") then 
{
	_defenderItems = _usItems;
};

[_defenderArsenal, _commonItems + _spcDefenderItems + _defenderItems, true] call ace_arsenal_fnc_initBox;

//spawn attacker arsenal
_attackerItems = _ruItems;

if (_attackerFaction == "US") then 
{
	_attackerItems = _usItems;
};

[hq_arsenal, _commonItems + _attackerItems, true] call ace_arsenal_fnc_initBox;

_defenderArsenal