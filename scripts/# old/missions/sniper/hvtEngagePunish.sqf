//Create game logic at target location
_logicCenter = createCenter sideLogic;
_logicGroup = createGroup _logicCenter;
_playerArray = [];
{ if (_x inArea Flare_Trigger) then {_playerArray pushBack _x}; } forEach allPlayers;

if (count _playerArray > 0) then {
	_logPos = getPos (selectRandom _playerArray);
	_targetLogic = _logicGroup createUnit ["Logic", _logPos, [], 0, "NONE"];

	//Get units who are supposed to fire at sniper
	_sniperSuppressOpf = [];
	{if (side _x == east && ((getPos _x) distance _logPos) < 900 && !((leader _x) getVariable ["hvt", false])) then {_sniperSuppressOpf pushBack _x}} forEach allUnits;

	//Order suppressive fire
	/*
	_this select 0:		OBJECT	- Unit that is injured
	//	_this select 1:		OBJECT 	- Target game logic
	//  _this select 2:		SCALAR	- (optional) weapon index (derived from Achilles_fnc_getWeaponsMuzzlesMagazines) (0 by default)
	//  _this select 3:		SCALAR	- (optional) muzzle index (derived from Achilles_fnc_getWeaponsMuzzlesMagazines) (0 by default)
	//  _this select 4:		SCALAR	- (optional) magazine index (derived from Achilles_fnc_getWeaponsMuzzlesMagazines) (0 by default)
	//	_this select 5:		SCALAR	- (optional) Stance index: 0:auto, 1:burst, 2:single, 3:talking guns (0 by default)
	//	_this select 6:		SCALAR	- (optional) Stance index: 0:prone, 1:crouch, 2:stand (1 by default)
	//	_this select 7:		BOOL	- (optional) Line up before firing (false by default)
	//	_this select 8:		SCALAR	- (optional) Duration in sec (20 by default)
	*/
	{
		[_x,_targetLogic,0,0,0,1,2,false,15] call Achilles_fnc_suppressiveFire;
	} forEach _sniperSuppressOpf;
};