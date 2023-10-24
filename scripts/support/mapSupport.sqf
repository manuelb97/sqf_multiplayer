//Params
params [
"_target", 
"_caller", 
"_arguments"
];

_arguments params ["_ammo", "_rounds", "_xStart", "_yDisp", "_dist", "_speed", "_height", "_directional"];
_delays = [10, 20, 30];
_height = 400;
_velocity = 50;

_supp = "Strike";

if (_ammo in ["G_40mm_SmokeRed", "ACE_40mm_Flare_white"]) then 
{
	_supp = "Smoke";
};

_cd = missionNamespace getvariable [format["%1SupportCD", _supp], 300];
_lastExe = missionNamespace getvariable [format["Last%1Support", _supp], serverTime - _cd];

if (servertime >= (_lastExe + _cd)) then 
{
	_lastExe = missionNamespace setvariable [format["Last%1Support", _supp], serverTime, true];

	//Wait for Input or Cancel
	openMap true;
	clicked = 0;
	onMapSingleClick 
	{
		mapPos = _pos; 
		clicked = 1; 
		onMapSingleClick ""; 
		true;
	};

	while {!visibleMap} do
	{
		uiSleep 0.1;
	};
		
	while {clicked == 0 && visibleMap} do
	{
		uiSleep 0.1;
	};

	if (clicked == 0) exitWith {};
	openMap false;

	//get 2nd click
	if (_directional == "directional") then 
	{
		openMap true;
		clicked = 0;
		onMapSingleClick 
		{
			mapPos2 = _pos; 
			clicked = 1; 
			onMapSingleClick ""; 
			true;
		};

		while {!visibleMap} do
		{
			uiSleep 0.1;
		};
			
		while {clicked == 0 && visibleMap} do
		{
			uiSleep 0.1;
		};

		if (clicked == 0) exitWith {};
		openMap false;

		[
			"Executing Gun Run, ETA 20 seconds"
		] remoteExec ["bia_spawn_text", _caller];

		_dist =  mapPos distance mapPos2;
		_strikeDir = mapPos getDir mapPos2;
		_pos = mapPos getPos [_dist / 2, _strikeDir];
		[_pos, _strikeDir, "B_Plane_CAS_01_F", true] spawn bia_cas_variable_weap;
	} else 
	{
		//Non directional types
		mapPos set [2, 0]; 
		_counter = 1; 
		_realDelay = random _delays;
		
		[
			format["Executing requested Strike, ETA %1 seconds", round(_realDelay)]
		] remoteExec ["bia_spawn_text", _caller];

		uiSleep _realDelay;

		for "_i" from 1 to _rounds do  
		{ 
			_yStart = random [-1 * _yDisp, 0, _yDisp];
			_pos = mapPos vectorAdd [_xStart + (_counter * _dist), _yStart, 0];
			["", _caller, _pos, 0, _ammo, _height, _velocity, true] spawn bia_drop_projectile;
			_counter = _counter + 1;
			uiSleep random[1,3,5];
		};
	};
} else 
{
	[
		format["%1 Support denied, remaining Cooldown: %2", _supp, round((_lastExe + _cd) - serverTime)]
	] remoteExec ["bia_spawn_text", _caller];
};

/*

	_relDir = mapPos getDir mapPos2;
	_dist2D = mapPos distance2D mapPos2;
	_necessaryRounds = round(_dist2D / _dist);
	_minRounds = round(_rounds / 5);
	_rounds = selectMin[selectMax[_necessaryRounds, _minRounds], _rounds];

	_counter = 0; 
	uiSleep (random _delays);

	for "_i" from 1 to _rounds do  
	{ 
		_pos = mapPos getPos [(_dist2D / _rounds) * _counter, _relDir];
		_missile = createVehicle [_ammo, _pos vectorAdd [0, 0, _height], [], 0, "CAN_COLLIDE"];  
		_missile setVectorDirAndUp [[0, 0, -1], [0, 1, -1]];  
		_missile setVelocity [0, 0, -1 * _speed]; 

		_counter = _counter + 1; 
		sleep 0.1; 
	}; 

	//hint format["Number used: %1", _rounds];

	// ["_ammo", "_rounds", "_xStart", "_yDisp", "_dist", "_speed", "_height", "_directional"];
	// ["B_30mm_HE", 20, 0, 0, 5, 1000, 300, "directional"]
	
	// ["G_40mm_SmokeRed", 3, -4, 2, 4, 50, 300, ""],
	// ["ACE_40mm_Flare_white", 1, 0, 0, 0, 6, 160, ""]

	_spawnHeight = 300; 

	if (_rounds > 1) then 
	{
		_counter = 1; 

		for "_i" from 1 to _rounds do  
		{ 
			_yStart = random [-1 * _yDisp, 0, _yDisp]; 

			_missile = createVehicle [_ammo, mapPos vectorAdd [_xStart + (_counter * _dist), _yStart, _height], [], 0, "CAN_COLLIDE"];  
			_missile setVectorDirAndUp [[0, 0, -1], [0, 1, -1]];  
			_missile setVelocity [0, 0, -1 * _speed]; 

			_counter = _counter + 1; 
			sleep 0.1; 
		}; 
	} else 
	{
		_missile = createVehicle [_ammo, mapPos vectorAdd [0, 0, _height], [], 0, "CAN_COLLIDE"];  
		_missile setVectorDirAndUp [[0, 0, -1], [0, 1, -1]];  
		_missile setVelocity [0, 0, -1 * _speed]; 
	};
*/