//get cfg info
PHAN_ASPLUS_VICS=[];
{
    if ((getText (configfile >> "CfgVehicles" >> _x >> "editorPreview")) != "" && _x!="" && getNumber (configfile >> "CfgVehicles" >> _x >> "Type") == 2 && (getText (configfile >> "CfgVehicles" >> _x >> "displayName")) != "") then {
        (PHAN_ASPLUS_VICS pushBack [_x,(getText (configfile >> "CfgVehicles" >> _x >> "displayName")),(getNumber (configfile >> "CfgVehicles" >> _x >> "side"))])}
    
}forEach ((configfile >> "CfgVehicles") call BIS_fnc_getCfgSubClasses);

PHAN_ASPLUS_VICSDISPLAY=[];
{
    if ((getText (configfile >> "CfgVehicles" >> _x >> "editorPreview")) != "" && _x!="" && getNumber (configfile >> "CfgVehicles" >> _x >> "Type") == 2 && (getText (configfile >> "CfgVehicles" >> _x >> "displayName")) != "") then {
        _colour=switch ((getNumber (configfile >> "CfgVehicles" >> _x >> "side"))) do {case 0: {[255,0,0,255]}; case 1: {[0,0,255,255]}; case 2: {[0,255,0,255]}; case 3: {[255,0,255,255]}; default {[0,0,0,255]};};
        (PHAN_ASPLUS_VICSDISPLAY pushBack [(getText (configfile >> "CfgVehicles" >> _x >> "displayName")),"",(getText (configfile >> "CfgVehicles" >> _x >> "editorPreview")),_colour])}
    
}forEach ((configfile >> "CfgVehicles") call BIS_fnc_getCfgSubClasses);

PHAN_ASPLUS_GUNS=[];
{
    if (((getArray (configFile >> "CfgWeapons" >> (_x) >> "magazines") ) # 0) != "" && getNumber (configfile >> "CfgWeapons" >> _x >> "Type") == 65536 && (getText (configfile >> "CfgWeapons" >> _x >> "displayName")) != "") then {
        (PHAN_ASPLUS_GUNS pushBackUnique [_x,(getText (configfile >> "CfgWeapons" >> _x >> "displayName"))])}
    
}forEach ((configfile >> "CfgWeapons") call BIS_fnc_getCfgSubClasses);

PHAN_ASPLUS_GUNSDISPLAY=[];
{
    PHAN_ASPLUS_GUNSDISPLAY pushBack [_x#1,_x#0];
    
}forEach (PHAN_ASPLUS_GUNS);

_vics = PHAN_ASPLUS_VICS;
_vicsdisplay = PHAN_ASPLUS_VICSDISPLAY;
_guns = PHAN_ASPLUS_GUNS;
_gunsdisplay = PHAN_ASPLUS_GUNSDISPLAY;

//Input
params["_casPos", "_casDir", "_planeClass", "_weapons", "_logic"];

// "--- Detect gun";
_weaponTypes = [];
_weaponTypes pushBackUnique (((_weapons#0) call bis_fnc_itemType) #1);
_planeCfg = configfile >> "cfgvehicles" >> _planeClass;
if !(isclass _planeCfg) exitwith {["Vehicle class '%1' not found",_planeClass] call bis_fnc_error; false};

_posATL = _casPos; //getposatl _logic;
_pos = +_posATL;
_pos set [2,(_pos select 2) + getterrainheightasl _pos];
_dir = direction _logic;

_dis = 3000;
_alt = 1000;
_pitch = atan (_alt / _dis);
_speed = 400 / 3.6;
_duration = ([0,0] distance [_dis,_alt]) / _speed;

// "--- Create plane";
// str (_planeClass);
_planePos = [_pos,_dis,_dir + 180] call bis_fnc_relpos;
_planePos set [2,(_pos select 2) + _alt];
_planeSide = (getnumber (_planeCfg >> "side")) call bis_fnc_sideType;
_planeArray = [_planePos,_dir,_planeClass,_planeSide] call bis_fnc_spawnVehicle;
_plane = _planeArray select 0;
_plane setposasl _planePos;
_plane move ([_pos,_dis,_dir] call bis_fnc_relpos);
_plane disableai "move";
_plane disableai "target";
_plane disableai "autotarget";
_plane setcombatmode "blue";

_vectorDir = [_planePos,_pos] call bis_fnc_vectorFromXtoY;
_velocity = [_vectorDir,_speed] call bis_fnc_vectorMultiply;
_plane setvectordir _vectorDir;
[_plane,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
_vectorUp = vectorup _plane;

// "--- Remove all other weapons;";
_currentWeapons = weapons _plane;
{
    if !(_x in _weapons) then {
        _plane removeweapon _x;
    };
} foreach _currentWeapons;
_plane addWeaponTurret [_weapons # 0,[-1]];
_plane addMagazineTurret [(getArray (configFile >> "CfgWeapons" >> (_weapons # 0) >> "magazines") ) # 0, [-1]];
waitUntil {(weaponState [_plane,[-1]])#6 == 0};

// "--- Approach";
_fire = [] spawn {waituntil {false}};
_fireNull = true;
_time = time;
_offset = if ({_x == "missilelauncher"} count _weaponTypes > 0) then {20} else {0};
waituntil 
{
    _fireProgress = _plane getvariable ["fireProgress",0];
    
    // "--- Update plane position when module was moved / rotated";
    if ((getposatl _logic distance _posATL > 0 || direction _logic != _dir) && _fireProgress == 0) then {
        _posATL = getposatl _logic;
        _pos = +_posATL;
        _pos set [2,(_pos select 2) + getterrainheightasl _pos];
        _dir = direction _logic;
        
        _planePos = [_pos,_dis,_dir + 180] call bis_fnc_relpos;
        _planePos set [2,(_pos select 2) + _alt];
        _vectorDir = [_planePos,_pos] call bis_fnc_vectorFromXtoY;
        _velocity = [_vectorDir,_speed] call bis_fnc_vectorMultiply;
        _plane setvectordir _vectorDir;
        //[_plane,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
        _vectorUp = vectorup _plane;
        
        _plane move ([_pos,_dis,_dir] call bis_fnc_relpos);
    };
    
    // "--- Set the plane approach vector";
    _plane setVelocityTransformation [
        _planePos, [_pos select 0,_pos select 1,(_pos select 2) + _offset + _fireProgress * 12],
        _velocity, _velocity,
        _vectorDir,_vectorDir,
        _vectorUp, _vectorUp,
        (time - _time) / _duration
    ];
    _plane setvelocity velocity _plane;
    
    // "--- Fire!";
    if ((getposasl _plane) distance _pos < 1500 && _fireNull) then {
        
        
        // "--- Create laser target";
        private _targetType = if (_planeSide getfriend west > 0.6) then {"LaserTargetW"} else {"LaserTargetE"};
        _target = ((position _logic nearEntities [_targetType,250])) param [0,objnull];
        if (isnull _target) then {
            _target = createvehicle [_targetType,position _logic,[],0,"none"];
        };
        _plane reveal lasertarget _target;
        _plane dowatch lasertarget _target;
        _plane dotarget lasertarget _target;
        
        _fireNull = false;
        terminate _fire;
        _fire = [_plane,_weapons,_target] spawn {
            _plane = _this select 0;
            _planeDriver = driver _plane;
            _weapons = _this select 1;
            _target = _this select 2;
            _duration = 8;
            _time = time + _duration;
            waituntil {
                
                    _plane selectweapon (_weapons#0);
                    _planeDriver forceweaponfire [_weapons#0,selectRandom (getArray (configFile >> "CfgWeapons" >> (_weapons # 0) >> "modes"))];
                    
                    //_planeDriver fireattarget [_target,_weapons # 0];
                    
                _plane setvariable ["fireProgress",(1 - ((_time - time) / _duration)) max 0 min 1];
                sleep 0.01;
                time > _time || isnull _plane //--- Shoot only for specific period or only one bomb
            };
            sleep 1;
        };
    };
    
    sleep 0.01;
    scriptdone _fire || isnull _logic || isnull _plane
};