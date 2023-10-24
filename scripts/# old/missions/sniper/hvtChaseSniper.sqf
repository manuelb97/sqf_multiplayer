//Determine player to chase
_playerArray = [];
{ if (_x inArea Flare_Trigger) then {_playerArray pushBack _x}; } forEach allPlayers;
_targetPlayer = selectRandom _playerArray;

//Get units for the chase
_chaserGroups = [];
{if (side _x == east && ((getPos leader _x) distance _targetPlayer) < 900 && !((leader _x) getVariable ["hvt", false])) then {_chaserGroups pushBack _x}} forEach allGroups;

//Make enemies chase players
{
	//Delete WPs
	for "_i" from (count waypoints _x - 1) to 0 step -1 do {deleteWaypoint [_x, _i];};
	
	_biaWP1 = _x addWaypoint [getPos _targetPlayer, 10];
	_biaWP1 setWaypointType "SAD";
	_biaWP1 setWaypointSpeed "FULL";
	_biaWP1 setWaypointFormation (selectRandom["WEDGE","ECH LEFT","ECH RIGHT","LINE"]);
	_biaWP1 setWaypointBehaviour "AWARE";
	_biaWP1 setWaypointCombatMode "YELLOW";
} forEach _chaserGroups;