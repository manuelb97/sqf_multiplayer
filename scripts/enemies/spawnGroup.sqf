// [["pvpDefend", 5, getPos player, getPos player, [], ["rhs_msv_rifleman"], "pvp", 10]] spawn compileFinal preprocessFileLineNumbers "scripts\enemies\spawnGroup.sqf";

//Paras
params [
"_args"
];

// ["SpawnGroup", str _args, true] spawn bia_to_log;

_grpType = _args select 0;
_grp = createGroup [east, true];

_varNameGlobal = "";
_debug = true;

if ("pvp" in _grpType) then 
{
	_args params ["_grpType", "_size", "_spawnpos", "_targetPos", "_wpPosArr", "_infantry", "_varName", "_radius"];
	_varNameGlobal = _varName;
	
	_onWater = surfaceIsWater _spawnpos;
	private "_newvehicle";

	if (_onWater && "pvpAttack" in _grpType) then 
	{
		_boatClass = "I_C_Boat_Transport_02_F";
		_newvehicle = createVehicle [_boatClass, _spawnpos, [], 0, "NONE"];
		clearWeaponCargoGlobal 		_newvehicle;
		clearMagazineCargoGlobal 	_newvehicle;
		clearItemCargoGlobal 		_newvehicle;
		clearBackpackCargoGlobal	_newvehicle;
	};
	
	_exampleInfClass = _infantry select 0;
	_classSide = getNumber (configFile >> "CfgVehicles" >> _exampleInfClass >> "side");

	if (_classSide == 1) then 
	{
		_grp = createGroup [west, true];
	};

	for "_i" from 1 to _size do 
	{
		_infClass = selectRandom _infantry;
		_soldier = _grp createUnit [_infClass, _spawnpos, [], 5, "NONE"];

		if (_onWater && "pvpAttack" in _grpType) then 
		{
			_soldier moveInAny _newvehicle;
		};
	};

	_patrolType = "Defence";

	if (_grpType == "pvpAttack") then 
	{
		_patrolType = "Attack";
	};

	[_patrolType, _grp, getPos (leader _grp), _targetPos, _radius] spawn bia_group_patrol;
};

if (_grpType == "Patrol") then 
{
	_args params ["_grpType", "_size", "_spawnpos", "_targetPos", "_wpPosArr", "_infantry", "_varName", "_radius"];
	_varNameGlobal = _varName;
	
	_exampleInfClass = _infantry select 0;
	_classSide = getNumber (configFile >> "CfgVehicles" >> _exampleInfClass >> "side");

	if (_classSide == 1) then 
	{
		_grp = createGroup [west, true];
	};

	for "_i" from 1 to _size do 
	{
		_infClass = selectRandom _infantry;
		_soldier = _grp createUnit [_infClass, _spawnpos, [], 5, "NONE"];
	};

	["Defence", _grp, getPos (leader _grp), _targetPos, _radius] spawn bia_group_patrol;
};

if (_grpType == "Hunt") then 
{
	_args params ["_grpType", "_size", "_spawnpos", "_target", "_infantry", "_varName"];
	_varNameGlobal = _varName;

	for "_i" from 1 to _size do 
	{
		_infClass = selectRandom _infantry;
		_soldier = _grp createUnit [_infClass, _spawnpos, [], 5, "NONE"];
		_soldier disableAI "AUTOCOMBAT";
	};

	[_grp, _target] spawn bia_hunt_target;
};

if (_grpType == "QRF") then 
{
	_args params ["_grpType", "_size", "_spawnpos", "_targetPos", "_wpPosArr", "_infantry", "_varName", "_radius"];
	_varNameGlobal = _varName;
	
	for "_i" from 1 to _size do 
	{
		_infClass = selectRandom _infantry;
		_soldier = _grp createUnit [_infClass, _spawnpos, [], 5, "NONE"];
	};

	["Attack", _grp, getPos (leader _grp), _targetPos, _radius] spawn bia_group_patrol;
};

if (_grpType == "Guard") then 
{
	_args params ["_grpType", "_posArr", "_cqbDist", "_chanceToLeaveBuilding", "_infantry", "_varName"];
	_varNameGlobal = _varName;

	{
		_buildingPos = _x;
		
		_infClass = selectRandom _infantry;
		_soldier = _grp createUnit [_infClass, _buildingPos vectorAdd [0,0,0.5], [], 0, "NONE"];
		
		doStop _soldier;
		_soldier disableAI "PATH";
		
		//Turn soldier to the outside (only works for leader since others turn same direction)
		_nearestBuilding = nearestBuilding _buildingPos;
		_soldierToHouse = _nearestBuilding getDir _soldier;
		_soldier setDir _soldierToHouse;
	} forEach _posArr;
	
	[units _grp, _cqbDist, _chanceToLeaveBuilding] spawn bia_cqb_control;
};

{
	_x setVariable [_varNameGlobal, true, true];
	_x addMPEventHandler ["MPKilled", { _nul = _this call killedManInfo; }];
	_x disableAI "AUTOCOMBAT";
} forEach (units _grp);

//make own grp if guards spawned 
if (_grpType == "Guard" && _varNameGlobal == "guardBool") then 
{
	_guards = allUnits select {_x getVariable ["guardBool", false]};
	_grp = group (_guards select 0);

	{
		if (group _x != _grp) then 
		{
			[_x] joinSilent _grp;
		};
	} forEach (_guards - [_guards select 0]);
};

//Set Skill 
_skillArr = missionNamespace getVariable "InfantrySkill";
_tier = [] call bia_get_curr_tier;
_tiers = ["Tier_4", "Tier_3", "Tier_2", "Tier_1"];
_skill = _skillArr select (_tiers find _tier);
[units _grp, _skill] call bia_set_skill;

/*
_plates = ["SCT_Panel_Safariland_ZeroG_BlackDiamond_IIIA_S", "SCT_Ceradyne_Defender275_xS_magtype", "SCT_SRI2_BALCS_XS_magtype", "SCT_OSKV_Verseidag_UltiMax_Modulard_s_magtype"];
_tierPlate = _plates select (_tiers find _tier);
{
	_x addItemToVest _tierPlate;
} forEach (units _grp);
*/

// ["Patrol", _size, _spawnPos, _targetPos, 75, _infantry]