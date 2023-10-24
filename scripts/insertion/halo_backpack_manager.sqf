//Params
params [
"_caller"
];

_backpackcontents = [];
_gunBagWeaponArr = [];
_backpack = backpack _caller;

if ( _backpack != "" && _backpack != "B_Parachute" ) then 
{
	_backpackcontents = backpackItems _caller;
	
	//get current gunbag weapon
	_gunBagWeaponArr = (backpackContainer _caller) getVariable ["ace_gunbag_gunbagweapon", []];
	
	removeBackpack _caller;
	sleep 0.1;
};

_caller addBackpack "B_Parachute";
sleep 4;
waitUntil { !alive _caller || isTouchingGround _caller };

if ( _backpack != "" && _backpack != "B_Parachute" ) then 
{
	sleep 2;
	removeBackpack _caller;
	sleep 2;
	_caller addBackpack _backpack;
	clearAllItemsFromBackpack _caller;
	{
		_caller addItemToBackpack _x 
	} foreach _backpackcontents;
	
	//add gunbag weapon to new backpack
	if (count _gunBagWeaponArr > 0) then
	{
		(backpackContainer _caller) setVariable ["ace_gunbag_gunbagweapon", _gunBagWeaponArr, true];
	};
};

if (backpack _caller == "ACE_ReserveParachute") then 
{
	removeBackpack _caller;
};

_caller selectWeapon (primaryWeapon _caller);