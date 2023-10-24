//call compile preprocessFileLineNumbers "scripts\supplyDrop.sqf"

[
	["B_supplyCrate_F","Medical Supply","\A3\Ui_f\data\IGUI\Cfg\simpleTasks\types\rearm_ca.paa",{
		clearItemCargoGlobal _this;
        clearMagazineCargoGlobal _this;
        clearWeaponCargoGlobal _this;
        clearBackpackCargoGlobal _this;
		
		_this addItemCargoGlobal ["ACE_fieldDressing",15*(count allPlayers)];
		_this addItemCargoGlobal ["ACE_morphine",5*(count allPlayers)];
		_this addItemCargoGlobal ["ACE_epinephrine",2*(count allPlayers)];
    }],
    ["B_supplyCrate_F","US Ammo","\A3\Ui_f\data\IGUI\Cfg\simpleTasks\types\rearm_ca.paa",{
		clearItemCargoGlobal _this;
        clearMagazineCargoGlobal _this;
        clearWeaponCargoGlobal _this;
        clearBackpackCargoGlobal _this;
		
		_this addMagazineCargoGlobal ["rhs_mag_30Rnd_556x45_M855A1_Stanag",10*(count allPlayers)];
		_this addMagazineCargoGlobal ["rhssaf_30rnd_556x45_EPR_G36",10*(count allPlayers)];
		_this addMagazineCargoGlobal ["rhs_mag_20Rnd_SCAR_762x51_m80_ball_bk",10*(count allPlayers)];
		
		_this addMagazineCargoGlobal ["rhsgref_50Rnd_792x57_SmE_drum",8*(count allPlayers)];
		_this addMagazineCargoGlobal ["rhsusf_200Rnd_556x45_box",4*(count allPlayers)];
		_this addMagazineCargoGlobal ["rhsusf_100Rnd_762x51",4*(count allPlayers)];
		
        _this addMagazineCargoGlobal ["ACE_30Rnd_556x45_Stanag_Mk262_mag",10*(count allPlayers)];
		_this addMagazineCargoGlobal ["ACE_20Rnd_762x51_Mk316_Mod_0_Mag",10*(count allPlayers)];
		
		_this addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",10*(count allPlayers)];
		_this addMagazineCargoGlobal ["rhs_mag_m18_green",3*(count allPlayers)];
    }],
    ["B_supplyCrate_F","RU Ammo","\A3\Ui_f\data\IGUI\Cfg\simpleTasks\types\rearm_ca.paa",{
        clearItemCargoGlobal _this;
        clearMagazineCargoGlobal _this;
        clearWeaponCargoGlobal _this;
        clearBackpackCargoGlobal _this;
		
        _this addMagazineCargoGlobal ["rhs_30Rnd_545x39_7N10_AK",10*(count allPlayers)];
		_this addMagazineCargoGlobal ["rhs_30Rnd_762x39mm_polymer",10*(count allPlayers)];
		_this addMagazineCargoGlobal ["rhs_VOG25",10*(count allPlayers)];
		_this addMagazineCargoGlobal ["rhs_100Rnd_762x54mmR",4*(count allPlayers)];
		_this addMagazineCargoGlobal ["rhs_10Rnd_762x54mmR_7N1",20*(count allPlayers)];
    }],
    ["B_supplyCrate_F","Anti Vehicle","\A3\Ui_f\data\IGUI\Cfg\simpleTasks\types\rearm_ca.paa",{
        clearItemCargoGlobal _this;
        clearMagazineCargoGlobal _this;
        clearWeaponCargoGlobal _this;
        clearBackpackCargoGlobal _this;
		
        _this addWeaponCargoGlobal ["rhs_weap_m72a7",1*(count allPlayers)];
		
        _this addMagazineCargoGlobal ["rhs_rpg7_PG7V_mag",3*(count allPlayers)];
		_this addMagazineCargoGlobal ["MRAWS_HEAT_F",2*(count allPlayers)];
		_this addMagazineCargoGlobal ["rhs_fim92_mag",2*(count allPlayers)];
    }]
]