// [] execVM "scripts\missions\addFlashlights.sqf";

if (daytime < 6 || daytime >= 18) then {
	{if (selectRandom[true,true,true,true,false]) then {
			_unitPrimaryItems = primaryWeaponItems _x;
			if (!(isplayer _x) && !("acc_flashlight" in _unitPrimaryItems)) then {_x addPrimaryWeaponItem "acc_flashlight";};
			_x enableGunLights "ForceOn";
	};} forEach allUnits;
};