params [
"_debug"
];

_tag = "SavePlayerStatsLoop";

while {true} do
{
	_currentStatsArr = HQ_Arsenal getVariable ["PlayerStatsArr", []];
	
	if (_debug) then 
	{
		_text = format["Player Stats Arr for Saving: %1", _currentStatsArr];
		//[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
	};

	["PlayerStatsArr", _currentStatsArr] call bia_save_to_profile; //execVM "scripts\patrolsGuards\NewSaving\saveToProfile.sqf";
	
	uiSleep 60;
};