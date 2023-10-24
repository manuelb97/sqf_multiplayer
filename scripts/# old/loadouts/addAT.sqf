/*
//Add AT giver
[HQ_Arsenal, ["Add AT to Loadout",'scripts\loadouts\addAT.sqf',[],1.5,true,false,"","true",4,false,"",""]] remoteExec ["addAction", 0, true];
*/

//Paras
_player 	= _this select 1;

//Add AT
_at = "rhs_weap_m72a7";
_player addWeapon _at;