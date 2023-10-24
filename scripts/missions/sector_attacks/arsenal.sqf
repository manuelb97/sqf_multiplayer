// [hq_arsenal, player, []] call compileFinal preprocessFileLineNumbers "scripts\equipment\adaptiveArsenal.sqf";

//Params
params [
"_target", 
"_caller", 
"_arguments"
];

#include "arsenalInfo.hpp"

//get progress info 
_progress = missionNamespace getVariable ["Progress", 0];

//decide what to make available
_numPremiumItems = count _premiumItems;
_premiumItemPacks = _premiumItems select [0, _numPremiumItems];

_unlockedItems = [];
{
	_unlockedItems append _x;
} forEach _premiumItemPacks;

[_target, _commonItems + _unlockedItems] call ace_arsenal_fnc_initBox;

//open arsenal with custom item pool
[_target, _caller] call ace_arsenal_fnc_openBox;
[_target] call ace_arsenal_fnc_removeBox; 

// we add items + open it, while its open we remove it 
//otherwise we have a second arsenal option for the box, which does not update

//respawn loadouts 
// _loadouts = [1, 2, 3, 4, 5, 6, 7] apply {format["West_House_Raids_%1", _x]};
// {
// 	[west, [_loadout, -1, -1]] call BIS_fnc_addRespawnInventory;
// } forEach (_loadouts select [0, _numPremiumItems]);