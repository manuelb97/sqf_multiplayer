//Paras
params [
"_player",
"_item",
["_itemCount",1],
["_backpackToAdd","rhs_sidor"], //TAC_BP_Butt_RG
["_debug", true]
];

_tag = "addItemEffectively";

_uniformCon = uniformContainer _player;
_vestCon = vestContainer _player;

_backpackCon = "";
if (backpack _player != "") then
{
	_backpackCon = backpackContainer _player;
};

for "_i" from 1 to _itemCount do 
{ 
	_addToUniform = _uniformCon canAdd _item;
	
	if (_addToUniform) then
	{
		_uniformCon addItemCargoGlobal [_item,1];
	} else
	{
		_addToVest = _vestCon canAdd _item;
		
		if (_addToVest) then
		{
			_vestCon addItemCargoGlobal [_item,1];
		} else
		{
			_addToBackpack = false;
			
			if (backpack _player != "") then
			{
				_addToBackpack = _backpackCon canAdd _item;
			} else
			{
				_player addBackpack _backpackToAdd;
				_backpackCon = backpackContainer _player;
				_addToBackpack = _backpackCon canAdd _item;
			};
			
			if (_addToBackpack) then
			{
				_backpackCon addItemCargoGlobal [_item, 1];
			} else 
			{
				["AddItem", format["Failed to add: %1 to %2", [_item, _itemCount - _i], _player]] spawn bia_to_log;
			};
		};
	};
};