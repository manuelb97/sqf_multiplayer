params [
"_victim",
["_debug",false]
];

_tag = "AddDeath";
_oldStatsArr = missionNamespace getVariable ["PlayerStatsArr", []];

//find stats array
_uid = getPlayerUID _victim;
_statsArrIDs = _oldStatsArr apply {_x select 0};
_arrIdx = _statsArrIDs find _uid;

//modify stats array of victim
if (_arrIdx != -1) then
{
	_oldPlayerArr = _oldStatsArr select _arrIdx;
	_oldPlayerArr params ["_uid", "_oldKills", "_oldDeaths"];
	
	_newPlayerArr = [_uid, _oldKills, _oldDeaths + 1];
	_oldStatsArr set [_arrIdx, _newPlayerArr];
	missionNamespace setVariable ["PlayerStatsArr", _oldStatsArr, true];
	
	[_tag, format["Victim: %1, found in Stats Arr", _victim], _debug] spawn bia_to_log;
} else
{
	//killer not found, add new array for him
	_oldStatsArr pushBack [getPlayerUID _victim, 0, 1];
	missionNamespace setVariable ["PlayerStatsArr", _oldStatsArr, true];

	[_tag, format["Victim: %1, not found in Stats Arr", _victim], _debug] spawn bia_to_log;
};