// _test = [["Tier_4", "Tier_3", "Tier_2"], true] call bia_faction_mix;

//Paras
params [
["_tiers", ["Tier_4"]],
"_type"
];

_text = str _tiers;
// ["UnitArr", _text] remoteExec ["bia_to_log", 2, false]; 

_finalArr = [];

{
	_tier = _x;
	_unitsArray = [_tier] call bia_faction_units;
	_unitArrs = _unitsArray select [2, 4];

	if (_type == "ground_combat_vehicles")  then 
	{
		_unitArrs = [_unitsArray select 8];
	};
	
	{
		_arr = _x;
		
		{
			_finalArr pushBack _x;
		} forEach _arr;
	} forEach _unitArrs;
} forEach _tiers;

_finalArr