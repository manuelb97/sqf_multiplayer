//[0,manu] execVM "scripts\missions\teleportToFriendlies.sqf";
//[mission_prep,["Teleport to Team Mate","scripts\missions\teleportToFriendlies.sqf",	[],1.5,true,false,"","true",5,false,"",""]] remoteExec ["addAction", 0, true];

//Paras
_player = _this select 1;

//Find friendlies
_friendliesOutsideHQ = [];
{ 
	if (_x distance hq_pos > 100) then 
	{
		_friendliesOutsideHQ pushBack _x;
	};
} forEach allPlayers;

//Teleport to friendly
if (count _friendliesOutsideHQ > 0) then
{
	"Teleporting you to a Team Mate" remoteExec ["hint", _player, false];
	uiSleep 2;
	
	_mate = selectRandom _friendliesOutsideHQ;
	
	if (vehicle _mate != _mate) then 
	{
		_player moveInAny (vehicle _mate);
	} else
	{
		_friendlyPos = getPosATL _mate;
		_player setPosATL _friendlyPos;
	};
} else
{
	"No Team Mate outside of HQ" remoteExec ["hint", _player, false];
};