//Paras
params [
"_loadoutObjArr",
"_debug"
];

_arsenalManageTag = "ArsenalManager";
_allArsenals = ["Russian", "Modern Russian", "American", "Special"];

while {true} do 
{
	//check mission progress
	_clearedVillages = allMapMarkers select {"village" in _x && markerColor _x == "colorBLUFOR"};
	_clearedMilBases = allMapMarkers select {"military" in _x && markerColor _x == "colorBLUFOR"};
	_clearedCities = allMapMarkers select {"city" in _x && markerColor _x == "colorBLUFOR"};
	_allCleared = _clearedVillages + _clearedMilBases + _clearedCities;

	_allOccupied = allMapMarkers select {markerColor _x == "colorOPFOR"};
	_percentCleared = (count _allCleared) / ((count _allCleared) + (count _allOccupied));

	//check which arsenals should be available 
	_selectCount = floor(1 + _percentCleared * 4);
	_neededArsenals = _allArsenals select [0, 1 max _selectCount];
	_activeArsenals = missionNamespace getVariable ["ActiveArsenals", []];

	//_nodeAdded = [actionTree, ["ACE_TapShoulderRight","VulcanPinchAction"]] call ace_interact_menu_fnc_findActionNode;

	if (count _activeArsenals < count _neededArsenals) then 
	{
		_arsenalsToAdd = _neededArsenals - _activeArsenals;

		{
			_theme = _x;
			{
				_obj = _x;
				_loadoutID = format["%1_Loadout", _theme];
				_action =  [_loadoutID, _theme, "", {_this spawn bia_class_arsenal;}, {true}, {}, [_obj, _theme]] call ace_interact_menu_fnc_createAction;
				[_obj, 0, ["ACE_MainActions", "BiA_Loadouts"], _action] remoteExec ["ace_interact_menu_fnc_addActionToObject", 0, true];
			} forEach _loadoutObjArr;
		} forEach _arsenalsToAdd;
		
		missionNamespace setVariable ["ActiveArsenals", _neededArsenals, true];
		[_arsenalManageTag, format["Newly available Arsenal: %1", _arsenalsToAdd]] spawn bia_to_log;
	} else
	{
		if (count _activeArsenals > count _neededArsenals) then 
		{
			_arsenalsToRemove = _activeArsenals - _neededArsenals;

			{
				_theme = _x;
				{
					_obj = _x;
					_loadoutID = format["%1_Loadout", _theme];
					_action =  [_loadoutID, _theme, "", {_this spawn bia_class_arsenal;}, {true}, {}, [_obj, _theme]] call ace_interact_menu_fnc_createAction;
					[_obj, 0, ["ACE_MainActions", "BiA_Loadouts"], _action] remoteExec ["ace_interact_menu_fnc_addActionToObject", 0, true];
				} forEach _loadoutObjArr;
			} forEach _arsenalsToRemove;
			
			missionNamespace setVariable ["ActiveArsenals", _neededArsenals, true];
			[_arsenalManageTag, format["Removed the following Arsenal: %1", _arsenalsToRemove]] spawn bia_to_log;
		};
	};

	uiSleep 10;
};