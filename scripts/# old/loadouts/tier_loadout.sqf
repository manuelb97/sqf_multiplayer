//[manu,"Tier_2","BIS_Vector","RHS_M9","RHS_M134"] execVM "scripts\loadouts\tier_loadout.sqf";

//Paras
_player 	= _this select 1;
_tier 		= _this select 3 select 0;
_primary = _this select 3 select 1;
_pistol 	= _this select 3 select 2;
_at 		= "None";

if (count (_this select 3) > 3) then {
	_at = _this select 3 select 3;
};

//hint (_tier + " " + _primary + " " + _pistol + " " + _at);

//Base KIt
[_tier,_player] execVM "scripts\loadouts\tier_base.sqf";
uiSleep 0.5;

/*
//Secondary + Grenades
[_tier,_player,_pistol] execVM "scripts\loadouts\tier_Secondary.sqf";
uiSleep 0.5;
*/

//Primary
[_tier,_player,_primary,_at] execVM "scripts\loadouts\tier_PrimaryAT.sqf";
uiSleep 0.5;

//Switch to primary
_player selectWeapon (primaryWeapon _player);