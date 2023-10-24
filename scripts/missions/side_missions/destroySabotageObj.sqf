//Paras
params [
"_sabObj",
"_debug"
];

//Prep Stuff
_chargePlaced = false;
_sabObj allowDamage false;

//Check for C4 in Proximity of Sab Obj
while {alive _sabObj && !_chargePlaced} do 
{
	_closeObjs =  _sabObj nearObjects 30;
	
	{
		if ("c4" in str _x) then 
		{
			_chargePlaced = true;
			
			//Allow Sab Obj to be destroyed
			//"Objective can be destroyed now" remoteExec ["hint", 0, false];
			[_sabObj, true] remoteExec ["allowDamage", 0, false];
			_sabObj allowDamage true;
			_sabObj setDamage 0.9;
		};
	} forEach _closeObjs;
	
	uiSleep 1;
	//[format["Waiting for charge to be placed"]] remoteExec ["hintSilent", 0, true];
};