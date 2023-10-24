while {isNil "hq_map"} do 
{
	uiSleep 1;
};

[hq_map] execVM "scripts\missions\pvp\mapActions.sqf";

_healUnconscious = ["BiA_HealDead", "Heal Mate", "", {_this spawn bia_heal_uncon;}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
[player, 0, ["ACE_MainActions"], _healUnconscious] call ace_interact_menu_fnc_addActionToObject;

player addMPEventHandler ["MPKilled", { _nul = _this call killedManInfo; }];