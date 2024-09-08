// [player getPos [340, 156], 1, true] spawn compileFinal preprocessFileLineNumbers "scripts\support\ac130Support.sqf";

params [
"_player",
"_dist",
"_dir",
"_numStrikes",
"_radiusX",
"_radiusY",
"_debug"
];

//create logic
_pos = _player getPos [_dist, _dir];
_logicCenter = createCenter sideLogic;
_logicGroup = createGroup _logicCenter;
_logic = _logicGroup createUnit ["Logic", _pos, [], 0, "NONE"];
_logic enableSimulationGlobal false;
_logic allowDamage false;

//attach laser target to logic
_laserTarget = "LaserTargetW" createVehicle [0,0,0];
_laserTarget attachTo [_logic, [0,0,0]];
_laserTarget enableSimulationGlobal false;
_laserTarget allowDamage false;

//Spawn Blackfish Aircraft
_class = "B_T_VTOL_01_armed_olive_F";
_planeCfg = configfile >> "cfgvehicles" >> _class;
_posATL = _pos;
_pos = +_posATL;
_pos set [2, (_pos select 2) + getterrainheightasl _pos];

_dir = random 360; 
_dis = 3000;
_alt = 500; //500

_planePos = [_pos, _dis, _dir + 180] call bis_fnc_relpos;
_planePos set [2, (_pos select 2) + _alt];

_planeSide = (getnumber (_planeCfg >> "side")) call bis_fnc_sideType;
_planeArray = [_planePos, _dir, _class, _planeSide] call bis_fnc_spawnVehicle;
_aircraft = _planeArray select 0;
_aircraft setposasl _planePos;
// _aircraft move ([_pos,_dis,_dir] call bis_fnc_relpos);
// _aircraft disableai "move";
// _aircraft disableai "target";
// _aircraft disableai "autotarget";
// _aircraft setcombatmode "blue";

_grp = _planeArray select 2;
{
	_x setSkill 1;
} forEach units _grp;

//Blackfish CAS
_ALL_CM_WEAP_CLASSES = ["CMFlareLauncher", "CMFlareLauncher_Singles", "CMFlareLauncher_Triples", "rhs_weap_CMFlareLauncher", "rhsusf_weap_CMFlareLauncher", "rhsusf_weap_LWIRCM", "rhsusf_weap_ANAAQ24", "rhsusf_weap_ANALQ144", "rhsusf_weap_ANALQ157", "rhsusf_weap_ANALQ212"];
_ALL_LD_WEAP_CLASSES = ["Laserdesignator", "Laserdesignator_mounted", "Laserdesignator_pilotCamera", "Laserdesignator_vehicle"];

// Get available weapons, muzzles, magazines
private _availableMagazines = [];
{
	if (_x#2 > 0) then
	{
		_availableMagazines pushBackUnique (_x#0);
	};
} forEach (magazinesAllTurrets _aircraft);

private _weaponsToFire = [];
private _weaponMuzzleMagazineIdxList = [];
{
	private _weapIdx = _forEachIndex;
	_x params [["_weaponAndTurret","",["",[]]], ["_muzzlesAndMagazines",[""],[[]]]];
	_weaponAndTurret params [["_weapon","",[""]]];
	if ((_ALL_CM_WEAP_CLASSES findIf {_weapon == _x}) < 0 && (_ALL_LD_WEAP_CLASSES findIf {_weapon == _x}) < 0) then
	{
		private _weaponName = getText (configFile >> "CfgWeapons" >> _weapon >> "displayName");
		{
			private _muzzleIdx = _forEachIndex;
			_x params ["", ["_magazines",[""],[[]]]];
			{
				private _magazine = _x;
				if (_magazine in _availableMagazines) then
				{
					private _magIdx = _forEachIndex;
					private _magName = getText (configFile >> "CfgMagazines" >> _magazine >> "displayName");
					if !(_magName isEqualTo "") then
					{
						_weaponsToFire pushBack format ["%1 (%2)", _weaponName, _magName];
					}
					else
					{
						_weaponsToFire pushBack format ["%1", _weaponName];
					};
					_weaponMuzzleMagazineIdxList pushBack [_weapIdx, _muzzleIdx, _magIdx];
				};
			} forEach _magazines;
		} forEach _muzzlesAndMagazines;
	};
} forEach ([_aircraft] call Achilles_fnc_getWeaponsMuzzlesMagazines);

["BlackfishCASDebug", format["%1", str [_weaponsToFire, _weaponMuzzleMagazineIdxList]]] spawn bia_to_log;

/*
 [[""M68 (105mm HEAT-MP)"",""Minigun 20 mm (20 mm Shells)"",""L/60 Bofors Autocannon (40 mm GPR-T)"",""L/60 Bofors Autocannon (40 mm APFSDS-T)""],[[2,0,0],[3,0,0],[4,0,0],[4,1,0]]]"
Line 12944: 18:21:18 "[BiA] [BlackfishCASDebug]: [B Alpha 1-4:1,L Charlie 2-2:1,any,[0]]"
*/

// select parameters
_selectedTarget = _logic; //[position _logic, _allTargets] call Ares_fnc_GetFarthest;
_numberOfStrikes = _numStrikes;
_weaponsToFireIdx = 1; //_weaponsToFire select 1; // [0,1,2] selectRandomWeighted [0.1, 0.6, 3]; // 0 = Howitzer, 1 = 20mm, 2 = 40mm
_customOffset = 0; // needs to be array for some reason

// hint str [_aircraft, _selectedTarget, _weaponMuzzleMagazineIdxList select _weaponsToFireIdx, _customOffset];

for "_i" from 1 to _numberOfStrikes do
{
	["BlackfishCASDebug", format["%1", str [_aircraft, _selectedTarget, _weaponMuzzleMagazineIdxList select _weaponsToFireIdx, _customOffset]]] spawn bia_to_log;

	if (_i > 1) then 
	{
		_tPos = getPos _laserTarget;
		_x = random 1 * (selectRandom [-1 * _radiusX, _radiusX]);
		_y = random 1 * (selectRandom [-1 * _radiusY, _radiusY]);
		_newTargetPos = _tPos getPos [random _x, _dir] getPos [random _y, _dir + 90];
		// _newTargetPos = [(_tPos select 0) + random _radius, (_tPos select 1) + random _radius, 0];
		_selectedTarget setPos _newTargetPos; 
	};

	[_aircraft, _selectedTarget, _weaponMuzzleMagazineIdxList select _weaponsToFireIdx, _customOffset] call Achilles_fnc_advancedBlackfishCAS;
};

//--- Delete plane
_despawnPos = (_logic getRelPos [4000, _logic getRelDir _aircraft]) vectorAdd [0,0,500];

private _aircraftGroup = group effectiveCommander _aircraft;
private _wpHeli01 = [_aircraftGroup, currentWaypoint _aircraftGroup];
private _allWps = waypoints _aircraftGroup;
reverse _allWps;
{deleteWaypoint _x} forEach _allWps;
_wpHeli01 = _aircraftGroup addWaypoint [_despawnPos, 0];
_wpHeli01 setWaypointType "MOVE";
_aircraftGroup move _despawnPos;

_aircraft disableai "target";
_aircraft disableai "autotarget";
_aircraft setcombatmode "blue";

{
	_x disableai "target";
	_x disableai "autotarget";
	_x setcombatmode "blue";
} forEach (units _aircraftGroup);

//delete
while {_aircraft distance _pos < 3000 && alive _aircraft} do 
{
	_aircraftGroup move _despawnPos;
	_aircraft move _despawnPos;
	uiSleep 1;
};

// waituntil {_aircraft distance _pos > 3000 || !alive _aircraft};

if (alive _aircraft) then 
{
	_group = group _aircraft;
	_crew = crew _aircraft;
	deletevehicle _aircraft;
	{deletevehicle _x} foreach _crew;
	deletegroup _group;
};