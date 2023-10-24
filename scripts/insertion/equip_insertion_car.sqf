//In order to use it with addAction & execVM
private ["_target", "_caller", "_actionID", "_arguments", "_vehicle", "_allowResupply", "_debug"];
if (count _this > 2) then
{
	_actionID = _this select 2;
	_arguments = _this select 3;
	_vehicle = _arguments select 0;
	_debug = _arguments select 1;
	_allowResupply = false;
} else
{
	_vehicle = _this select 0;
	_debug = _this select 1;
	_allowResupply = true;
};

/*
_vehicle = test;
clearItemCargoGlobal test;
*/

//Check if equipping allowed
if (!_allowResupply) then
{
	if (_vehicle distance hq_pos < 50) then
	{
		_allowResupply = true;
	};
};

//Get Players
_playerArr = allPlayers;
_playerCount = count _playerArr;

//Equip vehicle with supplies
if (_playerCount > 0 && _allowResupply) then
{
	//Equip Vehicle with Medical Stuff
	_vehicle addItemCargoGlobal ["ACE_fieldDressing", 15 * _playerCount];
	_vehicle addItemCargoGlobal ["ACE_morphine", 5 * _playerCount];
	_vehicle addItemCargoGlobal ["ACE_epinephrine", 2 * _playerCount];

	//Equip Vehicle with Player Ammo
	{
		//Get Player Ammo Types
		_player = _x;
		
		_primaryMags = primaryWeaponMagazine _player;
		
		if (count _primaryMags > 0) then
		{
			_primaryMag = _primaryMags select 0;
			_primaryMagGL = "";
			
			if (count _primaryMags > 1) then
			{
				_primaryMagGL = _primaryMags select 1;
			};
			
			_atMags = secondaryWeaponMagazine _player;
			_atMag = "";
			if (count _atMags > 0) then
			{
				_atMag = _atMags select 0;
			};
			
			//Count primary and at mags + add them to vehicle
			_allItems = itemsWithMagazines _player;
			_numPriMags 	= { _x == _primaryMag } count _allItems;
			_vehicle addItemCargoGlobal [_primaryMag, 2 * _numPriMags];
			
			if (_primaryMagGL != "") then
			{
				_numPriMagsGL	= { _x == _primaryMagGL } count _allItems;
				_vehicle addItemCargoGlobal [_primaryMagGL, 2 * _numPriMagsGL];
			};
			
			if (_atMag != "") then
			{
				_numATMags = { _x == _atMag } count _allItems;
				_vehicle addItemCargoGlobal [_atMag, 2 * _numATMags];
			};
		};
	} forEach _playerArr;

	if (!isNil "_actionID") then
	{
		_vehicle removeAction _actionID;
	};
} else {
	[format ["Too far away from HQ"]] remoteExec ["hint", 0, true]; 
};