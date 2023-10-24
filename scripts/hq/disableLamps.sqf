//Paras
params [
"_target", 
"_caller", 
"_arguments"
];

//Get Range Lamps
_rangeLamps = hq_pos nearObjects 100;
_rangeLamps = _rangeLamps select {"lamp" in (str _x) || "light" in (str _x)};

//Switch Light on or off according to current state
{
	if (lightIsOn _x == "ON") then 
	{
		[_x, "OFF"] remoteExec ["switchLight", 0, true];
	} else 
	{
		[_x, "ON"] remoteExec ["switchLight", 0, true];
	};
} forEach _rangeLamps;