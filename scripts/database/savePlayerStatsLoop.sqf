params [
"_debug"
];

_tag = "SavePlayerStatsLoop";

while {true} do
{
	_currentStatsArr = missionNamespace getVariable ["PlayerStatsArr", []];
	//[_tag, format["Player Stats Arr for Saving: %1", _currentStatsArr], _debug] spawn bia_to_log;
	["PlayerStatsArr", _currentStatsArr] call bia_save_to_profile;
	
	uiSleep 60;
};