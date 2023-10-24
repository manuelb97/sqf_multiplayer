//Paras
params [
"_unit",
"_loadout",
"_at",
"_debug"
];

_tag = "AISupportSquadEquipment";

//Base Equipment
removeUniform 					_unit;
removeVest 						_unit;
removeBackpack 				_unit;
removeHeadgear 				_unit;
removeGoggles 				_unit;
removeAllAssignedItems	_unit;
removeAllWeapons 			_unit;
removeAllItems 				_unit;
uiSleep 0.1;

//Standard items
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
_unit linkItem "ACE_Altimeter";
_unit linkItem "rhsusf_ANPVS_15";	//selectRandom["rhs_1PN138","rhsusf_ANPVS_15","O_NVGoggles_ghex_F"];
uiSleep 0.1;

//Basic Equipment
_unit forceAddUniform "dgr_uniform15"; 							//"VSM_Multicam_Camo";
_unit addVest "dgr_vestB15";											//"VSM_LBT6094_operator_Multicam";
_unit addBackpack "dgr_pack15";									//"VSM_Multicam_Backpack_Kitbag";
_unit addHeadgear "dgr_ch15";										//"VSM_OPS_multicam";
_unit addGoggles "VSM_Balaclava2_OD_Peltor_Goggles";
uiSleep 0.1;

//Medicals & Nades
_unit addWeapon selectRandom["ACE_Vector"]; //"rhssaf_zrak_rd7j","rhs_pdu4", "Laserdesignator_03","Laserbatteries"
[_unit,"ACE_EarPlugs",1,""] 			execVM "scripts\loadouts\addItemEffectively.sqf"; 
[_unit,"ACE_fieldDressing",21,""] 	execVM "scripts\loadouts\addItemEffectively.sqf"; 
[_unit,"ACE_morphine",7,""] 			execVM "scripts\loadouts\addItemEffectively.sqf"; 
[_unit,"ACE_epinephrine",2,""] 		execVM "scripts\loadouts\addItemEffectively.sqf"; 
uiSleep 0.1;
[_unit,"B_IR_Grenade",1,""] 			execVM "scripts\loadouts\addItemEffectively.sqf"; 
[_unit,"rhs_mag_m18_green",1,""] 	execVM "scripts\loadouts\addItemEffectively.sqf"; 
[_unit,"HandGrenade",2,""] 			execVM "scripts\loadouts\addItemEffectively.sqf"; 
uiSleep 0.1;

if (_loadout == "RifleUnsuppressed") then
{
	_unit addWeapon "rhs_weap_m4a1_blockII_KAC_d";
	_unit addPrimaryWeaponItem "rhsusf_acc_eotech_xps3";
	_unit addPrimaryWeaponItem "rhs_acc_perst1ik_ris";
	_unit addPrimaryWeaponItem "rhsusf_acc_grip2";
	_unit addPrimaryWeaponItem "ACE_30Rnd_556x45_Stanag_M995_AP_mag";
	
	[_unit, "ACE_30Rnd_556x45_Stanag_M995_AP_mag", 10, "dgr_pack15"] execVM "scripts\loadouts\addItemEffectively.sqf";
};

if (_loadout == "RifleSuppressed") then
{
	_unit addWeapon "rhs_weap_m4a1_blockII_KAC_d";
	_unit addPrimaryWeaponItem "rhsusf_acc_eotech_xps3";
	_unit addPrimaryWeaponItem "rhs_acc_perst1ik_ris";
	_unit addPrimaryWeaponItem "rhsusf_acc_grip2";
	_unit addPrimaryWeaponItem "rhsusf_acc_nt4_tan";
	_unit addPrimaryWeaponItem "ACE_30Rnd_556x45_Stanag_M995_AP_mag";
	
	[_unit, "ACE_30Rnd_556x45_Stanag_M995_AP_mag", 10, "dgr_pack15"] execVM "scripts\loadouts\addItemEffectively.sqf";
};

if (_loadout == "RifleGrenadier") then
{
	_unit addWeapon "rhs_weap_m4a1_blockII_M203_d";
	_unit addPrimaryWeaponItem "rhsusf_acc_eotech_xps3";
	_unit addPrimaryWeaponItem "rhs_acc_perst1ik_ris";
	_unit addPrimaryWeaponItem "ACE_30Rnd_556x45_Stanag_M995_AP_mag";
	_unit addPrimaryWeaponItem "1Rnd_HE_Grenade_shell";
	
	[_unit, "ACE_30Rnd_556x45_Stanag_M995_AP_mag", 10, "dgr_pack15"] execVM "scripts\loadouts\addItemEffectively.sqf";
	[_unit, "1Rnd_HE_Grenade_shell", 10, "dgr_pack15"] execVM "scripts\loadouts\addItemEffectively.sqf";
};

if (_loadout == "MG") then
{
	_unit addWeapon "rhs_weap_m240B";
	_unit addPrimaryWeaponItem "rhsusf_acc_eotech_xps3";
	_unit addPrimaryWeaponItem "rhs_acc_perst1ik_ris";
	_unit addPrimaryWeaponItem "rhsusf_100Rnd_762x51_m61_ap";
	
	[_unit, "rhsusf_100Rnd_762x51_m61_ap", 3, "dgr_pack15"] execVM "scripts\loadouts\addItemEffectively.sqf";
};

if (_at) then
{
	_unit addWeapon "launch_MRAWS_green_rail_F";
	_unit addSecondaryWeaponItem "MRAWS_HEAT_F";
	[_unit, "MRAWS_HEAT_F", 2, "dgr_pack15"] execVM "scripts\loadouts\addItemEffectively.sqf";
};