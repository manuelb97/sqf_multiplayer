///////
//Close Air Support
//By: Millenwise (beno_83au)
///////
//Use and abuse as required. Please just give credit to those deserving.
///////

MIL_CAS is a simple script to allow a mission designer to use the vanilla CAS Module in-game via scripting.
All this does is perform the required actions to properly call BIS_fnc_moduleCAS.
Best suited for ambience, the strikes shouldn't be relied on for 100% accuracy.

Features:

- Position and approach heading can be defined.
- Plane and type of CAS to be provided can be defined.

To use:	

- Copy the file MIL_CAS.sqf to your mission folder.
- Run the script using:
	- nul = [_position,_direction,_vehicle,_type] execVM "MIL_CAS.sqf";
		- _position - array
			    - position for CAS to strike
		- _direction - number
			     - direction for the CAS to approach on
		- _vehicle - string (optional)
			   - default: "B_Plane_CAS_01_F"
			   - classname of the plane to fly CAS
		- _type - number (optional)
			- default: 2
			- type of CAS to be used
				- 0 - Guns
				- 1 - Missiles
				- 2 - Guns & Missiles
				- 3 - Bomb

Example:

- nul = [getPos player,240] execVM "MIL_CAS.sqf";
	- Wipeout will fly in for a "Guns & Missiles" run.
- nul = [getPos player,240,"RHS_A10",3] execVM "MIL_CAS.sqf";
	- A-10 will fly in and drop a single bomb.