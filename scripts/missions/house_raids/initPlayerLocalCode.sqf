//Misc
enableEnvironment [false, true]; //Disable snakes rabbits etc, but keep bird / ac sounds
(group player) setVariable ["Vcm_Disable", true];
player setVariable ["ace_medical_medicclass", 1, true];

//FPS
execVM "scripts\ui\show_fps.sqf";
[true] execVM "scripts\ui\fpsUI.sqf";

//Actions
while {isNil "hq_map"} do 
{
	uiSleep 1;
};

[hq_map] execVM "scripts\missions\house_raids\mapActions.sqf";

{
	_arsenal = _x;
	_action = ["BiA_Arsenal", "Mission Arsenal", "", {_this spawn bia_house_raid_arsenal;}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
	[_arsenal, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
} forEach (missionNamespace getVariable ["ArsenalBoxes", [hq_arsenal]]);

_healUnconscious = ["BiA_HealDead", "Heal Mate", "", {_this spawn bia_heal_uncon;}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
[player, 0, ["ACE_MainActions"], _healUnconscious] call ace_interact_menu_fnc_addActionToObject;

//special manu code
_action = ["BiA_Supports", "BiA Supports", "", {}, {true}] call ace_interact_menu_fnc_createAction; 
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

if ((getPlayerUID player) == "76561198010214456") then 
{
	[] execVM "scripts\misc\addObjsToZeus.sqf";
	// [player, true] execVM "scripts\support\commanderSupports.sqf";
} else 
{
	_rearm = ["BiA_Rearm", "Rearm Vehicle", "", {_this spawn bia_rearm_vehicle;}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "BiA_Supports"], _rearm] call ace_interact_menu_fnc_addActionToObject;
};