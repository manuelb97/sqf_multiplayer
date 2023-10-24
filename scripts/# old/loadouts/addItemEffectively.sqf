//Paras
params [
"_player",
"_item",
["_itemCount",1],
["_backpackToAdd","dgr_pack15"]
];

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
	_text = format["Can add to Uniform: %1",_addToUniform];
	//[_tag, _text] remoteExec ["bia_to_log", 2, false];
	
	if (_addToUniform) then
	{
		_uniformCon addItemCargoGlobal [_item,1];
	} else
	{
		_addToVest = _vestCon canAdd _item;
		_text = format["Can add to Vest: %1",_addToVest];
		//[_tag, _text] remoteExec ["bia_to_log", 2, false];
		
		if (_addToVest) then
		{
			_vestCon addItemCargoGlobal [_item,1];
		} else
		{
			_addToBackpack = false;
			
			if (backpack _player != "") then
			{
				_addToBackpack = _backpackCon canAdd _item;
				_text = format["Can add to Backpack: %1",_addToBackpack];
				//[_tag, _text] remoteExec ["bia_to_log", 2, false];
			} else
			{
				_player addBackpack _backpackToAdd;
				_backpackCon = backpackContainer _player;
				
				_addToBackpack = _backpackCon canAdd _item;
				_text = format["Can add to Backpack: %1",_addToBackpack];
				//[_tag, _text] remoteExec ["bia_to_log", 2, false];
			};
			
			if (_addToBackpack) then
			{
				_backpackCon addItemCargoGlobal [_item,1];
			};
		};
	};
};