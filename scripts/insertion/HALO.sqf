//Params
params [
"_target", 
"_caller", 
"_arguments"
];

_tag = "HALOScript";
_teamInsertion = _arguments select 0;

//Wait for Input or Cancel
openMap true;
clicked = 0;
onMapSingleClick 
{
	mapPos = _pos; 
	clicked = 1; 
	onMapSingleClick ""; 
	true;
};

while {!visibleMap} do
{
	uiSleep 0.1;
};
	
while {clicked == 0 && visibleMap} do
{
	uiSleep 0.1;
};

if (clicked == 0) exitWith {};
openMap false;

//Execute HALO
_haloPos = [mapPos select 0, mapPos select 1, 1000];

if (!_teamInsertion) then 
{
	_caller setpos _haloPos;
	[_caller] spawn bia_halo_backpack;
} else 
{
	{
		_player = _x;
		_player setpos (_haloPos getPos [random[2,9,15], random 360]); 
		[_player] remoteExec ["bia_halo_backpack", _player]; //has to be executed on the respective players pc
		// [_player] spawn bia_halo_backpack;
	} forEach (allPlayers select {_x distance2D hq_pos < 100});
};