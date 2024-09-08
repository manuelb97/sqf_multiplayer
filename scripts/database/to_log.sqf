//Paras
params [
"_tag",
"_text",
["_print", false]
];

[format["[BiA] [%1]: %2", _tag, _text]] remoteExec ["diag_log", 2];

if (_print) then 
{
	[format["[BiA] [%1]: %2", _tag, _text]] remoteExec ["hint", 0];
};