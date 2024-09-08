//Params
params [
];

0

/*
_missionStart = true;
_oldPlayerStatsArr = [];

if (_missionStart) then 
{
	_oldPlayerStatsArr = missionNamespace getVariable ["PlayerStatsArr", []];
	_missionStart = false;
};



while {true} do
{
	if (missionNamespace getVariable ["MissionRunning", false]) then 
	{
		

		_playerStatsArr = missionNamespace getVariable ["PlayerStatsArr", []];
		_playerArray = allPlayers select {_x distance2D hq_pos < 100};
		_playerCount = count _playerArray;
		
		if (_playerCount > 0) then
		{
			{
				_player = _x;
				_uid = getPlayerUID _player;
				_statsArrIDs = _playerStatsArr apply {_x select 0};
				_arrIdx = _statsArrIDs find _uid;

				_statsArr = [];
				
				if (_arrIdx != -1) then
				{
					_statsArr = _playerStatsArr select _arrIdx;
				};
				
				_statsArr params [
					["_retUID", ""],
					["_kills", 0],
					["_deaths", 0]
				];

				// get old kills 
				_oldStatsArrIDs = _oldPlayerStatsArr apply {_x select 0};
				_oldArrIdx = _oldStatsArrIDs find _uid;
				_oldStatsArr = [];
				
				if (_oldArrIdx != -1) then
				{
					_oldStatsArr = _oldPlayerStatsArr select _oldArrIdx;
				};

				_oldStatsArr params [
					["_retUID", ""],
					["_oldKills", 0],
					["_oldDeaths", 0]
				];