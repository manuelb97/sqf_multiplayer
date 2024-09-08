//  [player, "Random", true, true, true] spawn compileFinal preprocessFileLineNumbers  "scripts\Equipment\equipUnit.sqf";

//Paras
params [
"_unit", 
"_role", 
"_pmc", 
"_addRandom",
"_debug"
];

_equipUnitTag = "EquipUnit";

//Remove Current Gear
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;
uiSleep 0.1;

//Tier dependent items
if (_role == "Random") then
{
	_role = selectRandom
	[
		"Rifleman","Rifleman","Rifleman","Rifleman",
		"Grenadier",
		"Rifleman_AT",
		"DMR",
		"MG"
	];
};

//need to be done here, otherwise rifleman_at no weaps
_addAT = false;
if (_role == "Rifleman_AT") then 
{
	_role = "Rifleman";
	_addAT = true;
};

//read in config infos
_gearCats = 
[
	"vals", "chances", 
	"uniforms", "vests", "backpacks", "headgear", "facegear", 
	"binos", "nvgs", "launchers", "weapons",
	"arMags", "glMags", "mgMags", "dmrMags", "launcherMags", "numNades"
];
_tierGear = _gearCats apply {getArray (missionConfigFile >> "bia_tier_configs" >> _x)};
_tierGear params 
[
	"_vals", "_chances", 
	"_uniforms", "_vests", "_backpacks", "_headgear", "_facegear", 
	"_binos", "_nvgs", "_launchers", "_weapons",
	"_arMags", "_glMags", "_mgMags", "_dmrMags", "_launcherMags", "_numNades"
];

_gearArr = [];
{
	_selectArr = _x;
	_tier = _vals selectRandomWeighted _chances;

	if (!_pmc) then 
	{
		_tier = _vals select 0;
	};

	_subArrSelection = _selectArr select _tier;
	
	// ["Test", str [_forEachIndex, _subArrSelection]] spawn bia_to_log;

	//restrict weapon selection to role weapons
	if (_selectArr isEqualTo _weapons) then 
	{
		_subArrSelection = _subArrSelection select {getText(missionConfigFile >> "bia_weapon_configs" >> _x >> "role") == _role};
	};

	//avoid players getting no backpack
	if (_selectArr isEqualTo _backpacks && isPlayer _unit) then 
	{
		_subArrSelection = _subArrSelection select {_x != ""};
	};

	if (typeName _subArrSelection == "ARRAY") then 
	{
		_gearArr pushBack (selectRandom _subArrSelection);
	} else 
	{
		_gearArr pushBack _subArrSelection;
	};
	
	// ["Test", str [_forEachIndex, _subArrSelection]] spawn bia_to_log;
} forEach 
[
	_uniforms, _vests, _backpacks, _headgear, _facegear, _binos, _nvgs, _launchers, _weapons,
	_arMags, _glMags, _mgMags, _dmrMags, _launcherMags, _numNades
];

_gearArr params 
[
	"_uniform", "_vest", "_backpack", "_helmet", "_goggle", "_bino", "_nvg", "_launcher", "_weap", 
	"_arMags", "_glMags", "_mgMags", "_dmrMags", "_launcherMags", "_numNades"
];

// hint str _gearArr;

_weapInfosCats = ["silencer", "laser", "optic", "mag", "secMag", "grip"]; //, "role"
// _weapInfos = _weapInfosCats apply {getText (missionConfigFile >> "bia_weapon_configs" >> _weap >> _x)};
_weapInfos = _weapInfosCats apply {selectRandom getArray (missionConfigFile >> "bia_weapon_configs" >> _weap >> _x)};
_weapInfos params ["_silencer", "_laser", "_optic", "_mag", "_secMag", "_grip"]; //, "_weapRole"
_weapClass = getText (missionConfigFile >> "bia_weapon_configs" >> _weap >> "weapClass");

//Specify which mag num to use based on class
_primMagNum = _arMags;
_glMagsNum = 0;
_launcherMagsNum = 0;
_launcherArr = [];
_backpackItems = [];

// _addAT = true; // remove
if (_addAT && count _launchers > 0) then 
{
	_launcherInfos = _weapInfosCats apply {selectRandom getArray (missionConfigFile >> "bia_weapon_configs" >> _launcher >> _x)};
	_launcherInfos params ["_launSilencer", "_launLaser", "_launOptic", "_launMag", "_launSecMag", "_launGrip"];

	_launcherMagsNum = _launcherMags;
	_launcherClass = getText (missionConfigFile >> "bia_weapon_configs" >> _launcher >> "weapClass");

	_launcherArr = 
	[
		_launcherClass, 
		_launSilencer, 
		_launLaser, 
		_launOptic, 
		[_launMag, 1], 
		[_launSecMag, [_launSecMag] call bia_mag_bullets], 
		_launGrip
	];
	_backpackItems = [[_launMag, _launcherMagsNum, 1]];
};

switch (_role) do
{
	case "Grenadier":
	{
		_glMagsNum = _glMags;
	};
	case "DMR":
	{
		_primMagNum = _dmrMags;
	};
	case "MG":
	{
		_primMagNum = _mgMags;
	};
};

//Specify final loadout
_uniformItems = 
[
	["ACE_EarPlugs", 1],
	["ACE_Flashlight_XL50", 1], 
	["ACE_fieldDressing", 3], 
	["ACE_morphine", 1]
];

_vestItems = 
[
	[_mag, _primMagNum, [_mag] call bia_mag_bullets], 
	[_secMag, _glMagsNum, [_secMag] call bia_mag_bullets]
];

// _tier = _vals selectRandomWeighted _chances;
// _numNades = _numNades select _tier;
// hint format["Num Nades: %1", _numNades];

if (_numNades > 0) then 
{
	_vestItems append ["HandGrenade", _numNades, 1];
};

_backPackArr = [];
if (_backpack != "") then 
{
	_backPackArr = [_backpack, _backpackItems];
};

_loadout = 
[
	[
		_weapClass, 
		_silencer, 
		_laser, 
		_optic, 
		[_mag, [_mag] call bia_mag_bullets], 
		[_secMag, [_secMag] call bia_mag_bullets], 
		_grip
	], 
	_launcherArr, 
	[], //possible pistol
	[
		_uniform, _uniformItems
	],
	[
		_vest, _vestItems
	], 
	_backPackArr,
	_helmet, 
	_goggle,
	[_bino, "", "", "", [], [], ""],
	["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",_nvg]
];

_unit setUnitLoadout _loadout;
_unit selectWeapon (primaryWeapon _unit);

if (_addRandom) then 
{
	uiSleep 1;
	[_unit, _debug] spawn bia_add_rand_items;
};

//add armor plates to vest
/*
_plateArrs = getArray (missionConfigFile >> "bia_tier_configs" >> "plates"); // select further
_tier = _vals selectRandomWeighted _chances;

if (!_pmc) then 
{
	_tier = _vals select 0;
};

_tierPlates = _plateArrs select _tier;
_unit addItemToVest (selectRandom _tierPlates);
*/



// ["Equipment", _weapClass] spawn bia_to_log;
// hint _weapClass;

/*
_allMags = (configfile >> "CfgMagazines") call BIS_fnc_getCfgSubClasses;
_plates = _allMags select {"SCT_" in str _x};

_plates apply 
{
	_plate = _x;
	_mass = getNumber (configFile >> "CfgMagazines" >> _plate >> "mass");
	_armorVals = getArray (configFile >> "CfgMagazines" >> _plate >> "SCT_ITEMINFO" >> "enableparts");
	
	_armor = 0;
	{
		_armor = _armor + _x;
	} forEach _armorVals;
	
	[_x, _mass, selectMax _armorVals]
};

_plates

getNumber (configfile >> "CfgMagazines" >> (_plates select 0) >> "SCT_ITEMINFO" >> "PL")
_plates select 0



getArray (configfile >> "CfgMagazines" >> "SCT_plate_ceramic_AB500_M_magtype" >> "SCT_ITEMINFO" >> "enableparts")


_allMags = (configfile >> "CfgMagazines") call BIS_fnc_getCfgSubClasses;
_plates = _allMags select {"SCT_" in str _x};
_arrs = [];
{
	_arrs append (getArray (configfile >> "CfgMagazines" >> _x >> "SCT_ITEMINFO" >> "enableparts"));
} forEach _plates;

_arrs
*/