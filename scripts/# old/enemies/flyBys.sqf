//Paras
params [
"_debug"
];

_tag = "FlyByLoop";

if (_debug) then 
{
	_text = format["Loop started"];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

flyBys = true;

while {flyBys} do 
{
	if (_debug) then 
	{
		_text = format["New Cycle"];
		[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
	};
	
	_playerArray = [];
	{ 
		if (_x inArea Flare_Trigger) then 
		{
			_playerArray pushBack _x; 
		}; 
	} forEach allPlayers;
	
	if (count _playerArray > 0) then 
	{
		if (selectRandom[true,false]) then 
		{
			if (_debug) then 
			{
				_text = format["Ordering Fly By"];
				[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
			};
			
			_targetPlayer = selectRandom _playerArray;
			_flyByMiddle = getPos _targetPlayer;
			
			_flyByHeading = random 360;
			_startPos = _flyByMiddle getPos [2500, _flyByHeading];
			_endPos = _flyByMiddle getPos [2500, _flyByHeading + 180];
			_speed = "FULL";
			
			_flyByType = selectRandom["heli","heli","jet"];
			_class = "";
			_altitude = 0;
			
			if (_debug) then 
			{
				_text = format["Fly By Type: %1",_flyByType];
				[_tag, _text] remoteExec ["bia_to_log", 2, false];
			};
			
			if (_flyByType == "heli") then 
			{
				_class = selectRandom["rhs_mi28n_vvsc","RHS_Mi8AMTSh_vvsc","RHS_Su25SM_vvsc"]; //"RHS_Mi24P_vvsc",
				_altitude = 100;
			} else 
			{
				_class = selectRandom["rhs_mig29s_vvsc","rhs_mig29sm_vvsc"]; //"RHS_Su25SM_vvsc",
				_altitude = 300;
			};
			
			[_startPos, _endPos, _altitude, _speed, _class, east] call BIS_fnc_ambientFlyby;
			
			uiSleep 90; //240
		};
	};
	
	uiSleep 60; //60
};