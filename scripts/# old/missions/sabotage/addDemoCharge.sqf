//Paras
_player 	= _this select 1;

//Add Demo Charge
_c4 = "DemoCharge_Remote_Mag";
if (_player canAddItemToVest [_c4, 1]) then {
	_player addItemToVest _c4;
} else {
	if (backpack _player != "") then {
		_player addItemToBackpack _c4;
	} else {
		_player addBackpack "dgr_pack";
		_player addItemToBackpack _c4;
	};
};