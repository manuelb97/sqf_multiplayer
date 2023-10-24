//Paras
params [
"_inputArgs", 
"_elapsedTime", 
"_totalTime", 
"_errorCode"
];

_inputArgs params ["_target", "_caller", "_args"];

// if (_caller getVariable ["pvp_defend", false]) then 
_radius = 5;
_delay = 5;

if (count _args > 0) then 
{
    _delay = _args select 0;
};

_vegetation = ["BUSH", "SMALL TREE", "TREE"];
_vegetationObjects = nearestTerrainObjects [_caller, _vegetation, _radius, true, true];
_vegetationObjects = _vegetationObjects select {!(isObjectHidden _x)};

if (count _vegetationObjects > 0) then 
{
    uiSleep _delay;

    (_vegetationObjects select 0) hideObjectGlobal true;

    [
        format["Cleared closest vegetation"], "center_top", 5, 0, 0, 100, "Green"
    ] remoteExec ["bia_spawn_text", _caller];
} else 
{
    [
        "No vegetation to clear close enough", "center_top", 5, 0, 0, 100, "Green"
    ] remoteExec ["bia_spawn_text", _caller];
};