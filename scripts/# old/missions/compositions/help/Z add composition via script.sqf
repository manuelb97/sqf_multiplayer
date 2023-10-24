1.) Build your composition in a flat area. The VR map is the best option to me, but you do you.

2.) Place your player in the middle of the composition, and place the following code in his init:

[getPos player, 20, true] call BIS_fnc_ObjectsGrabber;
3.) Create and open a new .sqf file. Press ctrl + V in it, and it will post all of your object code.

4.) Save this file in the mission you want to spawn it in.

5.) To spawn in the composition, use the following code

0 = [positionWhereYouWantToSpawnYourComposition, azimutOfYourComposition, call (compile (preprocessFileLineNumbers "yourComposition.sqf"))] call BIS_fnc_ObjectsMapper;

0 = [getPosATL manu, 0, call (compile (preprocessFileLineNumbers "scripts\missions\compositions\concreteBunkerMedium1.sqf"))] call BIS_fnc_ObjectsMapper;


[getPos test, 50, true] call BIS_fnc_ObjectsGrabber;
//"Box_NATO_Ammo_F"

// get difference between position of major object via objectGrabber
// check in real game how big difference between targets and major object and use that as Z