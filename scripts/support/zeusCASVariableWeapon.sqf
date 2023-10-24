// [, , "B_Plane_CAS_01_dynamicLoadout_F", true] call compileFinal preprocessFileLineNumbers "scripts\support\zeusCASVariableWeapon.sqf";

//Paras
params [
"_casPos",
"_casDir",
"_planeClass",
// "_weapons",
"_debug"
];

//Select Weapon 
_weapons = selectRandom [
	["gatling_20mm_VTOL_01","Minigun 20 mm"]
	, ["Twin_Cannon_20mm","Plamen PL-20"]
	, ["gatling_20mm","Minigun 20 mm"]
	, ["gatling_25mm","GAU-12 Cannon 25 mm"]
	, ["Cannon_30mm_Plane_CAS_02_F","GSh-301"]
	, ["autocannon_35mm","GDF-001"]

	// , ["gatling_30mm_base","GSh-3-30"]
	// , ["Gatling_30mm_Plane_CAS_01_F","GAU-8"]
];

_planeCfg = configfile >> "cfgvehicles" >> _planeClass;

//Set parameters
_posATL = _casPos; //probably only agl but on terrain = atl, getposatl _logic;
_pos = +_posATL;
_pos set [2, (_pos select 2) + getterrainheightasl _pos];
_dir = _casDir + 180; //direction _logic;

_dis = 3000;
_alt = 1000;
_pitch = atan (_alt / _dis);
_speed = 400 / 3.6;
_duration = ([0,0] distance [_dis,_alt]) / _speed;

//--- Create plane
_planePos = [_pos, _dis, _dir + 180] call bis_fnc_relpos;
_planePos set [2, (_pos select 2) + _alt];
_planeSide = (getnumber (_planeCfg >> "side")) call bis_fnc_sideType;
_planeArray = [_planePos, _dir, _planeClass, _planeSide] call bis_fnc_spawnVehicle;
_plane = _planeArray select 0;
_plane setposasl _planePos;
_plane move ([_pos,_dis,_dir] call bis_fnc_relpos);
_plane disableai "move";
_plane disableai "target";
_plane disableai "autotarget";
_plane setcombatmode "blue";

_vectorDir = [_planePos, _pos] call bis_fnc_vectorFromXtoY;
_velocity = [_vectorDir, _speed] call bis_fnc_vectorMultiply;
_plane setvectordir _vectorDir;
[_plane, -90 + atan (_dis / _alt), 0] call bis_fnc_setpitchbank;
_vectorUp = vectorup _plane;

// "--- Remove all other weapons;";
_weaponTypes = [];
_weaponTypes pushBackUnique (((_weapons#0) call bis_fnc_itemType) #1);

_currentWeapons = weapons _plane;
{
    if !(_x in _weapons) then 
	{
        _plane removeweapon _x;
    };
} foreach _currentWeapons;
_plane addWeaponTurret [_weapons # 0,[-1]];
// hint str (getArray (configFile >> "CfgWeapons" >> (_weapons # 0) >> "magazines") ) # 0;
_plane addMagazineTurret [(getArray (configFile >> "CfgWeapons" >> (_weapons # 0) >> "magazines") ) # 0, [-1]];
waitUntil {(weaponState [_plane,[-1]])#6 == 0};

//--- Approach
_fire = [] spawn {waituntil {false}};
_fireNull = true;
_time = time;
_offset = if ({_x == "missilelauncher"} count _weaponTypes > 0) then {20} else {0};

waituntil {
	_fireProgress = _plane getvariable ["fireProgress",0];

	//--- Set the plane approach vector
	_plane setVelocityTransformation [
		_planePos, [_pos select 0, _pos select 1, (_pos select 2) + _offset + _fireProgress * 12],
		_velocity, _velocity,
		_vectorDir,_vectorDir,
		_vectorUp, _vectorUp,
		(time - _time) / _duration
	];
	_plane setvelocity velocity _plane;

	//--- Fire!
	if ((getposasl _plane) distance _pos < 1400 && _fireNull) then 
	{
		//--- Create laser target
		private _targetType = if (_planeSide getfriend west > 0.6) then {"LaserTargetW"} else {"LaserTargetE"};
		_target = ((_casPos nearEntities [_targetType,250])) param [0,objnull]; //position _logic

		if (isnull _target) then 
		{
			_target = createvehicle [_targetType, _casPos,[],0,"none"]; //position _logic
		};

		_plane reveal lasertarget _target;
		_plane dowatch lasertarget _target;
		_plane dotarget lasertarget _target;

		_fireNull = false;
		terminate _fire;
		_fire = [_plane,_weapons,_target] spawn //,_weaponTypesID
		{
			_plane = _this select 0;
			_planeDriver = driver _plane;
			_weapons = _this select 1;
			_target = _this select 2;
			// _weaponTypesID = _this select 3;
			_duration = 6;
			_time = time + _duration;

			waituntil 
			{
				_weapon = (_weapons select 0);
				_mode = (getarray (configfile >> "cfgweapons" >> _weapon >> "modes")) select 0;
				_forceWeapInfo = [_weapon, _mode];
				_plane selectweapon _weapon;
				_planeDriver forceweaponfire _forceWeapInfo;
				_planeDriver fireattarget [_target, _weapon];

				// _plane selectweapon (_weapons#0);
				// _planeDriver forceweaponfire [_weapons#0,selectRandom (getArray (configFile >> "CfgWeapons" >> (_weapons # 0) >> "modes"))];
                
				_plane setvariable ["fireProgress",(1 - ((_time - time) / _duration)) max 0 min 1];
				sleep 0.1;
				time > _time || isnull _plane //--- Shoot only for specific period or only one bomb _weaponTypesID == 3 || 
			};

			sleep 1;
		};
	};

	sleep 0.01;
	scriptdone _fire || isnull _plane//|| isnull _logic 
};
_plane setvelocity velocity _plane;
_plane flyinheight _alt;

/*
//--- Fire CM
if ({_x == "bomblauncher"} count _weaponTypes == 0) then 
{
	for "_i" from 0 to 1 do 
	{
		driver _plane forceweaponfire ["CMFlareLauncher","Burst"];
		_time = time + 1.1;
		waituntil {time > _time || isnull _plane}; //|| isnull _logic 
	};
};
*/

//--- Delete plane
while {_plane distance _pos < _dis && alive _plane} do 
{
	uiSleep 1;
};
// waituntil {_plane distance _pos > _dis || !alive _plane};

if (alive _plane) then 
{
	_group = group _plane;
	_crew = crew _plane;
	deletevehicle _plane;
	{deletevehicle _x} foreach _crew;
	deletegroup _group;
};

/*
[(getPos player) getPos [343, 161], 64, "B_Plane_CAS_01_F", ["Gatling_30mm_Plane_CAS_01_F","GAU-8"], true] spawn compileFinal preprocessFileLineNumbers "scripts\support\zeusCASVariableWeapon.sqf";

[
	//Rocket
	["missiles_DAR","Hydra 70"],

	//Great
	["gatling_20mm_VTOL_01","Minigun 20 mm"],
	["Twin_Cannon_20mm","Plamen PL-20"],
	["gatling_20mm","Minigun 20 mm"],
	["gatling_25mm","GAU-12 Cannon 25 mm"],
	["gatling_30mm_base","GSh-3-30"],
	["Cannon_30mm_Plane_CAS_02_F","GSh-301"],
	["autocannon_35mm","GDF-001"],
	["Gatling_30mm_Plane_CAS_01_F","GAU-8"],

	//OK 
	["GMG_20mm","XM307"],

	//Bad
	["GMG_40mm","Mk 19"],
	["weapon_Cannon_Phalanx","Gatling Cannon 20mm"],
	["weapon_Fighter_Gun20mm_AA","M61 Minigun 20 mm"],
	["weapon_Fighter_Gun_30mm","Gsh Cannon 30mm"],



	["LMG_RCWS","RCWS LMG 6.5 mm"],
	["LMG_65mm_body","RCWS LMG 6.5 mm"],
	["LMG_M200","M200 LMG 6.5 mm"],
	["LMG_M200_body","M200 LMG 6.5 mm"],
	["LMG_Minigun","M134 Minigun"],
	["LMG_Minigun_heli","M134 Minigun"],
	["HMG_127","M2"],
	["HMG_127_APC","M2"],
	["HMG_127_UGV","M2"],
	["HMG_01","XM312"],
	["HMG_static","XM312"],
	["HMG_M2","M2"],
	["HMG_NSVT","NSVT"],
	["SmokeLauncher","Smoke Screen"],
	["FlareLauncher","Flares"],
	["CMFlareLauncher","Flares"],
	["CMFlareLauncher_Singles","Flares"],
	["CMFlareLauncher_Triples","Flares"],
	["M134_minigun","2x M134 Minigun"],
	["mortar_82mm","Mortar 82 mm"],
	["missiles_DAGR","DAGR"],
	["Laserdesignator_mounted","Laser Marker"],
	["Laserdesignator_vehicle","Laser Marker"],
	["Laserdesignator_pilotCamera","Laser Marker"],
	["missiles_ASRAAM","AIM-132 ASRAAM"],
	["missiles_SCALPEL","9K121 Vikhr"],
	["missiles_titan","Mini-Spike"],
	["missiles_titan_AA","Mini-Spike"],
	["missiles_titan_static","Mini-Spike"],
	["rockets_Skyfire","Skyfire-70"],
	["LMG_Minigun2","M134 Minigun"],
	["LMG_Minigun_Transport","M134 Minigun"],
	["LMG_Minigun_Transport2","M134 Minigun"],
	["cannon_120mm","MG251"],
	["cannon_125mm","2A46"],
	["cannon_105mm","M68"],
	["mortar_155mm_AMOS","L/52"],
	["missiles_Zephyr","AIM-120A AMRAAM"],
	["GBU12BombLauncher","GBU-12"],
	["GBU12BombLauncher_Plane_Fighter_03_F","GBU-12"],
	["Bomb_04_Plane_CAS_01_F","GBU-12"],
	["Bomb_03_Plane_CAS_02_F","FAB-250M-54"],
	["Mk82BombLauncher","Mk82"],
	["rockets_230mm_GAT","M269"],
	["LMG_coax","PKT"],
	["LMG_coax_ext","PKT"],
	["cannon_120mm_long","L/55"],
	["Missile_AA_04_Plane_CAS_01_F","AIM-9 Sidewinder"],
	["Missile_AGM_02_Plane_CAS_01_F","AGM-65 Maverick G"],
	["Rocket_04_HE_Plane_CAS_01_F","Hydra 70"],
	["Rocket_04_AP_Plane_CAS_01_F","Hydra 70"],
	["Missile_AA_03_Plane_CAS_02_F","Wympel R-73"],
	["Missile_AGM_01_Plane_CAS_02_F","Kh-25MTP"],
	["Rocket_03_HE_Plane_CAS_02_F","S-8"],
	["Rocket_03_AP_Plane_CAS_02_F","S-8"],
	["HMG_127_MBT","M2"],
	["missiles_Jian","Jian"],
	["HMG_127_LSV_01","XM312"],
	["MMG_02_vehicle","SPMG .338"],
	["cannon_105mm_VTOL_01","M68"],
	["weapon_rim116Launcher","RIM 116 Spartan"],
	["weapon_rim162Launcher","RIM 162 Centurion"],
	["weapon_AMRAAMLauncher","AMRAAM"],
	["weapon_BIM9xLauncher","BIM 9X"],
	["weapon_AGM_65Launcher","AGM-65 Maverick G"],
	["weapon_GBU12Launcher","GBU 12"],
	["weapon_R73Launcher","R73 Archer"],
	["weapon_R77Launcher","R77 Adder"],
	["weapon_AGM_KH25Launcher","KH25 Kedge"],
	["weapon_KAB250Launcher","KAB 250"],
	["BombCluster_01_F","CBU-85 Cluster Bomb"],
	["BombCluster_02_F","RBK-500F"],
	["BombCluster_03_F","BL778 Cluster Bomb"],
	["BombDemine_01_F","Demining Charge"],
	["Bomb_Leaflets","Leaflets Dispenser"],
	["launcher_SPG9","SPG-9"],
	["cannon_125mm_advanced","2A82-1M"],
	["missiles_SAAMI","FIM-92F"],
	["missiles_Firefist","FireFIST ATGM"],
	["missiles_Vorona","Metis-M"],
	["MMG_01_vehicle","Navid 9.3 mm"],
	["MMG_02_coax","SPMG .338"],
	["autocannon_30mm_RCWS","2A42"],
	["HMG_127_AFV","M2"],
	["weapon_VLS_01","Venator Cruise Missile"],
	["weapon_ShipCannon_120mm","Cannon 120 mm"],
	["weapon_mim145Launcher","MIM-145 Defender"],
	["weapon_s750Launcher","S-750 Rhea"],
	["weapon_HARMLauncher","AGM-88C HARM"],
	["weapon_SDBLauncher","Small Diameter Bomb"],
	["weapon_KH58Launcher","KH58 ARM"],
	["DeminingDisruptor_01_base_f","Disruptor"],
	["ProbingWeapon_01_F","Sampling Laser"],
	["ProbingWeapon_02_F","Biopsy Probe"],
	["DeminingDisruptor_01_F","Disruptor"],
	["ProbingLaser_01_F","Sampling Laser"],
	["rhs_weap_902a","Smoke 902A"],
	["rhs_weap_902b","Smoke 902B"],
	["rhs_weap_dazzler","Dazzler"],
	["rhs_weap_CMFlareLauncher","Flares"],
	["rhs_weap_CMDispenser_ASO2","Flares"],
	["rhs_weap_CMDispenser_BVP3026","Flares"],
	["rhs_weap_CMDispenser_UV26","Flares"],
	["rhs_weap_DIRCM_Vitebsk","Vitebsk DIRCM"],
	["rhs_weap_DIRCM_Lipa","Lipa DIRCM"],
	["rhs_weap_afganit_smoke","Smoke Launcher"],
	["rhs_weap_yakB","YakBYu"],
	["RHS_T72_FCS","Fire Control System"],
	["rhs_weap_PL1","PL-1 Laser Designator"],
	["rhs_weap_klen_ps","Klen-PS"],
	["rhs_weap_d81","MG251"],
	["rhs_weap_2a26","2A26"],
	["rhs_weap_2a46_2","2A46-2"],
	["rhs_weap_2a46m_2","2A46M-2"],
	["rhs_weap_2a46m","2A46M"],
	["rhs_weap_2a46m_4","2A46M-4"],
	["rhs_weap_2a46m_5","2A46M-5"],
	["rhs_weap_2a82","2A82"],
	["rhs_weap_2a82_1m","2A82-1M"],
	["rhs_weap_d10t2s_2","D10-T2S"],
	["rhs_weap_d10tg","D10-TG"],
	["rhs_weap_d10t2s","D10-T2S"],
	["rhs_weap_u5ts","2A20"],
	["rhs_weap_2a70","2A70"],
	["rhs_weap_2a75","2A75"],
	["rhs_weap_2a28_base","2A28"],
	["rhs_weap_2a28","2A28"],
	["rhs_weap_2a41_base","2A41"],
	["rhs_weap_2a41","2A41"],
	["rhs_weap_2a33","2A33"],
	["rhs_weap_2a33_at","2A33"],
	["rhs_weap_2a31","2A31"],
	["rhs_weap_2a31_at","2A31"],
	["rhs_weap_d30","2A18M (D-30A)"],
	["rhs_weap_d30_at","2A18M (D-30A)"],
	["rhs_weap_gsh30","GSh-30-2K"],
	["rhs_weap_gsh302","GSh-30-2"],
	["rhs_weap_gsh301","GSh-30-1"],
	["rhs_weap_gsh23l","GSh-23L"],
	["rhs_weap_gsh23lx2","GSh-23L"],
	["rhs_weap_azp23","AZP-23"],
	["rhs_weap_2p130","2P130-1"],
	["rhs_weap_2b14","2B14-1 'Podnos'"],
	["rhs_weap_9k11","9K11"],
	["rhs_weap_9m111","9M111"],
	["rhs_weap_9m113","9M113"],
	["rhs_weap_9P148","9M111"],
	["rhs_weap_9m119","9M111"],
	["rhs_weap_2k4","2K4"],
	["rhs_weap_9k133","9K133"],
	["rhs_weap_SPG9","SPG-9"],
	["rhs_weap_9K114_launcher","9K114"],
	["rhs_weap_9K114F_launcher","9K114F"],
	["rhs_weap_2K8_launcher","2K8"],
	["rhs_weap_9K115_launcher","9K115 Metis"],
	["rhs_weap_9K115_1_launcher","9K115-1 Metis-M"],
	["rhs_weap_9K115_2_launcher","9K115-2 Metis-M1"],
	["rhs_weap_9K133_launcher","9K133-1 'Kornet-M'"],
	["rhs_weap_9K133M_9M133","9M133"],
	["rhs_weap_9K133M_9M133f","9M133F"],
	["rhs_weap_9K133M_9M1331","9M133-1"],
	["rhs_weap_9K133M_9M133M2","9M133M2"],
	["rhs_weap_9M120_launcher","9M120"],
	["rhs_weap_9M120F_launcher","9M120F"],
	["rhs_weap_9M120O_launcher","9M120O"],
	["rhs_weap_Igla_twice","9K38 (Djigit)"],
	["rhs_weap_grad","122mm Grad"],
	["rhs_weap_bm21","122mm Grad"],
	["rhs_weap_bm21_9m28f","122mm Grad"],
	["rhs_weap_bm21_9m28k","122mm Grad"],
	["rhs_weap_bm21_9m218","122mm Grad"],
	["rhs_weap_bm21_9m521","122mm Grad"],
	["rhs_weap_bm21_9m522","122mm Grad"],
	["rhs_weap_laserDesignator_AI","Laser Marker"],
	["rhs_weap_m256","120mm M256A1"],
	["cannon_155mm","L/52"],
	["rhs_weap_m284","Howitzer 155 mm"],
	["RHS_weap_M119","M119A2"],
	["RHS_M2_Abrams_Commander","M2"],
	["RHS_M2_Abrams_Gunner","M2 CSAMM"],
	["rhs_weap_m134_minigun_1","M134 Minigun 7.62mm"],
	["rhs_weap_m134_minigun_2","M134 Minigun 7.62mm"],
	["rhs_weap_m134_mounted","M134D Minigun 7.62mm"],
	["RHS_MKV_M134","Port M134"],
	["RHS_weap_m134_pylon","M134D-H"],
	["rhs_weap_M197","M197"],
	["rhs_weap_M301","M301"],
	["rhs_weap_M230","M230"],
	["RHS_weap_gau8","GAU-8"],
	["RHS_weap_gau19","GAU-19/A"],
	["rhs_weap_TOW_Launcher","BGM-71 TOW Launcher"],
	["rhs_weap_TOW_Launcher_static","BGM-71 TOW Launcher"],
	["rhs_weap_mlrs","MLRS"],
	["rhs_weap_mlrs_m26","M269"],
	["rhs_weap_mlrs_m26a1","M269"],
	["rhs_weap_mlrs_guided","GMLRS"],
	["rhs_weap_atacms","ATacMS"],
	["rhs_weap_atacms_guided","ATacMS (ER)"],
	["rhsusf_weap_M259","Smoke Screen"],
	["rhsusf_weap_M257","Smoke Screen"],
	["rhsusf_weap_M6","Smoke Screen"],
	["rhsusf_weap_M7","Smoke Screen"],
	["rhsusf_weap_M6_GLUA","Smoke Screen"],
	["rhsusf_weap_M6_L1","Smoke Screen"],
	["rhsusf_weap_M6_L2","Smoke Screen"],
	["rhsusf_weap_M6_L3","Smoke Screen"],
	["rhsusf_weap_M6_R1","Smoke Screen"],
	["rhsusf_weap_M6_R2","Smoke Screen"],
	["rhsusf_weap_M6_R3","Smoke Screen"],
	["rhsusf_weap_M257_8","Smoke Screen"],
	["rhsusf_weap_M250","Smoke Screen"],
	["rhsusf_weap_CMFlareLauncher","Flares"],
	["rhsusf_weap_CMDispenser_M130","Flares"],
	["rhsusf_weap_CMDispenser_ANALE39","Flares"],
	["rhsusf_weap_CMDispenser_ANALE40","Flares"],
	["rhsusf_weap_CMDispenser_ANALE52","Flares"],
	["rhsusf_weap_duke","DUKE offline"],
	["rhsusf_weap_duke_on","DUKE online"],
	["rhsusf_weap_LWIRCM","LWIRCM"],
	["rhsusf_weap_ANALQ144","LWIRCM"],
	["rhsusf_weap_ANALQ157","AN/ALQ-157"],
	["rhsusf_weap_ANALQ212","AN/ALQ-212"],
	["rhsusf_weap_ANAAQ24","AN/AAQ-24"],
	["rhsusf_weap_laneMarkerSystem","Lane Marking"],
	["rhs_mortar_81mm","81mm Mortar"],
	["rhs_weap_s5","S5"],
	["rhs_weap_s5_ub32","S5"],
	["rhs_weap_s5ko","S5"],
	["rhs_weap_s5k1","S5"],
	["rhs_weap_s5m1","S5"],
	["rhs_weap_s8","S8"],
	["rhs_weap_s8df","S8"],
	["rhs_weap_s8t","S8"],
	["rhs_weap_s13","S13"],
	["rhs_weap_s13d","S13"],
	["rhs_weap_s13df","S13"],
	["rhs_weap_s13of","S13"],
	["rhs_weap_s13t","S13"],
	["rhs_weap_s24","S24"],
	["rhs_weap_s24b","S24"],
	["rhs_weap_s25","S25O"],
	["rhs_weap_s25of","S25OF"],
	["rhs_weap_s25l","S25L"],
	["rhs_weap_s25ld","S25LD"],
	["rhs_weap_r27r_Launcher","R-27R"],
	["rhs_weap_r27t_Launcher","R-27T"],
	["rhs_weap_r60_Launcher","R-60"],
	["rhs_weap_r73_Launcher","R-73"],
	["rhs_weap_r73m_Launcher","R-73M"],
	["rhs_weap_r74_Launcher","R-74"],
	["rhs_weap_r74m2_Launcher","R-74M2"],
	["rhs_weap_r77_Launcher","R-77"],
	["rhs_weap_r77m_Launcher","R-77M"],
	["rhs_weap_kh25_Launcher","Kh-25"],
	["rhs_weap_kh25_mig29_Launcher","Kh-25"],
	["rhs_weap_kh25ml_Launcher","Kh-25ML"],
	["rhs_weap_kh25ml_mig29_Launcher","Kh-25ML"],
	["rhs_weap_kh25ma_Launcher","Kh-25MA"],
	["rhs_weap_kh25mt_Launcher","Kh-25MT"],
	["rhs_weap_kh25mtp_Launcher","Kh-25MTP"],
	["rhs_weap_kh25mp_Launcher","Kh-25MP"],
	["rhs_weap_kh29_Launcher","Kh-29L"],
	["rhs_weap_kh29_mig29_Launcher","Kh-29L"],
	["rhs_weap_kh29ml_Launcher","Kh-29ML"],
	["rhs_weap_kh29ml_mig29_Launcher","Kh-29ML"],
	["rhs_weap_kh29t_Launcher","Kh-29T"],
	["rhs_weap_kh29mp_Launcher","Kh-29MP"],
	["rhs_weap_kh29d_Launcher","Kh-29D"],
	["rhs_weap_kh38mle_Launcher","Kh-38MLE"],
	["rhs_weap_kh38mae_Launcher","Kh-38MAE"],
	["rhs_weap_kh38mte_Launcher","Kh-38MTE"],
	["rhs_weap_kh55sm_Launcher","MKU-5-6 rotary launcher"],
	["rhs_weap_kh55sm_dummy_Launcher","MKU-5-6 rotary launcher"],
	["rhs_weap_9k121_Launcher","9K121M"],
	["rhs_weap_fab250","FAB-250"],
	["rhs_weap_fab250_m62","FAB-250"],
	["rhs_weap_ofab250","FAB-250"],
	["rhs_weap_rbk250","RBK-250"],
	["rhs_weap_rbk250_ao1","RBK-250"],
	["rhs_weap_rbk250_ptab25","RBK-250"],
	["rhs_weap_rbk250_zab25t","RBK-250"],
	["rhs_weap_fab100","FAB-100"],
	["rhs_weap_fab100_mbd3_u4t","FAB-100"],
	["rhs_weap_fab100_mbd3_u6","FAB-100"],
	["rhs_weap_kab250","KAB-250"],
	["rhs_weap_fab500","FAB-500"],
	["rhs_weap_ptb1150","PTB-1150"],
	["rhs_weap_kab500","KAB-500"],
	["rhs_weap_kab500lk","KAB-500LK"],
	["rhs_weap_kab500KR","KAB-500KR"],
	["rhs_weap_kab500OD","KAB-500OD"],
	["rhs_weap_rbk500","RBK-500"],
	["rhs_weap_rbk500_ao25","RBK-500"],
	["rhs_weap_rbk500_ofab50","RBK-500"],
	["rhs_weap_rbk500_spbed","RBK-500"],
	["rhs_weap_rbk500_ptab1m","RBK-500"],
	["rhs_weap_rbk500_zab25t","RBK-500"],
	["rhs_weap_kmgu2","KMGU-2"],
	["rhs_weap_kmgu2_ptab1m","KMGU-2"],
	["rhs_weap_kmgu2_ao25","KMGU-2"],
	["rhs_weap_kmgu2_ptm1","KMGU-2"],
	["rhs_weap_kmgu2_pfm1","KMGU-2"],
	["rhs_weap_SidewinderLauncher","AIM-9X"],
	["rhs_weap_AIM9M","AIM-9M"],
	["rhs_weap_AIM120","AIM-120"],
	["rhs_weap_AIM120D","AIM-120D"],
	["rhs_weap_FFARLauncher","Hydra (M151 HE)"],
	["rhs_weap_FFARLauncher_M229","Hydra (M229 HEPD)"],
	["rhs_weap_FFARLauncher_M257","Hydra (M257 ILLUM)"],
	["rhs_weap_HellfireLauncher","AGM-114L Hellfire II"],
	["rhs_weap_AGM114L_Launcher","AGM-114L Hellfire II"],
	["rhs_weap_AGM114K_base_Launcher","AGM-114K Hellfire II"],
	["rhs_weap_AGM114K_Launcher","AGM-114K Hellfire II"],
	["rhs_weap_AGM114M_base_Launcher","AGM-114M Hellfire II"],
	["rhs_weap_AGM114M_Launcher","AGM-114M Hellfire II"],
	["RHS_weap_AGM114N_base_Launcher","AGM-114N Hellfire II"],
	["RHS_weap_AGM114N_Launcher","AGM-114N Hellfire II"],
	["rhs_weap_DAGR_Launcher","DAGR"],
	["rhs_weap_agm65","AGM-65 Maverick"],
	["rhs_weap_agm65b","AGM-65 Maverick"],
	["rhs_weap_agm65d","AGM-65 Maverick"],
	["rhs_weap_agm65e","AGM-65 Maverick"],
	["rhs_weap_agm65f","AGM-65 Maverick"],
	["rhs_weap_agm65h","AGM-65 Maverick"],
	["rhs_weap_stinger_Launcher","FIM-92F Stinger"],
	["rhs_weap_stinger_Launcher_static","FIM-92F Stinger"],
	["rhs_weap_ATAS_launcher","ATAS"],
	["rhs_weap_gbu12","GBU-12"],
	["rhs_weap_gbu32","GBU-32"],
	["rhs_weap_mk82","Mk 82"],
	["rhs_weap_cbu100","CBU-100"],
	["rhs_weap_cbu87","CBU-87"],
	["rhs_weap_cbu89","CBU-89"],
	["rhsusf_M61A2","M61A2"],
	["RHS_Laserdesignator_MELB","Laser Designator"],
	["RHS_9M79_1Launcher","9M79-1"],
	["LOP_PKT","PKT"],
	["LOP_DT","DT"],
	["LOP_DT2","DT"],
	["LOP_D81","D-81"],
	["LOP_T72_FCS","Fire Control System"],
	["LOP_D10","D-10"],
	["LOP_S53","ZiS S-53"],
	["LOP_AZP23","AZP-23 Amur"],
	["ace_missileguidance_dagr","DAGR"],
	["ACE_HMG_127_KORD","6P49 Kord"],
	["ACE_cannon_120mm_GT12","GT12"],
	["ACE_LMG_coax_ext_MAG58","MAG 58M"],
	["ACE_LMG_coax_MAG58_mem3","MAG 58M"],
	["ACE_LMG_coax_L94A1_mem3","L94A1"],
	["ACE_LMG_coax_ext_MG3","Rheinmetall MG3"],
	["ACE_LMG_coax_DenelMG4","Denel MG4"],
	["rhs_weap_gi2_base","M197"],
	["RHS_weap_zpl20","ZPL-20 Plamen"],
	["rhs_weap_zt3_Launcher","ZT3 Ingwe"],
	["rhs_weap_zt6_Launcher","ZT-6 Mokopa"],
	["rhs_weap_m70c","M70 Commando"],
	["ACE_AIR_SAFETY","SAFE"],
	["ACE_gatling_20mm_Comanche","XM301"],
	["ace_csw_HMG_Static","XM312"],
	["ace_csw_GMG_20mm","XM307"],
	["ace_javelin_Titan_Static","Mini-Spike"],
	["ace_csw_Titan_AT_Static","Mini-Spike"],
	["ace_csw_Titan_AA_Static","Mini-Spike"],
	["ace_hellfire_launcher","AGM-114K Hellfire II"],
	["ace_hellfire_launcher_N","AGM-114N Hellfire II"],
	["ace_hellfire_launcher_L","AGM-114L Hellfire ""Longbow"""],
	["ace_hot_1_launcher","HOT 1"],
	["ace_hot_2_launcher","HOT 2"],
	["ace_hot_2mp_launcher","HOT 2MP"],
	["ace_hot_3_launcher","HOT 3"],
	["ace_hot_generic_launcher","HOT Missile"],
	["ace_maverick_L_Launcher","AGM-65 Maverick L"],
	["ace_maverick_L_Launcher_Plane","AGM-65 Maverick L"],
	["ace_kh25ml_launcher","Kh-25ML"],
	["ACE_mortar_82mm","Mortar 82 mm"],
	["ace_compat_rhs_afrf3_rhs_weap_2b14","2B14-1 'Podnos'"],
	["ace_compat_rhs_afrf3_rhs_weap_SPG9","SPG-9"],
	["ace_compat_rhs_afrf3_rhs_weap_9K133_launcher","9K133-1 'Kornet-M'"],
	["ace_compat_rhs_afrf3_rhs_weap_9K115_2_launcher","9K115-2 Metis-M1"],
	["ace_compat_rhs_usf3_rhs_mortar_81mm","81mm Mortar"],
	["ace_compat_rhs_usf3_Rhs_weap_TOW_Launcher_static","BGM-71 TOW Launcher"],
	["ace_dragon_superStatic","M47 Super-Dragon"]
]
*/