//Paras
params ["_sabObj"];

//Prep Stuff
_chargePlaced = false;
_sabObj allowDamage false;

//Check for C4 in Proximity of Sab Obj
while {missionLoop == 1 && !_chargePlaced} do {
	_closeObjs = nearestObjects [_sabObj, [], 30];
	
	{
		if ("c4" in str _x) then {
			_chargePlaced = true;
			
			//Allow Sab Obj to be destroyed
			//[format["Objective can be destroyed now"]] remoteExec ["hintSilent", 0, true];
			_sabObj allowDamage true;
			_sabObj setDamage 0.9;
		};
	} forEach _closeObjs;
	
	uiSleep 2;
	//[format["Waiting for charge to be placed"]] remoteExec ["hintSilent", 0, true];
};