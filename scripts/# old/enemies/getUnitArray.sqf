// _test = [["Tier_4", "Tier_3", "Tier_2"], true] call bia_faction_mix;

//Paras
params [
["_tiers", ["Tier_4"]],
"_debug"
];

_tag = "PatrolVehicleLoop";

if (_debug) then 
{
	_text = format["Getting Units of: %1", _tiers];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};


_finalArr = [];

{
	_tier = _x;
	_unitsArray = [_tier] call bia_faction_units;
	_infantryArrs = _unitsArray select [2, 4];
	
	{
		_arr = _x;
		
		{
			_finalArr pushBack _x;
		} forEach _arr;
	} forEach _infantryArrs;
} forEach _tiers;

_finalArr