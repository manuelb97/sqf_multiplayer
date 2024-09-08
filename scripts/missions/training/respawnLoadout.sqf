params 
[
	"_player"
];

_baseLoadout = 
[
	[], [], [],
	[
		"VSM_MulticamTropic_Camo", 
		[
			["ACE_EarPlugs", 1], ["ACE_Flashlight_XL50", 1], ["ACE_fieldDressing", 21], ["ACE_morphine", 7],
			["ACE_personalAidKit", 1], ["ACE_RangeCard", 1], ["ACE_ATragMX",1], ["ACE_Kestrel4500",1], ["ACE_microDAGR",1]
		]
	],
	[
		"V_CarrierRigKBT_01_light_Olive_F", 
		[
			["HandGrenade", 2, 1], ["rhs_mag_m18_green", 2, 1]
		]
	], 
	[
		"B_AssaultPack_eaf_F", []
	],
	"H_HelmetHBK_headset_F", 
	"rhsusf_shemagh2_gogg_grn",
	["Rangefinder", "", "", "", ["", 0], [], ""],
	["ItemMap", "ItemGPS", "ItemRadio", "ItemCompass", "ACE_Altimeter", "rhsusf_ANPVS_15"]
];

_player setUnitLoadout _baseLoadout;
[_player] call ace_weaponselect_fnc_putWeaponAway;