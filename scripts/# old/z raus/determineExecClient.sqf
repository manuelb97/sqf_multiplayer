//Set stuff up
_uidArr = [3,4,5,6,7,8,9,10];
_playerCount = count allPlayers;

//Select UID based on current players
_execClient = 3;
if (_playerCount > 1) then {
	_uidArr = _uidArr resize _playerCount;
	_execClient = selectRandom _uidArr;
};

_execClient