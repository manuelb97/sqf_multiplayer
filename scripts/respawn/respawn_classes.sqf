#define Flashlight "ACE_Flashlight_XL50"
#define EARPLUGS "ACE_EarPlugs"
#define BANDAGE "ACE_fieldDressing"
#define MORPHINE "ACE_morphine"

#define MAP "ItemMap"
#define GPS "ItemGPS"
#define RADIO "ItemRadio"
#define COMPASS "ItemCompass"
#define WATCH "ItemWatch"

//west
#define US_UNIFORM "rhs_uniform_g3_m81"
#define US_HELMET "rhsusf_mich_bare_norotos_arc_alt"
#define US_BINO "rhsusf_bino_m24_ARD"
#define US_NVG "rhsusf_ANPVS_14"
#define US_Backpack "VSM_OGA_Backpack_Compact"

#define US_PISTOL "rhsusf_weap_m9"
#define US_PISTOL_MAG "rhsusf_mag_15Rnd_9x19_JHP"
#define US_556_MAG "rhs_mag_30Rnd_556x45_M855A1_PMAG"

#define US_FRAG "HandGrenade"
#define US_SMOKE "SmokeShellBlue"
#define US_FLASHBANG "ACE_M84"

#define US_REDDOT "rhsusf_acc_compm4"
#define US_FLASH "rhsusf_acc_wmx_bk"
#define US_GRIP "rhsusf_acc_kac_grip"

//east
#define RU_UNIFORM "rhs_uniform_flora_patchless"
#define RU_HELMET "rhs_6b26_bala"
#define RU_BINO "rhssaf_zrak_rd7j"
#define RU_NVG "rhs_1PN138"
#define RU_Backpack "rhs_rd54_flora2"

#define RU_PISTOL "rhs_weap_pya"
#define RU_PISTOL_MAG "rhs_mag_9x19_17"
#define RU_556_MAG "rhs_30Rnd_545x39_7N10_AK"

#define RU_FRAG "rhs_mag_rgd5"
#define RU_SMOKE "SmokeShellRed"
#define RU_FLASHBANG "ACE_M84"

#define RU_REDDOT "rhsusf_acc_eotech_xps3"
#define RU_FLASH "rhs_acc_2dpZenit_ris"
#define RU_GRIP "rhs_acc_grip_ffg2"

class CfgRespawnInventory
{
	//House Raids
	class West_House_Raids
	{
		role = "BiA_Rifleman";
		show = "true";
		uniformClass = "U_BG_Guerrilla_6_1";
		backpack = "";
		weapons[] = {"rhssaf_zrak_rd7j"};
		magazines[] = {};
		items[] = {
			Flashlight, EARPLUGS, 
			BANDAGE, BANDAGE, BANDAGE, 
			BANDAGE, BANDAGE, BANDAGE, 
			BANDAGE, BANDAGE, BANDAGE, 
			MORPHINE, MORPHINE, MORPHINE
		};
		linkedItems[] = {MAP, GPS, RADIO, COMPASS, WATCH};
	};

	class West_House_Raids_0: West_House_Raids
	{
		displayName = "Level 0";
		linkedItems[] += {
			"V_BandollierB_oli", "H_Booniehat_oli", "rhsusf_shemagh2_grn", "rhs_1PN138"
		};
	};

	class West_House_Raids_1: West_House_Raids
	{
		displayName = "Level 1";
		backpack = "B_AssaultPack_khk";
		linkedItems[] += {
			"V_TacVest_oli", "rhsgref_helmet_M1_liner", "rhsusf_shemagh2_grn", "rhs_1PN138"
		};
	};

	class West_House_Raids_2: West_House_Raids
	{
		displayName = "Level 2";
		backpack = "B_AssaultPack_khk";
		weapons[] = {"rhs_pdu4"};
		linkedItems[] += {
			"V_TacVest_oli", "rhsgref_helmet_M1_liner", "rhsusf_shemagh2_grn", "rhs_1PN138"
		};
	};

	class West_House_Raids_3: West_House_Raids
	{
		displayName = "Level 3";
		uniformClass = "rhsgref_uniform_og107";
		backpack = "B_FieldPack_khk";
		weapons[] = {"rhs_pdu4"};
		linkedItems[] += {
			"rhs_6b2_chicom", "rhs_6b7_1m_bala2_emr", "rhs_googles_black", "rhs_1PN138"
		};
	};

	class West_House_Raids_4: West_House_Raids
	{
		displayName = "Level 4";
		uniformClass = "rhsgref_uniform_og107";
		backpack = "B_FieldPack_khk";
		weapons[] = {"ACE_Vector"};
		linkedItems[] += {
			"rhs_6b2_chicom", "rhs_6b7_1m_bala2_emr", "rhs_googles_black", "rhsusf_ANPVS_15"
		};
	};

	class West_House_Raids_5: West_House_Raids
	{
		displayName = "Level 5";
		uniformClass = "rhs_uniform_6sh122_gloves_v1";
		backpack = "rhs_rd54_emr1";
		weapons[] = {"ACE_Vector"};
		linkedItems[] += {
			"rhs_6b23_digi_6sh92_spetsnaz2", "rhs_6b26_digi_bala", "rhsusf_ANPVS_15"
		};
	};

	class West_House_Raids_6: West_House_Raids
	{
		displayName = "Level 6";
		uniformClass = "rhs_uniform_6sh122_gloves_v1";
		backpack = "rhs_rd54_emr1";
		weapons[] = {"ACE_MX2A"};
		linkedItems[] += {
			"rhs_6b23_digi_6sh92_spetsnaz2", "rhs_6b26_digi_bala", "rhsusf_ANPVS_15"
		};
	};

	class West_House_Raids_7: West_House_Raids
	{
		displayName = "Level 7";
		uniformClass = "rhs_uniform_vkpo_gloves_alt";
		backpack = "rhs_tortila_emr";
		weapons[] = {"ACE_MX2A"};
		linkedItems[] += {
			"rhs_6b45_rifleman", "rhs_6b26_digi_bala", "O_NVGoggles_ghex_F"
		};
	};

	//PvP
	class West_Basic
	{
		role = "BiA_Rifleman";
		show = "true";
		uniformClass = US_UNIFORM;
		backpack = "";
		weapons[] = {US_PISTOL, US_BINO};
		magazines[] = {US_PISTOL_MAG, US_PISTOL_MAG, US_FRAG,  US_SMOKE, US_FLASHBANG};
		items[] = {
			Flashlight, EARPLUGS, 
			BANDAGE, BANDAGE, BANDAGE, 
			BANDAGE, BANDAGE, BANDAGE, 
			BANDAGE, BANDAGE, BANDAGE, 
			MORPHINE, MORPHINE, MORPHINE
		};
		linkedItems[] = {US_FLASH, MAP, GPS, RADIO, COMPASS, WATCH, US_HELMET, US_NVG};
	};

	class West_Rifleman: West_Basic
	{
		displayName = "0 Standard";
		weapons[] += {"rhs_weap_m4a1_blockII"};
		magazines[] += {US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG};
		linkedItems[] += {
			"rhsusf_acc_SFMB556",
			"rhsusf_mbav_rifleman",
			US_REDDOT, US_GRIP
		};
	};

	class West_CQB_Specialist: West_Basic
	{
		displayName = "1 CQB";
		weapons[] += {"rhs_weap_mk18_grip"};
		magazines[] += {
			US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG,
			US_FRAG, US_FLASHBANG
		};
		items[] += {BANDAGE, BANDAGE, BANDAGE, MORPHINE};
		linkedItems[] += {
			"rhsusf_acc_SFMB556",
			"rhsusf_mbav_rifleman",
			US_REDDOT, US_GRIP
		};
	};

	class West_Heavy_Rifleman: West_Basic
	{
		displayName = "2 Heavy";
		weapons[] += {"rhs_weap_SCARH_CQC"};
		magazines[] += {
			"rhs_mag_20Rnd_SCAR_762x51_m80a1_epr", "rhs_mag_20Rnd_SCAR_762x51_m80a1_epr", "rhs_mag_20Rnd_SCAR_762x51_m80a1_epr",
			"rhs_mag_20Rnd_SCAR_762x51_m80a1_epr", "rhs_mag_20Rnd_SCAR_762x51_m80a1_epr"
		};
		linkedItems[] += {
			"rhsusf_mbav_rifleman",
			US_REDDOT, US_GRIP
		};
	};

	class West_Medic: West_Basic
	{
		displayName = "3 Medic";
		weapons[] += {"rhs_weap_mk18_grip"};
		magazines[] += {US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG};
		items[] += {
			BANDAGE, BANDAGE, BANDAGE, 
			BANDAGE, BANDAGE, BANDAGE, 
			BANDAGE, BANDAGE, BANDAGE, 
			MORPHINE, MORPHINE, MORPHINE,
			"ACE_personalAidKit"
		};
		linkedItems[] += {
			"rhsusf_acc_SFMB556",
			"rhsusf_mbav_rifleman",
			US_REDDOT, US_GRIP
		};
	};

	class West_Grenadier: West_Basic
	{
		displayName = "0 Grenadier (GL)";
		role = "BiA_Explosive";
		weapons[] += {"rhs_weap_mk18_m320"};
		magazines[] += {
			US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG,
			"1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell",
			"1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell"
		};
		linkedItems[] += {
			"rhsusf_acc_SFMB556",
			"rhsusf_mbav_grenadier", //change
			US_REDDOT
		};
	};

	class West_Grenadier_Launcher: West_Basic
	{
		displayName = "2 Grenadier (Launcher)";
		role = "BiA_Explosive";
		backpack = US_Backpack;
		weapons[] += {"rhs_weap_mk18", "rhs_weap_maaws"};
		magazines[] += {
			US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG,
			"rhs_mag_maaws_HE", "rhs_mag_maaws_HE", "rhs_mag_maaws_HE"
		};
		linkedItems[] += {
			"rhsusf_acc_SFMB556",
			"rhsusf_mbav_rifleman",
			US_REDDOT, US_GRIP
		};
	};

	class West_AT: West_Basic
	{
		displayName = "3 Anti Tank";
		role = "BiA_Explosive";
		backpack = US_Backpack;
		weapons[] += {"rhs_weap_mk18", "rhs_weap_maaws"};
		magazines[] += {
			US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG,
			"rhs_mag_maaws_HEAT", "rhs_mag_maaws_HEAT", "rhs_mag_maaws_HEAT"
		};
		linkedItems[] += {
			"rhsusf_acc_SFMB556",
			"rhsusf_mbav_rifleman",
			US_REDDOT, US_GRIP
		};
	};

	class West_Mine: West_Basic
	{
		displayName = "4 Mine Specialist";
		role = "BiA_Explosive";
		backpack = US_Backpack;
		weapons[] += {"rhs_weap_mk18"};
		magazines[] += {
			US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG
			// add mines, comma after last line 
		};
		linkedItems[] += {
			"rhsusf_acc_SFMB556",
			"rhsusf_mbav_rifleman",
			US_REDDOT, US_GRIP
		};
	};

	class West_AR: West_Basic
	{
		displayName = "0 Auto Rifleman";
		role = "BiA_Gunner";
		backpack = US_Backpack;
		weapons[] += {"rhs_weap_m27iar_grip"};
		magazines[] += {US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG};
		linkedItems[] += {
			"rhsusf_acc_SFMB556",
			"rhsusf_mbav_mg", //change
			US_REDDOT, "rhsusf_acc_harris_bipod"
		};
	};

	class West_LMG: West_Basic
	{
		displayName = "1 Light Machine Gunner";
		role = "BiA_Gunner";
		backpack = US_Backpack;
		weapons[] += {"rhs_weap_m249_pip_L"};
		magazines[] += {"rhsusf_200rnd_556x45_mixed_box", "rhsusf_200rnd_556x45_mixed_box", "rhsusf_200rnd_556x45_mixed_box"};
		linkedItems[] += {
			"rhsusf_acc_SFMB556",
			"rhsusf_mbav_mg", //change
			US_REDDOT, "rhsusf_acc_kac_grip_saw_bipod"
		};
	};

	class West_MMG: West_Basic
	{
		displayName = "2 Medium Machine Gunner";
		role = "BiA_Gunner";
		backpack = US_Backpack;
		weapons[] += {"rhs_weap_m240B"};
		magazines[] += {"rhsusf_100Rnd_762x51_m80a1epr", "rhsusf_100Rnd_762x51_m80a1epr", "rhsusf_100Rnd_762x51_m80a1epr"};
		linkedItems[] += {
			"rhsusf_acc_ARDEC_M240", 
			"rhsusf_mbav_mg", //change
			US_REDDOT
		};
	};

	class West_SPR: West_Basic
	{
		displayName = "1 Light DMR";
		role = "BiA_Marksman";
		weapons[] += {"rhs_weap_m16a4_imod"};
		magazines[] += {US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG, US_556_MAG};
		linkedItems[] += {
			"rhsusf_acc_SFMB556",
			"rhsusf_mbav_rifleman",
			"rhsusf_acc_ACOG", "rhsusf_acc_harris_bipod"
		};
	};

	class West_DMR: West_Basic
	{
		displayName = "2 DMR";
		role = "BiA_Marksman";
		weapons[] += {"rhs_weap_sr25_ec"};
		magazines[] += {
			"ACE_20Rnd_762x51_M993_AP_mag", "ACE_20Rnd_762x51_M993_AP_mag", 
			"ACE_20Rnd_762x51_M993_AP_mag", "ACE_20Rnd_762x51_M993_AP_mag", 
			"ACE_20Rnd_762x51_M993_AP_mag"
		};
		linkedItems[] += {
			"rhsusf_mbav_rifleman",
			"rhsusf_acc_LEUPOLDMK4", "rhsusf_acc_harris_bipod"
		};
	};

	class West_Sniper: West_Basic
	{
		displayName = "3 Sniper";
		role = "BiA_Marksman";
		weapons[] += {"rhs_weap_XM2010"};
		magazines[] += {
			"rhsusf_5Rnd_300winmag_xm2010", "rhsusf_5Rnd_300winmag_xm2010", 
			"rhsusf_5Rnd_300winmag_xm2010", "rhsusf_5Rnd_300winmag_xm2010",
			"rhsusf_5Rnd_300winmag_xm2010", "rhsusf_5Rnd_300winmag_xm2010",
			"rhsusf_5Rnd_300winmag_xm2010", "rhsusf_5Rnd_300winmag_xm2010"
		};
		linkedItems[] += {
			"rhsusf_mbav_rifleman",
			"rhsusf_acc_M8541", "rhsusf_acc_harris_bipod"
		};
	};

	//East
	class East_Basic
	{
		role = "BiA_Rifleman";
		show = "true";
		uniformClass = RU_UNIFORM;
		backpack = "";
		weapons[] = {RU_PISTOL, US_BINO};
		magazines[] = {RU_PISTOL_MAG, RU_PISTOL_MAG, RU_FRAG,  RU_SMOKE, RU_FLASHBANG};
		items[] = {
			Flashlight, EARPLUGS, 
			BANDAGE, BANDAGE, BANDAGE, 
			BANDAGE, BANDAGE, BANDAGE, 
			BANDAGE, BANDAGE, BANDAGE, 
			MORPHINE, MORPHINE, MORPHINE
		};
		linkedItems[] = {MAP, GPS, RADIO, COMPASS, WATCH, RU_HELMET, RU_NVG};
	};

	class East_Rifleman: East_Basic
	{
		displayName = "0 Standard";
		weapons[] += {"rhs_weap_ak74m_zenitco01_b33"};
		magazines[] += {RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG};
		linkedItems[] += {
			"rhs_acc_dtk",
			"rhs_6b23_6sh116_flora",
			RU_REDDOT, RU_GRIP
		};
	};

	class East_CQB_Specialist: East_Basic
	{
		displayName = "1 CQB";
		weapons[] += {"rhs_weap_ak105_zenitco01_b33_grip1"};
		magazines[] += {
			RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG,
			RU_FRAG, RU_FLASHBANG
		};
		items[] += {BANDAGE, BANDAGE, BANDAGE, MORPHINE};
		linkedItems[] += {
			"rhs_acc_pgs64",
			"rhs_6b23_6sh116_flora",
			RU_REDDOT, RU_GRIP
		};
	};

	class East_Heavy_Rifleman: East_Basic
	{
		displayName = "2 Heavy";
		weapons[] += {"rhs_weap_ak104_zenitco01_b33"};
		magazines[] += {
			"rhs_30Rnd_762x39mm_polymer", "rhs_30Rnd_762x39mm_polymer", "rhs_30Rnd_762x39mm_polymer",
			"rhs_30Rnd_762x39mm_polymer", "rhs_30Rnd_762x39mm_polymer"
		};
		linkedItems[] += {
			"rhs_acc_pgs64",
			"rhs_6b23_6sh116_flora",
			RU_REDDOT, RU_GRIP
		};
	};

	class East_Medic: East_Basic
	{
		displayName = "3 Medic";
		weapons[] += {"rhs_weap_ak105_zenitco01_b33_grip1"};
		magazines[] += {RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG};
		items[] += {
			BANDAGE, BANDAGE, BANDAGE, 
			BANDAGE, BANDAGE, BANDAGE, 
			BANDAGE, BANDAGE, BANDAGE, 
			MORPHINE, MORPHINE, MORPHINE,
			"ACE_personalAidKit"
		};
		linkedItems[] += {
			"rhs_acc_pgs64",
			"rhs_6b23_6sh116_flora",
			RU_REDDOT, RU_GRIP
		};
	};

	class East_Grenadier: East_Basic
	{
		displayName = "0 Grenadier (GL)";
		role = "BiA_Explosive";
		weapons[] += {"rhs_weap_ak74mr_gp25"};
		magazines[] += {
			RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG,
			"rhs_VOG25", "rhs_VOG25", "rhs_VOG25", "rhs_VOG25",
			"rhs_VOG25", "rhs_VOG25", "rhs_VOG25", "rhs_VOG25"
		};
		linkedItems[] += {
			"rhs_acc_dtk",
			"rhs_6b23_6sh92_vog", //change
			RU_REDDOT
		};
	};

	class East_Grenadier_Launcher: East_Basic
	{
		displayName = "1 Grenadier (Launcher)";
		role = "BiA_Explosive";
		backpack = RU_Backpack;
		weapons[] += {"rhs_weap_ak105_zenitco01_b33_grip1", "rhs_weap_rpg7"};
		magazines[] += {
			RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG,
			"rhs_rpg7_OG7V_mag", "rhs_rpg7_OG7V_mag", "rhs_rpg7_OG7V_mag"
		};
		linkedItems[] += {
			"rhs_acc_pgs64",
			"rhs_6b23_6sh116_flora",
			RU_REDDOT, RU_GRIP
		};
	};

	class East_AT: East_Basic
	{
		displayName = "2 Anti Tank";
		role = "BiA_Explosive";
		backpack = RU_Backpack;
		weapons[] += {"rhs_weap_ak105_zenitco01_b33_grip1", "rhs_weap_rpg7"};
		magazines[] += {
			RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG,
			"rhs_rpg7_PG7VL_mag", "rhs_rpg7_PG7VL_mag", "rhs_rpg7_PG7VL_mag"
		};
		linkedItems[] += {
			"rhs_acc_pgs64",
			"rhs_6b23_6sh116_flora",
			RU_REDDOT, RU_GRIP
		};
	};

	class East_Mine: East_Basic
	{
		displayName = "3 Mine Specialist";
		role = "BiA_Explosive";
		backpack = RU_Backpack;
		weapons[] += {"rhs_weap_ak105_zenitco01_b33_grip1"};
		magazines[] += {
			RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG
			// add mines, comma after last line 
		};
		linkedItems[] += {
			"rhs_acc_pgs64",
			"rhs_6b23_6sh116_flora",
			RU_REDDOT, RU_GRIP
		};
	};

	class East_AR: East_Basic
	{
		displayName = "0 Auto Rifleman";
		role = "BiA_Gunner";
		backpack = RU_Backpack;
		weapons[] += {"rhs_weap_rpk74m_npz"};
		magazines[] += {RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG};
		linkedItems[] += {
			"rhs_acc_dtk1983",
			"rhs_6b23_6sh116_flora", //change
			RU_REDDOT, "rhs_acc_2dpZenit"
		};
	};

	class East_LMG: East_Basic
	{
		displayName = "1 Light Machine Gunner";
		role = "BiA_Gunner";
		backpack = RU_Backpack;
		weapons[] += {"rhs_weap_rpk74m_npz"};
		magazines[] += {"rhs_60Rnd_545X39_7N10_AK", "rhs_60Rnd_545X39_7N10_AK", "rhs_60Rnd_545X39_7N10_AK"};
		linkedItems[] += {
			"rhs_acc_dtk1983",
			"rhs_6b23_6sh116_flora", //change
			RU_REDDOT, "rhs_acc_2dpZenit"
		};
	};

	class East_MMG: East_Basic
	{
		displayName = "2 Medium Machine Gunner";
		role = "BiA_Gunner";
		backpack = RU_Backpack;
		weapons[] += {"rhs_weap_pkp"};
		magazines[] += {"rhs_100Rnd_762x54mmR_7N13", "rhs_100Rnd_762x54mmR_7N13", "rhs_100Rnd_762x54mmR_7N13"};
		linkedItems[] += {
			"rhs_6b23_6sh116_flora", //change
			"rhs_acc_pkas"
		};
	};

	class East_SPR: East_Basic
	{
		displayName = "0 Light DMR";
		role = "BiA_Marksman";
		weapons[] += {"rhs_weap_ak74m_zenitco01_b33"};
		magazines[] += {RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG, RU_556_MAG};
		linkedItems[] += {
			"rhs_acc_dtk", "rhs_acc_2dpZenit_ris",
			"rhs_6b23_6sh116_flora",
			"rhsusf_acc_ACOG", "rhsusf_acc_grip1"
		};
	};

	class East_DMR: East_Basic
	{
		displayName = "1 DMR";
		role = "BiA_Marksman";
		weapons[] += {"rhs_weap_svds_npz"};
		magazines[] += {
			"rhs_10Rnd_762x54mmR_7N1", "rhs_10Rnd_762x54mmR_7N1", 
			"rhs_10Rnd_762x54mmR_7N1", "rhs_10Rnd_762x54mmR_7N1", 
			"rhs_10Rnd_762x54mmR_7N1", "rhs_10Rnd_762x54mmR_7N1", 
			"rhs_10Rnd_762x54mmR_7N1", "rhs_10Rnd_762x54mmR_7N1"
		};
		linkedItems[] += {
			"rhs_6b23_6sh116_flora",
			"rhsusf_acc_LEUPOLDMK4"
		};
	};

	class East_Sniper: East_Basic
	{
		displayName = "2 Sniper";
		role = "BiA_Marksman";
		weapons[] += {"rhs_weap_t5000"};
		magazines[] += {
			"rhs_5Rnd_338lapua_t5000", "rhs_5Rnd_338lapua_t5000", 
			"rhs_5Rnd_338lapua_t5000", "rhs_5Rnd_338lapua_t5000", 
			"rhs_5Rnd_338lapua_t5000", "rhs_5Rnd_338lapua_t5000", 
			"rhs_5Rnd_338lapua_t5000", "rhs_5Rnd_338lapua_t5000"
		};
		linkedItems[] += {
			"rhs_6b23_6sh116_flora",
			"rhsusf_acc_M8541", "rhs_acc_harris_swivel"
		};
	};
};