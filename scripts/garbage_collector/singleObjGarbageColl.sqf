//Paras
params [
"_obj",
"_minDelay",
"_minDist",
"_maxVis",
"_maxDelay",
"_debug"
];

//waiting for obj to die
while {alive _obj} do 
{
	uiSleep 1;
};

_objDeathTime = serverTime;

//check when we can delete obj
_deleted = false;

while {!_deleted} do 
{
	//check if obj can be deleted (by time criterion)
	if (serverTime > (_objDeathTime + _minDelay)) then 
	{
		_players = allPlayers;
		_visArr = _players apply {[objNull, "VIEW"] checkVisibility [eyePos _x, getPosASL _obj]};
		_bestVis = selectMax _visArr;

		//check if obj currently visible to players
		if (_bestVis < _maxVis) then 
		{
			_dists = allPlayers apply {_x distance2D _obj};
			_smallestDist = selectMin _dists;

			//check if far enough away to further process
			if (_smallestDist > _minDist) then 
			{
				deleteVehicle _obj;
				_deleted = true;
			};
		};
	};

	uiSleep 1;
};