//Params
params [
"_inputArr"
];

{
	if (typeName _x != "SCALAR") then 
	{
		_inputArr set [_forEachIndex, parseNumber _x];
	};
} forEach _inputArr;

_inputArr