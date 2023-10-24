/*
[manu, 4, true, true, false, false] call bia_ai_squad;
*/

//Paras
params [
"_player",
"_number",
"_mg",
"_at",
"_suppressed",
"_debug"
];

_tag = "AISupportSquad";

_spawnPos = getPos _player;

_rifleClass = "B_Soldier_F";
_scoutClass = "B_recon_F";
_atClass = "B_soldier_AT_F";
_glClass = "B_Soldier_GL_F";
_arClass = "B_soldier_AR_F";

//Define classes in team
_teamArr = [];

if (_mg) then
{
	_teamArr pushBack _arClass;
};

if (_at) then
{
	_teamArr pushBack _atClass;
};

_slotsLeft = _number - (count _teamArr);

if (_slotsLeft > 1) then
{
	_teamArr pushBack _glClass;
};

_slotsLeft = _number - (count _teamArr);
for "_i" from 1 to _slotsLeft do 
{
	if (_suppressed) then
	{
		_teamArr pushBack _scoutClass;
	} else
	{
		_teamArr pushBack _rifleClass;
	};
};

//Set skill & equipment for team members
_grp = createGroup west;
_grp deleteGroupWhenEmpty true;

{
	_class = _x;
	_soldier = _grp createUnit [_class, _spawnPos, [], 5, "NONE"];
	_soldier setSkill 1;
	
	if (_class == _rifleClass) then
	{
		[_soldier, "RifleUnsuppressed", false, _debug] spawn bia_ai_equip;
	};
	
	if (_class == _scoutClass) then
	{
		[_soldier, "RifleSuppressed", false, _debug] spawn bia_ai_equip;
	};
	
	if (_class == _atClass) then
	{
		[_soldier, "RifleUnsuppressed", true, _debug] spawn bia_ai_equip;
	};
	
	if (_class == _glClass) then
	{
		[_soldier, "RifleGrenadier", false, _debug] spawn bia_ai_equip;
	};
	
	if (_class == _arClass) then
	{
		[_soldier, "MG", false, _debug] spawn bia_ai_equip;
	};
} forEach _teamArr;

//Join player
(units _grp) join (group _player); //joinSilent doesnt work with C2