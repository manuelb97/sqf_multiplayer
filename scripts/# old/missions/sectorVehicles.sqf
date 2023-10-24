//Params
_tier = param [0,""];

//included vehicles
_tier4Veh = ["LOP_SLA_UAZ_DshKM","rhssaf_army_o_m1025_olive_m2"];
_tier3Veh = ["rhssaf_army_o_m1025_olive_m2","rhs_gaz66_zu23_msv"];//["rhsusf_m113_usarmy_supply","rhsusf_m113_usarmy_M240","rhsusf_M1232_M2_usarmy_wd","rhsusf_M1083A1P2_B_M2_WD_fmtv_usarmy"];
_tier2Veh = ["rhs_gaz66_zu23_msv","RHS_Ural_Zu23_MSV_01"];
_tier1Veh = ["rhsgref_BRDM2_msv","rhsusf_M1220_M153_M2_usarmy_wd","rhsusf_stryker_m1126_m2_wd","rhs_btr60_msv"];
_vehArray = [selectRandom _tier4Veh,selectRandom _tier3Veh,selectRandom _tier2Veh,selectRandom _tier1Veh];

//Set respective arrays
_defenceVehArr = [];
switch _tier do {
    case "Tier_4": 	{
		_vehAmount = selectRandom[0,0,1];
		if (_vehAmount > 0) then {
			for '_i' from 1 to _vehAmount do 
			{
				_veh = _vehArray selectRandomWeighted [70,15,10,5];
				_defenceVehArr pushBack _veh;
			};
		};
	};
    case "Tier_3": 	{ 
		_vehAmount = selectRandom[1,1,2];
		for '_i' from 1 to _vehAmount do 
		{
			_veh = _vehArray selectRandomWeighted [50,25,15,10];
			_defenceVehArr pushBack _veh;
		};
	};
    case "Tier_2": 	{ 
		_vehAmount = selectRandom[1,2,2];
		for '_i' from 1 to _vehAmount do 
		{
			_veh = _vehArray selectRandomWeighted [30,35,20,15];
			_defenceVehArr pushBack _veh;
		};
	};
    case "Tier_1": 	{ 
		_vehAmount = selectRandom[2,2,3];
		for '_i' from 1 to _vehAmount do 
		{
			_veh = _vehArray selectRandomWeighted [10,45,25,20];
			_defenceVehArr pushBack _veh;
		};
	};
};

_defenceVehArr