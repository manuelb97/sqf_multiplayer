params [
"_varArr",
"_typeArr"
];

_passed = true;

{
	_var = _x;
	_desiredVarType = _typeArr select _forEachIndex;

	if (typeName _desiredVarType == "ARRAY") then 
	{
		if !(typeName _var in _desiredVarType) then 
		{
			_passed = false;
		};
	} else 
	{
		if (typeName _var != _desiredVarType) then 
		{
			_passed = false;
		};
	};
} forEach _varArr;

_passed