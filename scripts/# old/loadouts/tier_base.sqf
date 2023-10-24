//Paras
_tier = param [0,""];
_player = param [1,player];

//Reset Kit first
removeUniform 					_player;
removeVest 						_player;
removeBackpack 				_player;
removeHeadgear 				_player;
removeGoggles 				_player;
removeAllAssignedItems	_player;
removeAllWeapons 			_player;
removeAllItems 				_player;
[_player,"WhiteHead_22_sa","ace_novoice"] remoteExec ["BIS_fnc_setIdentity", 0, true];
uiSleep 0.1;

//Standard items
_player linkItem "ItemMap";
_player linkItem "ItemCompass";
_player linkItem "ItemRadio";
_player linkItem "ItemGPS";
_player linkItem "ACE_Altimeter";
_player linkItem "rhsusf_ANPVS_15";	//selectRandom["rhs_1PN138","rhsusf_ANPVS_15","O_NVGoggles_ghex_F"];
uiSleep 0.1;

//Basic Equipment
_player forceAddUniform "dgr_uniform15"; 							//"VSM_Multicam_Camo";
_player addVest "dgr_vestB15";											//"VSM_LBT6094_operator_Multicam";
_player addBackpack "dgr_pack15";									//"VSM_Multicam_Backpack_Kitbag";
_player addHeadgear "dgr_ch15";										//"VSM_OPS_multicam";
_player addGoggles "VSM_Balaclava2_OD_Peltor_Goggles";
uiSleep 0.1;

//Medicals & Nades
_player addWeapon selectRandom["ACE_Vector"]; //"rhssaf_zrak_rd7j","rhs_pdu4", "Laserdesignator_03","Laserbatteries"
[_player,"ACE_EarPlugs",1,""] 			execVM "scripts\loadouts\addItemEffectively.sqf"; 
[_player,"ACE_Flashlight_XL50",1,""]	execVM "scripts\loadouts\addItemEffectively.sqf"; 
[_player,"ACE_fieldDressing",21,""] 	execVM "scripts\loadouts\addItemEffectively.sqf"; 
[_player,"ACE_morphine",7,""] 			execVM "scripts\loadouts\addItemEffectively.sqf"; 
[_player,"ACE_epinephrine",2,""] 		execVM "scripts\loadouts\addItemEffectively.sqf"; 
[_player,"ACE_EntrenchingTool",1,""] 	execVM "scripts\loadouts\addItemEffectively.sqf"; 
[_player,"ACE_RangeCard",1,""] 		execVM "scripts\loadouts\addItemEffectively.sqf"; 

uiSleep 0.1;
[_player,"B_IR_Grenade",1,""] 			execVM "scripts\loadouts\addItemEffectively.sqf"; 
[_player,"rhs_mag_m18_green",1,""] 	execVM "scripts\loadouts\addItemEffectively.sqf"; 
[_player,"HandGrenade",2,""] 			execVM "scripts\loadouts\addItemEffectively.sqf"; 