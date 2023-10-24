//Paras
params [
];

_aggroLvl = missionNamespace getVariable ["Aggression", 0];
_tier = "Tier_4";

if (_aggroLvl >= 25 && _aggroLvl < 50) then 
{
	_tier = "Tier_3";
} else 
{
	if (_aggroLvl >= 50 && _aggroLvl < 75) then 
	{
		_tier = "Tier_2";
	} else 
	{
		if (_aggroLvl >= 75) then 
		{
			_tier = "Tier_1";
		};
	};
};

_tier