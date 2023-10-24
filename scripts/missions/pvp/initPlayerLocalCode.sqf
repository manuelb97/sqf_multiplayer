//Misc
enableEnvironment [false, true]; //Disable snakes rabbits etc, but keep bird / ac sounds
(group player) setVariable ["Vcm_Disable", true];
player setVariable ["ace_medical_medicclass", 1, true];
player addMPEventHandler ["MPKilled", { _nul = _this call killedManInfo; }];

//FPS
execVM "scripts\ui\show_fps.sqf";
[true] execVM "scripts\ui\fpsUI.sqf";

//Actions
while {isNil "hq_map"} do 
{
	uiSleep 1;
};

[hq_map] execVM "scripts\missions\pvp\mapActions.sqf";

_healUnconscious = ["BiA_HealDead", "Heal Mate", "", {_this spawn bia_heal_uncon;}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
[player, 0, ["ACE_MainActions"], _healUnconscious] call ace_interact_menu_fnc_addActionToObject;

_clearVegetation = 
[
	"BiA_ClearVegetation", "Clear Vegetation", "", 
	{
		[5, [player, player, [0]], {_this spawn bia_clear_vegetation}, {}, "Clearing vegetation"] call ace_common_fnc_progressBar;
		// _this spawn bia_clear_vegetation;
	}, {true}, {}, []
] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _clearVegetation] call ace_interact_menu_fnc_addActionToObject;

// Zeus Stuff
if ((getPlayerUID player) == "76561198010214456") then 
{
	//Assign to Zeus Module
	player assignCurator zeus_1;

	//Add players to zeus
	{
		[_x,[allUnits select {isPlayer _x}, true]] remoteExec ["addCuratorEditableObjects", 0, true];
		_x removeCuratorEditableObjects [vehicles select {"cutter" in (typeOf _x)}, false];
	} forEach allCurators;
};