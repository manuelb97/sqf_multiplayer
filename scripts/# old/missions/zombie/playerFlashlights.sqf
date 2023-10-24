//Get players
_playerArray = allPlayers;
// { if (_x inArea "ACavoid") then {_playerArray pushBack _x}; } forEach allPlayers;

//Wait till players selected loadout
if (count _playerArray > 0) then {
	_playersEquipped = false;
	while {!_playersEquipped} do {
		uiSleep 3;
		_equippedPlayerCount = 0;
		{
			_weapon = primaryWeapon _x; 
			if (_weapon != "") then {_equippedPlayerCount = _equippedPlayerCount + 1;};
		} forEach _playerArray;
		
		if (_equippedPlayerCount == count _playerArray) then {_playersEquipped = true};
	};

	//Remove nvg + add flashlight
	//[format ["Removing NVGs and adding Flashlights / Headlamp"]] remoteExec ["hint", 0, true];
	{ 
		//Remove nvg
		_nvg = hmd _x;
		if (_nvg != "") then {_x unlinkItem _nvg};

		//Add flashlight
		_light = (primaryWeaponItems _x) select 1;
		_canAdd = false;
		if (_light == "") then {
			_canAdd = _x addPrimaryWeaponItem "SMA_SFFL_BLK";
		} else {
			_x removePrimaryWeaponItem _light;
			_canAdd = _x addPrimaryWeaponItem "SMA_SFFL_BLK";
		};
		
		//If couldnt add flashlight, check if russian can be added
		if (!isNil "_canAdd") then {
			_canAdd = _x addPrimaryWeaponItem "rhs_acc_2dpZenit";
		};
		
		//If couldnt add flashlight, check if vanilla can be added
		if (!isNil "_canAdd") then {
			_canAdd = _x addPrimaryWeaponItem "acc_flashlight";
		};
		
		//If still couldnt add flashlights to weapon, add helmet flashlight
		if (!isNil "_canAdd") then {
			_x linkItem "SAN_Headlamp_v2"; // SAN_Headlamp_v1
		};
	} forEach _playerArray;
};