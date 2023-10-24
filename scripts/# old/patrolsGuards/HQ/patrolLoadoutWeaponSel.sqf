//Paras
params [
"_debug"
];

_tag = "WeaponSelection";

//Include weapon arrays
#include "..\..\loadouts\tier_weapons.hpp"

//All same tier
_tier = selectRandom[	1,1,1,
									2,2,
									3,3,
									4
								];

if (_debug) then 
{
	_text = format["Weapon Tier: %1",_tier];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

private ["_pistols","_SMGs","_ATs","_rifles","_rifleGLs","_MGs","_DMRs","_snipers"];
switch _tier do 
{
	case 1: 
	{
		_pistols		=	selectRandom[_pistolTier4	+ _pistolTier3];
		_SMGs 		= 	selectRandom[_smgTier4 	+ _smgTier3];
		_ATs 		= 	selectRandom[_atTier4 		+ _atTier3];
		_rifles 		= 	selectRandom[_rifleTier4 	+ _rifleTier3];
		_rifleGLs 	= 	selectRandom[_glTier4 		+ _glTier3];
		_MGs 		= 	selectRandom[_mgTier4 	+ _mgTier3];
		_DMRs 		= 	selectRandom[_dmrTier4 	+ _dmrTier3];
		_snipers	= 	selectRandom[_sniperTier4	+ _sniperTier3];
	};
	case 2: 
	{
		_pistols		=	selectRandom[_pistolTier3 	+  _pistolTier2];
		_SMGs 		= 	selectRandom[_smgTier3 	+  _smgTier2];
		_ATs 		= 	selectRandom[_atTier3 		+ _atTier2];
		_rifles 		= 	selectRandom[_rifleTier3 	+ _rifleTier2];
		_rifleGLs 	= 	selectRandom[_glTier3 		+ _glTier2];
		_MGs 		= 	selectRandom[_mgTier3 	+ _mgTier2];
		_DMRs 		= 	selectRandom[_dmrTier3 	+ _dmrTier2];
		_snipers	= 	selectRandom[_sniperTier3	+ _sniperTier2];
	};
	case 3: 
	{
		_pistols		=	_pistolTier2;
		_SMGs 		= 	_smgTier2;
		_ATs 		= 	_atTier2;
		_rifles 		= 	_rifleTier2;
		_rifleGLs 	= 	_glTier2;
		_MGs 		= 	_mgTier2;
		_DMRs 		= 	_dmrTier2;
		_snipers	= 	_sniperTier2;
	};
	case 4: 
	{
		_pistols		=	_pistolTier1;
		_SMGs 		= 	_smgTier1;
		_ATs 		= 	_atTier1;
		_rifles 		= 	_rifleTier1;
		_rifleGLs 	= 	_glTier1;
		_MGs 		= 	_mgTier1;
		_DMRs 		= 	_dmrTier1;
		_snipers	= 	_sniperTier1;
	};
};

//Select weapon
_pistol 		= 	selectRandom _pistols;
_smg 		= 	selectRandom _SMGs;
_at 			= 	selectRandom _ATs;
_rifle 		= 	selectRandom _rifles;
_rifleGL		= 	selectRandom _rifleGLs;
_mg 			= 	selectRandom _MGs;
_dmr 		= 	selectRandom _DMRs;
_sniper 	= 	selectRandom _snipers;

if (_debug) then 
{
	_text = format["%1\n%2\n%3\n%4\n%5\n%6",_smg,_at,_rifle,_rifleGL,_mg,_dmr,_sniper];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

[_pistol,_smg,_at,_rifle,_rifleGL,_mg,_dmr,_sniper]