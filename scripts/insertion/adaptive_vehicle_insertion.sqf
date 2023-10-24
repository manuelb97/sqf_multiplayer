//Paras
params [
"_target", 
"_caller", 
"_arguments"
];

_tag = "InsertionAction";
_arguments params ["_teleportAllPlayers"];

_carClasses = ["B_MRAP_01_hmg_F"];
_boatClasses = ["B_Boat_Armed_01_minigun_F"]; // O_Boat_Armed_01_hmg_F rhsusf_mkvsoc

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
while {clicked == 0 } do
{
	uiSleep 0.1;
};

private ["_newvehicle"];

//Check if viable position
_enemyMarkers  = allMapMarkers select 
{
	mapPos distance2D (getMarkerPos _x) < 250 
	&& (markerColor _x) == "ColorRed"
	&& (markerType _x) == "mil_dot"
};

if (count _enemyMarkers < 1) then 
{
	if (!surfaceIsWater mapPos) then 
	{
		//Spawn in car
		_telePos = [mapPos, 0, 100, 5, 0, 20, 0] call BIS_fnc_findSafePos;

		_carClass = selectRandom _carClasses;
		_newvehicle = _carClass createVehicle _telePos;
		
		if (!_teleportAllPlayers) then 
		{
			
			_caller setPos _telePos;
			_caller moveInAny _newvehicle;
		} else
		{
			_playerArr = [];
			{
				if (_x distance hq_pos < 100) then 
				{
					_playerArr pushBack _x;
				};
			} forEach allPlayers;
			
			{
				_player = _x;
				_player setPos _telePos;
				_player moveInAny _newvehicle;
			} forEach _playerArr;
		};
	} else 
	{
		//Spawn in boat 
		_telePos = [mapPos, 0, 100, 8, 2, 20, 0, [], mapPos] call BIS_fnc_findSafePos;
		
		_vehClass = selectRandom _boatClasses;
		_newvehicle = _vehClass createVehicle _telePos;
		
		if (!_teleportAllPlayers) then 
		{
			_caller setPos _telePos;
			_caller moveInAny _newvehicle;
		} else
		{
			_playerArr = [];
			{
				if (_x distance hq_pos < 50) then 
				{
					_playerArr pushBack _x;
				};
			} forEach allPlayers;
			
			{
				_player = _x;
				_player setPos _telePos;
				_player moveInAny _newvehicle;
			} forEach _playerArr;
		};
	};
	
	[_newvehicle] spawn bia_delete_inser_veh;
	
	clearWeaponCargoGlobal 		_newvehicle;
	clearMagazineCargoGlobal 	_newvehicle;
	clearItemCargoGlobal 		_newvehicle;
	clearBackpackCargoGlobal	_newvehicle;
	
	[_newvehicle] spawn bia_equip_inser_veh;
} else
{
	[format ["Too close to enemy Buildings"]] remoteExec ["hint", 0, true]; 
	uiSleep 3;
};