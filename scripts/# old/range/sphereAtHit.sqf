/*
	Author: Mossarelli

	Description:
	Function called by the sign with the action that registers the shooter with name and score variable.

	Parameter(s):
		0:	Target Object.
		1:	Name of Logic associated with Lane.
	
	Usage:
	0 = [this,Logic_Name] call Moss_fnc_TargetInit;
	
	0 = [this,game_logic1] execVM "scripts\range\targetScript.sqf";
*/

/*
execVM "scripts\range\fn_MainInit.sqf";

private ["_object","_LogicName","_LogicTargetArray"];

_LogicName = _this select 1;

_object allowDamage false;

//Error Message.
if (isNull _LogicName) exitWith
{
	[
		localize "No logic exists that was passed as a parameter to the function! Make sure the logic exists and is referenced in the function call!"
	] call BIS_fnc_errorMsg;
};

//Make sure Target knows its logic's name
_object setVariable ["MossTargetLogicName",_LogicName,false];
*/

/*
//Add Current target to Logic's Array variable
_LogicTargetArray = _LogicName getVariable "MossLogicTargetArray";

//Make sure the target object is not in the array and then add it.
if ( ! ( str (_object) in _LogicTargetArray) ) then
{
	_LogicTargetArray set [(count _LogicTargetArray),_object];
	_LogicName setVariable ["MossLogicTargetArray",_LogicTargetArray,true];
};

//Set the texture on the object.
_object setObjectTexture [0,"pics\Range\T_1.jpg"];

//hint format ["%1",_LogicTargetArray]; 
*/

//Add Score counter to Target Event Handler
_object = _this select 0;

_object addEventHandler
["HitPart",
{
	_target = (_this select 0 select 0);
	_shooter = (_this select 0 select 1);
	//_LogicNameTarget = _target getVariable ["MossTargetLogicName","Null"];
	//_LogicNameShooter = _shooter getVariable ["MossPlayerLogicName","Nullify"];
	
	//Create orange markers where the bullet hit. Turn this off in MainInit.
	[(_this select 0 select 3)] spawn
	{
		_spr = "Sign_Sphere10cm_F" createVehicle [0,0,0];
		_spr setPosASL (_this select 0);
		sleep 5;
		deleteVehicle _spr;
	};
	
	/*
	//Make sure the lane logic is the same object for both player and target.
	if ( str _LogicNameTarget != str _LogicNameShooter ) exitWith { };
	
	//Grab score data.
	_array = _shooter getVariable "MossShooterScoreInfo";
	
	//Safety check for the variable
	if (isNil "_array") then
	{
		_shooter setVariable ["MossShooterScoreInfo",[_shooter],false];
	};
	
	//Where did Bullet hit on relative to the target?
	_bullet = _target worldToModel (ASLToATL (_this select 0 select 3));
	
	//Sort XYZ and multiply to centimeters
	_bx = abs (((_bullet select 0) * 100));
	_by = abs (((_bullet select 2) * 100) - MOSS_TargetHeighOffset); //Change in MainInit.
	_bz = ((_bullet select 1) * 100); //Z is not used.
	
	//Show XYZ coordinates for the bullets impact. Turn this on in MainInit.
	if (MOSS_DEBUG) then
	{
		systemChat format ["X:%1,Y:%2,Z:%3",_bx,_by,_bz];
	};
	
	//Distance from center. Pythagoras theorem: X*X + Y*Y = R*R.
	_sqr = sqrt ((_bx ^ 2) + (_by ^ 2));
	
	_bullet = [_sqr];
	
	//Show distance from center of impact. Distance from center is used in score calculation. Turn this on in MainInit.
	if (MOSS_DEBUG) then
	{
		systemChat format ["%1",_bullet];
	};
	
	//Put Bullet XYZ in Array
	_array set [(count _array),_bullet];
	_shooter setVariable ["MossShooterScoreInfo",_array,false];
	*/
}
];