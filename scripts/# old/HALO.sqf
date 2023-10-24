private [ "_backpack", "_backpackcontents" ];

_unit = _this select 1;

hint "";
openMap true;
clicked = 0;
onMapSingleClick 
{
	player setpos [_pos select 0, _pos select 1, 2000]; 
	clicked = 1; 
	openMap false;; 
	openmap false;
	onMapSingleClick ""; 
	true;
};
waitUntil {clicked == 1};

_backpackcontents = [];
_backpack = backpack player;
if ( _backpack != "" && _backpack != "B_Parachute" ) then {
	_backpackcontents = backpackItems player;
	removeBackpack player;
	sleep 0.1;
};
player addBackpack "B_Parachute";
sleep 4;
waitUntil { !alive player || isTouchingGround player };
if ( _backpack != "" && _backpack != "B_Parachute" ) then {
	sleep 2;
	removeBackpack player;
	sleep 2;
	player addBackpack _backpack;
	clearAllItemsFromBackpack player;
	{ player addItemToBackpack _x } foreach _backpackcontents;
};

if (backpack player == "ACE_ReserveParachute") then {
	removeBackpack player;
};

player selectWeapon (primaryWeapon player);