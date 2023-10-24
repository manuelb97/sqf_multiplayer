//Paras
_tier = param [0,""];

//Include weapon arrays
#include "tier_weapons.hpp"

//Select tier
switch _tier do {
	case "Tier_4": {
		currentPistol 	=	selectRandom[_pistolTier4,_pistolTier4,_pistolTier3];
		currentSMG 	= 	selectRandom[_smgTier4,_smgTier4,_smgTier3];
		currentAT 		= 	selectRandom[_atTier4,_atTier4,_atTier3];
		currentRifle 	= 	selectRandom[_rifleTier4,_rifleTier4,_rifleTier3];
		currentRifleGL 	= 	selectRandom[_glTier4,_glTier4,_glTier3];
		currentMG 		= 	selectRandom[_mgTier4,_mgTier4,_mgTier3];
		currentDMR 	= 	selectRandom[_dmrTier4,_dmrTier4,_dmrTier3];
		currentSniper	= 	selectRandom[_sniperTier4,_sniperTier4,_sniperTier3];
	};
	case "Tier_3": {
		currentPistol 	=	selectRandom[_pistolTier3,_pistolTier3,_pistolTier2];
		currentSMG 	= 	selectRandom[_smgTier3,_smgTier3,_smgTier2];
		currentAT 		= 	selectRandom[_atTier3,_atTier3,_atTier2];
		currentRifle 	= 	selectRandom[_rifleTier3,_rifleTier3,_rifleTier2];
		currentRifleGL 	= 	selectRandom[_glTier3,_glTier3,_glTier2];
		currentMG 		= 	selectRandom[_mgTier3,_mgTier3,_mgTier2];
		currentDMR 	= 	selectRandom[_dmrTier3,_dmrTier3,_dmrTier2];
		currentSniper	= 	selectRandom[_sniperTier3,_sniperTier3,_sniperTier2];
	};
	case "Tier_2": {
		currentPistol 	=	selectRandom[_pistolTier2,_pistolTier2,_pistolTier1];
		currentSMG 	= 	selectRandom[_smgTier2,_smgTier2,_smgTier1];
		currentAT 		= 	selectRandom[_atTier2,_atTier2,_atTier1];
		currentRifle 	= 	selectRandom[_rifleTier2,_rifleTier2,_rifleTier1];
		currentRifleGL 	= 	selectRandom[_glTier2,_glTier2,_glTier1];
		currentMG 		= 	selectRandom[_mgTier2,_mgTier2,_mgTier1];
		currentDMR 	= 	selectRandom[_dmrTier2,_dmrTier2,_dmrTier1];
		currentSniper 	= 	selectRandom[_sniperTier2,_sniperTier2,_sniperTier1];
	};
	case "Tier_1": {
		currentPistol 	=	_pistolTier1;
		currentSMG 	= 	_smgTier1;
		currentAT 		= 	_atTier1;
		currentRifle 	= 	_rifleTier1;
		currentRifleGL	= 	_glTier1;
		currentMG 		= 	_mgTier1;
		currentDMR 	= 	_dmrTier1;
		currentSniper 	= 	_sniperTier1;
	};
};

//Select weapon
_pistol 	= 	selectRandom currentPistol;
_smg 	= 	selectRandom currentSMG;
_at 		= 	selectRandom currentAT;
_rifle 		= 	selectRandom currentRifle;
_rifleGL	= 	selectRandom currentRifleGL;
_mg 		= 	selectRandom currentMG;
_dmr 		= 	selectRandom currentDMR;
_sniper 	= 	selectRandom currentSniper;

//return
[_pistol,_smg,_at,_rifle,_rifleGL,_mg,_dmr,_sniper]