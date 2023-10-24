// _unitsArray = ["Tier_4"] call compile preprocessFileLineNumbers "scripts\enemies\factionUnits.sqf";

//Params
_tier = param [0,""];

//officers
_officer = selectRandom
[
	/*
	"LOP_TKA_Infantry_Officer",
	"LOP_SLA_Infantry_Officer",
	"rhs_vmf_flora_officer",
	"rhs_vdv_mflora_officer",
	"rhs_vdv_flora_officer",
	"rhs_vdv_des_officer",
	"rhs_vdv_officer",
	"rhs_rva_crew_officer"
	*/

	"rhs_vdv_officer_armored",
	"rhssaf_army_o_m10_para_officer"
];

/*
RHS_M2A2
B_APC_Wheeled_01_cannon_F
rhs_btr60_msv
rhs_btr80a_msv
rhs_bmp1_msv
rhs_bmp1d_msv
rhs_bmp1k_msv
rhs_bmp1p_msv
rhs_bmp2e_msv
rhs_bmp2_msv
rhs_bmp2d_msv
rhs_bmp2_msv
rhs_bmp2k_msv
rhs_bmp3_msv
rhs_bmp3_late_msv
rhs_bmp3m_msv
rhs_bmp3mera_msv
rhs_brm1k_msv
rhs_Ob_681_2
rhs_t15_tv

rhsgref_ins_uaz_spg9
LOP_BH_Landrover_SPG9
O_G_Offroad_01_AT_F
rhsusf_m1045_d
B_LSV_01_AT_F

B_APC_Tracked_01_AA_F
rhs_zsu234_aa
*/

// "_faction", "_officer", "_infantry", "_riflemen","_rifleClasses","_atClasses","_mgClasses","_transportClasses","_fightingClasses","_heliClasses"

//Tier 4
_tier4 = 
[
	"bia_tier4_bandits",
	[_officer],
	[
		"O_bia_bandits_rifleman_akm",
		"O_bia_bandits_rifleman_akm_rpg7_pg",
		"O_bia_bandits_rifleman_akm_rpg7_pg_support",
		"O_bia_bandits_grenadier_akm",
		"O_bia_bandits_medic_akm",
		"O_bia_bandits_pk_support_akm",
		"O_bia_bandits_mg42_support_akm",
		
		"O_bia_bandits_rifleman_ak74",
		"O_bia_bandits_rifleman_ak74_rpg7_pg",
		"O_bia_bandits_rifleman_ak74_rpg7_pg_support",
		"O_bia_bandits_grenadier_ak74",
		"O_bia_bandits_medic_ak74",
		"O_bia_bandits_pk_support_ak74",
		"O_bia_bandits_mg42_support_ak74",
		
		"O_bia_bandits_mg_rpk",
		"O_bia_bandits_mg_pkm",
		"O_bia_bandits_mg_mg42"
	],
	[
		"O_bia_bandits_rifleman_akm",
		"O_bia_bandits_rifleman_akm",
		"O_bia_bandits_rifleman_ak74",
		"O_bia_bandits_rifleman_ak74",
		"O_bia_bandits_rifleman_ak74",
		"O_bia_bandits_mg_rpk"
	],
	[
		"O_bia_bandits_rifleman_akm",
		"O_bia_bandits_rifleman_akm",
		"O_bia_bandits_rifleman_akm_rpg7_pg_support",
		"O_bia_bandits_grenadier_akm",
		"O_bia_bandits_medic_akm",
		"O_bia_bandits_rifleman_ak74",
		"O_bia_bandits_rifleman_ak74",
		"O_bia_bandits_rifleman_ak74",
		"O_bia_bandits_rifleman_ak74_rpg7_pg_support",
		"O_bia_bandits_grenadier_ak74",
		"O_bia_bandits_medic_ak74",
		"O_bia_bandits_mg_rpk"
	],
	[
		"O_bia_bandits_rifleman_akm_rpg7_pg", 
		"O_bia_bandits_rifleman_ak74_rpg7_pg", 
		"O_bia_bandits_rifleman_ak74_rpg7_pg"
	],
	[
		"O_bia_bandits_mg_pkm", 
		"O_bia_bandits_mg_mg42"
	],
	[
		"rhs_gaz66_msv",
		"rhs_gaz66o_msv"
	],
	[
		"rhsusf_m1025_w_m2",
		"LOP_IRA_Landrover_M2",
		"LOP_SLA_UAZ_DshKM"

		/*
		"rhs_gaz66_zu23_msv",
		"rhs_btr60_msv"
		"rhs_bmp2k_msv"
		"rhs_bmp1p_msv"
		"rhs_btr80a_msv"
		*/
	],
	[
		"RHS_Mi8mt_vdv"
	]
];

//Tier 3
_tier3 =
[
	"bia_tier3_militia",
	[_officer],
	[
		"O_bia_militia_rifleman_ak103",
		"O_bia_militia_rifleman_ak103_rpg7_pg",
		"O_bia_militia_rifleman_ak103_rpg7_pg_support",
		"O_bia_militia_grenadier_ak103",
		"O_bia_militia_medic_ak103",
		"O_bia_militia_pkp_support_ak103",
		
		"O_bia_militia_rifleman_ak74m",
		"O_bia_militia_rifleman_ak74m_rpg7_pg",
		"O_bia_militia_rifleman_ak74m_rpg7_pg_support",
		"O_bia_militia_grenadier_ak74m",
		"O_bia_militia_medic_ak74m",
		"O_bia_militia_pkp_support_ak74m",
		
		"O_bia_militia_mg_pkp"
	],
	[
		"O_bia_militia_rifleman_ak103",
		"O_bia_militia_rifleman_ak103",
		"O_bia_militia_rifleman_ak74m",
		"O_bia_militia_rifleman_ak74m",
		"O_bia_militia_rifleman_ak74m"
	],
	[
		"O_bia_militia_rifleman_ak103",
		"O_bia_militia_rifleman_ak103",
		"O_bia_militia_rifleman_ak103_rpg7_pg_support",
		"O_bia_militia_grenadier_ak103",
		"O_bia_militia_medic_ak103",
		"O_bia_militia_rifleman_ak74m",
		"O_bia_militia_rifleman_ak74m",
		"O_bia_militia_rifleman_ak74m",
		"O_bia_militia_rifleman_ak74m_rpg7_pg_support",
		"O_bia_militia_grenadier_ak74m",
		"O_bia_militia_medic_ak74m"
	],
	[
		"O_bia_militia_rifleman_ak103_rpg7_pg",
		"O_bia_militia_rifleman_ak74m_rpg7_pg",
		"O_bia_militia_rifleman_ak74m_rpg7_pg"
	],
	[
		"O_bia_militia_mg_pkp"
	],
	[
		"RHS_Ural_MSV_01",
		"RHS_Ural_Open_MSV_01"
	],
	[
		"rhs_tigr_sts_msv",
		"rhsusf_M1220_M2_usarmy_wd",
		"rhsusf_m1151_m240_v1_usarmy_wd",
		"rhsusf_m1151_m2_v1_usarmy_wd"

		/*
		"rhs_btr60_msv"
		"RHS_Ural_Zu23_MSV_01",
		"rhs_bmp2k_msv"
		"rhs_bmp1p_msv"
		*/
	],
	[
		"RHS_UH60M_d",
		"RHS_Mi8mt_vdv",
		"RHS_Mi24V_vdv"
	]
];
					
//Tier 2 
//"_infantry", "_riflemen","_rifleClasses","_atClasses","_mgClasses","_transportClasses","_fightingClasses","_heliClasses"
_tier2 = 
[
	"bia_tier2_army",
	[_officer],
	[
		"O_bia_army_rifleman_m16",
		"O_bia_army_rifleman_m16_m136",
		"O_bia_army_grenadier_m16",
		"O_bia_army_medic_m16",
		"O_bia_army_m249_support_m16",
		"O_bia_army_m240_support_m16",
		
		"O_bia_army_rifleman_m4",
		"O_bia_army_rifleman_m4_m136",
		"O_bia_army_grenadier_m4",
		"O_bia_army_medic_m4",
		"O_bia_army_m249_support_m4",
		"O_bia_army_m240_support_m4",

		"O_bia_army_dmr_m14",
		"O_bia_army_mg_m249",
		"O_bia_army_mg_m240"
	],
	[
		"O_bia_army_rifleman_m16",
		"O_bia_army_rifleman_m4"
	],
	[
		"rhs_msv_emr_rifleman",
		"rhs_msv_emr_grenadier",
		"rhs_msv_emr_armoredcrew",
		"rhs_msv_emr_driver_armored",
		"rhs_msv_emr_engineer",
		"rhs_msv_emr_grenadier_rpg",
		"rhs_msv_emr_strelok_rpg_assist",
		"rhs_msv_emr_machinegunner_assistant",
		"rhs_msv_emr_marksman",
		"rhs_msv_emr_medic"
	],
	[
		"rhs_msv_emr_at"
	],
	[
		"rhs_msv_emr_arifleman",
		"rhs_msv_emr_machinegunner"
	],
	[
		"rhsgref_BRDM2_HQ_msv",
		"rhsusf_M1220_M2_usarmy_wd"
	],
	[
		"rhsgref_BRDM2_msv",
		"rhs_btr60_msv"

		/*
		"B_APC_Tracked_01_AA_F",
		"rhs_bmp2k_msv"
		"rhs_bmp1p_msv"
		"rhs_bmp3_msv"
		"rhs_brm1k_msv"
		"rhs_t15_tv"
		*/
	],
	[
		"RHS_CH_47F_10", 
		"RHS_Mi8mt_vdv"
	]
];
								
//Tier 1
_tier1 = 
[
	"russian_msv",
	[_officer],
	[
		"rhs_msv_emr_rifleman",
		"rhs_msv_emr_grenadier",
		"rhs_msv_emr_armoredcrew",
		"rhs_msv_emr_driver_armored",
		"rhs_msv_emr_engineer",
		"rhs_msv_emr_grenadier_rpg",
		"rhs_msv_emr_strelok_rpg_assist",
		"rhs_msv_emr_machinegunner_assistant",
		"rhs_msv_emr_marksman",
		"rhs_msv_emr_medic",

		"rhs_msv_emr_at",
		"rhs_msv_emr_LAT",
		"rhs_msv_emr_RShG2",

		"rhs_msv_emr_arifleman",
		"rhs_msv_emr_machinegunner"
	],
	[
		"rhs_msv_emr_rifleman"
	],
	[
		"rhs_msv_emr_rifleman",
		"rhs_msv_emr_grenadier",
		"rhs_msv_emr_armoredcrew",
		"rhs_msv_emr_driver_armored",
		"rhs_msv_emr_engineer",
		"rhs_msv_emr_grenadier_rpg",
		"rhs_msv_emr_strelok_rpg_assist",
		"rhs_msv_emr_machinegunner_assistant",
		"rhs_msv_emr_marksman",
		"rhs_msv_emr_medic"
	],
	[
		"rhs_msv_emr_at"
	],
	[
		"rhs_msv_emr_arifleman",
		"rhs_msv_emr_machinegunner"
	],
	[
		"rhsusf_M1078A1P2_B_M2_WD_fmtv_usarmy",
		"rhsusf_M1083A1P2_B_M2_WD_fmtv_usarmy"
	],
	[
		"rhs_btr60_msv"

		/*
		rhs_zsu234_aa",
		rhs_btr80a_msv",
		"RHS_M2A2"
		"rhs_bmp3_msv",
		"B_APC_Wheeled_01_cannon_F",
		*/
	],
	[
		"RHS_Mi8mt_vdv",
		"B_T_VTOL_01_infantry_F",
		"B_Heli_Transport_03_F"
	]
];

//Set respective arrays
_tierNumStr = _tier select [((count _tier) - 1), 1];
_tierNum = parseNumber(_tierNumStr);
_tierArrs = [_tier4, _tier3, _tier2, _tier1];

_tierArrs select abs(_tierNum - 4)

/*
_ret = [];
switch _tier do 
{
    case "Tier_4":
	{
		_ret = _tier4;
	};
    case "Tier_3":
	{ 
		_ret = _tier3;
	};
    case "Tier_2":
	{ 
		_ret = _tier2;
	};
    case "Tier_1":
	{ 
		_ret = _tier1;
	};
};

_txt = "Tier_2"
_arrs = [4, 3, 2, 1]

_tierNum = int(_txt[-1])

_arrs[abs(_tierNum - 4)]

_ret


_vehicles 	= 
[
	"LOP_NK_UAZ_DshKM"
	,"LOP_IRA_Landrover_M2"
	,"rhs_gaz66_zu23_msv"
	,"RHS_Ural_Zu23_MSV_01"
	//, "LOP_NK_BTR60"
]; 
*/