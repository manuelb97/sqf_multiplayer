params [
"_obj",
"_objArr"
];

// ["CosestDist", format["%1 || %2", _obj, _objArr], _debug] spawn bia_to_log;

_ret = 9999;

if (typeName _obj in ["OBJECT", "ARRAY"] and typeName _objArr in ["ARRAY"]) then
{
	private _distances = [];
	{
		_distances pushBack (_obj distance2D _x);
	} forEach _objArr;

	_ret = selectMin _distances;
};

_ret