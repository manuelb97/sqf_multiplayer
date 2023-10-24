//Paras
params [
"_player"
];

//Reset Kit first
removeUniform 				_player;
removeVest 					_player;
removeBackpack 				_player;
removeHeadgear 				_player;
removeGoggles 				_player;
removeAllAssignedItems		_player;
removeAllWeapons 			_player;
removeAllItems 				_player;

_baseLoadout = 
[
	[], [], [],
	[
		"dgr_uniform15", 
		[
			["ACE_EarPlugs", 1], ["ACE_Flashlight_XL50", 1], ["ACE_fieldDressing", 21], ["ACE_morphine", 7], ["ACE_personalAidKit", 1]
		]
	],
	[
		"dgr_vestB15", 
		[
			// ["SCT_plate_OSPREY2_morgan_S_magtype", 1], ["SCT_overhelmet_3M_Lima_magtype", 1]
		]
	], 
	["dgr_pack15", []],
	"H_HelmetSpecB_sand", 
	"rhsusf_shemagh2_gogg_tan",
	["rhssaf_zrak_rd7j", "", "", "", ["", 0], [], ""],
	["ItemMap", "ItemGPS", "ItemRadio", "ItemCompass", "ACE_Altimeter", "O_NVGoggles_hex_F"] // O_NVGoggles_hex_F
];

/*
// low to high 

{"SCT_Panel_Safariland_ZeroG_BlackDiamond_IIIA_S"},
{"SCT_Ceradyne_Defender275_xS_magtype"},
{"SCT_SRI2_BALCS_XS_magtype"},
{"SCT_OSKV_Verseidag_UltiMax_Modulard_s_magtype"},
{"SCT_VTT_ExoteShapeHonky_S_magtype"}
*/

_player setUnitLoadout _baseLoadout;
[_player] call ace_weaponselect_fnc_putWeaponAway;

if (_player == manu) then 
{
	//_player addItemToUniform "ACE_microDAGR";
	_player removeWeapon (binocular _player);
	_player addWeapon "Rangefinder"; //ACE_Vector
};