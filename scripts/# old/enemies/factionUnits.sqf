// _unitsArray = ["Tier_4"] call compile preprocessFileLineNumbers "scripts\missions\factionUnits.sqf";

//Params
_tier = param [0,""];

_transportTrucks = [ "rhs_gaz66_msv",
									"rhs_gaz66o_msv",
									"rhs_kamaz5350_open_msv",
									"RHS_Ural_MSV_01",
									"RHS_Ural_Open_MSV_01",
									"rhsusf_M1078A1P2_D_fmtv_usarmy",
									"rhsusf_M1078A1P2_B_M2_D_fmtv_usarmy",
									"rhsusf_M1083A1P2_D_fmtv_usarmy",
									"rhsusf_M1083A1P2_B_M2_D_fmtv_usarmy",
									"rhsusf_M1078A1P2_WD_fmtv_usarmy",
									"rhsusf_M1078A1P2_B_M2_WD_fmtv_usarmy",
									"rhsusf_M1083A1P2_B_WD_fmtv_usarmy",
									"rhsusf_M1083A1P2_B_M2_WD_fmtv_usarmy"
								];
_oldTransports = [	"rhsusf_M1232_M2_usarmy_wd",
								"rhsusf_M1083A1P2_B_M2_WD_fmtv_usarmy",
								"rhsusf_m113_usarmy_supply",
								"rhsusf_m113_usarmy_M240"
							];

//officers
_officer = selectRandom[	"LOP_TKA_Infantry_Officer",
									"LOP_SLA_Infantry_Officer",
									"rhs_vmf_flora_officer",
									"rhs_vdv_mflora_officer",
									"rhs_vdv_flora_officer",
									"rhs_vdv_des_officer",
									"rhs_vdv_officer",
									"rhs_rva_crew_officer"];

//Tier 4
_tier4all 			= [	"O_bia_bandits_rifleman_akm",
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
						"O_bia_bandits_mg_mg42"];

_tier4officer 		= 	_officer; 
_tier4riflemen 		= [	"O_bia_bandits_rifleman_akm",
						"O_bia_bandits_rifleman_akm",
						"O_bia_bandits_rifleman_ak74",
						"O_bia_bandits_rifleman_ak74",
						"O_bia_bandits_rifleman_ak74",
						"O_bia_bandits_mg_rpk"]; 
_tier4rifleClasses 	= [	"O_bia_bandits_rifleman_akm",
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
						"O_bia_bandits_mg_rpk"]; 
_tier4at			= [ "O_bia_bandits_rifleman_akm_rpg7_pg",
						"O_bia_bandits_rifleman_ak74_rpg7_pg",
						"O_bia_bandits_rifleman_ak74_rpg7_pg"];
_tier4mg			= [	"O_bia_bandits_mg_pkm",
						"O_bia_bandits_mg_mg42"];
_tier4helis 		= [	"RHS_Mi8mt_vdv"];
_tier4transport 	= _transportTrucks;

//Tier 3
_tier3all 			= [	"O_bia_militia_rifleman_ak103",
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
						
						"O_bia_militia_mg_pkp"];

_tier3officer 		= 	_officer; 
_tier3riflemen 		= [	"O_bia_militia_rifleman_ak103",
						"O_bia_militia_rifleman_ak103",
						"O_bia_militia_rifleman_ak74m",
						"O_bia_militia_rifleman_ak74m",
						"O_bia_militia_rifleman_ak74m"]; 
_tier3rifleClasses 	= [	"O_bia_militia_rifleman_ak103",
						"O_bia_militia_rifleman_ak103",
						"O_bia_militia_rifleman_ak103_rpg7_pg_support",
						"O_bia_militia_grenadier_ak103",
						"O_bia_militia_medic_ak103",
						"O_bia_militia_rifleman_ak74m",
						"O_bia_militia_rifleman_ak74m",
						"O_bia_militia_rifleman_ak74m",
						"O_bia_militia_rifleman_ak74m_rpg7_pg_support",
						"O_bia_militia_grenadier_ak74m",
						"O_bia_militia_medic_ak74m"]; 
_tier3at			= [ "O_bia_militia_rifleman_ak103_rpg7_pg",
						"O_bia_militia_rifleman_ak74m_rpg7_pg",
						"O_bia_militia_rifleman_ak74m_rpg7_pg"];
_tier3mg			= [	"O_bia_militia_mg_pkp"];
_tier3helis 		= [	"RHS_UH60M_d",
								"RHS_Mi8mt_vdv",
								"RHS_Mi24V_vdv"];
_tier3transport 	= _transportTrucks;
						
						
//Tier 2
_tier2all 				= [	"O_bia_army_rifleman_m16",
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
								"O_bia_army_mg_m240"];

_tier2officer 		= 		_officer; 
_tier2riflemen 		= [	"O_bia_army_rifleman_m16",
								"O_bia_army_rifleman_m16",
								"O_bia_army_rifleman_m4",
								"O_bia_army_rifleman_m4",
								"O_bia_army_rifleman_m4"]; 
_tier2rifleClasses 	= [	"O_bia_army_rifleman_m16",
								"O_bia_army_rifleman_m16",
								"O_bia_army_grenadier_m16",
								"O_bia_army_medic_m16",
								"O_bia_army_rifleman_m4",
								"O_bia_army_rifleman_m4",
								"O_bia_army_rifleman_m4",
								"O_bia_army_grenadier_m4",
								"O_bia_army_medic_m4"]; 
_tier2at				= [ 	"O_bia_army_rifleman_m16_m136",
								"O_bia_army_rifleman_m4_m136",
								"O_bia_army_rifleman_m4_m136"];
_tier2mg				= [	"O_bia_army_dmr_m14", 
								"O_bia_army_mg_m249",
								"O_bia_army_mg_m240"];
_tier2helis 			= [	"RHS_CH_47F_10",
									"RHS_Mi8mt_vdv"];
_tier2transport 	= _transportTrucks;
								
//Tier 1
_tier1all 				= [	"O_bia_sf_rifleman_msbs",
								"O_bia_sf_grenadier_msbs",
								"O_bia_sf_medic_msbs",
								"O_bia_sf_rpg32_msbs",
								"O_bia_sf_at_support_msbs",
								"O_bia_sf_rifleman_type115",
								"O_bia_sf_rifleman_scarh",
								"O_bia_sf_medic_scarh",
								"O_bia_sf_rpg32_scarh",
								"O_bia_sf_at_support_scarh",
								"O_bia_sf_mg_m240"];
								
_tier1officer 		= 		_officer; 
_tier1riflemen 		= [	"O_bia_sf_rifleman_msbs",
								"O_bia_sf_rifleman_type115",
								"O_bia_sf_rifleman_scarh"]; 
_tier1rifleClasses 	= [	"O_bia_sf_rifleman_msbs",
								"O_bia_sf_grenadier_msbs",
								"O_bia_sf_medic_msbs",
								"O_bia_sf_rpg32_msbs",
								"O_bia_sf_at_support_msbs",
								"O_bia_sf_rifleman_type115",
								"O_bia_sf_rifleman_scarh",
								"O_bia_sf_medic_scarh",
								"O_bia_sf_rpg32_scarh",
								"O_bia_sf_at_support_scarh"]; 
_tier1at				= [	"O_bia_sf_rpg32_msbs",
								"O_bia_sf_rpg32_scarh"];
_tier1mg				= [	"O_bia_sf_mg_m240"];
_tier1helis 			= [	"RHS_Mi8mt_vdv",
								"B_T_VTOL_01_infantry_F",
								"B_Heli_Transport_03_F"];
_tier1transport 	= _transportTrucks;

//Set respective arrays
private ["_faction","_officer", "_riflemen", "_rifleClasses","_atClasses","_mgClasses","_carsClasses","_heliClasses","_transportClasses"];
switch _tier do {
    case "Tier_4": 	{ 
		_faction 				= "bia_tier4_bandits";
		_officer 					= _tier4officer;
		_riflemen 				= _tier4riflemen;
		_rifleClasses 			= _tier4rifleClasses;
		_atClasses				= _tier4at;
		_mgClasses 			= _tier4mg;
		_heliClasses			= _tier4helis;
		_transportClasses	= _tier4transport;
	};
    case "Tier_3": 	{ 
		_faction 				= "bia_tier3_militia";
		_officer 					= _tier3officer;
		_riflemen 				= _tier3riflemen;
		_rifleClasses 			= _tier3rifleClasses;
		_atClasses				= _tier3at;
		_mgClasses 			= _tier3mg;
		_heliClasses			= _tier3helis;
		_transportClasses	= _tier3transport;
	};
    case "Tier_2": 	{ 
		_faction 				= "bia_tier2_army";
		_officer 					= _tier2officer;
		_riflemen 				= _tier2riflemen;
		_rifleClasses 			= _tier2rifleClasses;
		_atClasses				= _tier2at;
		_mgClasses 			= _tier2mg;
		_heliClasses			= _tier2helis;
		_transportClasses	= _tier2transport;
	};
    case "Tier_1": 	{ 
		_faction 				= "bia_tier2_army";//"bia_tier1_sf";
		_officer 					= _tier1officer;
		_riflemen 				= _tier1riflemen;
		_rifleClasses 			= _tier1rifleClasses;
		_atClasses				= _tier1at;
		_mgClasses 			= _tier1mg;
		_heliClasses			= _tier1helis;
		_transportClasses	= _tier1transport;
	};
};

_returnArray = [_faction,_officer,_riflemen,_rifleClasses,_atClasses,_mgClasses,_heliClasses,_transportClasses];
_returnArray