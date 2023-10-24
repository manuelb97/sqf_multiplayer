params [
"_victim",
["_debug",false]
];

_tag = "AddDeath";

if (_debug) then 
{
	_text = format["Victim: %1", _victim];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

//Get current array
_oldStatsArr = HQ_Arsenal getVariable ["PlayerStatsArr", []];

if (_debug) then 
{
	_text = format["Old stats arr: %1", _oldStatsArr];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

//find stats array
_arrIdx = false;
{
	_arr = _x;
	_player = _arr select 0;
	
	if (str _player == str getPlayerUID _victim) then
	{
		if (_debug) then 
		{
			_text = format["Victim %1 found in Stats Arr", _victim];
			[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
		};
		
		_arrIdx = _oldStatsArr find _arr;
	};
} forEach _oldStatsArr;

//modify stats array of victim
if (typeName _arrIdx == "SCALAR") then
{
	_oldPlayerArr = _oldStatsArr select _arrIdx;
	_oldKills = _oldPlayerArr select 1;
	_oldDistances = _oldPlayerArr select 2;
	_oldDeaths = _oldPlayerArr select 3;
	
	_newPlayerArr = [getPlayerUID _victim, _oldKills, _oldDistances, _oldDeaths + 1];
	_oldStatsArr set [_arrIdx, _newPlayerArr];
	HQ_Arsenal setVariable ["PlayerStatsArr", _oldStatsArr];
	
	if (_debug) then 
	{
		_text = format["Death Added to StatsArr of %1", _victim];
		[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
	};
} else
{
	//killer not found, add new array for him
	_oldStatsArr pushBack [getPlayerUID _victim, 0, [], 1];
	HQ_Arsenal setVariable ["PlayerStatsArr", _oldStatsArr, false];
	
	if (_debug) then 
	{
		_text = format["New Stats Arr Entry created for %1", _victim];
		[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
	};
};

if (_debug) then 
{
	_text = format["New stats arr: %1", _oldStatsArr];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};