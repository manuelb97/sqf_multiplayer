params [
"_obj",
"_objArr"
];

// ["CosestDist", format["%1 || %2", _obj, _objArr], _debug] spawn bia_to_log;

_ret = selectRandom _objArr;

if (typeName _obj in ["OBJECT", "ARRAY"] and typeName _objArr in ["ARRAY"]) then
{
	private _distances = [];
	{
		_distances pushBack (_obj distance2D _x);
	} forEach _objArr;

	_minDist = selectMin _distances;
	_idx = _distances find _minDist;
	_ret = _objArr select _idx;
};

_ret