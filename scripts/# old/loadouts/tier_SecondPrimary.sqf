//Paras
_player 				= _this select 1;
_paras				= _this select 3;
_gun 					= _paras select 0;
_optic 				= _paras select 1;
_grip 					= _paras select 2;
_light 				= _paras select 3;
_silencer			= _paras select 4;
_mag					= _paras select 5;
_magCount			= _paras select 6;
_xMag				= _paras select 7;
_xMagCount		= _paras select 8;
_gunSec 			= _paras select 9;
_opticSec 			= _paras select 10;
_gripSec				= _paras select 11;
_lightSec 			= _paras select 12;
_silencerSec 		= _paras select 13;
_magSec 			= _paras select 14;
_magSecCount	= _paras select 15;

_player removeWeapon (primaryWeapon _player);
if (isNil "biaCurrentSwitch") then { biaCurrentSwitch = false; };
//currentPlayerItems = (vestItems _player) + (backpackItems _player);

if (!biaCurrentSwitch) then {
	uiSleep 2;
	_player addWeapon _gunSec;
	if (_opticSec != "no") 		then { _player addPrimaryWeaponItem _opticSec; };
	if (_gripSec != "no") 			then { _player addPrimaryWeaponItem _gripSec; };
	if (_lightSec != "no") 		then { _player addPrimaryWeaponItem _lightSec; };
	if (_silencerSec != "no")	then { _player addPrimaryWeaponItem _silencerSec; };
	if (_magSec != "no") 		then { _player addPrimaryWeaponItem _magSec; };
	_player addItemToVest _magSec;
	_player selectWeapon (primaryWeapon _player);
	biaCurrentSwitch = true;
} else {
	uiSleep 2;
	_player addWeapon _gun;
	if (_optic != "no") 	then { _player addPrimaryWeaponItem _optic; };
	if (_grip != "no") 		then { _player addPrimaryWeaponItem _grip; };
	if (_light != "no") 		then { _player addPrimaryWeaponItem _light; };
	if (_silencer != "no")	then { _player addPrimaryWeaponItem _silencer; };
	if (_mag != "no") 		then { _player addPrimaryWeaponItem _mag; };
	_player addItemToVest _mag;
	_player selectWeapon (primaryWeapon _player);
	biaCurrentSwitch = false;
};