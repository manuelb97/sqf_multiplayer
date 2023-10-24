//[0,manu] execVM "scripts\missions\teleportToFriendlies.sqf";
//[mission_prep,["Teleport to Team Mate","scripts\missions\teleportToFriendlies.sqf",	[],1.5,true,false,"","true",5,false,"",""]] remoteExec ["addAction", 0, true];

//Paras
_player = _this select 1;

//Find friendlies
_friendliesInZone = [];
{ 
	if (side _x == west && _x inArea Flare_Trigger) then {_friendliesInZone pushBack _x};
} forEach allUnits;

//Teleport to friendly
_friendlyPos = getPosATL (selectRandom _friendliesInZone);
_player setPosATL [_friendlyPos select 0, _friendlyPos select 1, _friendlyPos select 2];