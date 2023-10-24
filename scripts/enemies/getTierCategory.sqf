//Paras
params [
"_tierArr",
"_category",
"_debug"
];

_catArr = ["Faction", "Officer", "Infantry", "Riflemen","RifleClasses","ATClasses","MGClasses","Transport","CombatVehicle","Heli"];

_retArr = [];
{
	_tier = _x;
	_unitsArray = [_tier] call bia_faction_units;

	_categoryIdx = _catArr find _category;

	if (_categoryIdx > -1) then 
	{
		_retArr append (_unitsArray select _categoryIdx);
	};
} forEach _tierArr;

_retArr