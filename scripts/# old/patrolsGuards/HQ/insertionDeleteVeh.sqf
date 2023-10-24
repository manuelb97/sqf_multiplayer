//Paras
params [
"_vehicle",
"_debug"
];

_tag = "SingleInsertionVehicleDeletionLoop";

if (_debug) then 
{
	_text = format["Loop Started"];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

//Delete vehicle if left
while {alive _vehicle} do 
{
	if (_debug) then 
	{
		_text = format["New Cycle"];
		[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
	};

	_playerArr = [];
	{
		if (_x distance _vehicle < 1000) then 
		{
			_playerArr pushBack _x;
		};
	} forEach allPlayers;
	
	if (count _playerArr < 1) then
	{
		if (_debug) then 
		{
			_text = format["Deleting insertion vehicle"];
			[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
		};
		
		deleteVehicle _vehicle;
	};
	
	uiSleep 10;
};