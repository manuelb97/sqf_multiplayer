/*
["tag","text"] remoteExec ["bia_to_log", 2, false]; 
*/

params [
["_tag", "Info"],
["_text", ""],
["_debug",false]
];

if (count _text > 0 && count _tag > 0) then
{
	if (_debug) then
	{
		[format["Print to RPT: %1 - %2 ", _tag, _text]] remoteExec ["hint", 0, true]; 
		uiSleep 3;
	};
	
	_msg = format["[BiA] [%1]: %2", _tag, _text];
	diag_log _msg;
};


