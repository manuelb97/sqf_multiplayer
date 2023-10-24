class bia_weapon_configs
{
	/*

	//code
	_allAmmos = (configFile >> "cfgammo") call Bis_fnc_getCfgSubClasses; 
	_ammos = _allAmmos select {"UAS" in _x && "7N39" in _x};

	_sortedAmmos = [_ammos, [], 
	{
		_ammo = _x;
		getNumber (configFile >> "cfgammo" >> _ammo >> "AP")
	}, "DESCEND"} call BIS_fnc_sortBy;

	_sortedAmmos //apply {getNumber (configFile >> "cfgammo" >> _x >> "AP")}

	*/

	//SMGs
	class bia_scorpion
	{
		weapClass = "rhs_weap_savz61";
		silencer[] = {""};
		laser[] = {""};
		optic[] = {""};
		mag[] = {"rhsgref_20rnd_765x17_vz61"};
		secmag[] = {""};
		grip[] = {""};
		role[] = {"CQB"};
	};

	class bia_vector
	{
		weapClass = "SMG_01_F";
		silencer[] = {""}; //muzzle_snds_acp
		laser[] = {"acc_flashlight_smg_01"};
		optic[] = {"rhsusf_acc_T1_low"};
		mag[] = {"30Rnd_45ACP_mag_SMG_01"}; //5
		secmag[] = {""};
		grip[] = {""};
		role[] = {"CQB"};
	};

	class bia_pp2000
	{
		weapClass = "rhs_weap_pp2000";
		silencer[] = {""};
		laser[] = {""};
		optic[] = 
		{
			"optic_Holosight_blk_F", 
			"optic_Aco", 
			"sma_spitfire_01_black"
		};
		mag[] = 
		{
			"UAS_BASE_9x19_7N21_30Rnd", 
			"UAS_BASE_9x19_7N21_40Rnd",
			"UAS_BASE_9x19_7N30_30Rnd"
		}; //rhs_mag_9x19mm_7n21_44
		secmag[] = {""};
		grip[] = {""};
		role[] = {"Rifleman"};
	};

	class bia_mp5
	{
		weapClass = "SMG_05_F";
		silencer[] = 
		{
			"", "", "",
			"muzzle_snds_L"
		};
		laser[] = 
		{
			"SMA_SFFL_BLK",
			"SMA_SFFL_BLK",
			"rhs_acc_perst1ik_ris"
		};
		optic[] = 
		{
			"optic_Holosight_blk_F",
			"optic_Aco"
		};
		mag[] = 
		{
			"UAS_BASE_9x19_7N21_40Rnd", 
			"UAS_BASE_9x19_7N30_30Rnd", 
			"UAS_BASE_9x19_7N30_40Rnd"
		}; //30Rnd_9x21_mag_SMG_02
		secmag[] = {""};
		grip[] = {""};
		role[] = {"Rifleman", "SniperSecondary"};
	};

	class bia_evo
	{
		weapClass = "SMG_02_F";
		silencer[] = 
		{
			"", "",
			"muzzle_snds_L"
		};
		laser[] = 
		{
			"SMA_SFFL_BLK",
			"SMA_SFFL_BLK",
			"rhs_acc_perst1ik_ris"
		};
		optic[] = 
		{
			"rhs_acc_rakursPM",
			"optic_Aco",
			"iansky_cmore",
			"SMA_eotech552",
			"SMA_eotech",
			"rhsusf_acc_mrds",
			"rhsusf_acc_T1_low"
		};
		mag[] = 
		{
			"UAS_BASE_9x19_7N30_40Rnd",
			"UAS_BASE_9x19_7N42_30Rnd",
			"UAS_BASE_9x19_7N42_40Rnd"
		}; //30Rnd_9x21_mag_SMG_02
		secmag[] = {""};
		grip[] = {""};
		role[] = {"Rifleman"};
	};

	class bia_mp7
	{
		weapClass = "rhsusf_weap_MP7A2";
		silencer[] = 
		{
			"", 
			"rhsusf_acc_rotex_mp7"
		};
		laser[] = 
		{
			"SMA_SFFL_BLK",
			"rhs_acc_perst1ik_ris"
		};
		optic[] = 
		{
			"rhsusf_acc_eotech_552",
			"rhsusf_acc_compm4",
			"rhsusf_acc_eotech_xps3"
		};
		mag[] = 
		{
			"UAS_BASE_46x30_APSX_40Rnd"
			// "UAS_BASE_46x30_DM41_40Rnd",
			// "UAS_BASE_46x30_DM21_40Rnd"
		}; //rhsusf_mag_40Rnd_46x30_AP
		secmag[] = {""};
		grip[] = {""};
		role[] = {"Rifleman", "SniperSecondary"};
	};
	
	//ARs
	//545 AKs
	class bia_ak74
	{
		weapClass = "rhs_weap_ak74";
		silencer[] = 
		{
			"rhs_acc_dtk1983", 
			"rhs_acc_dtk1983", 
			"rhs_acc_dtk1983", 
			"rhs_acc_dtk1983", 
			"rhs_acc_dtk4short"
		};
		laser[] = 
		{
			"rhs_acc_2dpZenit", 
			"rhs_acc_2dpZenit", 
			"rhs_acc_perst1ik"
		};
		optic[] = {""};
		mag[] = 
		{
			"UAS_BASE_545x39_7N6_30Rnd",
			"UAS_BASE_545x39_7N6_40Rnd",
			"UAS_BASE_545x39_7N22_30Rnd"
		}; //rhs_30Rnd_545x39_7N6M_AK
		secmag[] = {""};
		grip[] = {""};
		role[] = {"Rifleman"}; 
	};

	class bia_ak74_gl: bia_ak74
	{
		weapClass = "rhs_weap_ak74_gp25";
		laser[] = {""};
		secmag[] = {"rhs_VOG25"};
		role[] = {"Grenadier"};
	};
	
	class bia_ak74m: bia_ak74
	{
		weapClass = "rhs_weap_ak74m";
		silencer[] = 
		{
			"rhs_acc_dtk", 
			"rhs_acc_dtk", 
			"rhs_acc_dtk", 
			"rhs_acc_dtk4short"
		};
		optic[] = 
		{
			"rhs_acc_1p63", 
			"rhs_acc_pkas"
		}; 
		mag[] = 
		{
			"UAS_BASE_545x39_7N22_30Rnd",
			"UAS_BASE_545x39_7N22_40Rnd",
			"UAS_BASE_545x39_7N39_30Rnd"
		}; //rhs_30Rnd_545x39_7N10_AK
	};

	class bia_ak74m_gl: bia_ak74m
	{
		weapClass = "rhs_weap_ak74m_gp25";
		laser[] = {""};
		secmag[] = {"rhs_VOG25"};
		role[] = {"Grenadier"};
	};

	class bia_ak74_b33: bia_ak74
	{
		weapClass = "rhs_weap_ak74m_zenitco01_b33";
		silencer[] = 
		{
			"rhs_acc_dtk1983", 
			"rhs_acc_dtk1983", 
			"rhs_acc_dtk4short"
		};
		laser[] = 
		{
			"SMA_SFFL_BLK", 
			"rhsusf_acc_anpeq15side_bk"
		};
		optic[] = 
		{
			"SMA_eotech552",
			"RKSL_optic_EOT552",
			"SMA_eotech",
			"rhsusf_acc_mrds",
			"rhsusf_acc_RX01_NoFilter",
			"rhsusf_acc_T1_high"
		}; // iansky_cmore 
		mag[] = 
		{
			"UAS_BASE_545x39_7N22_40Rnd",
			"UAS_BASE_545x39_7N39_30Rnd",
			"UAS_BASE_545x39_7N39_40Rnd"
		}; //rhs_30Rnd_545x39_7N22_AK
		grip[] = {"rhs_acc_grip_ffg2"};
		role[] = {"Rifleman", "SniperSecondary"};
	};

	class bia_ak74_mr_gl: bia_ak74_b33
	{
		weapClass = "rhs_weap_ak74mr_gp25";
		optic[] = 
		{
			"optic_Aco",
			"sma_spitfire_01_black"
		};
		secmag[] = {"rhs_VOG25"};
		grip[] = {""};
		role[] = {"Grenadier", "SniperSecondary"};
	};

	//762 AKs
	class bia_sav58
	{
		weapClass = "rhs_weap_savz58p_black";
		silencer[] = {"rhsgref_acc_zendl"};
		laser[] = {""};
		optic[] = {""};
		mag[] = 
		{
			"UAS_BASE_762x39_57N231_30Rnd",
			"UAS_BASE_762x39_57N231_40Rnd",
			"UAS_BASE_762x39_7N27_30Rnd"
		};
		secmag[] = {""};
		grip[] = {""};
		role[] = {"Rifleman"};
	};

	class bia_akm: bia_sav58
	{
		weapClass = "rhs_weap_akm";
		silencer[] = 
		{
			"rhs_acc_dtkakm",
			"rhs_acc_dtkakm",
			"rhs_acc_dtkakm",
			"rhs_acc_dtkakm",
			"rhs_acc_pbs1"
		};
		laser[] = 
		{
			"rhs_acc_2dpZenit", 
			"rhs_acc_2dpZenit", 
			"rhs_acc_perst1ik"
		};
	};

	class bia_akm_gl: bia_akm
	{
		weapClass = "rhs_weap_akm_gp25";
		laser[] = {""};
		secmag[] = {"rhs_VOG25"};
		role[] = {"Grenadier"};
	};

	class bia_ak103: bia_ak74m
	{
		weapClass = "rhs_weap_ak103";
		silencer[] = 
		{
			"rhs_acc_dtk", 
			"rhs_acc_dtk", 
			"rhs_acc_dtk", 
			"rhs_acc_dtk4long"
		};
		mag[] = 
		{
			"UAS_BASE_762x39_57N231_40Rnd",
			"UAS_BASE_762x39_7N27_30Rnd",
			"UAS_BASE_762x39_7N27_40Rnd"
		};
	};

	class bia_ak103_gl: bia_ak103
	{
		weapClass = "rhs_weap_ak103_gp25";
		laser[] = {""};
		secmag[] = {"rhs_VOG25"};
		role[] = {"Grenadier"};
	};

	class bia_akm_b33: bia_akm
	{
		weapClass = "rhs_weap_akm_zenitco01_b33";
		laser[] = 
		{
			"SMA_SFFL_BLK",
			"rhs_acc_perst1ik_ris"
		};
		optic[] = 
		{
			"SMA_eotech552",
			"RKSL_optic_EOT552",
			"SMA_eotech",
			"rhsusf_acc_mrds",
			"rhsusf_acc_RX01_NoFilter",
			"rhsusf_acc_T1_high",
			"sma_spitfire_01_black",
			"rhsusf_acc_eotech_xps3"
		};
		mag[] = 
		{
			"UAS_BASE_762x39_7N27_40Rnd",
			"UAS_BASE_762x39_7N38_30Rnd",
			"UAS_BASE_762x39_7N38_40Rnd"
		};
		grip[] = {"rhs_acc_grip_ffg2"};
		role[] = {"Rifleman", "SniperSecondary"};
	};

	class bia_ak103_npz_gl: bia_ak103_gl
	{
		weapClass = "rhs_weap_ak103_gp25_npz";
		optic[] = 
		{
			"rhsusf_acc_compm4",
			"rhsusf_acc_mrds",
			"rhsusf_acc_T1_high"
		};
		mag[] = 
		{
			"UAS_BASE_762x39_7N27_40Rnd",
			"UAS_BASE_762x39_7N38_30Rnd",
			"UAS_BASE_762x39_7N38_40Rnd"
		};
		role[] = {"Grenadier"};
	};

	class bia_sav58_ris: bia_sav58
	{
		weapClass = "rhs_weap_savz58v_ris";
		laser[] = 
		{
			"SMA_SFFL_BLK",
			"rhs_acc_perst1ik_ris"
		};
		optic[] = 
		{
			"SMA_eotech552",
			"SMA_eotech",
			"rhsusf_acc_mrds",
			"rhsusf_acc_RX01_NoFilter",
			"rhsusf_acc_T1_high",
			"sma_spitfire_01_black"
		};
		mag[] = 
		{
			"UAS_BASE_762x39_7N38_30Rnd",
			"UAS_BASE_762x39_7N38_40Rnd"
		};
		grip[] = {"rhs_acc_grip_ffg2"};
		role[] = {"Rifleman"};
	};

	//US 556
	class bia_m16
	{
		weapClass = "rhs_weap_m16a4_imod";
		silencer[] = 
		{
			"rhsusf_acc_SFMB556", 
			"rhsusf_acc_SFMB556", 
			"rhsusf_acc_SFMB556", 
			"rhsusf_acc_nt4_black"
		};
		laser[] = 
		{
			"SMA_SFFL_BLK",
			"rhsusf_acc_anpeq15side_bk"
		};
		optic[] = 
		{
			"RKSL_optic_EOT552",
			"rhsusf_acc_eotech_552",
			"rhsusf_acc_compm4",
			"rhsusf_acc_T1_high",
			"rhsusf_acc_eotech_xps3"
		};
		mag[] = 
		{
			"UAS_BASE_556_M193_30Rnd",
			"UAS_BASE_556_M193_40Rnd",
			"UAS_BASE_556_M855A2_20Rnd"
		}; //rhs_mag[]_30Rnd_556x45_M855A1_Stanag
		secmag[] = {""};
		grip[] = {"rhsusf_acc_grip3"};
		role[] = {"Rifleman"};
	};

	class bia_m4: bia_m16
	{
		weapClass = "rhs_weap_m4a1";
		laser[] = 
		{
			"SMA_SFFL_BLK",
			"rhsusf_acc_anpeq15_bk"
		};
		mag[] = 
		{
			"UAS_BASE_556_M193_40Rnd",
			"UAS_BASE_556_M855A2_30Rnd",
			"UAS_BASE_556_M855A2_40Rnd"
		};
	};

	class bia_m4_gl: bia_m4
	{
		weapClass = "rhs_weap_m4a1_m320";
		secmag[] = {"1Rnd_HE_Grenade_shell"};
		grip[] = {""};
		role[] = {"Grenadier"};
	};

	class bia_mk18: bia_m4
	{
		weapClass = "rhs_weap_mk18_KAC";
		optic[] = {"rhsusf_acc_eotech_xps3"};
		mag[] = {"UAS_BASE_556_M995_40Rnd"};
		role[] = {"Rifleman"};
	};

	class bia_m4BII: bia_mk18
	{
		weapClass = "rhs_weap_m4a1_blockII_KAC";
		role[] = {"Rifleman"};
	};

	class bia_mk18_gl: bia_mk18
	{
		weapClass = "rhs_weap_mk18_m320";
		secmag[] = {"1Rnd_HE_Grenade_shell"};
		grip[] = {""};
		role[] = {"Grenadier"};
	};

	class bia_hk416: bia_mk18
	{
		weapClass = "rhs_weap_hk416d145";
		role[] = {"Rifleman", "SniperSecondary"};
	};

	class bia_hk416_gl: bia_hk416
	{
		weapClass = "rhs_weap_hk416d145_m320";
		secmag[] = {"1Rnd_HE_Grenade_shell"};
		grip[] = {""};
		role[] = {"Grenadier", "SniperSecondary"};
	};
	
	class bia_g36: bia_m4
	{
		weapClass = "rhs_weap_g36kv";
		laser[] = 
		{
			"SMA_SFFL_BLK",
			"rhs_acc_perst1ik_ris"
		};
		optic[] = 
		{
			"SMA_eotech552",
			"SMA_eotech",
			"rhsusf_acc_mrds",
			"rhsusf_acc_RX01_NoFilter",
			"rhsusf_acc_T1_high",
			"sma_spitfire_01_black"
		};
		mag[] = 
		{
			"UAS_BASE_556_M855A2_40Rnd",
			"UAS_BASE_556_M995_30Rnd",
			"UAS_BASE_556_M995_40Rnd"
		};
	};
	
	class bia_g36_gl: bia_g36
	{
		weapClass = "rhs_weap_g36kv_ag36";
		secmag[] = {"1Rnd_HE_Grenade_shell"};
		grip[] = {""};
		role[] = {"Grenadier", "SniperSecondary"};
	};
	
	class bia_f2000: bia_g36
	{
		weapClass = "arifle_Mk20_plain_F";
		optic[] = 
		{
			"optic_Aco",
			"SMA_eotech552",
			"SMA_eotech",
			"rhsusf_acc_mrds",
			"rhsusf_acc_T1_low",
			"sma_spitfire_01_black"
		};
		grip[] = {""};
	};
	
	class bia_f2000_gl: bia_f2000
	{
		weapClass = "arifle_Mk20_GL_plain_F";
		secmag[] = {"1Rnd_HE_Grenade_shell"};
		role[] = {"Grenadier", "SniperSecondary"};
	};
	
	class bia_tar21: bia_f2000
	{
		weapClass = "arifle_TRG21_F";
	};
	
	class bia_tar21_gl: bia_tar21
	{
		weapClass = "arifle_TRG21_GL_F";
		secmag[] = {"1Rnd_HE_Grenade_shell"};
		role[] = {"Grenadier", "SniperSecondary"};
	};
	
	class bia_vhs: bia_f2000
	{
		weapClass = "rhs_weap_vhsd2";
		optic[] = 
		{
			"RKSL_optic_EOT552",
			"rhsusf_acc_T1_high",
			"rhsusf_acc_eotech_xps3"
		};
		grip[] = {"rhs_acc_grip_ffg2"};
		role[] = {"Rifleman"};
	};
	
	class bia_vhs_gl: bia_vhs
	{
		weapClass = "rhs_weap_vhsd2_bg";
		secmag[] = {"1Rnd_HE_Grenade_shell"};
		grip[] = {""};
		role[] = {"Grenadier"};
	};

	class bia_hk416_bis: bia_tar21
	{
		weapClass = "arifle_SPAR_01_blk_F";
		optic[] = 
		{
			"optic_Aco",
			"SMA_eotech",
			"optic_Holosight_blk_F",
			"sma_spitfire_01_black"
		};
		mag[] = 
		{
			"UAS_BASE_556_M995_40Rnd",
			"UAS_BASE_556_M995A1_30Rnd",
			"UAS_BASE_556_M995A1_40Rnd"
		}; //ACE_30Rnd_556x45_Stanag_M995_AP_mag
		role[] = {"Rifleman"};
	};

	class bia_hk416_gl_bis: bia_hk416_bis
	{
		weapClass = "arifle_SPAR_01_GL_blk_F";
		secmag[] = {"1Rnd_HE_Grenade_shell"};
		role[] = {"Grenadier"};
	};

	class bia_hk416_sma: bia_hk416_bis
	{
		weapClass = "SMA_HK416CUSTOMCQBvfgB";
		silencer[] = 
		{
			"SMA_FLASHHIDER1", 
			"SMA_FLASHHIDER1", 
			"SMA_supp1b_556"
		};
		optic[] = 
		{
			"SMA_eotech",
			"SMA_eotech552",
			"rhsusf_acc_T1_high",
			"sma_spitfire_01_black",
			"rhsusf_acc_eotech_xps3"
		};
	};

	class bia_hk416_gl_sma: bia_hk416_sma
	{
		weapClass = "SMA_HK416GLCQB_B";
		secmag[] = {"1Rnd_HE_Grenade_shell"};
		role[] = {"Grenadier"};
	};

	class bia_scarl_sma: bia_hk416_sma
	{
		weapClass = "SMA_Mk16_black";
		optic[] = 
		{
			"SMA_eotech552",
			"rhsusf_acc_T1_high",
			"rhsusf_acc_eotech_xps3"
		};
		role[] = {"Rifleman", "SniperSecondary"};
	};

	class bia_scarl_gl_sma: bia_scarl_sma
	{
		weapClass = "SMA_MK16_EGLM_black";
		secmag[] = {"1Rnd_HE_Grenade_shell"};
		role[] = {"Grenadier", "SniperSecondary"};
	};

	class bia_tavor_sma: bia_hk416_sma
	{
		weapClass = "SMA_CTARBLK_F";
		optic[] = 
		{
			"SMA_eotech552",
			"rhsusf_acc_RX01_NoFilter",
			"rhsusf_acc_T1_high",
			"rhsusf_acc_eotech_xps3"
		};
		role[] = {"Rifleman", "SniperSecondary"};
	};

	//US 762
	class bia_m14_sof_rhs
	{
		weapClass = "rhs_weap_m14_socom"; //rhs_weap_m14_socom_rail
		silencer[] = {"rhsusf_acc_m14_flashsuppresor", "rhsusf_acc_aac_m14dcqd_silencer"};
		laser[] = {""};
		optic[] = {""}; //optic_Holosight_blk_F
		mag[] = {"UAS_BASE_762N_M852_20Rnd"};
		secmag[] = {""};
		grip[] = {""};
		role[] = {"Rifleman"};
	};

	class bia_scarhs_rhs: bia_g36
	{
		weapClass = "rhs_weap_SCARH_CQC";
		silencer[] = 
		{
			"", "", 
			"rhsusf_acc_aac_762sdn6_silencer"
		};
		optic[] = 
		{
			"SMA_eotech552",
			"RKSL_optic_EOT552",
			"rhsusf_acc_compm4",
			"rhsusf_acc_T1_high",
			"rhsusf_acc_eotech_xps3"
		};
		mag[] = {"UAS_BASE_762N_M852_20Rnd"};
		role[] = {"Rifleman"};
	};

	class bia_hk417s: bia_hk416_sma
	{
		weapClass = "SMA_HK417vfg";
		silencer[] = 
		{
			"", "",
			"SMA_supp_762"
		};
		mag[] = {"UAS_BASE_762N_M80A1_30Rnd"}; //rhs_mag[]_20Rnd_SCAR_762x51_m80a1_epr_bk
		role[] = {"Rifleman"};
	};

	class bia_scarhs: bia_hk417s
	{
		weapClass = "SMA_Mk17_black";
	};

	class bia_scarhs_gl: bia_scarhs
	{
		weapClass = "SMA_MK17_EGLM_black";
		secmag[] = {"1Rnd_HE_Grenade_shell"};
		role[] = {"Grenadier"};
	};

	//MG
	class bia_mg42
	{
		weapClass = "rhs_weap_mg42";
		silencer[] = {""};
		laser[] = {""};
		optic[] = {""};
		mag[] = 
		{
			"UAS_BASE_762N_M80A1_100Rnd",
			"UAS_BASE_762N_M80A1_200Rnd"
		}; //rhsgref_50Rnd_792x57_SmK_drum
		secmag[] = {""};
		grip[] = {""};
		role[] = {"MG"};
	};

	class bia_pkm: bia_mg42
	{
		weapClass = "rhs_weap_pkm";
		mag[] = 
		{
			"UAS_BASE_762x54_7N13_100Rnd",
			"UAS_BASE_762x54_7N13_200Rnd",
			"UAS_BASE_762x54_7N26_100Rnd"
		}; //"rhs_100Rnd_762x54mmR"
	};

	class bia_m84: bia_pkm
	{
		weapClass = "rhs_weap_m84"; //"rhssaf_250Rnd_762x54R"
	};
	
	class bia_pkp: bia_pkm
	{
		weapClass = "rhs_weap_pkp";
		optic[] = {"rhs_acc_pkas"};
		mag[] = 
		{
			"UAS_BASE_762x54_7N26_200Rnd",
			"UAS_Base_762x54_7N37M_100Rnd",
			"UAS_Base_762x54_7N37M_200Rnd"
		}; //"rhs_100Rnd_762x54mmR_7N13"
	};

	class bia_negev: bia_pkp
	{
		weapClass = "LMG_Zafir_F";
		laser[] = {"rhsusf_acc_anpeq15side_bk"};
		optic[] = 
		{
			"optic_Holosight_blk_F",
			"sma_spitfire_01_black",
			"rhsusf_acc_eotech_xps3"
		};
		mag[] = 
		{
			"UAS_Base_762x54_7N37M_100Rnd",
			"UAS_Base_762x54_7N37M_200Rnd"
		}; //"rhs_100Rnd_762x54mmR_7N26" 150Rnd_762x54_Box
	};

	class bia_m249: bia_pkp
	{
		weapClass = "rhs_weap_m249_pip_L";
		silencer[] = {"rhsusf_acc_SFMB556"};
		laser[] = {"rhsusf_acc_anpeq15side_bk"};
		optic[] = 
		{
			"rhsusf_acc_eotech_552",
			"rhsusf_acc_compm4"
		};
		mag[] = 
		{
			// "UAS_BASE_556_M193_100Rnd",
			// "UAS_BASE_556_M193_200Rnd",
			"UAS_BASE_556_M855A2_100Rnd",
			"UAS_BASE_556_M855A2_200Rnd",
			"UAS_BASE_556_M995_100Rnd",
			"UAS_BASE_556_M995_200Rnd",
			"UAS_BASE_556_M995A1_100Rnd",
			"UAS_BASE_556_M995A1_200Rnd"
		}; //rhsusf_200rnd_556x45_mixed_box
		grip[] = {"rhsusf_acc_kac_grip_saw_bipod"}; // rhsusf_acc_grip4_bipod
	};

	class bia_m240: bia_m249
	{
		weapClass = "rhs_weap_m240B";
		silencer[] = {"rhsusf_acc_ARDEC_M240"};
		optic[] = 
		{
			"rhsusf_acc_compm4",
			"rhsusf_acc_eotech_xps3"
		};
		mag[] = 
		{
			// "UAS_BASE_762N_M852_100Rnd",
			// "UAS_BASE_762N_M852_200Rnd",
			// "UAS_BASE_762N_M80_100Rnd",
			// "UAS_BASE_762N_M80_200Rnd",
			"UAS_BASE_762N_M80A1_100Rnd",
			"UAS_BASE_762N_M80A1_200Rnd",
			"UAS_BASE_762N_M993_100Rnd",
			"UAS_BASE_762N_M993_200Rnd"
		}; // rhsusf_100Rnd_762x51_m80a1epr
		grip[] = {""};
	};

	class bia_mk3: bia_m240
	{
		weapClass = "sma_minimi_mk3_762tlb";
		laser[] = {"rhsusf_acc_anpeq15side_bk"};
		optic[] = 
		{
			"SMA_eotech",
			"optic_Holosight_blk_F"
		};
		mag[] = 
		{
			// "UAS_BASE_762N_M852_100Rnd",
			// "UAS_BASE_762N_M852_200Rnd",
			// "UAS_BASE_762N_M80_100Rnd",
			// "UAS_BASE_762N_M80_200Rnd",
			"UAS_BASE_762N_M80A1_100Rnd",
			"UAS_BASE_762N_M80A1_200Rnd",
			"UAS_BASE_762N_M993_100Rnd",
			"UAS_BASE_762N_M993_200Rnd"
		}; //rhsusf_100Rnd_762x51_m61_ap SMA_150Rnd_762_M80A1_Mixed
	};

	//DMR
	class bia_fal
	{
		weapClass = "rhs_weap_l1a1_wood";
		silencer[] = {"rhsgref_acc_falMuzzle_l1a1"};
		laser[] = {""};
		optic[] = {"rhsgref_acc_l1a1_l2a2"};
		mag[] = {"UAS_BASE_762N_M80_10Rnd"}; //rhs_mag[]_20Rnd_762x51_m80_fnfal
		secmag[] = {""};
		grip[] = {""};
		role[] = {"DMR"};
	};
	
	class bia_m76: bia_fal
	{
		weapClass = "rhs_weap_m76";
		silencer[] = {""};
		optic[] = {"rhs_acc_1p78"};
		mag[] = {"UAS_Base_762x54_7N1_10Rnd"}; //rhsgref_10Rnd_792x57_m76
	};

	class bia_svd: bia_m76
	{
		weapClass = "rhs_weap_svdp";
		silencer[] = {"", "","rhs_acc_tgpv2"};
		optic[] = {"rhs_acc_pso1m2"};
		mag[] = {"UAS_Base_762x54_7N14_10Rnd"};  //"rhs_10Rnd_762x54mmR_7N1"
	};

	class bia_svd_npz: bia_m76
	{
		weapClass = "rhs_weap_svds_npz";
		silencer[] = {"", "rhs_acc_tgpv2"};
		optic[] = {"rhsusf_acc_LEUPOLDMK4", "RKSL_optic_PMII_312", "optic_AMS"};
		mag[] = {"UAS_Base_762x54_7N41_10Rnd"};
	};

	class bia_m14_bis: bia_fal
	{
		weapClass = "srifle_DMR_06_olive_F";
		silencer[] = {"", "rhsgref_sdn6_suppressor"};
		optic[] = {"rhsusf_acc_LEUPOLDMK4_wd", "RKSL_optic_PMII_312_wdl", "optic_AMS"};
		mag[] = {"UAS_BASE_762N_M80A1_10Rnd"}; //UAS_BASE_762N_M118LR_20Rnd
		grip[] = {"bipod_03_F_oli"};
	};

	class bia_m14ebr: bia_fal
	{
		weapClass = "rhs_weap_m14ebrri";
		silencer[] = {"", "rhsusf_acc_aac_762sdn6_silencer"};
		laser[] = {"rhsusf_acc_anpeq15side_bk"};
		optic[] = {"rhsusf_acc_LEUPOLDMK4", "RKSL_optic_PMII_312"};
		mag[] = {"UAS_BASE_762N_M80A1_10Rnd"}; //ACE_20Rnd_762x51_M993_AP_mag[]
		grip[] = {"rhsusf_acc_harris_bipod"};
	};

	class bia_sig762: bia_fal
	{
		weapClass = "srifle_DMR_03_F";
		silencer[] = {"", "rhsusf_acc_aac_762sdn6_silencer"};
		laser[] = {"rhsusf_acc_anpeq15A"};
		optic[] = {"optic_AMS"};
		mag[] = {"UAS_BASE_762N_M80A1_10Rnd"};
		grip[] = {"bipod_01_F_blk"};
	};

	class bia_sr25: bia_m14ebr
	{
		weapClass = "rhs_weap_sr25_ec";
		silencer[] = {"", "rhsusf_acc_aac_762sdn6_silencer"};
		laser[] = {"SMA_ANPEQ15_BLK"};
		optic[] = {"rhsusf_acc_premier_low", "optic_AMS"};
		mag[] = {"UAS_BASE_762N_M993_10Rnd"}; //ACE_20Rnd_762x51_M993_AP_mag[]
	};

	class bia_scarhl_rhs: bia_sr25
	{
		weapClass = "rhs_weap_SCARH_LB";
		laser[] = {"rhs_acc_perst1ik_ris"};
		optic[] = {"Scot_NForce_Atcr_RMR_Top"};
		grip[] = {"rhsusf_acc_harris_bipod"};
	};

	class bia_hk41716: bia_scarhl_rhs
	{
		weapClass = "SMA_HK417_16in";
		silencer[] = {"", "SMA_supp_762"};
		laser[] = {"SMA_ANPEQ15_BLK"};
		optic[] = {"Scot_NForce_Atcr_RMR_Top", "rhsusf_acc_premier_low"};
		grip[] = {"rhs_acc_harris_swivel"};
	};

	class bia_hk41720: bia_sr25
	{
		weapClass = "arifle_SPAR_03_blk_F";
		laser[] = {"SMA_ANPEQ15_BLK"};
		optic[] = {"rhsusf_acc_premier_low"};
		grip[] = {"rhs_acc_harris_swivel"};
	};

	//Sniper
	class bia_m40
	{
		weapClass = "rhs_weap_m40a5";
		silencer[] = {""};
		laser[] = {""};
		optic[] = {"rhsusf_acc_premier_low"};
		mag[] = {"UAS_BASE_762N_M993_5Rnd"}; //"UAS_BASE_762N_M118LR_5Rnd", rhsusf_5Rnd_762x51_m993_mag
		secmag[] = {""};
		grip[] = {"rhsusf_acc_harris_swivel"};
		role[] = {"Sniper"};
	};

	class bia_m24: bia_m40
	{
		weapClass = "rhs_weap_m24sws";
		silencer[] = {"", "rhsusf_acc_m24_silencer_black"};
		optic[] = {"rhsusf_acc_M8541_low"};
		mag[] = {"UAS_BASE_762N_M948_5Rnd"};
	};

	class bia_m2010: bia_m40
	{
		weapClass = "rhs_weap_XM2010";
		silencer[] = {"rhsusf_acc_M2010S_wd"};
		optic[] = {"rhsusf_acc_M8541"};
		mag[] = {"UAS_BASE_300WinMag_M1158_5Rnd"}; //UAS_BASE_300WinMag_SAPI_5Rnd UAS_BASE_300WinMag_Mk248_Mod1_5Rnd rhsusf_5Rnd_300winmag_xm2010
		grip[] = {"rhsusf_acc_harris_bipod"};
	};

	class bia_t5000: bia_m40
	{
		weapClass = "rhs_weap_t5000";
		optic[] = {"rhsusf_acc_M8541_low"};
		mag[] = {"UAS_BASE_338_7N45_5Rnd"};
		// {
		// 	"UAS_BASE_338_7N45_5Rnd",
		// 	"UAS_BASE_338_STS8BP_5Rnd",
		// 	"UAS_BASE_338_SC152_5Rnd",
		// 	"UAS_BASE_338_STS8_5Rnd"
		// }; // "rhs_5Rnd_338lapua_t5000"
		grip[] = {"rhsusf_acc_harris_bipod"};
	};

	class bia_m200: bia_t5000
	{
		weapClass = "srifle_LRR_F";
		optic[] = {"rhsusf_acc_premier_low"};
		mag[] = {"UAS_BASE_408_SBR_API_7Rnd"}; //UAS_BASE_408_Cheytac_Match_419_7Rnd 7Rnd_408_mag
		grip[] = {""};
	};

	class bia_m107: bia_m200
	{
		weapClass = "rhs_weap_M107";
		mag[] = {"UAS_Base_127x99_M903_5Rnd"}; // UAS_Base_127x99_Mk263_5Rnd UAS_Base_127x99_AMAX_5Rnd ACE_10Rnd_127x99_API_mag
	};

	class bia_gm6: bia_m200
	{
		weapClass = "srifle_GM6_F";
		optic[] = {"rhsusf_acc_premier"};
		mag[] = {"UAS_Base_127x99_M903_5Rnd"}; //UAS_Base_127x99_Mk263_5Rnd UAS_Base_127x99_AMAX_5Rnd ACE_5Rnd_127x99_API_mag
	};

	//HE Launchers
	class bia_rshg2
	{
		weapClass = "rhs_weap_rshg2";
		silencer[] = {""};
		laser[] = {""};
		optic[] = {""};
		mag[] = {""};
		secmag[] = {""};
		grip[] = {""};
		role[] = {"AT"};
	};

	class bia_m72: bia_rshg2
	{
		weapClass = "rhs_weap_m72a7";
	};

	class bia_m136: bia_rshg2
	{
		weapClass = "rhs_weap_M136_hedp";
	};

	class bia_rpg7: bia_rshg2
	{
		weapClass = "rhs_weap_rpg7";
		optic[] = {""};
		mag[] = {"rhs_rpg7_OG7V_mag"};
	};

	class bia_maaws: bia_rshg2
	{
		weapClass = "rhs_weap_maaws";
		optic[] = {""};
		mag[] = {"rhs_mag_maaws_HE"};
	};

	class bia_mraws: bia_rshg2 //
	{
		weapClass = "launch_MRAWS_green_rail_F";
		mag[] = {"MRAWS_HE_F"};
	};
};

class bia_tier_configs
{
	vals[] = {0, 1, 2, 3, 4}; //use as index to select from right sub arr
	chances[] = {1, 1, 1, 1, 1}; //{100, 33, 20, 10, 5};

	// array of arrays equal to num of vals
	// each arr needs 5 sub arrs
	uniforms[] = 
	{
		{
			"U_BG_Guerilla2_3",
			"U_BG_Guerrilla_6_1",
			"U_I_C_Soldier_Bandit_3_F"
		},
		{
			"rhs_uniform_afghanka_wdl",
			"rhs_uniform_bdu_erdl",
			"rhsgref_uniform_og107",
			"rhsgref_uniform_woodland",
			"rhssaf_uniform_m93_oakleaf_summer"
		},
		{"rhs_uniform_emr_patchless"},
		{"rhs_uniform_vkpo_gloves_alt"},
		{"rhs_uniform_g3_rgr"}
	};
	vests[] = 
	{
		{
			"V_BandollierB_oli",
			"V_TacVest_oli",
			"V_TacChestrig_oli_F"
		},
		{
			"rhs_6b2",
			"rhs_6b2_chicom",
			"rhs_6b2_lifchik"
		},
		{"rhs_6b23_digi_6sh92_spetsnaz2"},
		{"TAC_EI_RRV21_RG"},
		{"dgr_vestB6"}
	};
	backpacks[] = 
	{
		{
			"", 
			"TAC_BP_Butt_RG"
		},
		{
			"rhs_sidor",
			"B_AssaultPack_sgg"
		},
		{"rhs_rk_sht_30_olive"},
		{"rhssaf_kitbag_smb"},
		{"B_Carryall_oli"}
	};
	headgear[] = 
	{
		{
			"H_Bandanna_khk",
			"H_Cap_oli",
			"H_Booniehat_oli",
			"dgr_cap6"
		},
		{
			"PO_H_M1_OLV_2",
			"PO_H_SSh68Helmet_M81_1",
			"rhsgref_helmet_M1_erdl",
			"rhsgref_ssh68_emr"
		},
		{"rhs_6b7_1m_olive"},
		{"dgr_ech14"},
		{"TAC_K6"}
	};
	facegear[] = 
	{
		{
			"G_Balaclava_oli",
			"G_Bandanna_oli",
			"rhsusf_shemagh2_grn"
		},
		{
			"G_Balaclava_oli",
			"G_Bandanna_oli",
			"rhsusf_shemagh2_grn"
		},
		{
			"G_Balaclava_oli",
			"G_Bandanna_oli",
			"rhsusf_shemagh2_grn"
		},
		{
			"G_Balaclava_oli",
			"G_Bandanna_oli",
			"rhsusf_shemagh2_grn"
		},
		{"VSM_Balaclava2_OD_Goggles"}
	};
	binos[] = 
	{
		{
			"",
			"rhssaf_zrak_rd7j"
		},
		{"rhs_pdu4"},
		{"ACE_Vector"},
		{"Rangefinder"},
		{"ACE_MX2A"}
	};
	nvgs[] = 
	{
		{""},
		{
			"", 
			"rhs_1PN138"
		},
		{"rhs_1PN138"},
		{"rhsusf_ANPVS_15"},
		{"O_NVGoggles_ghex_F"}
	};
	launchers[] = 
	{
		{"bia_rshg2"},
		{"bia_m136"},
		{"bia_rpg7"},
		{"bia_maaws"},
		{"bia_mraws"}
	};
	plates[] = 
	{
		{"SCT_Panel_Safariland_ZeroG_BlackDiamond_IIIA_S"},
		{"SCT_Ceradyne_Defender275_xS_magtype"},
		{"SCT_SRI2_BALCS_XS_magtype"},
		{"SCT_OSKV_Verseidag_UltiMax_Modulard_s_magtype"},
		{"SCT_VTT_ExoteShapeHonky_S_magtype"}
		// {"SCT_plate_ceramic_PA500_AP_S_magtype"},
	};
	weapons[] = 
	{
		{
			// "bia_scorpion",
			// "bia_pp2000",
			"bia_ak74",
			"bia_ak74_gl",
			"bia_akm",
			"bia_akm_gl",
			// "bia_mg42",
			"bia_pkm",
			// "bia_m84",
			// "bia_fal",
			"bia_m76"
			// "bia_svd"
		},
		{
			// "bia_vector",
			// "bia_pp2000",
			// "bia_mp5",
			"bia_ak74m",
			"bia_ak74m_gl",
			"bia_ak103",
			"bia_ak103_gl",
			"bia_pkp",
			"bia_svd_npz"
		},
		{
			// "bia_evo",
			"bia_ak74_b33",
			"bia_ak74_mr_gl",
			"bia_akm_b33",
			"bia_ak103_npz_gl",
			"bia_m4",
			"bia_m4_gl",
			"bia_m16",
			"bia_m249",
			"bia_m14ebr"
		},
		{
			// "bia_mp7",
			"bia_g36",
			"bia_g36_gl",
			"bia_f2000",
			"bia_f2000_gl",
			"bia_tar21",
			"bia_tar21_gl",
			"bia_m240",
			"bia_sr25"
		},
		{
			"bia_mk18",
			"bia_mk18_gl",
			// "bia_m4BII",
			"bia_hk416",
			"bia_hk416_gl",
			// "bia_scarhs_rhs",
			"bia_hk417s",
			"bia_scarhs",
			"bia_scarhs_gl",
			"bia_mk3",
			"bia_negev",
			// "bia_scarhl_rhs"
			"bia_hk41716"
		}
	};
	armags[] = {3, 4, 5, 6, 7};
	glmags[] = {2, 3, 4, 5, 6};
	mgmags[] = {1, 1, 2, 2, 2};
	dmrmags[] = {2, 3, 4, 5, 6};
	launchermags[] = {0, 0, 1, 1, 1};
	numNades[] = {0, 0, 1, 2, 2};
};

/*
//old config approach, only used for player
class tier_5
{
	uniforms[] = 
	{
		"U_BG_Guerilla2_3",
		"U_BG_Guerrilla_6_1",
		"U_I_C_Soldier_Bandit_3_F"
	};
	vests[] = 
	{
		"V_BandollierB_oli", 
		"V_TacVest_oli", 
		"V_TacChestrig_oli_F"
		
		// "rhs_chicom", 
		// "rhs_6sh92_digi",
		
		// "rhsgref_chestrig"
	};
	backpacks[]	= 
	{
		"TAC_BP_Butt_RG"
	};
	headgear[]	= 
	{
		"G_Bandanna_oli",
		"H_Cap_oli", 
		"H_Booniehat_oli",

		"dgr_cap6"
	};
	facegear[]	= 
	{
		"G_Balaclava_oli", 
		"G_Bandanna_oli", 
		"rhsusf_shemag[]h2_grn"
	}; //"G_Balaclava_blk", , "rhs_balaclava", "rhs_balaclava1_olive"
	binos[] 	= {"rhssaf_zrak_rd7j"};
	nvgs[] 		= {{""}};
	launchers[]	= {{""}};
	weapons[] = 
	{
		"bia_ak74", 
		"bia_ak74_gl", 
		"bia_akm", 
		"bia_akm_gl", 
		"bia_mg42",
		"bia_pkm",
		"bia_m84",
		"bia_fal",
		"bia_m76"
	};
	
	armag[]s = 3;
	glmag[]s = 2;
	mgmag[]s = 1;
	dmrmag[]s = 2;
	launchermag[]s = 0;
	numNades = 1;
};

	//9mm
		UAS_BASE_9x19_7N21_30Rnd
		UAS_BASE_9x19_7N30_30Rnd
		UAS_BASE_9x19_7N31_30Rnd
		UAS_BASE_9x19_7N31M_30Rnd
		UAS_BASE_9x19_7N35_30Rnd
		UAS_BASE_9x19_7N42_30Rnd
		UAS_BASE_9x19_7N21_40Rnd
		UAS_BASE_9x19_7N30_40Rnd
		UAS_BASE_9x19_7N31_40Rnd
		UAS_BASE_9x19_7N31M_40Rnd
		UAS_BASE_9x19_7N35_40Rnd
		UAS_BASE_9x19_7N42_40Rnd
	pp2000, mp5, scorpion all same mags
	vector, mp7 still useful?

	mini scorpion weird ammo only

	//545
	UAS_545x39_7N39
		UAS_BASE_545x39_7N39_30Rnd
		UAS_BASE_545x39_7N39_40Rnd
		UAS_BASE_545x39_7N39_60Rnd
	UAS_545x39_7N22
		UAS_BASE_545x39_7N22_30Rnd
		UAS_BASE_545x39_7N22_40Rnd
		UAS_BASE_545x39_7N22_60Rnd
	UAS_545x39_7N6
		UAS_BASE_545x39_7N6_30Rnd
		UAS_BASE_545x39_7N6_40Rnd
		UAS_BASE_545x39_7N6_60Rnd

	//762x39
	UAS_762x39_7N38
		UAS_BASE_762x39_7N38_30Rnd
		UAS_BASE_762x39_7N38_40Rnd
		UAS_BASE_762x39_7N38_60Rnd
	UAS_762x39_7N27
		UAS_BASE_762x39_7N27_30Rnd
		UAS_BASE_762x39_7N27_40Rnd
		UAS_BASE_762x39_7N27_60Rnd
	UAS_762x39_57N231
		UAS_BASE_762x39_57N231_10Rnd
		UAS_BASE_762x39_57N231_40Rnd
		UAS_BASE_762x39_57N231_60Rnd

	//556
	UAS_556x45_M856A2
	UAS_556x45_M196 Tracer

	UAS_556x45_M995A1
		UAS_BASE_556_M995A1_20Rnd
		UAS_BASE_556_M995A1_30Rnd
		UAS_BASE_556_M995A1_40Rnd
		UAS_BASE_556_M995A1_60Rnd
	UAS_556x45_M995
		UAS_BASE_556_M995_20Rnd
		UAS_BASE_556_M995_30Rnd
		UAS_BASE_556_M995_40Rnd
		UAS_BASE_556_M995_60Rnd
	UAS_556x45_M855A2
		UAS_BASE_556_M855A2_20Rnd
		UAS_BASE_556_M855A2_30Rnd
		UAS_BASE_556_M855A2_40Rnd
		UAS_BASE_556_M855A2_60Rnd
	UAS_556x45_M193
		UAS_BASE_556_M193_20Rnd
		UAS_BASE_556_M193_30Rnd
		UAS_BASE_556_M193_40Rnd
		UAS_BASE_556_M193_60Rnd

	//762x51
	UAS_762x51_M993
		UAS_BASE_762N_M993_5Rnd
		UAS_BASE_762N_M993_10Rnd
		UAS_BASE_762N_M993_20Rnd
		UAS_BASE_762N_M993_30Rnd
		UAS_BASE_762N_M993_40Rnd
		UAS_BASE_762N_M993_50Rnd
	UAS_762x51_M80A1
		UAS_BASE_762N_M80A1_5Rnd
		UAS_BASE_762N_M80A1_10Rnd
		UAS_BASE_762N_M80A1_20Rnd
		UAS_BASE_762N_M80A1_30Rnd
		UAS_BASE_762N_M80A1_40Rnd
		UAS_BASE_762N_M80A1_50Rnd
	UAS_762x51_M80
		UAS_BASE_762N_M80_5Rnd
		UAS_BASE_762N_M80_10Rnd
		UAS_BASE_762N_M80_20Rnd
		UAS_BASE_762N_M80_30Rnd
		UAS_BASE_762N_M80_40Rnd
		UAS_BASE_762N_M80_50Rnd
	UAS_762x51_M852
		UAS_BASE_762N_M852_5Rnd
		UAS_BASE_762N_M852_10Rnd
		UAS_BASE_762N_M852_20Rnd
		UAS_BASE_762N_M852_30Rnd
		UAS_BASE_762N_M852_40Rnd
		UAS_BASE_762N_M852_50Rnd
*/