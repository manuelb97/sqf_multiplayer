//Paras
_host = objNull;
_oldHost = objNull;

while {true} do 
{
	_players = allPlayers;// + [2]; //2 for server

	if (count _players > 0) then 
	{
		{
			[_x] remoteExec ["bia_check_fps", _x];
		} forEach _players;

		_fpsVals = _players apply { missionNamespace getVariable [format["%1_fps", _x], 0] };
		_host = _players select (_fpsVals find (selectMax _fpsVals));

		if !(_host in [missionNamespace getVariable ["BiA_Host", ""]]) then 
		{
			missionNamespace setVariable ["BiA_Host", _host, true];

			if (typeName _host == "SCALAR") then 
			{
				_host = "Server";
			};

			if (_host != _oldHost) then 
			{
				["HostSelector", format["Current Host: %1", _host]] spawn bia_to_log;
			};
		};

		_oldHost = _host;
	};

	uiSleep 60;
};