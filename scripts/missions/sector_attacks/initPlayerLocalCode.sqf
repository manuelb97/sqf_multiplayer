//Misc
enableEnvironment [false, true]; //Disable snakes rabbits etc, but keep bird / ac sounds
(group player) setVariable ["Vcm_Disable", true];
player setVariable ["ace_medical_medicclass", 1, true];
player addMPEventHandler ["MPKilled", { _nul = _this call killedManInfo; }];

//FPS
execVM "scripts\ui\show_fps.sqf";
[true] execVM "scripts\ui\fpsUI.sqf";

//Map actions 
while {isNil "hq_map"} do 
{
	uiSleep 1;
};

[hq_map] execVM "scripts\missions\sector_attacks\mapActions.sqf";

//Arsenal actions 
_arsenals = missionNamespace getVariable ["ArsenalBoxes", [hq_arsenal]];
{
	_arsenal = _x;
	_action = ["BiA_Arsenal", "Mission Arsenal", "", {_this spawn bia_sector_attacks_arsenal;}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
	[_arsenal, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

	[_arsenal] execVM "scripts\missions\sector_attacks\arsenalActions.sqf";
} forEach _arsenals;

//Special bia actions 
_action = ["BiA_Actions", "BiA Actions", "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_clearVegetation = 
[
	"BiA_ClearVegetation", "Clear Vegetation", "", 
	{
		[5, [player, player, [0]], {_this spawn bia_clear_vegetation}, {}, "Clearing vegetation"] call ace_common_fnc_progressBar;
	}, 
	{
		_ret = false; //true
		_vegetation = ["BUSH", "SMALL TREE", "TREE"];
		_vegetationObjects = nearestTerrainObjects [_player, _vegetation, 5, true, true];
		_vegetationObjects = _vegetationObjects select {!(isObjectHidden _x)};

		if (count _vegetationObjects > 0) then 
		{
			_ret = true;
		};

		// _ret
		true
	}, {}, []
] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "BiA_Actions"], _clearVegetation] call ace_interact_menu_fnc_addActionToObject;

// _healUnconscious = ["BiA_HealDead", "Heal Mate", "", {_this spawn bia_heal_uncon;}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
// [player, 0, ["ACE_MainActions", "BiA_Actions"], _healUnconscious] call ace_interact_menu_fnc_addActionToObject;

//Commander stuff
if ((getPlayerUID player) == "76561198010214456") then 
{
	//Assign to Zeus Module
	player assignCurator zeus_1;

	//Add players to zeus
	{
		[_x,[allUnits select {isPlayer _x}, true]] remoteExec ["addCuratorEditableObjects", 0, true];
		_x removeCuratorEditableObjects [vehicles select {"cutter" in (typeOf _x)}, false];
	} forEach allCurators;

	//add commander supports 
	[player] execVM "scripts\support\commanderSupports.sqf";
};