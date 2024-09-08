//Params
params [
	"_script",
	"_parent",
	"_arr"
];

[_script, format["%1: input invalid", _parent]] spawn bia_to_log;
[_script, format["%1", _arr]] spawn bia_to_log;
[_script, format["%1", _arr apply {typeName _x}]] spawn bia_to_log;