//Params
params [
"_target", 
"_caller", 
"_arguments"
];

_arguments params ["_box", "_class"];

_commonItems = 
[
	//Clothes
	"dgr_uniform20",
	"dgr_vestB20",
	"dgr_pack20",
	"H_HelmetSpecB_paint2",
	"rhsusf_shemagh2_gogg_tan",

	//Inventory Items 
	"ItemMap",
	"ItemGPS",
	"ItemRadio",
	"ItemCompass",
	"ACE_Altimeter",

	//Medical 
	"ACE_EarPlugs",
	"ACE_fieldDressing",
	"ACE_morphine",
	"ACE_epinephrine",
	"ACE_personalAidKit",

	//Demolitions
	"DemoCharge_Remote_Mag",
	"rhssaf_mine_tma4_mag",

	//Items 
	"ACE_Flashlight_XL50",
	"ACE_M26_Clacker",
	"ACE_EntrenchingTool",
	"ACE_HuntIR_monitor",
	"ACE_SpareBarrel",
	"ACE_RangeCard",
	"ACE_Kestrel4500",
	"ACE_ATragMX",
	"ACE_Tripod"
];

_russian = 
[
	//Weapons
	"rhs_weap_ak74",
	"rhs_weap_ak74_gp25",
	"rhs_weap_akm",
	"rhs_weap_akm_gp25",
	"bia_pkm", //rhs_weap_pkm
	"rhs_weap_svdp",

	//AT
	"rhs_weap_rpg18",
	"rhs_weap_rpg26",
	"rhs_weap_rpg7",
	"rhs_weap_igla",

	//Binos 
	"rhssaf_zrak_rd7j",

	//NVG
	"rhs_1PN138",

	//No NVG but flare 40mms

	//Ammo 
	"rhs_30Rnd_545x39_7N6M_AK",
	"rhs_30Rnd_545x39_AK_green",
	"rhs_30Rnd_762x39mm_bakelite",
	"rhs_30Rnd_762x39mm_bakelite_tracer",

	"rhs_100Rnd_762x54mmR",
	"rhs_100Rnd_762x54mmR_green",

	"rhs_10Rnd_762x54mmR_7N1",
	"ACE_10Rnd_762x54_Tracer_mag",

	//Explosives
	"rhs_VOG25",
	"rhs_VG40OP_white",
	"rhs_mag_rdg2_white", //smoke 
	"rhs_mag_rgn", //impact nade 
	"rhs_mag_rgd5", //frag
	"rhs_mag_9k38_rocket", //igla rocket
	"rhs_rpg7_PG7V_mag",
	"rhs_rpg7_OG7V_mag",

	//ACC
	"rhs_acc_pso1m2",
	"rhs_acc_2dpZenit", 
	"rhs_acc_dtkakm",
	"rhs_acc_dtk1983",
	//"rhs_acc_dtk",
	"rhs_acc_dtk4short",
	"rhs_acc_pbs1",
	//"rhs_acc_dtk4long",
	"rhs_acc_tgpv"
];

_modernRussian = 
[
	//Weapons
	"rhs_weap_ak74m",
	"rhs_weap_ak74m_gp25",
	"rhs_weap_ak103",
	"rhs_weap_ak103_gp25",
	"rhs_weap_svds",
	"bia_pkp", //rhs_weap_pkp

	//AT
	"rhs_weap_rpg18",
	"rhs_weap_rpg26",
	"rhs_weap_rpg7",
	"rhs_weap_igla",

	//Binos 
	"rhs_pdu4",

	//NVG
	"rhs_1PN138",

	//Ammo
	"rhs_30Rnd_545x39_7N10_plum_AK",
	"rhs_30Rnd_545x39_AK_plum_green",
	"rhs_30Rnd_762x39mm_polymer",
	"rhs_30Rnd_762x39mm_polymer_tracer",

	"rhs_100Rnd_762x54mmR_7N26",
	"rhs_100Rnd_762x54mmR_green",

	"rhs_10Rnd_762x54mmR_7N14",
	"ACE_10Rnd_762x54_Tracer_mag",

	//Explosives
	"rhs_VOG25",
	"rhs_mag_rdg2_white", //smoke 
	"rhs_mag_rgn", //impact nade 
	"rhs_mag_rgd5", //frag
	"rhs_mag_9k38_rocket", //igla rocket
	"rhs_rpg7_PG7VM_mag",
	"rhs_rpg7_OG7V_mag",

	//ACC
	"rhs_acc_1p63",
	"rhs_acc_1p78",
	"rhs_acc_pkas",
	"rhs_acc_pso1m2",
	
	"rhs_acc_2dpZenit", 
	"rhs_acc_perst1ik",

	"rhs_acc_grip_ffg2",
	"rhs_acc_dtk",
	"rhs_acc_dtk4short",
	"rhs_acc_dtk4long",
	"rhs_acc_tgpv"

	/*
	"rhs_weap_akm_zenitco01_b33",
	"rhs_weap_ak74mr",

	"rhs_acc_dtkakm",
	"rhs_acc_pgs64",
	"rhs_acc_ak5",
	"rhs_acc_dtk1983",
	"rhs_acc_uuk",

	"optic_DMS",
	"rhsusf_acc_T1_high",
	"CUP_optic_CompM2_Black",

	//"rhs_weap_ak105_zenitco01_b33",
	//"rhs_weap_ak104_zenitco01_b33",
	*/
];

_american = 
[
	//Weapons
	"rhs_weap_m4a1",
	"rhs_weap_m4a1_m320",
	"rhs_weap_m16a4_imod",

	"rhs_weap_m249_pip_L",
	"rhs_weap_m240B",

	"rhs_weap_m14ebrri",
	"rhs_weap_sr25",

	//AT
	"rhs_weap_m72a7",
	"rhs_weap_M136",
	"rhs_weap_maaws",
	"rhs_weap_fim92",

	//Binos
	"ACE_Vector",

	//NVG
	"rhsusf_ANPVS_15",
	
	//Ammo
	"ACE_30Rnd_556x45_Stanag_M995_AP_mag",
	"rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",

	"rhsusf_200rnd_556x45_mixed_box",
	"rhsusf_100Rnd_556x45_M995_soft_pouch_coyote",

	"rhsusf_100Rnd_762x51_m61_ap",
	"rhsusf_100Rnd_762x51_m62_tracer",

	"ACE_20Rnd_762x51_M993_AP_Mag",
	"ACE_20Rnd_762x51_Mag_Tracer",
	
	//Explosives
	"1Rnd_HE_Grenade_shell",
	"HandGrenade",
	"rhs_mag_m18_green",
	"rhs_mag_maaws_HEAT",
	"rhs_mag_maaws_HE",
	"rhs_fim92_mag",
	
	//ACC
	"rhsusf_acc_eotech_552",
	"rhsusf_acc_compm4",

	"rhsusf_acc_ACOG",
	"rhsusf_acc_ELCAN",

	"rhsusf_acc_LEUPOLDMK4",
	"rhsusf_acc_premier_low",

	"rhsusf_acc_anpeq15side_bk",
	"rhsusf_acc_anpeq15_bk",

	"rhsusf_acc_SR25S",
	"rhsusf_acc_aac_762sdn6_silencer",
	"rhsusf_acc_nt4_black",
	"rhsusf_acc_SFMB556",
	"rhsusf_acc_ARDEC_M240",

	"rhsusf_acc_grip3",
	"rhsusf_acc_grip4_bipod",
	"rhsusf_acc_harris_bipod"

	/*
	"rhsusf_acc_M8541_mrds",
	"rhsusf_acc_premier_mrds",
	"RKSL_optic_PMII_312",
	*/
];

_special = 
[
	//Weapons 
	"rhs_weap_ak74m_zenitco01_b33",
	"rhs_weap_ak74mr_gp25",
	"rhs_weap_ak103_zenitco01_b33",
	"rhs_weap_ak103_gp25_npz",
	"rhs_weap_svds_npz",

	"rhs_weap_mk18_KAC", 
	"rhs_weap_mk18_m320",
	"rhs_weap_m4a1_blockII_KAC",

	"arifle_SPAR_01_blk_F",
	"SMA_HK416CUSTOMvfgB",
	"rhs_weap_hk416d145",
	"rhs_weap_hk416d145_m320",

	"SMA_HK417vfg",
	"SMA_HK417_16in",
	"arifle_SPAR_03_blk_F",
	
	"rhs_weap_savz58v_ris",
	"rhs_weap_m14_socom_rail",
	
	"arifle_ARX_blk_F",
	"arifle_MSBS65_black_F",
	"arifle_MSBS65_GL_black_F",

	"arifle_Mk20_plain_F",
	"arifle_Mk20_GL_plain_F",

	"rhs_weap_vhsd2",
	"rhs_weap_vhsd2_bg",

	"rhs_weap_g36kv",
	"rhs_weap_g36kv_ag36",

	"arifle_TRG21_F",
	"arifle_TRG21_GL_F",
	"SMA_TavorBLK_F",

	"SMA_Mk16_black",
	"SMA_MK16_EGLM_black",
	"rhs_weap_mk17_CQC",
	"SMA_Mk17_black",
	"SMA_MK17_EGLM_black",

	"sma_minimi_mk3_762tlb",
	"LMG_Zafir_F",
	
	"srifle_DMR_05_tan_f",
	"srifle_GM6_F",
	"srifle_LRR_F",
	"rhs_weap_M107",
	
	//AT
	"launch_MRAWS_green_rail_F",
	"launch_B_Titan_short_F",

	//Binos
	"ACE_Vector",
	"ACE_MX2A",

	//NVG
	"O_NVGoggles_hex_F",

	//RU Ammo
	"rhs_30Rnd_545x39_7N22_plum_AK",
	"rhs_30Rnd_545x39_AK_plum_green",
	"rhs_30Rnd_762x39mm_polymer",
	"rhs_30Rnd_762x39mm_polymer_tracer",

	"rhs_10Rnd_762x54mmR_7N14",
	"ACE_10Rnd_762x54_Tracer_mag",
	
	"rhs_VOG25",

	//Ammo
	"ACE_30Rnd_556x45_Stanag_M995_AP_mag",
	"rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",

	"rhs_mag_100Rnd_556x45_M855A1_cmag",
	"rhs_mag_100Rnd_556x45_M855A1_cmag_mixed",

	"ACE_20Rnd_762x51_M993_AP_Mag",
	"ACE_20Rnd_762x51_Mag_Tracer",

	"rhs_30Rnd_762x39mm_Savz58",
	"rhs_30Rnd_762x39mm_Savz58_tracer",

	"30Rnd_65x39_caseless_green",
	"30Rnd_65x39_caseless_green_mag_Tracer",
	"10Rnd_50BW_Mag_F",

	"30Rnd_65x39_caseless_msbs_mag",
	"30Rnd_65x39_caseless_msbs_mag_Tracer",

	"rhssaf_30rnd_556x45_EPR_G36",
	"rhssaf_30rnd_556x45_Tracers_G36",

	"rhs_mag_20Rnd_SCAR_762x51_m61_ap_bk",
	"rhs_mag_20Rnd_SCAR_762x51_m62_tracer_bk",
	
	"SMA_150Rnd_762_M80A1",
	"SMA_150Rnd_762_M80A1_Mixed",
	"SMA_150Rnd_762_M80A1_Tracer",

	"150Rnd_762x54_Box",
	"150Rnd_762x54_Box_Tracer",

	"10Rnd_93x64_DMR_05_Mag",
	"ACE_5Rnd_127x99_AMAX_Mag",
	"ACE_5Rnd_127x99_API_Mag",
	"7Rnd_408_Mag",
	"ACE_10Rnd_127x99_AMAX_Mag",
	"ACE_10Rnd_127x99_API_Mag",

	//Explosives
	"1Rnd_HE_Grenade_shell",
	"HandGrenade",
	"rhs_mag_m18_green",
	"ACE_M84",
	"MRAWS_HEAT_F",
	"MRAWS_HE_F",
	"Titan_AT",

	//RU ACC
	"rhs_acc_grip_ffg2",
	"rhs_acc_dtk1983",
	"rhs_acc_dtk4short",
	"rhs_acc_dtk4long",
	"rhs_acc_tgpv",

	//ACC
	"FHQ_optic_AIM",
	"rhsusf_acc_compm4",
	"rhsusf_acc_eotech_xps3",
	"iansky_cmore",

	"FHQ_optic_AimM_BLK",
	"SMA_eotech552_3XDOWN",
	"SMA_eotechG33_3XDOWN",
	
	"bia_optic_arco",
	"bia_optic_erco",
	"bia_optic_hamr",
	"sma_spitfire_03_rds_low_black",
	"rhsusf_acc_ACOG_RMR",
	"SMA_ELCAN_SPECTER_RDS_4z",
	"Scot_NForce_Atcr_RMR_Top",

	"rhsusf_acc_SFMB556",
	"rhsusf_acc_nt4_black",
	"rhsusf_acc_aac_762sdn6_silencer",
	"SMA_FLASHHIDER1",
	"SMA_supp1b_556",
	"SMA_supp_762",

	"rhsusf_acc_grip3",
	"bipod_01_F_blk"

	/*
	//"rhs_weap_m27iar_grip",
	//"SMA_HK416CUSTOMCQBvfgB",
	//"rhs_weap_hk416d10",
	//"SMA_HK417_16in",
	//"arifle_Mk20C_plain_F",
	//"rhs_weap_vhsk2",
	//"arifle_TRG20_F",
	//"SMA_Mk16_blackQCB",
	//"rhs_weap_mk17_STD",
	//"SMA_Mk17_16_black",
	*/
];

[_box] call ace_arsenal_fnc_removeBox;
/*
_caller removeWeapon (primaryWeapon _caller);
_caller removeWeapon (secondaryWeapon _caller);
_caller removeWeapon (handgunWeapon _caller);

_magsTypes = magazines [_caller, true];
{
	_caller removeMagazines _x;
} forEach _magsTypes;
*/

_caller setVariable ["ace_medical_medicclass", 1, true]; // 0 no medic, 1 medic, 2 doctor

switch (_class) do
{
	case "Russian": 
	{
		[_box, _commonItems + _russian] call ace_arsenal_fnc_initBox;
	};
	case "Modern Russian": 
	{
		[_box, _commonItems + _modernRussian] call ace_arsenal_fnc_initBox;
	};
	case "American": 
	{
		[_box, _commonItems + _american] call ace_arsenal_fnc_initBox;
	};
	case "Special": 
	{
		[_box, _commonItems + _special] call ace_arsenal_fnc_initBox;
	};
};

[_box, _caller] call ace_arsenal_fnc_openBox;

/*
_actTree = ["ACE_SelfActions", "BiA_Supports"];
[_caller, 1, _actTree + ["BiA_Spawn_UAV"]] call ace_interact_menu_fnc_removeActionFromObject;
[_caller, 1, _actTree + ["BiA_UAV"]] call ace_interact_menu_fnc_removeActionFromObject;
*/