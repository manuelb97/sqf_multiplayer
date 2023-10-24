// [true] spawn compileFinal preprocessFileLineNumbers "scripts\support\supportOnSmoke.sqf";

//Paras
params [
"_jtac",
"_debug"
];

missionNamespace setvariable ["JTAC", _jtac, true];

_jtac addEventHandler 
[
	"Fired", 
	{
		params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
		_parent = inheritsFrom (configFile >> "CfgMagazines" >> _magazine);
		// hint str [_unit, _weapon, _muzzle, _mode, _ammo, _magazine, _projectile, _gunner, str _parent];
			
		if ("Grenade_shell" in (str _parent)) then 
		{
			// hint "worked";
			_projectile addEventHandler 
			[
				"Explode", 
				{
					params ["_projectile", "_pos", "_velocity"];

					// hint "Final stop";
					_projectilePos = getPos _projectile; //[_pos select 0, _pos select 1]; //getPosATL _projectile;
					// _projectilePos set [2, 0];
					_targetToJtac = _projectilePos getDir (missionNamespace getvariable "JTAC");
					_strikeDir = _targetToJtac + random [170, 180, 190];

					// hint str [_projectilePos, _strikeDir];
					[_projectilePos, _strikeDir, "B_Plane_CAS_01_F", true] spawn bia_cas_variable_weap;
				}
			];
		};
	}
];

/*
_oldTargets = [];

while {true} do 
{
	_currObjs = allMissionObjects "";
	_smokes = _currObjs select 
	{
		_obj = _x;
		_magClass = ((str _obj) splitString ".: #") select 1;

		_ret = false;
		if (!isNil "_magClass") then 
		{
			_parent = inheritsFrom (configFile >> "CfgMagazines" >> _magClass);
			
			if ("1Rnd_HE_Grenade_shell" in (str _parent) && speed _obj < 1) then 
			{
				_ret = true;
			};
		};

		_ret
	};

	if (count _smokes > 0) then 
	{
		_smoke = _smokes select 0;

		if !(_smoke in _oldTargets) then 
		{
			// hint format["%1: %2", _smoke, getPos _smoke];
			_targetToJtac = _smoke getDir _jtac;
			_strikeDir = _targetToJtac + random [170, 180, 190];
			[getPos _smoke, _strikeDir, "B_Plane_CAS_01_F", true] spawn bia_cas_variable_weap;
			
			//avoid multiple triggers by same smoke
			_oldTargets pushBack _smoke;
		};
	};

	uiSleep 1;
};
*/

/*
HE, GunRun, RocketRun, AC130

1Rnd_Smoke_Grenade_shell
1Rnd_SmokeRed_Grenade_shell
1Rnd_SmokeOrange_Grenade_shell
1Rnd_SmokeYellow_Grenade_shell
1Rnd_SmokeGreen_Grenade_shell
1Rnd_SmokeBlue_Grenade_shell
1Rnd_SmokePurple_Grenade_shell
*/