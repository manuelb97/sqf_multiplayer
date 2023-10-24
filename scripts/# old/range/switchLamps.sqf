//Get Range Lamps
_rangeLamps = CQB_Arsenal nearObjects 50;
_rangeLamps = _rangeLamps select {"lamp" in (str _x)};

//Switch Light on or off according to current state
{
	if (lightIsOn _x == "ON") then {
		[_x,"OFF"] remoteExec ["switchLight",0, true];
	} else {
		[_x,"ON"] remoteExec ["switchLight",0, true];
	};
} forEach _rangeLamps;