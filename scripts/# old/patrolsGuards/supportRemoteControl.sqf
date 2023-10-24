//Paras
_caller 			= param[1,""];
_inputArray	= param [3,[]];
_vehType 		= _inputArray select 0;

//Get gunner of vehicle
_units =[]; 
{ 
 if (side _x == west && typeOf (vehicle _x) == _vehType) then { 
  _units pushback _x; 
 }; 
} forEach allUnits; 
_gunner = gunner (vehicle (_units select 0));

//Get unit control
if (!isNil "_gunner") then {
	player remoteControl _gunner;
	_gunner switchCamera "Internal";
} else {
	
	"Couldnt find the gunner" remoteExec ["hint", _caller, false];
};

//objNull remoteControl driver UAV;