//Get current time
_currentDate 	= date;
_hour 			= date select 3;

//Check if currently day/night and switch accordingly
if (_hour > 6 && _hour < 20) then {
	_currentDate set [3, 22];
	[_currentDate] remoteExec ["setDate",0, true];
} else {
	_currentDate set [3, 10];
	[_currentDate] remoteExec ["setDate",0, true];
};