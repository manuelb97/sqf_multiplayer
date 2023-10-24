params [
"_victim", 
"_killer"
];

if (false) then 
{
	[format["Victim: %1", _victim]] remoteExec ["hint", 0, true]; 
};

_oldStatsArr = hq_stats getVariable ["PlayerStatsArr", []];

if (false) then 
{
	[format["Old Arr: %1", _oldStatsArr]] remoteExec ["hint", 0, true]; 
};
	
//find stats array of killer
_arrIdx = false;
{
	if (false) then 
	{
		[format["Arr to search: %1", _x]] remoteExec ["hint", 0, true]; 
	};
	
	_arr = _x;
	_player = _arr select 0;
	
	if (str _player == str _victim) then
	{
		if (false) then 
		{
			[format["Victim %1 found in Stats Arr", _victim]] remoteExec ["hint", 0, true]; 
		};
		
		_arrIdx = _oldStatsArr find _arr;
	};
} forEach _oldStatsArr;

if (false) then 
{
	[format["ArrIdx: %1", typeName _arrIdx]] remoteExec ["hint", 0, true]; 
};

//modify stats array of killer
if (typeName _arrIdx == "SCALAR") then
{
	_oldPlayerArr = _oldStatsArr select _arrIdx;
	_oldKills = _oldPlayerArr select 1;
	_oldDistances = _oldPlayerArr select 2;
	_oldDeaths = _oldPlayerArr select 3;
	_newPlayerArr = [_victim, _oldKills, _oldDistances, _oldDeaths + 1];
	_oldStatsArr set [_arrIdx, _newPlayerArr];
	hq_stats setVariable ["PlayerStatsArr", _oldStatsArr];
} else
{
	if (false) then 
	{
		[format["Victim %1 not found in Stats Arr, adding new Entry", _victim]] remoteExec ["hint", 0, true]; 
	};
	
	//killer not found, add new array for him
	_oldStatsArr pushBack [_victim, 0, [], 1];
	hq_stats setVariable ["PlayerStatsArr", _oldStatsArr];
};