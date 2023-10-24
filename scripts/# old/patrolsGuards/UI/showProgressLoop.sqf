//Parameters
params [
"_debug"
];

//_debug = true;
_tag = "ProgressUI";
	
_xCor = 0.9;
_yCor = 0;
_layer = 90;
_dur = 3;
_fade = 0;
_delta = 0;

while {true} do
{
	_playerStatsArr = ["PlayerStatsArr", []] call bia_load_from_profile; //compile preprocessFileLineNumbers "scripts\patrolsGuards\NewSaving\loadFromProfile.sqf";

	if (_debug) then 
	{
		_text = format["Stats Arr: %1", _playerStatsArr];
		[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
	};
	
	_playerArray = [];
	{
		if (!(_x inArea Flare_Trigger)) then 
		{
			_playerArray pushBack _x;
		};
	} forEach allPlayers;
	_playerCount = count _playerArray;
	
	if (_debug) then 
	{
		_text = format["Number of players found in HQ: %1", _playerCount];
		[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
	};
	
	if (_playerCount > 0) then
	{
		{
			_player = _x;
			
			if (_debug) then 
			{
				_text = format["Stats for: %1", _player];
				[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
			};
			
			_arrIdx = 0;
			_playerFound = false;
			{
				_arr = _x;
				
				if (str (_arr select 0) == (str getPlayerUID _player)) then
				{
					_arrIdx = _playerStatsArr find _arr;
					_playerFound = true;
				};
			} forEach _playerStatsArr;
			
			_kills = 0;
			_killDistances = [];
			_deaths = 0;
			
			if (_playerFound) then
			{
				if (_debug) then 
				{
					_text = format["Player %1 found in StatsArr", _player];
					[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
				};
				_statsArr = _playerStatsArr select _arrIdx;
				_kills = _statsArr select 1;
				_killDistances = _statsArr select 2;
				_deaths = _statsArr select 3;
			} else
			{
				if (_debug) then 
				{
					_text = format["Player %1 not found in StatsArr", _player];
					[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
				};
			};
			
			//Kill Distance
			_distSum = 0;
			_distMean = 0;
			if (count _killDistances > 0) then 
			{
				{
					_distSum = _distSum + _x;
				} forEach _killDistances;
				_distMean = round(_distSum / (count _killDistances));
			};
			
			//Buildings Cleared
			_allMarkers = allMapMarkers;
			_clearedBuildings = 0;
			_occupiedBildungs = 0;
			{
				_marker = _x;
				if (markerColor _marker == "ColorGreen" && (getMarkerPos _marker) inArea Flare_Trigger && markerType _marker == "mil_dot") then 
				{
					_clearedBuildings = _clearedBuildings + 1;
				};
				if (markerColor _marker == "ColorRed" && (getMarkerPos _marker) inArea Flare_Trigger && markerType _marker == "mil_dot") then 
				{
					_occupiedBildungs = _occupiedBildungs + 1;
				};
			} forEach _allMarkers;
			_progress = (_clearedBuildings / (_clearedBuildings + _occupiedBildungs)) * 100;
			
			if (_debug) then 
			{
				_text = format["%1 Overview: Kills: %2, Deaths: %3, Distances: %4, Cleared Builds: %5, Occupied Builds: %6, Progress: %7", 
				_player, _kills, _deaths, _killDistances, _clearedBuildings, _occupiedBildungs, _progress];
				[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
			};
			
			//Cleared Buildings
			_cbText = format["Cleared Buildings: %1",_clearedBuildings];
			
			//Occupied Buildings
			_obText = format["Occupied Buildings: %1",_occupiedBildungs];
			
			//% cleared
			_cText = format["Mission Progress: %1%2",[_progress, 0] call BIS_fnc_cutDecimals,"%"];

			//Enemies killed
			_ekText = format["Enemies Killed: %1",_kills];
			
			//Mean Kill Distance
			_kdText = format["Mean Kill Distance: %1",_distMean];

			//Deaths
			_dText = format["Times Died: %1",_deaths];
			
			//Show Stats
			[_cbText, 	_xCor, _yCor, 			_dur, _fade, _delta, _layer, "Green"] 			remoteExecCall ["bia_spawn_text", _player, false];
			[_obText, 	_xCor, _yCor + 0.1, 	_dur, _fade, _delta, _layer + 1, "Red"] 		remoteExecCall ["bia_spawn_text", _player, false];
			[_cText, 	_xCor, _yCor + 0.2, 	_dur, _fade, _delta, _layer + 2, "Green"] 	remoteExecCall ["bia_spawn_text", _player, false];
			[_ekText, 	_xCor, _yCor + 0.3, 	_dur, _fade, _delta, _layer + 3, "Green"] 	remoteExecCall ["bia_spawn_text", _player, false];
			[_kdText, 	_xCor, _yCor + 0.4, 	_dur, _fade, _delta, _layer + 4, "Green"] 	remoteExecCall ["bia_spawn_text", _player, false];
			[_dText, 	_xCor, _yCor + 0.5, 	_dur, _fade, _delta, _layer + 5, "Red"] 		remoteExecCall ["bia_spawn_text", _player, false];
			
		} forEach _playerArray;
		
		uiSleep (_dur - 1);
	};
	
	uiSleep 1;
};