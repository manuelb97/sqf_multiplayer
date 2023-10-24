//Paras
params [
"_unit", 
"_debug"
];

_addRandItemTag = "RandomItem";

// _items = getArray (missionConfigFile >> "CfgLootTables" >> "Military" >> "items");
_items = [] call bia_weighted_item_list;
_items params ["_items", "_weights"];

//add random items 
_numToAdd = selectRandomWeighted
[
	1, 100,
	2, 20,
	3, 10
];

for "_i" from 1 to _numToAdd do 
{
	_item = _items selectRandomWeighted _weights;
	[_unit, _item] call bia_add_item;
};