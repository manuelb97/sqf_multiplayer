//Suppl Init
call compile preprocessFileLineNumbers "scripts\supplyDrop.sqf"

//Transport
_this allowDamage false; _this setPosATL (getPosATL heli_pos); {_x allowDamage false;} forEach (crew _this);

//Artillery Heavy
_this allowDamage false; _this setPosATL (getPosATL rocket_pos);

//Artillery
_this allowDamage false; _this setPosATL (getPosATL arty_pos);

