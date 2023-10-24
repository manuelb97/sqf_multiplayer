//Paras
params [
"_vehicle"
];

_tag = "SingleInsertionVehicleDeletionLoop";

//Delete vehicle if left
while {alive _vehicle} do 
{
	_playerArr = [];
	{
		if (_x distance _vehicle < 1000) then 
		{
			_playerArr pushBack _x;
		};
	} forEach allPlayers;
	
	if (count _playerArr < 1) then
	{
		deleteVehicle _vehicle;
	};
	
	uiSleep 10;
};