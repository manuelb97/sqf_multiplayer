/*
(group this) setVariable ["GAIA_ZONE_INTEND",["<ZONE NUMBER>", "MOVE"], false]; -> Agressive.
(group this) setVariable ["GAIA_ZONE_INTEND",["<ZONE NUMBER>", "NOFOLLOW"], false]; -> Defensive
(group this) setVariable ["GAIA_ZONE_INTEND",["<ZONE NUMBER>", "FORTIFY"], false]; -> Fortify

[_grp, _zone, _intend] remoteExec ["bia_give_to_gaia", 0, true];
*/

//Paras
params [
"_grp",
"_zone",
"_intend"
];

//Give to GAIA
_grp setVariable ["GAIA_ZONE_INTEND",[_zone,_intend], false];