//Paras
params [
];

while {true} do 
{
	_playerArray = [];
	{ 
		if (_x distance2D hq_pos > 100) then 
		{
			_playerArray pushBack _x; 
		}; 
	} forEach allPlayers;
	
	if (count _playerArray > 0) then 
	{
		//Check if buildings cleared
		{
			_player = _x;
			_playerPos = getPos _player;
			_nearBuildings = _playerPos nearObjects ["Building", 15]; //has to be 15 for cargo towers and hangars
			
			if (count _nearBuildings > 0) then 
			{
				_relevantMarkers = allMapMarkers select 
				{
					markerType _x == "mil_dot" 
					&& markerColor _x == "ColorRed"
				};
		
				_enemyBuildings = [];
				{
					_building = _x;
					_numBuildPos = count(_building call BIS_fnc_buildingPositions);
					_nearestMarker = [_relevantMarkers, _building] call BIS_fnc_nearestPosition;

					if (_numBuildPos >= 0) then 
					{
						if ((markerColor _nearestMarker) == "ColorRed") then 
						{
							if ((getMarkerPos _nearestMarker) distance2D _building <= 5) then 
							{
								if (_playerPos distance2D _building <= 5) then
								{
									_enemyBuildings pushBack _building;
								};
							};
						};
					};
				} forEach _nearBuildings;
				
				{
					_enemyBuilding = _x;
					_currentGuards = [];
					{
						if (_x getVariable "guardBool" && _x distance (getPos _enemyBuilding) <= 7) then 
						{ 
							_currentGuards pushBack _x; 
						}; 
					} forEach allUnits;
					
					if (count _currentGuards < 1) then 
					{
						_text = format["Building cleared"];
						["ClearedBuildingsLoop", _text] remoteExec ["bia_to_log", 2]; 
						
						_nearestMarker = [_relevantMarkers, _enemyBuilding] call BIS_fnc_nearestPosition;
						_nearestMarker setMarkerColor "ColorGreen";
						
						//Save to ProfileNameSpace
						_clearedPosArr = ["ClearedPosArr",[]] call bia_load_from_profile;
						_clearedPosArr pushBack (getMarkerPos _nearestMarker);
						["ClearedPosArr",_clearedPosArr] call bia_save_to_profile;
					};
				} forEach _enemyBuildings;
			};
		} forEach _playerArray;
	};
	
	uiSleep 1;
};