//black screen
// cutText ["Loading Mission","BLACK", 0.001];

//misc stuff for all players
(group player) setVariable ["Vcm_Disable", true];
player setVariable ["ace_medical_medicclass", 1, true];
execVM "scripts\ui\show_fps.sqf";

_clearVegetation = 
[
	"BiA_ClearVegetation", "Clear Vegetation", "", 
	{
		[5, [player, player, [0]], {_this spawn bia_clear_vegetation}, {}, "Clearing vegetation"] call ace_common_fnc_progressBar;
		// _this spawn bia_clear_vegetation;
	}, {true}, {}, []
] call ace_interact_menu_fnc_createAction;

[player, 1, ["ACE_SelfActions"], _clearVegetation] call ace_interact_menu_fnc_addActionToObject;

//black screen till loaded
// while {player distance hq_pos > 2} do
// {
// 	uiSleep 1;
// };
// cutText ["", "BLACK IN", 0.001];

//Execute appropriate player local init
while {missionNamespace getVariable ["Mission", ""] == ""} do
{
	uiSleep 1;
};

switch (missionNamespace getVariable ["Mission", ""]) do
{
	case "house_raids": 
	{
		[] spawn bia_house_radis_local_init;
	};
	case "pvp": 
	{
		[] spawn bia_pvp_local_init;
	};
};

//Disable snakes rabbits etc, but keep bird / ac sounds
enableEnvironment [false, true];

while {isNil "hq_map"} do 
{
	uiSleep 1;
};