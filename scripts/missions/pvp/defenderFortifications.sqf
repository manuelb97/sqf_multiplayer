params [
"_side"
];

_fortifications = [
	["Land_Razorwire_F", 1], 

	["Land_SandbagBarricade_01_half_F", 1], 
	["Land_HBarrier_1_F", 2], 
	["Land_Bunker_01_blocks_1_F", 3], 

	["Land_SandbagBarricade_01_hole_F", 5], 
	["Land_Mil_WallBig_4m_damaged_center_F", 5], 
	["Land_Mil_WallBig_4m_battered_F", 5], 

	["Land_Bunker_01_small_F", 10], 
	["Land_Bunker_01_tall_F", 10]
];

[_side, 20, _fortifications] remoteExec ["ace_fortify_fnc_registerObjects", 2];