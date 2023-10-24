/* 
_debug = true;
_infantry = [["Tier_4"], "Infantry", _debug] call bia_get_tier_cat;
_pos = player getPos [200, random 360];
["QRF", _pos, getPos player, 50, _infantry, "RHS_Ural_MSV_01", "Transport", "test", true] spawn compileFinal preprocessFileLineNumbers "scripts\enemies\spawnVehicleGroup.sqf";
["QRF", _pos, getPos player, 50, _infantry, "LOP_SLA_UAZ_DshKM", "Combat", "test", true] spawn compileFinal preprocessFileLineNumbers "scripts\enemies\spawnVehicleGroup.sqf";
*/

//Paras
params [
"_type",
"_spawnPos",
"_targetPos",
"_radius",
"_infantry",
"_vehicle",
"_vehType",
"_varName"
];

//Spawn vehicle
_spawnPos = [_spawnPos, 0, 150, 10, 0, 20, 0, [], [_spawnPos, _spawnPos]] call BIS_fnc_findSafePos;
_newvehicle = createVehicle [_vehicle, _spawnpos, [], 0, "NONE"];
_newvehicle setVariable ["OpforVehicle", true, true];
_newvehicle setVariable [_varName, true, true];
//_newvehicle addMPEventHandler ["MPKilled", { _nul = _this call killedVehInfo; }];

clearWeaponCargoGlobal 		_newvehicle;
clearMagazineCargoGlobal 	_newvehicle;
clearItemCargoGlobal 		_newvehicle;
clearBackpackCargoGlobal	_newvehicle;

//Unflip vehicle
_normalVec = surfaceNormal getPos _newvehicle;
_newvehicle setVectorUp _normalVec;
_newvehicle setPosATL [getPosATL _newvehicle select 0, getPosATL _newvehicle select 1, 0];
_newvehicle setdamage 0;

//Create group
_crewGrp = createGroup [east, true];
_crewSeats = [_vehicle, false] call BIS_fnc_crewCount; //) min 3;

for "_i" from 1 to _crewSeats do 
{
	_soldier = _crewGrp createUnit [selectRandom _infantry, getpos _newvehicle, [], 0, "NONE"];
	_soldier moveInAny _newvehicle;
};

//Set skill for combat vehicles group
_combatCrew = units _crewGrp;
_crewGrp setVariable ["VCM_Skilldisable", true, true];
_skill = missionNamespace getVariable "VehicleSkill";
[_combatCrew, _skill] call bia_set_skill;

//Move convoy to designation
if (_type == "Patrol") then 
{
	["Vehicle", _crewGrp, getPos leader _crewGrp, _targetPos, _radius] spawn bia_group_patrol;
};

_wholeCrew = _combatCrew;
_wpPos = [];

if (_type == "QRF") then 
{
	_formations = ["LINE", "WEDGE"]; // COLUMN", "STAG COLUMN", "FILE

	if (_vehType == "Transport") then 
	{
		// _cargoGrp = createGroup [east, true];
		_seats = [_vehicle, true] call BIS_fnc_crewCount;
		_currentCrew = count(crew _newvehicle);

		if ((_seats - _currentCrew) > 0) then
		{
			_soldiersToSpawn = (_seats - _currentCrew); // min 6;

			for "_i" from 1 to _soldiersToSpawn do 
			{
				_soldier = _crewGrp createUnit [selectRandom _infantry, getpos _newvehicle, [], 0, "NONE"];
				_soldier setVariable ["convoyTransport", true, true];
				_soldier moveInAny _newvehicle;
			};
		};

		_wholeCrew = units _crewGrp;
	
		_wpPos = _targetPos getPos [_radius, (_targetPos getDir _spawnPos) + random [-30, 0, 30]];
		[_crewGrp, _wpPos, 20, "GETOUT", selectRandom _formations, "FULL", "AWARE", "YELLOW", 20] call bia_add_wp;
		[_crewGrp, _targetPos, 20, "Hold", selectRandom _formations, "FULL", "AWARE", "YELLOW", 20] call bia_add_wp;
	} else 
	{
		[_crewGrp, _targetPos, 20, "Hold", selectRandom _formations, "FULL", "AWARE", "YELLOW", 20] call bia_add_wp;
	};

	// _grp setCurrentWaypoint [_grp, 1];
	_newvehicle setDir (_newvehicle getDir (getWPPos [_crewGrp, 1]));
	(leader _crewGrp) doMove (getWPPos [_crewGrp, 1]);
};

//Set variables for units 
{
	_x setVariable [_varName, true, true];
	_x addMPEventHandler ["MPKilled", { _nul = _this call killedManInfo; }];
	_x disableAI "AUTOCOMBAT";
} forEach _wholeCrew;

if (_vehType == "Transport") then 
{
	while {(count units _crewGrp) == (count crew _newvehicle)} do 
	{
		uiSleep 1;
	};

	{
		moveOut _x;
		unassignVehicle _x;
	} forEach (units _crewGrp);

	_crewGrp leaveVehicle _newvehicle;
	(units _crewGrp) orderGetIn false;
	(units _crewGrp) allowGetIn false;
} else 
{
	//switch driver to gunner if combat vehicle 
	uiSleep 10;

	while {damage _newvehicle < 1} do 
	{
		if (_vehType == "Combat") then 
		{
			if (isNull gunner _newvehicle || damage gunner _newvehicle == 1) then 
			{
				_crew = crew _newvehicle;

				if (count _crew > 0) then 
				{
					uiSleep 5;
					(gunner _newvehicle) moveOut _newvehicle;
					_newGunner = driver _newvehicle;
					_newGunner assignAsGunner _newvehicle;
				};
			};
		};

		//destroy vehicle if unmanned 
		_aliveCrew = count (crew _newvehicle select {damage _x < 1});
		if (_aliveCrew < 1) then 
		{
			uiSleep 10;
			_aliveCrew = count (crew _newvehicle select {damage _x < 1});

			if (_aliveCrew < 1) then 
			{
				_newvehicle setDamage 1;
			};
		};

		uiSleep 10;
	};
};

/*
//Set skill for potential non combat crew
_cargoCrew = (units _grp) - _combatCrew;
_tiers = ["Tier_4", "Tier_3", "Tier_2", "Tier_1"];

if (count _cargoCrew > 0) then 
{
	_skillArr = missionNamespace getVariable "InfantrySkill";
	_tier = [_debug] call bia_get_curr_tier;
	_skill = _skillArr select (_tiers find _tier);
	[_cargoCrew, _skill] call bia_set_skill;
};

_plates = ["SCT_Panel_Safariland_ZeroG_BlackDiamond_IIIA_S", "SCT_Ceradyne_Defender275_xS_magtype", "SCT_SRI2_BALCS_XS_magtype", "SCT_OSKV_Verseidag_UltiMax_Modulard_s_magtype"];
_tierPlate = _plates select (_tiers find _tier);
{
	_x addItemToVest _tierPlate;
} forEach (units _grp);
*/

//[units _grp, _newvehicle, 4, _debug] spawn bia_fix_stuck_veh;