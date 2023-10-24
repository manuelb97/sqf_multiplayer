#define AR_Grip "rhs_acc_grip_ffg2"

#define US_556 "rhs_mag_30Rnd_556x45_M855A1_Stanag"
#define US_762 "rhs_mag_20Rnd_SCAR_762x51_m80a1_epr_bk"
#define US_Muzzle "rhsusf_acc_SFMB556"
#define US_Light "rhsusf_acc_anpeq15_bk"
#define US_RedDot "rhsusf_acc_compm4"
#define US_Scope "rhsusf_acc_ACOG"
#define US_GL "1Rnd_HE_Grenade_shell"

#define RU_545 "rhs_30Rnd_545x39_7N10_AK"
#define RU_762 "rhs_30Rnd_762x39mm_polymer"
#define RU_Muzzle "rhs_acc_dtk1983"
#define RU_RedDot "rhs_acc_1p63"
#define RU_GL "rhs_VOG25"

class bia_kit_configs
{
	//Rifle
	class bia_ak74_iron
	{
		primArr = ["rhs_weap_ak74", RU_Muzzle, "", "", RU_545, "", ""];
		atArr = [];
		secArr = [];
		vestAmmo = [[RU_545, 8]];
		backAmmo = [];
		role = "Rifle";
	};

	class bia_ak74m_dot: bia_ak74_iron
	{
		primArr = ["rhs_weap_ak74m", RU_Muzzle, "rhs_acc_perst1ik", RU_RedDot, RU_545, "", ""];
	};

	class bia_ak74m_b33_dot: bia_ak74_iron
	{
		primArr = ["rhs_weap_ak74m_zenitco01_b33", RU_Muzzle, "rhs_acc_perst3_2dp_h", "rhsusf_acc_T1_high", RU_545, "", AR_Grip];
	};

	class bia_akm_iron: bia_ak74_iron
	{
		primArr = ["rhs_weap_akm", "rhs_acc_dtkakm", "", "", RU_762, "", ""];
		vestAmmo = [[RU_762, 8]];
	};

	class bia_ak103_dot: bia_akm_iron
	{
		primArr = ["rhs_weap_ak103", "rhs_acc_dtk", "rhs_acc_perst1ik", RU_RedDot, RU_762, "", AR_Grip];
	};

	class bia_akm_b33_dot: bia_akm_iron
	{
		primArr = ["rhs_weap_akm_zenitco01_b33", "rhs_acc_dtkakm", "rhs_acc_perst3_2dp_h", US_RedDot, RU_762, "", ""];
	};

	class bia_m4a1_dot: bia_ak74_iron
	{
		primArr = ["rhs_weap_m4a1", US_Muzzle, US_Light, US_RedDot, US_556, "", AR_Grip];
		vestAmmo = [[US_556, 8]];
	};
	
	class bia_m16a4_dot: bia_m4a1_dot
	{
		primArr = ["rhs_weap_m16a4_imod", US_Muzzle, US_Light, US_RedDot, US_556, "", AR_Grip];
	};
	
	class bia_hk416_dot: bia_m4a1_dot
	{
		primArr = ["rhs_weap_hk416d10_LMT", US_Muzzle, "acc_pointer_IR", "rhsusf_acc_eotech_xps3", US_556, "", AR_Grip];
	};
	
	class bia_g36_dot: bia_m4a1_dot
	{
		primArr = ["rhs_weap_g36kv", US_Muzzle, "", "rhsusf_acc_T1_high", US_556, "", AR_Grip];
	};
	
	class bia_f2000_dot: bia_m4a1_dot
	{
		primArr = ["arifle_Mk20_plain_F", US_Muzzle, "rhs_acc_perst1ik_ris", "rhsusf_acc_T1_high", US_556, "", ""];
	};
	
	class bia_tar21_dot: bia_m4a1_dot
	{
		primArr = ["arifle_TRG21_F", US_Muzzle, "rhs_acc_perst1ik_ris", "rhsusf_acc_T1_high", US_556, "", ""];
	};
	
	class bia_scarl_dot: bia_m4a1_dot
	{
		primArr = ["SMA_Mk16_black", "", "SMA_SFPEQ_SCARTOP_BLK", "rhsusf_acc_T1_high", US_556, "", ""];
	};
	
	class bia_tavor_dot: bia_m4a1_dot
	{
		primArr = ["SMA_CTARBLK_F", "", "rhs_acc_perst1ik_ris", "rhsusf_acc_eotech_xps3", US_556, "", ""];
	};
	
	class bia_m14_cqb_dot: bia_m4a1_dot
	{
		primArr = ["rhs_weap_m14_socom_rail", "rhsusf_acc_m14_flashsuppresor", "", "rhsusf_acc_RX01_NoFilter", US_762, "", ""];
		vestAmmo = [[US_762, 8]];
	};
	
	class bia_scarh_dot: bia_m14_cqb_dot
	{
		primArr = ["SMA_Mk17_black", "", "SMA_SFPEQ_SCARTOP_BLK", US_RedDot, US_762, "", ""];
	};
	
	class bia_hk417_dot: bia_m14_cqb_dot
	{
		primArr = ["SMA_HK417vfg", "", "", "rhsusf_acc_eotech_xps3", US_762, "", ""];
	};

	//Grenadier
	class bia_ak74_iron_gl: bia_ak74_iron
	{
		primArr = ["rhs_weap_ak74_gp25", "rhs_acc_dtk1983", "", "", RU_545, RU_GL, ""];
		vestAmmo = [[RU_545, 8], [RU_GL, 10]];
		role = "Grenadier";
	};

	class bia_ak74m_dot_gl: bia_ak74_iron_gl
	{
		primArr = ["rhs_weap_ak74m_gp25", RU_Muzzle, "", RU_RedDot, RU_545, RU_GL, ""];
	};

	class bia_ak74m_b33_dot_gl: bia_ak74_iron_gl
	{
		primArr = ["rhs_weap_ak74mr_gp25", "rhs_acc_uuk", "", "rhsusf_acc_T1_high", RU_545, RU_GL, ""];
	};

	class bia_akm_iron_gl: bia_ak74_iron_gl
	{
		primArr = ["rhs_weap_akm_gp25", "rhs_acc_dtkakm", "", "", RU_762, RU_GL, ""];
		vestAmmo = [[RU_762, 8]];
	};

	class bia_ak103_dot_gl: bia_akm_iron_gl
	{
		primArr = ["rhs_weap_ak103_gp25", "rhs_acc_dtk", "", RU_RedDot, RU_762, RU_GL, ""];
	};

	class bia_ak103_npz_dot_gl: bia_akm_iron_gl
	{
		primArr = ["rhs_weap_ak103_gp25_npz", "rhs_acc_dtk", "", US_RedDot, RU_762, RU_GL, ""];
	};

	class bia_m4a1_dot_gl: bia_ak74_iron_gl
	{
		primArr = ["rhs_weap_m4a1_m320", US_Muzzle, US_Light, US_RedDot, US_556, US_GL, ""];
		vestAmmo = [[US_556, 8], [US_GL, 10]];
	};
	
	class bia_hk416_dot_gl: bia_m4a1_dot_gl
	{
		primArr = ["rhs_weap_hk416d10_m320", US_Muzzle, "acc_pointer_IR", "rhsusf_acc_eotech_xps3", US_556, US_GL, ""];
	};
	
	class bia_g36_dot_gl: bia_m4a1_dot_gl
	{
		primArr = ["rhs_weap_g36kv_ag36", US_Muzzle, "", "rhsusf_acc_T1_high", US_556, US_GL, ""];
	};
	
	class bia_f2000_dot_gl: bia_m4a1_dot_gl
	{
		primArr = ["arifle_Mk20_GL_plain_F", US_Muzzle, "", "rhsusf_acc_T1_high", US_556, US_GL, ""];
	};
	
	class bia_tar21_dot_gl: bia_m4a1_dot_gl
	{
		primArr = ["arifle_TRG21_GL_F", US_Muzzle, "", "rhsusf_acc_T1_high", US_556, US_GL, ""];
	};
	
	class bia_scarl_dot_gl: bia_m4a1_dot_gl
	{
		primArr = ["SMA_MK16_EGLM_black", "", "SMA_SFPEQ_SCARTOP_BLK", "rhsusf_acc_T1_high", US_556, US_GL, ""];
	};
	
	class bia_scarh_dot_gl: bia_m4a1_dot_gl
	{
		primArr = ["SMA_MK17_EGLM_black", "", "SMA_SFPEQ_SCARTOP_BLK", US_RedDot, US_762, US_GL, ""];
		vestAmmo = [[US_762, 8], [US_GL, 10]];
	};

	//Rifle_AT
	class bia_ak74_iron_at
	{
		primArr = ["rhs_weap_ak74", RU_Muzzle, "", "", RU_545, "", ""];
		atArr = ["rhs_weap_rpg7", "", "", "", "rhs_rpg7_OG7V_mag", "", ""];
		secArr = [];
		vestAmmo = [[RU_545, 8]];
		backAmmo = [["rhs_rpg7_OG7V_mag", 2]];
		role = "Rifle_AT";
	};

	class bia_ak74m_dot_at: bia_ak74_iron_at
	{
		primArr = ["rhs_weap_ak74m", RU_Muzzle, "rhs_acc_perst1ik", RU_RedDot, RU_545, "", ""];
	};

	class bia_ak74m_b33_dot_at: bia_ak74_iron_at
	{
		primArr = ["rhs_weap_ak74m_zenitco01_b33", RU_Muzzle, "rhs_acc_perst3_2dp_h", "rhsusf_acc_T1_high", RU_545, "", AR_Grip];
	};

	class bia_akm_iron_at: bia_ak74_iron_at
	{
		primArr = ["rhs_weap_akm", "rhs_acc_dtkakm", "", "", RU_762, "", ""];
		vestAmmo = [[RU_762, 8]];
	};

	class bia_ak103_dot_at: bia_akm_iron_at
	{
		primArr = ["rhs_weap_ak103", "rhs_acc_dtk", "rhs_acc_perst1ik", RU_RedDot, RU_762, "", AR_Grip];
	};

	class bia_akm_b33_dot_at: bia_akm_iron_at
	{
		primArr = ["rhs_weap_akm_zenitco01_b33", "rhs_acc_dtkakm", "rhs_acc_perst3_2dp_h", US_RedDot, RU_762, "", ""];
	};

	class bia_m4a1_dot_at: bia_ak74_iron_at
	{
		primArr = ["rhs_weap_m4a1", US_Muzzle, US_Light, US_RedDot, US_556, "", AR_Grip];
		atArr = ["rhs_weap_maaws", "", "", "", "rhs_mag_maaws_HE", "", ""];
		vestAmmo = [[US_556, 8]];
		backAmmo = [["rhs_mag_maaws_HE", 2]];
	};
	
	class bia_m16a4_dot_at: bia_m4a1_dot_at
	{
		primArr = ["rhs_weap_m16a4_imod", US_Muzzle, US_Light, US_RedDot, US_556, "", AR_Grip];
	};
	
	class bia_hk416_dot_at: bia_m4a1_dot_at
	{
		primArr = ["rhs_weap_hk416d10_LMT", US_Muzzle, "acc_pointer_IR", "rhsusf_acc_eotech_xps3", US_556, "", AR_Grip];
	};
	
	class bia_g36_dot_at: bia_m4a1_dot_at
	{
		primArr = ["rhs_weap_g36kv", US_Muzzle, "", "rhsusf_acc_T1_high", US_556, "", AR_Grip];
	};
	
	class bia_f2000_dot_at: bia_m4a1_dot_at
	{
		primArr = ["arifle_Mk20_plain_F", US_Muzzle, "", "rhsusf_acc_T1_high", US_556, "", ""];
	};
	
	class bia_tar21_dot_at: bia_m4a1_dot_at
	{
		primArr = ["arifle_TRG21_F", US_Muzzle, "", "rhsusf_acc_T1_high", US_556, "", ""];
	};
	
	class bia_scarl_dot_at: bia_m4a1_dot_at
	{
		primArr = ["SMA_Mk16_black", "", "SMA_SFPEQ_SCARTOP_BLK", "rhsusf_acc_T1_high", US_556, "", ""];
	};
	
	class bia_tavor_dot_at: bia_m4a1_dot_at
	{
		primArr = ["SMA_CTARBLK_F", "", "", "rhsusf_acc_eotech_xps3", US_556, "", ""];
	};
	
	class bia_m14_cqb_dot_at: bia_m4a1_dot_at
	{
		primArr = ["rhs_weap_m14_socom", "rhsusf_acc_m14_flashsuppresor", "", "rhsusf_acc_RX01_NoFilter", US_762, "", ""];
		vestAmmo = [[US_762, 8]];
	};
	
	class bia_scarh_dot_at: bia_m14_cqb_dot_at
	{
		primArr = ["SMA_Mk17_black", "", "SMA_SFPEQ_SCARTOP_BLK", US_RedDot, US_762, "", ""];
	};
	
	class bia_hk417_dot_at: bia_m14_cqb_dot_at
	{
		primArr = ["SMA_HK417vfg", "", "", "rhsusf_acc_eotech_xps3", US_762, "", ""];
	};

	//MG
	class bia_mg42
	{
		primArr = ["rhs_weap_mg42", "", "", "", "rhsgref_296Rnd_792x57_SmK_belt", "", ""];
		atArr = [];
		secArr = [];
		vestAmmo = [];
		backAmmo = [["rhsgref_296Rnd_792x57_SmK_belt", 1]];
		role = "MG";
	};
	
	class bia_pkm: bia_mg42
	{
		primArr = ["rhs_weap_pkm", "", "", "", "rhs_100Rnd_762x54mmR", "", ""];
		backAmmo = [["rhs_100Rnd_762x54mmR", 3]];
	};
	
	class bia_pkp_dot: bia_pkm
	{
		primArr = ["rhs_weap_pkp", "", "", "rhs_acc_pkas", "rhs_100Rnd_762x54mmR", "", ""];
	};
	
	class bia_negev_dot: bia_mg42
	{
		primArr = ["LMG_Zafir_F", "", "acc_pointer_IR", "rhsusf_acc_eotech_xps3", "150Rnd_762x54_Box", "", ""];
		backAmmo = [["150Rnd_762x54_Box", 3]];
	};
	
	class bia_m249_dot: bia_mg42
	{
		primArr = ["rhs_weap_m249_pip_L", "rhsusf_acc_SFMB556", "rhsusf_acc_anpeq15side_bk", "rhsusf_acc_compm4", "rhsusf_200rnd_556x45_mixed_box", "", "rhsusf_acc_kac_grip_saw_bipod"];
		backAmmo = [["rhsusf_200rnd_556x45_mixed_box", 2]];
	};
	
	class bia_m240_dot: bia_mg42
	{
		primArr = ["rhs_weap_m240B", "rhsusf_acc_ARDEC_M240", "rhsusf_acc_anpeq15side_bk", "rhsusf_acc_compm4", "rhsusf_100Rnd_762x51_m80a1epr", "", ""];
		backAmmo = [["rhsusf_100Rnd_762x51_m80a1epr", 2]];
	};

	//DMR 
	class bia_m16a4_scope: bia_m4a1_dot
	{
		primArr = ["rhs_weap_m16a4_imod", US_Muzzle, US_Light, US_Scope, US_556, "", AR_Grip];
		secArr = ["rhsusf_weap_m9", "", "", "", "rhsusf_mag_15Rnd_9x19_FMJ", "", ""];
		vestAmmo = [[US_556, 6], ["rhsusf_mag_15Rnd_9x19_FMJ", 2]];
		role = "DMR";
	};

	class bia_m76_scope: bia_m16a4_scope
	{
		primArr = ["rhs_weap_m76", "", "", "rhs_acc_1p78", "rhsgref_10Rnd_792x57_m76", "", ""];
		secArr = ["rhs_weap_pya", "", "", "", "rhs_mag_9x19_17", "", ""];
		vestAmmo = [["rhsgref_10Rnd_792x57_m76", 6], ["rhs_mag_9x19_17", 2]];
	};

	class bia_svd_scope: bia_m16a4_scope
	{
		primArr = ["rhs_weap_svds", "", "", "rhs_acc_pso1m2", "rhs_10Rnd_762x54mmR_7N14", "", ""];
		secArr = ["rhs_weap_pya", "", "", "", "rhs_mag_9x19_17", "", ""];
		vestAmmo = [["rhs_10Rnd_762x54mmR_7N14", 6], ["rhs_mag_9x19_17", 2]];
	};

	class bia_svd_npz_scope: bia_m16a4_scope
	{
		primArr = ["rhs_weap_svds_npz", "", "", "rhsusf_acc_LEUPOLDMK4", "rhs_10Rnd_762x54mmR_7N14", "", ""];
		secArr = ["rhs_weap_pya", "", "", "", "rhs_mag_9x19_17", "", ""];
		vestAmmo = [["rhs_10Rnd_762x54mmR_7N14", 6], ["rhs_mag_9x19_17", 2]];
	};

	class bia_m14_ebr_scope: bia_m16a4_scope
	{
		primArr = ["rhs_weap_m14ebrri", "", "rhsusf_acc_anpeq15side_bk", "rhsusf_acc_LEUPOLDMK4", "ACE_20Rnd_762x51_M993_AP_mag", "", "rhsusf_acc_harris_bipod"];
		vestAmmo = [["ACE_20Rnd_762x51_M993_AP_mag", 6]];
	};

	class bia_m110_scope: bia_m14_ebr_scope
	{
		primArr = ["rhs_weap_sr25", "rhsusf_acc_SR25S", "", "rhsusf_acc_premier_low", "ACE_20Rnd_762x51_M993_AP_mag", "", "rhsusf_acc_harris_bipod"];
	};

	//Sniper
	class bia_m40
	{
		primArr = ["rhs_weap_m40a5", "", "", "rhsusf_acc_premier_low", "rhsusf_5Rnd_762x51_m993_mag", "", "rhsusf_acc_harris_swivel"];
		atArr = [];
		secArr = ["rhsusf_weap_m9", "", "", "", "rhsusf_mag_15Rnd_9x19_FMJ", "", ""];
		vestAmmo = [["rhsusf_5Rnd_762x51_m993_mag", 6], ["rhsusf_mag_15Rnd_9x19_FMJ", 2]];
		backAmmo = [];
		role = "Sniper";
	};
	
	class bia_m24: bia_m40
	{
		primArr = ["rhs_weap_m24sws", "rhsusf_acc_m24_silencer_black", "", "rhsusf_acc_M8541_low", "rhsusf_5Rnd_762x51_m993_mag", "", "rhsusf_acc_harris_swivel"];
	};
	
	class bia_m2010: bia_m40
	{
		primArr = ["rhs_weap_XM2010", "rhsusf_acc_M2010S_wd", "", "rhsusf_acc_M8541", "rhsusf_5Rnd_300winmag_xm2010", "", "rhsusf_acc_harris_bipod"];
		vestAmmo = [["rhsusf_5Rnd_300winmag_xm2010", 6]];
	};
	
	class bia_t5000: bia_m40
	{
		primArr = ["rhs_weap_t5000", "", "", "rhsusf_acc_M8541_low", "rhs_5Rnd_338lapua_t5000", "", "rhsusf_acc_harris_bipod"];
		secArr = ["rhs_weap_pya", "", "", "", "rhs_mag_9x19_17", "", ""];
		vestAmmo = [["rhs_5Rnd_338lapua_t5000", 6], ["rhs_mag_9x19_17", 2]];
	};
	
	class bia_m107: bia_m40
	{
		primArr = ["rhs_weap_M107", "", "", "rhsusf_acc_premier_low", "ACE_10Rnd_127x99_API_mag", "", ""];
		vestAmmo = [["ACE_10Rnd_127x99_API_mag", 6]];
	};
};

/*
_gun 		= "rhsusf_weap_glock17g4";
_light 		= "acc_flashlight_pistol";
_silencer	= selectRandom["rhsusf_acc_omega9k","no"];
_mag 		= "rhsusf_mag_17Rnd_9x19_JHP";

case "BIS_FNX": {
_gun 		= "hgun_Pistol_heavy_01_F";
_optic 		= "optic_MRD";
_light 		= "acc_flashlight_pistol";
_silencer	= selectRandom["muzzle_snds_acp","no"];
_mag 		= "11Rnd_45ACP_Mag";

case "RHS_MP443": {
_gun 		= "rhs_weap_pya";
_mag 		= "rhs_mag_9x19_17";
};
case "BIS_Custom_Covert": {
_gun 		= "hgun_ACPC2_F";
_light 		= "acc_flashlight_pistol";
_silencer	= selectRandom["muzzle_snds_acp","no"];
_mag 		= "9Rnd_45ACP_Mag";

_gun 		= "rhsusf_weap_m9";
_mag 		= "rhsusf_mag_15Rnd_9x19_JHP";

_gun 		= "rhsusf_weap_m1911a1";
_mag 		= "rhsusf_mag_7x45acp_MHP";