//Paras
_tier 		= param [0,""];
_player 	= param [1,player];
_primary	= param [2,""];
_at 		= param [3,""];

/*
_tier = "Tier_4";
_player = manu;
_primary = "RHS_SVDM";
_at = "no";
*/

//Mag count based on tier
private ["_mags","_glMags"];
switch _tier do {
	case "Tier_4": {_mags = 6; 	_glMags = 7;};
	case "Tier_3": {_mags = 8; 	_glMags = 9;};
	case "Tier_2": {_mags = 10; 	_glMags = 11;};
	case "Tier_1": {_mags = 12;	_glMags = 14;};
};

//Set primary default values
_gun 		= "no";
_optic 		= "no";
_grip 		= "no";
_light 		= "no";
_silencer 	= "no";
_mag 		= "no";
_magCount 	= _mags;
_xMag		= "no";
_xMagCount	= _glMags;
_spcItems		= [];

//Set secondary default values
_gunSec 		= "no";
_opticSec 		= "no";
_gripSec 		= "no";
_lightSec 		= "no";
_silencerSec 	= "no";
_magSec 		= "no";
_magSecCount	= "no";

//Primary Weapon
switch _primary do {
	// CQB
	case "BIS_Type115": {
		_gun		= "arifle_ARX_blk_F";
		_optic 		= selectRandom["RKSL_optic_EOT552","rhsusf_acc_compm4","CUP_optic_CompM2_Black","rhsusf_acc_T1_high","rhsusf_acc_eotech_xps3"]; //"SMA_eotechG33_3XDOWN","rhsusf_acc_su230a"
		_light 		= "FHQ_acc_LLM01L";
		_silencer 	= "no";//selectRandom["muzzle_snds_65_TI_blk_F","no"];
		_mag 		= "30Rnd_65x39_caseless_green";
		_xMag		= "10Rnd_50BW_Mag_F";
		_xMagCount	= 3;
		_magCount 	= _mags;
	};
	case "BIS_MSBS_SG": {
		_gun		= "arifle_MSBS65_UBS_black_F";
		_optic 		= selectRandom["optic_Aco"]; //"BWA3_optic_ZO4x30i_MicroT2"
		_light 		= "ACE_acc_pointer_green";
		_silencer 	= "no";//selectRandom["muzzle_snds_65_TI_blk_F","no"];
		_mag 		= "30Rnd_65x39_caseless_msbs_mag";
		_magCount 	= _mags;
		_xMag		= "ACE_6Rnd_12Gauge_Pellets_No0_Buck";
		_xMagCount	= 3;
	};
	case "SMA_SCAR_H_CQB": {
		_gun			= "SMA_Mk17_black";
		_optic 		= selectRandom["rhsusf_acc_eotech_xps3","rhsusf_acc_compm4","CUP_optic_CompM2_Black","SMA_eotech"]; //,"SMA_eotechG33_3XDOWN","iansky_specterdrkf_2D","SMA_ELCAN_SPECTER_RDS","SMA_eotech552_3XDOWN"
		_light 		= "FHQ_acc_LLM01L";
		_silencer 	= "no";//selectRandom["SMA_supp_762","no"];
		_mag 		= "SMA_20Rnd_762x51mm_M80A1_EPR";
		_magCount	= _mags;
	};
	case "RHS_SCAR_H_CQB": {
		_gun			= "rhs_weap_SCARH_CQC";
		_optic 		= selectRandom["rhsusf_acc_T1_high","rhsusf_acc_eotech_xps3","CUP_optic_CompM2_Black"]; //,"SMA_eotechG33_3XDOWN","iansky_specterdrkf_2D","SMA_ELCAN_SPECTER_RDS","SMA_eotech552_3XDOWN"
		_grip 			= "rhs_acc_grip_ffg2";
		_light 		= "FHQ_acc_LLM01L";
		_silencer 	= "no";//selectRandom["rhsusf_acc_aac_762sdn6_silencer","no"];
		_mag 		= "rhs_mag_20Rnd_SCAR_762x51_m80a1_epr_bk";
		_magCount	= _mags;
	};
	case "SMA_HK417_CQB": {
		_gun			= "SMA_HK417vfg";
		_optic 		= selectRandom["rhsusf_acc_eotech_xps3","RKSL_optic_EOT552","SMA_eotech","rhsusf_acc_compm4","CUP_optic_CompM2_Black"]; //,"SMA_eotechG33_3XDOWN","iansky_specterdrkf_2D","SMA_ELCAN_SPECTER_RDS","SMA_eotech552_3XDOWN"
		_light 		= "FHQ_acc_LLM01L";
		_silencer 	= "no";//selectRandom["SMA_supp_762","no"];
		_mag 		= "SMA_20Rnd_762x51mm_M80A1_EPR";
		_magCount	= _mags;
	};
	case "SMA_Tavor": {
		_gun		= "SMA_TavorBLK_F";
		_optic 		= selectRandom["iansky_cmore","rhsusf_acc_T1_high","rhsusf_acc_eotech_xps3","RKSL_optic_EOT552"]; //"BWA3_optic_ZO4x30i_MicroT2","SMA_ELCAN_SPECTER_RDS","SMA_eotech552_3XDOWN","SMA_eotechG33_3XDOWN"
		_light 		= "FHQ_acc_LLM01L";
		_silencer 	= "no";//selectRandom["SMA_supp1b_556","no"];
		_mag 		= "SMA_30Rnd_556x45_Mk318";
		_magCount 	= _mags;
	};
	case "BIS_HK416_CQB": {
		_gun		= "arifle_SPAR_01_blk_F";
		_optic 		= selectRandom["rhsusf_acc_T1_high"];
		_light 		= "FHQ_acc_LLM01L";
		_silencer 	= "no";//selectRandom["rhsusf_acc_nt4_black","no"];
		_mag 		= "ACE_30Rnd_556x45_Stanag_Mk318_mag";
		_magCount 	= _mags;
	};
	case "RHS_HK416_CQB": {
		_gun		= "rhs_weap_hk416d10_grip3";
		_optic 		= selectRandom["rhsusf_acc_eotech_xps3","rhsusf_acc_T1_high","CUP_optic_CompM2_Black"]; //"FHQ_optic_AimM_BLK","SMA_eotech552_3XDOWN","SMA_eotechG33_3XDOWN","SMA_ELCAN_SPECTER_RDS"
		_grip 		= "rhs_acc_grip_ffg2";
		_light 		= "FHQ_acc_LLM01L";
		_silencer 	= "no";//selectRandom["rhsusf_acc_nt4_black","no"];
		_mag 		= "ACE_30Rnd_556x45_Stanag_Mk318_mag";
		_magCount 	= _mags;
	};
	case "RHS_MK18": {
		_gun		= "rhs_weap_mk18_grip_KAC";
		_optic 		= selectRandom["SMA_eotech","RKSL_optic_EOT552","rhsusf_acc_compm4","rhsusf_acc_eotech_552","rhsusf_acc_T1_high","CUP_optic_CompM2_Black"]; //"rhsusf_acc_eotech_xps3","SMA_ELCAN_SPECTER_RDS"
		_grip 		= "rhs_acc_grip_ffg2";
		_light 		= "rhsusf_acc_anpeq15_bk";
		_silencer 	= "no";//selectRandom["rhsusf_acc_nt4_black","no"];
		_mag 		= "ACE_30Rnd_556x45_Stanag_Mk318_mag";
		_magCount 	= _mags;
	};
	case "RHS_G36C": {
		_gun		= "rhs_weap_g36c_grip3";
		_optic 		= selectRandom["rhsusf_acc_eotech_xps3","RKSL_optic_EOT552","rhsusf_acc_compm4","rhsusf_acc_T1_high"];
		_grip 		= "rhs_acc_grip_ffg2";
		_light 		= "FHQ_acc_LLM01F";
		_silencer 	= "no";//selectRandom["rhsusf_acc_nt4_black","no"];
		_mag 		= "rhssaf_30rnd_556x45_EPR_G36";
		_magCount 	= _mags;
	};
	case "RHS_AKS74U_Optic": {
		_gun		= "rhs_weap_aks74un";
		_optic 		= selectRandom["rhs_acc_1p63"];
		_silencer 	= selectRandom["rhs_acc_pgs64_74un"];
		_mag 		= "rhs_30Rnd_545x39_7N6M_AK";
		_magCount 	= _mags;
	};
	case "BIS_Tavor_C_Optic": {
		_gun			= "arifle_TRG20_F";
		_optic 		= selectRandom["rhsusf_acc_T1_high","rhsusf_acc_T1_low"];
		_light 		= selectRandom["SMA_SFFL_BLK"];
		_mag 		= "rhs_mag_30Rnd_556x45_M855A1_Stanag";
		_magCount	= _mags;
	};
	case "BIS_Tavor_C": {
		_gun			= "arifle_TRG20_F";
		//_optic 	= selectRandom["rhsusf_acc_T1_high","rhsusf_acc_T1_low","no","no"]; //"no",
		_light 		= selectRandom["SMA_SFFL_BLK"];
		_mag 		= "rhs_mag_30Rnd_556x45_M855A1_Stanag";
		_magCount	= _mags;
	};
	case "BIS_AKS74U": {
		_gun		= "arifle_AKS_F";
		_mag 		= "rhs_30Rnd_545x39_7N6M_plum_AK";
		_magCount 	= _mags;
	};
	case "RHS_AKS74U": {
		_gun		= "rhs_weap_aks74u";
		_silencer 	= selectRandom["rhs_acc_pgs64_74un"];
		_mag 		= "rhs_30Rnd_545x39_7N6M_AK";
		_magCount 	= _mags;
	};
	
	// Rifleman
	case "BIS_MSBS": {
		_gun		= "arifle_MSBS65_black_F";
		_optic 		= selectRandom["optic_Aco"]; //,"BWA3_optic_ZO4x30i_MicroT2"
		_light 		= "ACE_acc_pointer_green";
		_silencer 	= "no";//selectRandom["muzzle_snds_65_TI_blk_F","no"];
		_mag 		= "30Rnd_65x39_caseless_msbs_mag";
		_magCount 	= _mags;
	};
	case "RHS_SCAR_H": {
		_gun			= "rhs_weap_SCARH_STD";
		_optic 		= selectRandom["rhsusf_acc_T1_high","rhsusf_acc_eotech_xps3","CUP_optic_CompM2_Black"]; //"iansky_specterdrkf_2D" //"SMA_eotechG33_3XDOWN","SMA_ELCAN_SPECTER_RDS","SMA_eotech552_3XDOWN"
		_grip 			= "rhs_acc_grip_ffg2";
		_light 		= "FHQ_acc_LLM01L";
		_silencer 	= "no";//selectRandom["rhsusf_acc_aac_762sdn6_silencer","no"];
		_mag 		= "rhs_mag_20Rnd_SCAR_762x51_m80a1_epr_bk";
		_magCount	= _mags;
	};
	case "SMA_SCAR_H": {
		_gun			= "SMA_Mk17_16_black";
		_optic 		= selectRandom["rhsusf_acc_eotech_xps3","RKSL_optic_EOT552","SMA_eotech","CUP_optic_CompM2_Black"]; //"rhsusf_acc_compm4","SMA_eotechG33_3XDOWN","iansky_specterdrkf_2D","SMA_ELCAN_SPECTER_RDS","SMA_eotech552_3XDOWN"
		_light 		= "FHQ_acc_LLM01L";
		_silencer 	= "no";//selectRandom["SMA_supp_762","no"];
		_mag 		= "SMA_20Rnd_762x51mm_M80A1_EPR";
		_magCount	= _mags;
	};
	case "SMA_HK417": {
		_gun			= "SMA_HK417_16in";
		_optic 		= selectRandom["rhsusf_acc_eotech_xps3","RKSL_optic_EOT552","SMA_eotech","CUP_optic_CompM2_Black"]; //"rhsusf_acc_compm4","SMA_eotechG33_3XDOWN","iansky_specterdrkf_2D","SMA_ELCAN_SPECTER_RDS","SMA_eotech552_3XDOWN"
		_light 		= "FHQ_acc_LLM01L";
		_silencer 	= "no";//selectRandom["SMA_supp_762","no"];
		_mag 		= "SMA_20Rnd_762x51mm_M80A1_EPR";
		_magCount	= _mags;
	};
	case "RHS_HK416": {
		_gun		= "rhs_weap_hk416d145";
		_optic 		= selectRandom["rhsusf_acc_eotech_xps3","rhsusf_acc_T1_high","CUP_optic_CompM2_Black"]; //"FHQ_optic_AimM_BLK","SMA_eotech552_3XDOWN","SMA_eotechG33_3XDOWN","SMA_ELCAN_SPECTER_RDS"
		_grip 		= "rhs_acc_grip_ffg2";
		_light 		= "FHQ_acc_LLM01L";
		_silencer 	= "no";//selectRandom["rhsusf_acc_nt4_black","no"];
		_mag 		= "ACE_30Rnd_556x45_Stanag_Mk318_mag";
		_magCount 	= _mags;
	};
	case "RHS_M4_BII": {
		_gun		= "rhs_weap_m4a1_blockII";
		_optic 		= selectRandom["rhsusf_acc_eotech_552","rhsusf_acc_compm4"];
		_grip 		= "rhs_acc_grip_ffg2";
		_light 		= selectRandom["rhsusf_acc_anpeq15_bk"];
		_silencer 	= "no";
		_mag 		= "ACE_30Rnd_556x45_Stanag_Mk318_mag";
		_magCount 	= _mags;
	};
	case "RHS_AK74_UUK": {
		_gun		= "rhs_weap_ak74mr";
		_optic 		= selectRandom["SMA_eotech","CUP_optic_CompM2_Black","rhsusf_acc_T1_high"]; //"FHQ_optic_AimM_BLK","SMA_ELCAN_SPECTER_RDS","SMA_eotechG33_3XDOWN"
		_grip 		= "rhs_acc_grip_ffg2";
		_light 		= selectRandom["rhs_acc_perst3_2dp_h","rhs_acc_perst3"];
		_silencer 	= "rhs_acc_uuk";//selectRandom["rhs_acc_dtk4short","rhs_acc_uuk"];
		_mag 		= "rhs_30Rnd_545x39_7N22_AK";
		_magCount 	= _mags;
	};
	case "RHS_AK103_B33": {
		_gun		= "rhs_weap_ak103_zenitco01_b33_grip1";
		_optic 		= selectRandom["SMA_eotech","CUP_optic_CompM2_Black","rhsusf_acc_T1_high"]; //"FHQ_optic_AimM_BLK","SMA_ELCAN_SPECTER_RDS","SMA_eotechG33_3XDOWN"
		_grip 		= "rhs_acc_grip_ffg2";
		_light 		= selectRandom["rhs_acc_perst3_2dp_h","rhs_acc_perst3"];
		_silencer 	= "rhs_acc_dtk";//selectRandom["rhs_acc_dtk4long","rhs_acc_dtk"];
		_mag 		= "rhs_30Rnd_762x39mm_polymer";
		_magCount 	= _mags;
	};
	case "RHS_G36": {
		_gun			= "rhs_weap_g36kv_grip3";
		_optic 		= selectRandom["rhsusf_acc_T1_high","CUP_optic_CompM2_Black"];
		_grip 			= "rhs_acc_grip_ffg2";
		_light 		= "FHQ_acc_LLM01L";
		_mag 		= "rhssaf_30rnd_556x45_EPR_G36";
		_magCount	= _mags;
	};
	case "RHS_M4A1": {
		_gun		= "rhs_weap_m4a1_carryhandle";
		_optic 		= selectRandom["rhsusf_acc_eotech_552","rhsusf_acc_compm4","no","no"]; //,"rhsusf_acc_ACOG"
		_grip 		= "rhs_acc_grip_ffg2";
		_light 		= selectRandom["SMA_SFFL_BLK"]; //"rhsusf_acc_anpeq15_bk",
		_silencer 	= "no";//selectRandom["rhsusf_acc_nt4_black","no"];
		_mag 		= "rhs_mag_30Rnd_556x45_M855A1_Stanag";
		_magCount 	= _mags;
	};
	case "BIS_Tavor": {
		_gun		= "arifle_TRG21_F";
		_optic 		= selectRandom["rhsusf_acc_T1_high","rhsusf_acc_T1_low","no","no"]; //"no",
		_light 		= selectRandom["SMA_SFFL_BLK"];
		_silencer 	= "no";//selectRandom["no"];
		_mag 		= "rhs_mag_30Rnd_556x45_M855A1_Stanag";
		_magCount 	= _mags;
	};
	case "RHS_AK74M": {
		_gun		= selectRandom["rhs_weap_ak74m","rhs_weap_ak74m_camo","rhs_weap_ak74m_desert"];
		_light 		= selectRandom["rhs_acc_2dpZenit"];
		_silencer 	= selectRandom["rhs_acc_dtk"];
		_mag 		= "rhs_30Rnd_545x39_7N10_AK";
		_magCount 	= _mags;
	};
	case "RHS_AK103": {
		_gun		= "rhs_weap_ak103";
		_light 		= selectRandom["rhs_acc_2dpZenit"];
		_silencer 	= selectRandom["rhs_acc_dtk"];
		_mag 		= "rhs_30Rnd_762x39mm_polymer";
		_magCount 	= _mags;
	};
	case "RHS_M16": {
		_gun		= "rhs_weap_m16a4_carryhandle";
		_optic 		= selectRandom["no"]; //"rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_ACOG"
		_grip 		= "rhsusf_acc_grip2";
		_light 		= selectRandom["SMA_SFFL_BLK"];
		_silencer 	= "no";//selectRandom["rhsusf_acc_nt4_black","no"];
		_mag 		= "rhs_mag_30Rnd_556x45_M855A1_Stanag";
		_magCount 	= _mags;
	};
	case "RHS_M14": {
		_gun		= "rhs_weap_m14";
		_mag 		= "rhsusf_20Rnd_762x51_m80_Mag";
		_magCount 	= round(_mags * 1.5);
	};
	case "RHS_FAL": {
		_gun		= "rhs_weap_l1a1_wood";
		_mag 		= "rhs_mag_20Rnd_762x51_m80_fnfal";
		_magCount 	= round(_mags * 1.5);
	};
	case "RHS_Garand": {
		_gun			= "rhs_weap_m1garand_sa43";
		_mag 		= "rhsgref_8Rnd_762x63_M2B_M1rifle";
		_magCount = round(_mags * 1.4);
	};
	case "RHS_AKM": {
		_gun		= "rhs_weap_akm";
		_mag 		= "rhs_30Rnd_762x39mm";
		_magCount 	= _mags;
	};
	case "RHS_K98": {
		_gun			= "rhs_weap_kar98k";
		_mag 		= "rhsgref_5Rnd_792x57_kar98k";
		_magCount	= round(_mags * 6);
	};
	
	//GL
	case "BIS_MSBS_GL": {
		_gun		= "arifle_MSBS65_GL_black_F";
		_optic 		= selectRandom["optic_Aco"]; //,"BWA3_optic_ZO4x30i_MicroT2"
		_light 		= "ACE_acc_pointer_green";
		_silencer 	= "no";//selectRandom["muzzle_snds_65_TI_blk_F","no"];
		_mag 		= "30Rnd_65x39_caseless_msbs_mag";
		_magCount 	= _mags;
		_xMag		= "1Rnd_HE_Grenade_shell";
		_xMagCount	= _glMags;
	};
	case "RHS_HK416_GL": {
		_gun		= "rhs_weap_hk416d145_m320";
		_optic 		= selectRandom["rhsusf_acc_eotech_xps3","rhsusf_acc_T1_high","CUP_optic_CompM2_Black"]; //"FHQ_optic_AimM_BLK",,"SMA_eotech552_3XDOWN","SMA_eotechG33_3XDOWN","SMA_ELCAN_SPECTER_RDS"
		_light 		= "FHQ_acc_LLM01L";
		_silencer 	= "no";//selectRandom["rhsusf_acc_nt4_black","no"];
		_mag 		= "ACE_30Rnd_556x45_Stanag_Mk262_mag";
		_magCount 	= _mags;
		_xMag		= "1Rnd_HE_Grenade_shell";
		_xMagCount	= _glMags;
	};
	case "SMA_SCAR_H_CQB_GL": {
		_gun		= "SMA_MK17_EGLM_black";
		_optic 		= selectRandom["rhsusf_acc_eotech_xps3","rhsusf_acc_T1_high"]; //,"CUP_optic_CompM2_Black","FHQ_optic_AimM_BLK",,"SMA_eotech552_3XDOWN","SMA_eotechG33_3XDOWN","SMA_ELCAN_SPECTER_RDS"
		_light 		= "FHQ_acc_LLM01L";
		_silencer 	= "no";//selectRandom["rhsusf_acc_nt4_black","no"];
		_mag 		= "SMA_20Rnd_762x51mm_M80A1_EPR";
		_magCount 	= _mags;
		_xMag		= "1Rnd_HE_Grenade_shell";
		_xMagCount	= _glMags;
	};
	case "RHS_HK416_CQB_GL": {
		_gun		= "rhs_weap_hk416d10_m320";
		_optic 		= selectRandom["rhsusf_acc_eotech_xps3","rhsusf_acc_T1_high","CUP_optic_CompM2_Black"];
		_light 		= "FHQ_acc_LLM01L";
		_silencer 	= "no";//selectRandom["rhsusf_acc_nt4_black","no"];
		_mag 		= "ACE_30Rnd_556x45_Stanag_Mk262_mag";
		_magCount 	= _mags;
		_xMag		= "1Rnd_HE_Grenade_shell";
		_xMagCount	= _glMags;
	};
	case "RHS_MK18_GL": {
		_gun		= "rhs_weap_mk18_m320";
		_optic 		= selectRandom["rhsusf_acc_compm4","rhsusf_acc_T1_high","CUP_optic_CompM2_Black","SMA_eotech"];
		_light 		= "FHQ_acc_LLM01L";
		_silencer 	= "no";//selectRandom["rhsusf_acc_nt4_black","no"];
		_mag 		= "ACE_30Rnd_556x45_Stanag_Mk262_mag";
		_magCount 	= _mags;
		_xMag		= "1Rnd_HE_Grenade_shell";
		_xMagCount	= _glMags;
	};
	case "BIS_HK416_CQB_GL": {
		_gun		= "arifle_SPAR_01_GL_blk_F";
		_optic 		= selectRandom["rhsusf_acc_T1_high"];
		_light 		= "FHQ_acc_LLM01L";
		_silencer 	= "no";//selectRandom["rhsusf_acc_nt4_black","no"];
		_mag 		= "ACE_30Rnd_556x45_Stanag_Mk262_mag";
		_magCount 	= _mags;
		_xMag		= "1Rnd_HE_Grenade_shell";
		_xMagCount	= _glMags;
	};
	case "RHS_AK74_UUK_GL": {
		_gun		= "rhs_weap_ak74mr_gp25";
		_optic 		= selectRandom["SMA_eotech","CUP_optic_CompM2_Black","rhsusf_acc_T1_high"]; //"SMA_eotech552","RKSL_optic_EOT552","FHQ_optic_AimM_BLK","SMA_ELCAN_SPECTER_RDS","SMA_eotechG33_3XDOWN",
		_light 		= "FHQ_acc_LLM01L";
		_silencer 	= "rhs_acc_uuk";//selectRandom["rhs_acc_dtk4short","rhs_acc_uuk"];
		_mag 		= "rhs_30Rnd_545x39_7N22_AK";
		_magCount 	= _mags;
		_xMag		= "rhs_VOG25";
		_xMagCount	= _glMags;
	};
	case "RHS_M4A1_M320": {
		_gun		= "rhs_weap_m4a1_m320";
		_optic 		= selectRandom["rhsusf_acc_eotech_552","rhsusf_acc_compm4"]; //,"rhsusf_acc_ACOG"
		_light 		= selectRandom["SMA_SFFL_BLK"]; //"rhsusf_acc_anpeq15_bk"
		_mag 		= "rhs_mag_30Rnd_556x45_M855A1_Stanag";
		_magCount 	= _mags;
		_xMag		= "1Rnd_HE_Grenade_shell";
		_xMagCount	= _glMags;
	};
	case "RHS_AK103_B13_GL": {
		_gun		= "rhs_weap_ak103_gp25_npz";
		_optic 		= selectRandom["SMA_eotech","CUP_optic_CompM2_Black","rhsusf_acc_T1_high"]; //"SMA_eotech552","RKSL_optic_EOT552","FHQ_optic_AimM_BLK","SMA_ELCAN_SPECTER_RDS","SMA_eotechG33_3XDOWN",
		_silencer 	= "rhs_acc_dtk";//selectRandom["rhs_acc_dtk4long","rhs_acc_dtk"];
		_mag 		= "rhs_30Rnd_762x39mm_polymer";
		_magCount 	= _mags;
		_xMag		= "rhs_VOG25";
		_xMagCount	= _glMags;
	};
	case "RHS_G36_GL": {
		_gun				= "rhs_weap_g36kv_ag36";
		_optic 			= selectRandom["rhsusf_acc_T1_high","CUP_optic_CompM2_Black"];
		_light 			= "FHQ_acc_LLM01L";
		_mag 			= "rhssaf_30rnd_556x45_EPR_G36";
		_magCount 	= _mags;
		_xMag			= "1Rnd_HE_Grenade_shell";
		_xMagCount	= _glMags;
	};
	case "BIS_Tavor_GL": {
		_gun		= "arifle_TRG21_GL_F";
		_optic 		= selectRandom["rhsusf_acc_T1_high","rhsusf_acc_T1_low"];
		_light 		= selectRandom["SMA_SFFL_BLK"];
		_mag 		= "rhs_mag_30Rnd_556x45_M855A1_Stanag";
		_magCount 	= _mags;
		_xMag		= "1Rnd_HE_Grenade_shell";
		_xMagCount	= _glMags;
	};
	case "RHS_AK74M_GL": {
		_gun		= "rhs_weap_ak74m_gp25";
		_optic 		= selectRandom["no"];
		_silencer 	= selectRandom["rhs_acc_dtk"];
		_mag 		= "rhs_30Rnd_545x39_7N10_AK";
		_magCount 	= _mags;
		_xMag		= "rhs_VOG25";
		_xMagCount	= _glMags;
	};
	case "RHS_AK103_GL": {
		_gun		= "rhs_weap_ak103_gp25";
		_optic 		= selectRandom["no"];
		_silencer 	= selectRandom["rhs_acc_dtk"];
		_mag 		= "rhs_30Rnd_762x39mm_polymer";
		_magCount 	= _mags;
		_xMag		= "rhs_VOG25";
		_xMagCount	= _glMags;
	};
	case "RHS_M4A1_M203": {
		_gun				= "rhs_weap_m4a1_carryhandle_m203";
		_light 			= selectRandom["SMA_SFFL_BLK"];
		_mag 			= "rhs_mag_30Rnd_556x45_M855A1_Stanag";
		_magCount 	= _mags;
		_xMag			= "1Rnd_HE_Grenade_shell";
		_xMagCount	= _glMags;
	};
	case "RHS_M16_GL": {
		_gun				= "rhs_weap_m16a4_carryhandle_M203";
		_light 			= selectRandom["SMA_SFFL_BLK"];
		_mag 			= "rhs_mag_30Rnd_556x45_M855A1_Stanag";
		_magCount 	= _mags;
		_xMag			= "1Rnd_HE_Grenade_shell";
		_xMagCount	= _glMags;
	};
	case "RHS_AKM_GL": {
		_gun		= "rhs_weap_akm_gp25";
		_silencer 	= selectRandom["rhs_acc_dtkakm"];
		_mag 		= "rhs_30Rnd_762x39mm";
		_magCount 	= _mags;
		_xMag		= "rhs_VOG25";
		_xMagCount	= _glMags;
	};
	
	//MG
	case "BIS_LWMMG": {
		_gun		= "MMG_02_black_F";
		_optic 		= selectRandom["SMA_ELCAN_SPECTER_RDS","rhsusf_acc_eotech_xps3","rhsusf_acc_ELCAN"];
		_grip 		= "bipod_01_F_blk";
		_light 		= "SMA_ANPEQ15_BLK";
		_mag 		= "130Rnd_338_Mag";
		_magCount 	= round(_mags / 4.3);
	};
	case "BIS_HK121": {
		_gun		= "MMG_01_tan_F";
		_optic 		= selectRandom["FHQ_optic_AimM_BLK","SMA_ELCAN_SPECTER_RDS","rhsusf_acc_ELCAN","rhsusf_acc_eotech_xps3"];
		_grip 		= "bipod_01_F_blk";
		_light 		= "SMA_ANPEQ15_BLK";
		_mag 		= "150Rnd_93x64_Mag";
		_magCount 	= round(_mags / 5);
	};
	case "RHS_M240": {
		_gun			= "rhs_weap_m240B";
		_optic 		= selectRandom["rhsusf_acc_eotech_552","rhsusf_acc_compm4"]; //,"rhsusf_acc_ELCAN"
		_light 		= selectRandom["FHQ_acc_LLM01L","SMA_SFFL_BLK"];
		_mag 		= "rhsusf_100Rnd_762x51_m80a1epr";
		_magCount = round(_mags / 4);
	};
	case "RHS_M249": {
		_gun			= "rhs_weap_m249_pip_S_vfg2";
		_optic 		= selectRandom["rhsusf_acc_eotech_552","rhsusf_acc_compm4"]; //,"rhsusf_acc_ELCAN"
		_light 		= selectRandom["FHQ_acc_LLM01L","SMA_SFFL_BLK"];
		_grip 			= "rhsusf_acc_grip4_bipod";
		_mag 		= "rhsusf_200rnd_556x45_mixed_box";
		_magCount = round(_mags / 5);
	};
	case "RHS_PKP": {
		_gun			= "rhs_weap_pkp";
		_optic 		= selectRandom["rhs_acc_pkas"]; //,"rhs_acc_1p78","rhs_acc_1p63"
		_mag 		= "rhs_100Rnd_762x54mmR";
		_magCount = round(_mags / 4);
	};
	case "BIS_Negev": {
		_gun			= "LMG_Zafir_F";
		_optic 		= selectRandom["no","rhsusf_acc_RX01_NoFilter"];
		_light 		= selectRandom["rhsusf_acc_anpeq15side","SMA_SFFL_BLK"];
		_mag 		= "150Rnd_762x54_Box";
		_magCount = round(_mags / 4);
	};
	case "RHS_MG42_300": {
		_gun				= "rhs_weap_mg42";
		_mag 			= "rhsgref_296Rnd_792x57_SmE_belt";
		_magCount 	= 1;
	};
	case "RHS_PKM": {
		_gun			= "rhs_weap_pkm";
		_mag 		= "rhs_100Rnd_762x54mmR";
		_magCount = round(_mags / 3);
	};
	case "RHS_MG42": {
		_gun			= "rhs_weap_mg42";
		_mag 		= "rhsgref_50Rnd_792x57_SmE_drum";
		_magCount = round(_mags / 1.5);
	};
	/*
	case "RHS_PM63": {
		_gun		= "rhs_weap_pm63";
		_mag 		= "rhs_75Rnd_762x39mm";
		_magCount 	= round(_mags / 2.5);
	};
	*/
	
	//DMR
	case "BIS_Cyrus": {
		_gun			= "srifle_DMR_05_tan_f";
		_optic 		= selectRandom["BWA3_optic_PMII_DMR_MicroT1_front"]; //"BWA3_optic_PMII_ShortdotCC","ACE_optic_LRPS_2D","BWA3_optic_PMII_DMR_MicroT1_front","optic_KHS_tan","BWA3_optic_M5Xi_Tremor3_MicroT2","rhsusf_acc_M8541_d"
		_grip 			= "bipod_01_F_blk";
		_light 		= "rhsusf_acc_anpeq15side";
		_silencer 	= "no";//selectRandom["muzzle_snds_93mmg_tan","no"];
		_mag 		= "10Rnd_93x64_DMR_05_Mag";
		_magCount	= round(_mags / 1.5);
		_spcItems 	= ["ACE_RangeCard","ACE_Kestrel4500","ACE_ATragMX"];
		
		//Vector Secondary
		_gunSec				= "SMG_01_F";
		_opticSec 			= selectRandom["rhsusf_acc_T1_high","rhsusf_acc_T1_low","rhsusf_acc_mrds"]; //"CUP_optic_CompM2_Black","RKSL_optic_EOT552"
		_lightSec 			= "acc_flashlight_smg_01";
		//_silencerSec		= selectRandom["muzzle_snds_acp","no"];
		_magSec			= "30Rnd_45ACP_Mag_SMG_01";
		_magSecCount	= _mags;
	};
	case "RHS_MK11": {
		_gun			= "rhs_weap_sr25";
		_optic 		= selectRandom["optic_KHS_blk"]; //"optic_AMS","ACE_optic_LRPS_2D","optic_KHS_blk"
		_grip 			= "bipod_01_F_blk";
		_light 		= "rhs_acc_perst1ik_ris";
		_silencer 	= "no";//selectRandom["rhsusf_acc_SR25S","no"];
		_mag 		= "rhsusf_20Rnd_762x51_SR25_mk316_special_Mag";
		_magCount	= round(_mags / 1.5);
		_spcItems 	= ["ACE_RangeCard","ACE_Kestrel4500","ACE_ATragMX"];
		
		/*
		//P90 Secondary
		_gunSec				= "SMG_03C_TR_khaki";
		_opticSec 			= selectRandom["rhsusf_acc_mrds","rhsusf_acc_T1_low"];
		//_silencerSec 		= selectRandom["muzzle_snds_570","no"];
		_magSec 			= "50Rnd_570x28_SMG_03";
		_magSecCount	= round(_mags / 1.7);
		*/
		
		//Vector Secondary
		_gunSec				= "SMG_01_F";
		_opticSec 			= selectRandom["rhsusf_acc_T1_high","rhsusf_acc_T1_low","rhsusf_acc_mrds"]; //"CUP_optic_CompM2_Black","RKSL_optic_EOT552"
		_lightSec 			= "acc_flashlight_smg_01";
		//_silencerSec		= selectRandom["muzzle_snds_acp","no"];
		_magSec			= "30Rnd_45ACP_Mag_SMG_01";
		_magSecCount	= _mags;
	};
	case "SMA_SCAR_H_DMR": {
		_gun			= "SMA_Mk17_16_black";
		_optic 		= selectRandom["optic_AMS"];
		_grip 			= "bipod_01_F_blk";
		_light 		= "FHQ_acc_LLM01L";
		_silencer 	= "no";//selectRandom["SMA_supp_762","no"];
		_mag 		= "SMA_20Rnd_762x51mm_Mk316_Mod_0_Special_Long_Range";
		_magCount	= round(_mags / 1.5);
		_spcItems 	= ["ACE_RangeCard","ACE_Kestrel4500","ACE_ATragMX"];
		
		/*
		//P90 Secondary
		_gunSec				= "SMG_03C_TR_khaki";
		_opticSec 			= selectRandom["rhsusf_acc_mrds","rhsusf_acc_T1_low"];
		//_silencerSec 		= selectRandom["muzzle_snds_570","no"];
		_magSec 			= "50Rnd_570x28_SMG_03";
		_magSecCount	= round(_mags / 1.7);
		*/
		
		//MP7 Secondary
		_gunSec				= "rhsusf_weap_MP7A2";
		_opticSec 			= selectRandom["rhsusf_acc_T1_high","rhsusf_acc_T1_low","rhsusf_acc_mrds"]; //"CUP_optic_CompM2_Black","rhsusf_acc_eotech_xps3","RKSL_optic_EOT552"
		_gripSec 			= "rhs_acc_grip_ffg2";
		_lightSec 			= "FHQ_acc_LLM01F";
		//_silencerSec 		= selectRandom["rhsusf_acc_rotex_mp7","no"];
		_magSec 			= "rhsusf_mag_40Rnd_46x30_FMJ";
		_magSecCount	= round(_mags / 1.3);
	};
	case "SMA_HK417_DMR": {
		_gun			= "SMA_HK417_16in";
		_optic 		= selectRandom["optic_AMS"];
		_grip 			= "bipod_01_F_blk";
		_light 		= "FHQ_acc_LLM01F";
		_silencer 	= "no";//selectRandom["SMA_supp_762","no"];
		_mag 		= "SMA_20Rnd_762x51mm_Mk316_Mod_0_Special_Long_Range";
		_magCount	= round(_mags / 1.5);
		_spcItems 	= ["ACE_RangeCard","ACE_Kestrel4500","ACE_ATragMX"];
		
		/*
		//P90 Secondary
		_gunSec				= "SMG_03C_TR_khaki";
		_opticSec 			= selectRandom["rhsusf_acc_mrds","rhsusf_acc_T1_low"];
		//_silencerSec 		= selectRandom["muzzle_snds_570","no"];
		_magSec 			= "50Rnd_570x28_SMG_03";
		_magSecCount	= round(_mags / 1.7);
		*/
		
		//MP7 Secondary
		_gunSec				= "rhsusf_weap_MP7A2";
		_opticSec 			= selectRandom["rhsusf_acc_T1_high","rhsusf_acc_T1_low","rhsusf_acc_mrds"]; //"CUP_optic_CompM2_Black","rhsusf_acc_eotech_xps3","RKSL_optic_EOT552"
		_gripSec 			= "rhs_acc_grip_ffg2";
		_lightSec 			= "FHQ_acc_LLM01F";
		//_silencerSec 		= selectRandom["rhsusf_acc_rotex_mp7","no"];
		_magSec 			= "rhsusf_mag_40Rnd_46x30_FMJ";
		_magSecCount	= round(_mags / 1.3);
	};
	case "RHS_SCAR_H_DMR": {
		_gun			= "rhs_weap_SCARH_LB";
		_optic 		= selectRandom["optic_AMS"];
		_grip 			= "bipod_01_F_blk";
		_light 		= "rhs_acc_perst1ik_ris";
		_silencer 	= "no";//selectRandom["rhsusf_acc_aac_762sdn6_silencer","no"];
		_mag 		= "rhs_mag_20Rnd_SCAR_762x51_mk316_special_bk";
		_magCount	= round(_mags / 1.5);
		_spcItems 	= ["ACE_RangeCard","ACE_Kestrel4500","ACE_ATragMX"];
		
		/*
		//P90 Secondary
		_gunSec				= "SMG_03C_TR_khaki";
		_opticSec 			= selectRandom["rhsusf_acc_mrds","rhsusf_acc_T1_low"];
		//_silencerSec 		= selectRandom["muzzle_snds_570","no"];
		_magSec 			= "50Rnd_570x28_SMG_03";
		_magSecCount	= round(_mags / 1.7);
		*/
		
		//MP7 Secondary
		_gunSec				= "rhsusf_weap_MP7A2";
		_opticSec 			= selectRandom["rhsusf_acc_T1_high","rhsusf_acc_T1_low","rhsusf_acc_mrds"]; //"CUP_optic_CompM2_Black","rhsusf_acc_eotech_xps3","RKSL_optic_EOT552"
		_gripSec 			= "rhs_acc_grip_ffg2";
		_lightSec 			= "FHQ_acc_LLM01F";
		//_silencerSec 		= selectRandom["rhsusf_acc_rotex_mp7","no"];
		_magSec 			= "rhsusf_mag_40Rnd_46x30_FMJ";
		_magSecCount	= round(_mags / 1.3);
	};
	case "BIS_HK417": {
		_gun			= "arifle_SPAR_03_blk_F";
		_optic 		= selectRandom["optic_AMS"]; //"optic_KHS_blk"
		_grip 			= "bipod_01_F";
		_light 		= "SMA_ANPEQ15_BLK";
		_silencer 	= "no";//selectRandom["no"];
		_mag 		= "ACE_20Rnd_762x51_Mk316_Mod_0_Mag";
		_magCount	= round(_mags / 1.5);
		_spcItems 	= ["ACE_RangeCard","ACE_Kestrel4500","ACE_ATragMX"];
		
		/*
		//P90 Secondary
		_gunSec				= "SMG_03C_TR_khaki";
		_opticSec 			= selectRandom["rhsusf_acc_mrds","rhsusf_acc_T1_low"];
		//_silencerSec 		= selectRandom["muzzle_snds_570","no"];
		_magSec 			= "50Rnd_570x28_SMG_03";
		_magSecCount	= round(_mags / 1.7);
		*/
		
		//MP7 Secondary
		_gunSec				= "rhsusf_weap_MP7A2";
		_opticSec 			= selectRandom["rhsusf_acc_T1_high","rhsusf_acc_T1_low","rhsusf_acc_mrds"]; //"CUP_optic_CompM2_Black","rhsusf_acc_eotech_xps3","RKSL_optic_EOT552"
		_gripSec 			= "rhs_acc_grip_ffg2";
		_lightSec 			= "FHQ_acc_LLM01F";
		//_silencerSec 		= selectRandom["rhsusf_acc_rotex_mp7","no"];
		_magSec 			= "rhsusf_mag_40Rnd_46x30_FMJ";
		_magSecCount	= round(_mags / 1.3);
	};
	case "BIS_SG556": {
		_gun			= "srifle_DMR_03_F";
		_optic 		= selectRandom["rhsusf_acc_su230a"]; //"optic_KHS_blk","optic_AMS","optic_DMS","BWA3_optic_ZO4x30i_MicroT2"
		_grip 			= "rhsusf_acc_harris_bipod";
		_light 		= "rhsusf_acc_anpeq15A";
		_silencer 	= "no";//selectRandom["no"];
		_mag 		= "ACE_20Rnd_762x51_Mk316_Mod_0_Mag";
		_magCount	= round(_mags / 1.5);
		//_spcItems 	= ["ACE_RangeCard"];
		
		//Scorpion Evo Secondary
		_gunSec				= "SMG_02_F";
		_opticSec 			= selectRandom["rhsusf_acc_T1_high","rhsusf_acc_T1_low","rhsusf_acc_mrds"];
		_lightSec 			= "no";
		_silencerSec 		= "no";
		_magSec 			= "30Rnd_9x21_Mag_SMG_02";
		_magSecCount	= _mags;
	};
	case "RHS_M14_EBR": {
		_gun			= "rhs_weap_m14ebrri";
		_optic 		= "rhsusf_acc_ACOG_RMR"; //"rhsusf_acc_LEUPOLDMK4"
		_grip 			= "rhsusf_acc_harris_bipod";
		_light 		= "rhs_acc_perst1ik_ris";
		_mag 		= "rhsusf_20Rnd_762x51_m118_special_Mag";
		_magCount	= round(_mags / 1.5);
		//_spcItems 	= ["ACE_RangeCard"];
		
		//MP7 Secondary
		_gunSec				= "rhsusf_weap_MP7A2";
		_opticSec 			= selectRandom["rhsusf_acc_T1_high","rhsusf_acc_T1_low","rhsusf_acc_mrds"]; //"CUP_optic_CompM2_Black","rhsusf_acc_eotech_xps3","RKSL_optic_EOT552"
		_gripSec 			= "rhs_acc_grip_ffg2";
		_lightSec 			= "FHQ_acc_LLM01F";
		_silencerSec 		= selectRandom["rhsusf_acc_rotex_mp7","no"];
		_magSec 			= "rhsusf_mag_40Rnd_46x30_FMJ";
		_magSecCount	= round(_mags / 1.3);
	};
	case "RHS_SVDM": {
		_gun			= "rhs_weap_svds_npz";
		_optic 		= "rhsusf_acc_ACOG3"; //rhs_acc_pso1m2
		_silencer 	= "no";//"no";
		_mag 		= "rhs_10Rnd_762x54mmR_7N1";
		_magCount	= round(_mags / 1.5);
		//_spcItems 	= ["ACE_RangeCard"];
		
		//VAL Secondary
		_gunSec				= "rhs_weap_asval_grip";
		_opticSec 			= selectRandom["no","rhs_acc_pkas"];
		_gripSec 			= "rhs_acc_grip_ffg2";
		_lightSec 			= "no";
		_magSec 			= "rhs_20rnd_9x39mm_SP5";
		_magSecCount	= round(_mags * 1.5);
	};
	case "RHS_M76": {
		_gun			= "rhs_weap_m76";
		_optic 		= "rhs_acc_1p78"; //rhs_acc_pso1m2
		_silencer 	= "no";//"no";
		_mag 		= "rhsgref_10Rnd_792x57_m76";
		_magCount	= round(_mags / 1.5);
		//_spcItems 	= ["ACE_RangeCard"];
		
		//MP5 Secondary
		_gunSec				= "SMG_05_F";
		_opticSec 			= selectRandom["no","no","optic_Aco","rhsusf_acc_RX01_NoFilter"];
		_lightSec 			= "no";
		_silencerSec 		= "no";
		_magSec 			= "30Rnd_9x21_Mag_SMG_02";
		_magSecCount	= _mags;
	};
	
/*
"rhsusf_acc_ACOG2"
"rhsusf_acc_ACOG_USMC"
"ACE_optic_Hamr_2D"
"iansky_specterdrkf_2D"
"rhsusf_acc_su230"
"sma_spitfire_03_rds_low_black"
*/
	
	//Sniper
	case "BIS_M200": {
		_gun			= "srifle_LRR_camo_F";
		_optic 		= selectRandom["ACE_optic_LRPS_2D","rhsusf_acc_M8541_d"];
		_mag 		= "7Rnd_408_Mag";
		_magCount = 6;
		_spcItems 	= ["ACE_RangeCard","ACE_Kestrel4500","ACE_ATragMX"];
		
		//Vector Secondary
		_gunSec			= "SMG_01_F";
		_opticSec 		= selectRandom["rhsusf_acc_T1_high","rhsusf_acc_T1_low","rhsusf_acc_mrds"]; //,"CUP_optic_CompM2_Black","RKSL_optic_EOT552"
		_lightSec 		= "acc_flashlight_smg_01";
		//_silencerSec	= selectRandom["muzzle_snds_acp","no"];
		_magSec		= "30Rnd_45ACP_Mag_SMG_01";
		_magSecCount= _mags;
	};
	case "BIS_GM6": {
		_gun			= "srifle_GM6_F";
		_optic 		= selectRandom["rhsusf_acc_premier"];
		_mag 		= "ACE_5Rnd_127x99_AMAX_Mag";
		_magCount = 9;
		_spcItems 	= ["ACE_RangeCard","ACE_Kestrel4500","ACE_ATragMX"];
		
		//Vector Secondary
		_gunSec			= "SMG_01_F";
		_opticSec 		= selectRandom["rhsusf_acc_T1_high","rhsusf_acc_T1_low","rhsusf_acc_mrds"]; //,"CUP_optic_CompM2_Black","RKSL_optic_EOT552"
		_lightSec 		= "acc_flashlight_smg_01";
		//_silencerSec	= selectRandom["muzzle_snds_acp","no"];
		_magSec			= "30Rnd_45ACP_Mag_SMG_01";
		_magSecCount 	= _mags;
	};
	case "RHS_M107": {
		_gun			= "rhs_weap_M107";
		_optic 		= selectRandom["rhsusf_acc_premier"];
		_mag 		= "ACE_5Rnd_127x99_AMAX_Mag";
		_magCount	= 9;
		_spcItems 	= ["ACE_RangeCard","ACE_Kestrel4500","ACE_ATragMX"];
		
		//Vector Secondary
		_gunSec			= "SMG_01_F";
		_opticSec 		= selectRandom["rhsusf_acc_T1_high","rhsusf_acc_T1_low","rhsusf_acc_mrds"]; //,"CUP_optic_CompM2_Black","RKSL_optic_EOT552"
		_lightSec 		= "acc_flashlight_smg_01";
		//_silencerSec	= selectRandom["muzzle_snds_acp","no"];
		_magSec			= "30Rnd_45ACP_Mag_SMG_01";
		_magSecCount 	= _mags;
	};
	case "RHS_T5000": {
		_gun			= "rhs_weap_t5000";
		_optic 		= selectRandom["rhsusf_acc_M8541_low"];
		_grip 			= "rhsusf_acc_harris_bipod";
		_mag 		= "rhs_5Rnd_338lapua_t5000";
		_magCount	= 8;
		_spcItems 	= ["ACE_RangeCard","ACE_Kestrel4500","ACE_ATragMX"];
		
		/*
		//P90 Secondary
		_gunSec				= "SMG_03C_TR_khaki";
		_opticSec 			= selectRandom["rhsusf_acc_mrds","rhsusf_acc_T1_low"];
		//_silencerSec 		= selectRandom["muzzle_snds_570","no"];
		_magSec 			= "50Rnd_570x28_SMG_03";
		_magSecCount	= round(_mags / 1.7);
		*/
		
		//MP7 Secondary
		_gunSec				= "rhsusf_weap_MP7A2";
		_opticSec 			= selectRandom["rhsusf_acc_T1_high","rhsusf_acc_T1_low","rhsusf_acc_mrds"]; //"CUP_optic_CompM2_Black","rhsusf_acc_eotech_xps3","RKSL_optic_EOT552"
		_gripSec 			= "rhs_acc_grip_ffg2";
		_lightSec 			= "FHQ_acc_LLM01F";
		//_silencerSec 		= selectRandom["rhsusf_acc_rotex_mp7","no"];
		_magSec 			= "rhsusf_mag_40Rnd_46x30_FMJ";
		_magSecCount	= round(_mags / 1.3);
	};
	case "RHS_M2010": {
		_gun			= "rhs_weap_XM2010_sa";
		_optic 		= selectRandom["rhsusf_acc_M8541_wd"];
		_grip 			= "rhsusf_acc_harris_bipod";
		_light 		= "rhs_acc_perst1ik_ris";
		_silencer 	= selectRandom["rhsusf_acc_M2010S_sa"]; //,"no"
		_mag 		= "rhsusf_5Rnd_300winmag_xm2010";
		_magCount = 7;
		_spcItems 	= ["ACE_RangeCard","ACE_Kestrel4500","ACE_ATragMX"];
		
		/*
		//P90 Secondary
		_gunSec				= "SMG_03C_TR_khaki";
		_opticSec 			= selectRandom["rhsusf_acc_mrds","rhsusf_acc_T1_low"];
		//_silencerSec 		= selectRandom["muzzle_snds_570","no"];
		_magSec 			= "50Rnd_570x28_SMG_03";
		_magSecCount	= round(_mags / 1.7);
		*/
		
		//MP7 Secondary
		_gunSec				= "rhsusf_weap_MP7A2";
		_opticSec 			= selectRandom["rhsusf_acc_T1_high","rhsusf_acc_T1_low","rhsusf_acc_mrds"]; //"CUP_optic_CompM2_Black","rhsusf_acc_eotech_xps3","RKSL_optic_EOT552"
		_gripSec 			= "rhs_acc_grip_ffg2";
		_lightSec 			= "FHQ_acc_LLM01F";
		//_silencerSec 		= selectRandom["rhsusf_acc_rotex_mp7","no"];
		_magSec 			= "rhsusf_mag_40Rnd_46x30_FMJ";
		_magSecCount	= round(_mags / 1.3);
	};
	case "RHS_M24": {
		_gun			= "rhs_weap_m24sws_wd";
		_optic 		= selectRandom["rhsusf_acc_M8541_low_wd"];
		_grip 			= "rhsusf_acc_harris_swivel";
		_silencer 	= selectRandom["rhsusf_acc_m24_silencer_wd"]; //,"no"
		_mag 		= "rhsusf_5Rnd_762x51_m118_special_Mag";
		_magCount = 6;
		_spcItems 	= ["ACE_RangeCard","ACE_Kestrel4500","ACE_ATragMX"];
		
		/*
		//P90 Secondary
		_gunSec				= "SMG_03C_TR_khaki";
		_opticSec 			= selectRandom["rhsusf_acc_mrds","rhsusf_acc_T1_low"];
		//_silencerSec 		= selectRandom["muzzle_snds_570","no"];
		_magSec 			= "50Rnd_570x28_SMG_03";
		_magSecCount	= round(_mags / 1.7);
		*/
		
		//MP7 Secondary
		_gunSec				= "rhsusf_weap_MP7A2";
		_opticSec 			= selectRandom["rhsusf_acc_T1_high","rhsusf_acc_T1_low","rhsusf_acc_mrds"]; //"CUP_optic_CompM2_Black","rhsusf_acc_eotech_xps3","RKSL_optic_EOT552"
		_gripSec 			= "rhs_acc_grip_ffg2";
		_lightSec 			= "FHQ_acc_LLM01F";
		//_silencerSec 		= selectRandom["rhsusf_acc_rotex_mp7","no"];
		_magSec 			= "rhsusf_mag_40Rnd_46x30_FMJ";
		_magSecCount	= round(_mags / 1.3);
	};
	case "RHS_M40": {
		_gun			= "rhs_weap_m40a5_wd";
		_optic 		= selectRandom["rhsusf_acc_LEUPOLDMK4_wd"];
		_grip 			= "rhsusf_acc_harris_swivel";
		_light 		= "rhs_acc_perst1ik_ris";
		_mag 		= "rhsusf_5Rnd_762x51_AICS_m118_special_Mag";
		_magCount = 6;
		_spcItems 	= ["ACE_RangeCard","ACE_Kestrel4500","ACE_ATragMX"];
		
		//MP5 Secondary
		_gunSec			= "SMG_05_F";
		_opticSec 		= selectRandom["no","no","optic_Aco","rhsusf_acc_RX01_NoFilter"];
		_lightSec 		= "no";
		//_silencerSec 	= "no";
		_magSec 		= "30Rnd_9x21_Mag_SMG_02";
		_magSecCount= _mags;
	};
};

/////////////////////////////////////////////////////////////// AT

//Set default values
_launcher 		= "no";
_launcherMag	= "no";
_launcherScope = "no";
_lMagCount		= 2;

//AT
switch _at do {
	case "BIS_Titan": {
		_launcher 		= "launch_B_Titan_short_tna_F";
		_launcherMag	= "Titan_AT";
	};
    case "BIS_MRAWS_Laser": {
		_launcher 		= "launch_MRAWS_green_F";
		_launcherMag	= "rhs_mag_maaws_HEAT";
	};
    case "BIS_MRAWS": {
		_launcher 		= "launch_MRAWS_green_rail_F";
		_launcherMag	= "rhs_mag_maaws_HEAT";
	};
    case "RHS_MAAWS": {
		_launcher 		= "rhs_weap_maaws";
		_launcherMag	= "rhs_mag_maaws_HEAT";
	};
    case "RHS_RPG7_Scope": {
		_launcher 		= "rhs_weap_rpg7";
		_launcherMag	= "rhs_rpg7_PG7VL_mag";
		_launcherScope = "rhs_acc_pgo7v3";
	};
    case "RHS_RPG7": {
		_launcher 		= "rhs_weap_rpg7";
		_launcherMag	= "rhs_rpg7_PG7VL_mag";
	};
	
	case "BIS_RPG32": {
		_launcher 		= "launch_RPG32_green_F";
		_launcherMag	= "RPG32_F";
	};
	case "RHS_M72": {
		_launcher 		= "rhs_weap_m72a7";
	};
	case "RHS_M134": {
		_launcher 		= "rhs_weap_M136";
	};
    case "RHS_Pzf60": {
		_launcher 		= "rhs_weap_panzerfaust60";
	};
    case "RHS_RPG26": {
		_launcher 		= "rhs_weap_rpg26";
	};
};

////////////////////////////////////////////////////////////////////////// Add Weapons

//Prep Backpacks if needed
_playerBackpack = backpack _player;
_backpackToAdd = "VSM_Multicam_Backpack_Kitbag";

//Add special items
if (count _spcItems > 0) then {
	{ [_player,_x,1,_backpackToAdd] execVM "scripts\loadouts\addItemEffectively.sqf"; } forEach _spcItems;
};

//Add Secondary to backpack
_player addWeapon _gunSec;
if (_opticSec != "no") 	then { _player addPrimaryWeaponItem _opticSec; };
if (_gripSec != "no") 		then { _player addPrimaryWeaponItem _gripSec; };
if (_lightSec != "no") 		then { _player addPrimaryWeaponItem _lightSec; };
if (_silencerSec != "no")	then { _player addPrimaryWeaponItem _silencerSec; };
if (_magSec != "no") 		then { _player addPrimaryWeaponItem _magSec; };
if (typeName _magSecCount != "STRING") 	then { _player addPrimaryWeaponItem _magSec; };

//Add to bag
[_player, _player] call ace_gunbag_fnc_toGunbagCallback;

//Add primary weapon + acc + 1 mag
_player addWeapon _gun;
if (_optic != "no") 	then { _player addPrimaryWeaponItem _optic; };
if (_grip != "no") 		then { _player addPrimaryWeaponItem _grip; };
if (_light != "no") 		then { _player addPrimaryWeaponItem _light; };
if (_silencer != "no")	then { _player addPrimaryWeaponItem _silencer; };
if (_mag != "no") 		then { _player addPrimaryWeaponItem _mag; };
if (_xMag != "no") 	then { _player addPrimaryWeaponItem _xMag; };

//Add primary mags
[_player,_mag,_magCount,_backpackToAdd] execVM "scripts\loadouts\addItemEffectively.sqf";

//Add primary extra mags
if (_xMag != "no") then { [_player,_xMag,_xMagCount,_backpackToAdd] execVM "scripts\loadouts\addItemEffectively.sqf"; };

//Add secondary mags
if (_magSec != "no") then { [_player,_magSec,_magSecCount,_backpackToAdd] execVM "scripts\loadouts\addItemEffectively.sqf"; };

//Add launcher mags
if (_launcherMag != "no") then { [_player,_launcherMag,_lMagCount,_backpackToAdd] execVM "scripts\loadouts\addItemEffectively.sqf"; };

//Add custom action for second primary
/*
if (!isNil "secondPrimary") then {_player removeAction secondPrimary};
if (_gunSec != "no") then {
	secondPrimary = _player addAction ["Switch Weapon","scripts\loadouts\tier_SecondPrimary.sqf", 
	[_gun,_optic,_grip,_light,_silencer,_mag,_magCount,_xMag,_xMagCount,
	_gunSec,_opticSec,_gripSec,_lightSec,_silencerSec,_magSec,_magSecCount],2.5,true,false,"","true",1,false,"",""];
	publicVariable "secondPrimary";
};
*/

//Add launcher
if (_launcher != "no") then { _player addWeapon _launcher; };
if (_launcherMag != "no") then { _player addSecondaryWeaponItem _launcherMag; };
if (_launcherScope != "no") then { _player addSecondaryWeaponItem _launcherScope; };