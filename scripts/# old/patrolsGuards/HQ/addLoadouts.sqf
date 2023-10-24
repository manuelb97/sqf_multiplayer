//Paras
params [
"_box",
"_weapons"
];

_pistol 		=	_weapons select 0;
_smg 		=	_weapons select 1;
_at 			=	_weapons select 2;
_rifle 		=	_weapons select 3;
_rifleGL 	= 	_weapons select 4;
_mg 			= 	_weapons select 5;
_dmr 		=	_weapons select 6;
_sniper 	=	_weapons select 7;

//Add actions
_tier = "Tier_1";
_box addAction [format ['CQB AT Loadout  ( %1  /  %2 )',	_smg,_at],	'scripts\loadouts\tier_Loadout.sqf',[_tier,_smg,_pistol,_at],	1.5,true,false,"","true",3,false,"",""];
_box addAction [format ['Rifleman Loadout  ( %1  /  %2 )',	_rifle,_at],		'scripts\loadouts\tier_Loadout.sqf',[_tier,_rifle,_pistol,_at],		1.5,true,false,"","true",3,false,"",""]; 
_box addAction [format ['Grenadier Loadout  ( %1 )', 			_rifleGL],		'scripts\loadouts\tier_Loadout.sqf',[_tier,_rifleGL,_pistol],		1.5,true,false,"","true",3,false,"",""]; 
_box addAction [format ['MG Loadout  ( %1 )', 					_mg],			'scripts\loadouts\tier_Loadout.sqf',[_tier,_mg,_pistol],			1.5,true,false,"","true",3,false,"",""];
_box addAction [format ['DMR Loadout  ( %1 )', 					_dmr],			'scripts\loadouts\tier_Loadout.sqf',[_tier,_dmr,_pistol],			1.5,true,false,"","true",3,false,"",""]; 
_box addAction [format ['Sniper Loadout  ( %1 )', 				_sniper],		'scripts\loadouts\tier_Loadout.sqf',[_tier,_sniper,_pistol],		1.5,true,false,"","true",3,false,"",""]; 

//Add AT option
_box addAction ["Add AT to Loadout",'scripts\loadouts\addAT.sqf',[],1.5,true,true,"","true",3];