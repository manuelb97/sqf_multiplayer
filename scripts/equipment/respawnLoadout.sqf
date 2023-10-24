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
		"U_BG_Guerrilla_6_1", 
		[
			["ACE_EarPlugs", 1], ["ACE_Flashlight_XL50", 1], ["ACE_fieldDressing", 3], ["ACE_morphine", 1]//, ["ACE_personalAidKit", 1]
		]
	],
	[
		"V_BandollierB_oli", []
	], 
	[], //"", []
	"H_Booniehat_oli", 
	"rhsusf_shemagh2_grn",
	["rhssaf_zrak_rd7j", "", "", "", ["", 0], [], ""],
	["ItemMap", "ItemGPS", "ItemRadio", "ItemCompass", "ItemWatch", "rhs_1PN138"]
];

_player setUnitLoadout _baseLoadout;
[_player] call ace_weaponselect_fnc_putWeaponAway;