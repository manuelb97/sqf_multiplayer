//Paras
params [
"_target", 
"_caller", 
"_actionId", 
"_arguments"
];

_tag = "InsertionAction";
_includeNight = false;
_includeFog = true;

_teleportAllPlayers	= _arguments select 0;
_maxPerHouse		= _arguments select 1;
_carClasses 			= _arguments select 2;
_debug 				= _arguments select 3;

//Get desired map pos
openMap true;
clicked = 0;
onMapSingleClick 
{
	mapPos = _pos; 
	clicked = 1; 
	openMap false;
	onMapSingleClick ""; 
	true;
};

//Wait for player input
if (_debug) then 
{
	_text = format["Waiting for Click"];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

while {clicked == 0 } do
{
	uiSleep 0.1;
};

if (_debug) then 
{
	_text = format["Selected MapPos: %1", mapPos];
	[_tag, _text] remoteExec ["bia_to_log", 2, false];
};

private ["_newvehicle"];

//Check if viable position
_enemyMarkers  = allMapMarkers select {mapPos distance (getMarkerPos _x) < 500 && (markerColor _x) == "ColorRed"};
if (count _enemyMarkers < 1) then 
{
	_handle = [_includeNight, _includeFog, _debug] spawn bia_change_weather;
	
	if (_debug) then 
	{
		_text = format["No close enemy Markers found"];
		[_tag, _text] remoteExec ["bia_to_log", 2, false];
	};
	
	if (!surfaceIsWater mapPos) then 
	{
		//Spawn in car
		if (_debug) then 
		{
			_text = format["Teleport on Ground with Car"];
			[_tag, _text] remoteExec ["bia_to_log", 2, false];
		};
		
		_telePos = [mapPos, 0, 100, 5, 0, 20, 0] call BIS_fnc_findSafePos;
		
		if (!_teleportAllPlayers) then 
		{
			if (_debug) then 
			{
				_text = format["Teleporting only Caller"];
				[_tag, _text] remoteExec ["bia_to_log", 2, false];
			};
			
			_carClass = selectRandom _carClasses;
			_newvehicle = _carClass createVehicle _telePos;
			_newvehicle allowdamage false;
			_newvehicle setpos _telePos;
			_newvehicle allowdamage true;
			
			_caller setPos _telePos;
			_caller moveInAny _newvehicle;
		} else
		{
			if (_debug) then 
			{
				_text = format["Teleporting all Players in HQ"];
				[_tag, _text] remoteExec ["bia_to_log", 2, false];
			};
			
			_playerArr = [];
			{
				if (_x distance hq_pos < 50) then 
				{
					_playerArr pushBack _x;
				};
			} forEach allPlayers;
			
			_vehClass = selectRandom _carClasses;
			while { ([_vehClass,true] call BIS_fnc_crewCount) < count _playerArr } do
			{
				_vehClass = selectRandom _carClasses;
			};
			_newvehicle = _vehClass createVehicle _telePos;
			_newvehicle allowdamage false;
			_newvehicle setpos _telePos;
			_newvehicle allowdamage true;
			
			{
				_player = _x;
				_player setPos _telePos;
				_player moveInAny _newvehicle;
			} forEach _playerArr;
		};
	} else 
	{
		//Spawn in boat 
		if (_debug) then 
		{
			_text = format["Teleport on Water with Boat"];
			[_tag, _text] remoteExec ["bia_to_log", 2, false];
		};
		
		_telePos = [mapPos, 0, 100, 8, 2, 20, 0, [], mapPos] call BIS_fnc_findSafePos;
		
		if (!_teleportAllPlayers) then 
		{
			if (_debug) then 
			{
				_text = format["Teleporting only Caller"];
				[_tag, _text] remoteExec ["bia_to_log", 2, false];
			};
			
			_vehClass = "O_Boat_Armed_01_hmg_F"; //"rhsusf_mkvsoc"; //B_Boat_Armed_01_minigun_F
			_newvehicle = _vehClass createVehicle _telePos;
			_newvehicle allowdamage false;
			_newvehicle setpos _telePos;
			_newvehicle allowdamage true;
			
			_caller setPos _telePos;
			_caller moveInAny _newvehicle;
		} else
		{
			if (_debug) then 
			{
				_text = format["Teleporting all Players in HQ"];
				[_tag, _text] remoteExec ["bia_to_log", 2, false];
			};
			
			_playerArr = [];
			{
				if (_x distance hq_pos < 50) then 
				{
					_playerArr pushBack _x;
				};
			} forEach allPlayers;
			
			_vehClass = "O_Boat_Armed_01_hmg_F"; //"rhsusf_mkvsoc"; //B_Boat_Armed_01_minigun_F
			_newvehicle = _vehClass createVehicle _telePos;
			_newvehicle allowdamage false;
			_newvehicle setpos _telePos;
			_newvehicle allowdamage true;
			
			{
				_player = _x;
				_player setPos _telePos;
				_player moveInAny _newvehicle;
			} forEach _playerArr;
		};
	};
	
	[_newvehicle,_debug] spawn bia_del_inser_car;
	
	clearWeaponCargoGlobal 	_newvehicle;
	clearMagazineCargoGlobal 	_newvehicle;
	clearItemCargoGlobal 		_newvehicle;
	clearBackpackCargoGlobal	_newvehicle;
	
	[_newvehicle] spawn bia_equip_inser_car;
	_newvehicle setVehicleLock "LOCKED";
	{
		[_x, _newvehicle, false] call ace_vehiclelock_fnc_addKeyForVehicle;
	} forEach allPlayers;
} else
{
	[format ["Too close to enemy Buildings"]] remoteExec ["hint", 0, true]; 
	uiSleep 3;
};