/*
_gearCats = 
[
	"vals", "chances", 
	"uniforms", "vests", "backpacks", "headgear", "facegear", 
	"binos", "nvgs", "launchers", "weapons",
	"arMags", "glMags", "mgMags", "dmrMags", "launcherMags", "numNades"
];
_tierGear = _gearCats apply {getArray (missionConfigFile >> "bia_tier_configs" >> _x)};

_tierGear params 
[
	"_vals", "_chances", 
	"_uniforms", "_vests", "_backpacks", "_headgear", "_facegear", 
	"_binos", "_nvgs", "_launchers", "_weapons",
	"_arMags", "_glMags", "_mgMags", "_dmrMags", "_launcherMags", "_numNades"
];

_retArr = [];

{
	_arrOfArrs = _x;
	{
		_retArr append _x;
	} forEach _arrOfArrs;
} forEach [_uniforms, _vests, _backpacks, _headgear, _facegear, _binos, _nvgs];

{
	_arrOfArrs = _x;
	{
		_arr = _x;
		
		{
			_weap = _x;
			_weapInfosCats = ["silencer", "laser", "optic", "mag", "secMag", "grip"];
			_weapInfos = _weapInfosCats apply {getArray (missionConfigFile >> "bia_weapon_configs" >> _weap >> _x)};
			_weapInfos params ["_silencers", "_lasers", "_optics", "_mags", "_secMags", "_grips"];
			_weapClass = [getText (missionConfigFile >> "bia_weapon_configs" >> _weap >> "weapClass")];
			
			{
				_retArr append _x;
			} forEach [_weapClass, _silencers, _lasers, _optics, _mags, _secMags, _grips];
		} forEach _arr;
	} forEach _arrOfArrs;
} forEach [_weapons, _launchers];

_retArr arrayIntersect _retArr
*/

[
	//Uniform
	"U_BG_Guerilla2_3",
	"U_BG_Guerrilla_6_1",
	"U_I_C_Soldier_Bandit_3_F",
	"rhs_uniform_afghanka_wdl",
	"rhs_uniform_bdu_erdl",
	"rhsgref_uniform_og107",
	"rhsgref_uniform_woodland",
	"rhssaf_uniform_m93_oakleaf_summer",
	"rhs_uniform_emr_patchless",
	"rhs_uniform_vkpo_gloves_alt",
	"rhs_uniform_g3_rgr",

	//Vests
	"V_BandollierB_oli",
	"V_TacVest_oli",
	"V_TacChestrig_oli_F",
	"rhs_6b2",
	"rhs_6b2_chicom",
	"rhs_6b2_lifchik",
	"rhs_6b23_digi_6sh92_spetsnaz2",
	"TAC_EI_RRV21_RG",
	"dgr_vestB6",

	//Backpack
	"TAC_BP_Butt_RG",
	"rhs_sidor",
	"B_AssaultPack_sgg",
	"rhs_rk_sht_30_olive",
	"rhssaf_kitbag_smb",
	"B_Carryall_oli",

	//Headgear
	"H_Bandanna_khk",
	"H_Cap_oli",
	"H_Booniehat_oli",
	"dgr_cap6",
	"PO_H_M1_OLV_2",
	"PO_H_SSh68Helmet_M81_1",
	"rhsgref_helmet_M1_erdl",
	"rhsgref_ssh68_emr",
	"rhs_6b7_1m_olive",
	"dgr_ech14",
	"TAC_K6",

	//Facegear
	"G_Balaclava_oli",
	"G_Bandanna_oli",
	"rhsusf_shemagh2_grn",
	"VSM_Balaclava2_OD_Goggles",

	//Binos
	"rhssaf_zrak_rd7j",
	"rhs_pdu4",
	"ACE_Vector",
	"Rangefinder",
	"ACE_MX2A",

	//NVGs
	"rhs_1PN138",
	"rhsusf_ANPVS_15",
	"O_NVGoggles_ghex_F",

	//RU Weaps
	"rhs_weap_ak74",
	"rhs_weap_ak74m",
	"rhs_weap_ak74m_zenitco01_b33",
	"rhs_weap_ak74_gp25",
	"rhs_weap_ak74m_gp25",
	"rhs_weap_ak74mr_gp25",
	"rhs_weap_akm",
	"rhs_weap_akm_zenitco01_b33",
	"rhs_weap_ak103",
	"rhs_weap_akm_gp25",
	"rhs_weap_ak103_gp25",
	"rhs_weap_ak103_gp25_npz",
	"rhs_weap_pkm",
	"rhs_weap_pkp",
	"rhs_weap_m76",
	"rhs_weap_svds_npz",

	//RU Accs
	"rhs_acc_dtk1983",
	"rhs_acc_dtk4short",
	"rhs_acc_2dpZenit",
	"rhs_acc_perst1ik",
	"rhs_acc_dtkakm",
	"rhs_acc_pbs1",
	"rhs_acc_1p78",
	"rhs_acc_dtk",
	"rhs_acc_1p63",
	"rhs_acc_pkas",
	"rhs_acc_dtk4long",
	"rhs_acc_tgpv2",

	//RU Ammo
	"rhs_30Rnd_545x39_7N6M_AK",
	"rhs_30Rnd_545x39_7N10_plum_AK",
	"rhs_30Rnd_545x39_AK_plum_green",
	"rhs_30Rnd_545x39_AK_green",

	"rhs_30Rnd_762x39mm_bakelite",
	"rhs_30Rnd_762x39mm_bakelite_tracer",
	"rhs_30Rnd_762x39mm_polymer",
	"rhs_30Rnd_762x39mm_polymer_tracer",

	"rhs_100Rnd_762x54mmR",
	"rhs_100Rnd_762x54mmR_7N26",
	"rhs_100Rnd_762x54mmR_green",

	"rhs_10Rnd_762x54mmR_7N1",
	"rhs_10Rnd_762x54mmR_7N14",
	"ACE_10Rnd_762x54_Tracer_mag",
	
	"rhs_VOG25",

	//US Weapons
	"rhs_weap_m16a4_imod",
	"rhs_weap_m4a1",
	"rhs_weap_m4a1_m320",
	"rhs_weap_g36kv",
	"rhs_weap_g36kv_ag36",
	"arifle_Mk20_plain_F",
	"arifle_Mk20_GL_plain_F",
	"arifle_TRG21_F",
	"arifle_TRG21_GL_F",
	"rhs_weap_mk18_KAC",
	"rhs_weap_mk18_m320",
	"rhs_weap_hk416d145",
	"rhs_weap_hk416d145_m320",
	"rhs_weap_m249_pip_L",
	"rhs_weap_m240B",
	"sma_minimi_mk3_762tlb",
	"LMG_Zafir_F",
	"SMA_HK417vfg",
	"SMA_Mk17_black",
	"SMA_MK17_EGLM_black",
	"SMA_HK417_16in",
	"rhs_weap_m14ebrri",
	"rhs_weap_sr25_ec",

	//US Acc
	"rhsusf_acc_LEUPOLDMK4",
	"RKSL_optic_PMII_312",
	"optic_AMS",
	"SMA_SFFL_BLK",
	"rhsusf_acc_anpeq15side_bk",
	"SMA_eotech552",
	"RKSL_optic_EOT552",
	"SMA_eotech",
	"rhsusf_acc_mrds",
	"rhsusf_acc_RX01_NoFilter",
	"rhsusf_acc_T1_high",
	"rhs_acc_grip_ffg2",
	"optic_Aco",
	"sma_spitfire_01_black",
	"rhs_acc_perst1ik_ris",
	"rhsusf_acc_eotech_xps3",
	"rhsusf_acc_compm4",
	"rhsusf_acc_SFMB556",
	"rhsusf_acc_nt4_black",
	"rhsusf_acc_anpeq15_bk",
	"rhsusf_acc_eotech_552",
	"rhsusf_acc_grip3",
	"rhsusf_acc_kac_grip_saw_bipod",
	"rhsusf_acc_aac_762sdn6_silencer",
	"rhsusf_acc_harris_bipod",
	"rhsusf_acc_T1_low",
	"rhsusf_acc_ARDEC_M240",
	"SMA_ANPEQ15_BLK",
	"rhsusf_acc_premier_low",
	"SMA_supp_762",
	"optic_Holosight_blk_F",
	"Scot_NForce_Atcr_RMR_Top",
	"rhs_acc_harris_swivel",

	//US Ammo
	"rhs_mag_30Rnd_556x45_M855A1_Stanag",
	"ACE_30Rnd_556x45_Stanag_M995_AP_mag",
	"rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",

	"rhsusf_200rnd_556x45_mixed_box",
	"rhsusf_100Rnd_556x45_M995_soft_pouch_coyote",

	"rhsusf_100Rnd_762x51_m61_ap",
	"rhsusf_100Rnd_762x51_m62_tracer",
	
	"ACE_20Rnd_762x51_M993_AP_Mag",
	"ACE_20Rnd_762x51_Mag_Tracer",

	"rhs_30Rnd_545x39_7N22_plum_AK",
	"rhs_30Rnd_545x39_AK_plum_green",
	"rhs_30Rnd_762x39mm_polymer",
	"rhs_30Rnd_762x39mm_polymer_tracer",

	"rhs_mag_100Rnd_556x45_M855A1_cmag",
	"rhs_mag_100Rnd_556x45_M855A1_cmag_mixed",

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
	
	"1Rnd_HE_Grenade_shell",

	//Launchers
	"rhs_weap_rshg2",
	"rhs_weap_M136_hedp",
	"rhs_weap_rpg7",
	"rhs_weap_maaws",
	"launch_MRAWS_green_rail_F",

	//Launcher Ammo
	"rhs_rpg7_OG7V_mag",
	"rhs_mag_maaws_HE",
	"MRAWS_HE_F"
]

/*
	"UAS_BASE_545x39_7N6_30Rnd",
	"UAS_BASE_545x39_7N6_40Rnd",
	"UAS_BASE_545x39_7N22_30Rnd",
	"UAS_BASE_762N_M80A1_30Rnd",
	"UAS_BASE_762N_M80A1_100Rnd",
	"UAS_BASE_762N_M80A1_200Rnd",
	"UAS_BASE_762N_M993_100Rnd",
	"UAS_BASE_762N_M993_200Rnd",
	"UAS_BASE_762N_M80A1_10Rnd",
	"UAS_BASE_556_M995_30Rnd",
	"UAS_BASE_556_M995_40Rnd",
	"UAS_BASE_556_M855A2_100Rnd",
	"UAS_BASE_556_M855A2_200Rnd",
	"UAS_BASE_556_M995_100Rnd",
	"UAS_BASE_556_M995_200Rnd",
	"UAS_BASE_556_M995A1_100Rnd",
	"UAS_BASE_556_M995A1_200Rnd",
	"UAS_BASE_556_M193_30Rnd",
	"UAS_BASE_556_M855A2_20Rnd",
	"UAS_BASE_762x39_57N231_30Rnd",
	"UAS_BASE_762x39_57N231_40Rnd",
	"UAS_BASE_762x39_7N27_30Rnd",
	"UAS_BASE_762x54_7N13_100Rnd",
	"UAS_BASE_762x54_7N13_200Rnd",
	"UAS_BASE_762x54_7N26_100Rnd",
	"UAS_Base_762x54_7N1_10Rnd",
	"UAS_BASE_545x39_7N22_40Rnd",
	"UAS_BASE_545x39_7N39_30Rnd",
	"UAS_BASE_762x39_7N27_40Rnd",
	"UAS_BASE_762x54_7N26_200Rnd",
	"UAS_Base_762x54_7N37M_100Rnd",
	"UAS_Base_762x54_7N37M_200Rnd",
	"UAS_Base_762x54_7N41_10Rnd",
	"UAS_BASE_545x39_7N39_40Rnd",
	"UAS_BASE_762x39_7N38_30Rnd",
	"UAS_BASE_762x39_7N38_40Rnd",
	"UAS_BASE_556_M193_40Rnd",
	"UAS_BASE_556_M855A2_30Rnd",
	"UAS_BASE_556_M855A2_40Rnd",
	"UAS_BASE_762N_M993_10Rnd",

*/