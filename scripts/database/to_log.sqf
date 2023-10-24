//Paras
params [
"_tag",
"_text",
["_debug", true]
];

if (_debug) then 
{
	[format["[BiA] [%1]: %2", _tag, _text]] remoteExec ["diag_log", 2];
};