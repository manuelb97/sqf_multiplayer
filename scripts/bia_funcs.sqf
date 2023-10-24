//Helper 
bia_compile_script = compileFinal preprocessFileLineNumbers "scripts\scriptPath.sqf";

//Database
_p = "scripts\database\";
bia_save_to_profile		= [_p, "saveToProfile"] call bia_compile_script;
bia_load_from_profile	= [_p, "loadFromProfile"] call bia_compile_script;
bia_add_death			= [_p, "addDeath"] call bia_compile_script;
bia_to_log				= [_p, "to_log"] call bia_compile_script;

//UI
_p = "scripts\ui\";
bia_spawn_text		= [_p, "spawnText"] call bia_compile_script;
bia_countdown		= [_p, "countdown"] call bia_compile_script;
bia_progress_bar	= [_p, "progressBar"] call bia_compile_script;

//Weather
_p = "scripts\weather\";
bia_weather_params	= [_p, "defineWeatherParams"] call bia_compile_script;
bia_apply_weather	= [_p, "applyWeatherPreset"] call bia_compile_script;
bia_change_weather	= [_p, "changeWeather"] call bia_compile_script;

//HQ 
_p = "scripts\hq\";
bia_heal_caller	= [_p, "healCaller"] call bia_compile_script;
bia_heal_uncon	= [_p, "healPlayer"] call bia_compile_script;
bia_tele_to_base= [_p, "teleportToHQ"] call bia_compile_script;

//misc 
_p = "scripts\misc\";
bia_closest_dist		= [_p, "minDistanceToArrObjs"] call bia_compile_script;
bia_closest_obj			= [_p, "closestObj"] call bia_compile_script;
bia_clear_ground		= [_p, "clearGround"] call bia_compile_script;
bia_sweep_area			= [_p, "sweepAreaOfObjects"] call bia_compile_script;
bia_clear_vegetation	= [_p, "clearVegetation"] call bia_compile_script;

//hosting
_p = "scripts\host\";
bia_check_fps	= [_p, "checkFPS"] call bia_compile_script;

//respawn 
_p = "scripts\respawn\";
bia_respawn_sound	= [_p, "respawn_sound"] call bia_compile_script;
bia_respawn_marker	= [_p, "death_marker"] call bia_compile_script;

//equipment
_p = "scripts\equipment\";
bia_respawn_loadout		= [_p, "respawnLoadout"] call bia_compile_script;
bia_blank_loadout		= [_p, "blank_loadout"] call bia_compile_script;
bia_random_loadout		=[_p, "randomThemeLoadout"] call bia_compile_script;
bia_mag_bullets			=[_p, "getMagBullets"] call bia_compile_script;

//insertion 
_p = "scripts\insertion\";
bia_halo						= [_p, "HALO"] call bia_compile_script;
bia_halo_backpack				= [_p, "halo_backpack_manager"] call bia_compile_script;
bia_adaptive_vehicle_insertion	= [_p, "adaptive_vehicle_insertion"] call bia_compile_script;
bia_delete_inser_veh			= [_p, "delete_abandoned_vehicle"] call bia_compile_script;
bia_equip_inser_veh				= [_p, "equip_insertion_car"] call bia_compile_script;

//Support 
_p = "scripts\support\";
bia_support_qrf			= [_p, "qrf_convoy"] call bia_compile_script;
bia_drop_projectile		= [_p, "dropProjectile"] call bia_compile_script;
bia_cas_variable_weap	= [_p, "zeusCASVariableWeapon"] call bia_compile_script;
bia_zeus_cas			= [_p, "zeusCAS"] call bia_compile_script;
bia_ac130_support		= [_p, "ac130Support"] call bia_compile_script;
bia_rearm_vehicle		= [_p, "rearmVehicle"] call bia_compile_script;
bia_chat_execute		= [_p, "executeChatFunc"] call bia_compile_script;
bia_supp_variable_cas	= [_p, "zeusCASVariableWeapon"] call bia_compile_script;
bia_supp_spawn_drone	= [_p, "spawnDroneSupport"] call bia_compile_script;
bia_supp_control_drone	= [_p, "controlDroneGunner"] call bia_compile_script;
bia_supp_drone_strike	= [_p, "droneStrike"] call bia_compile_script;
bia_supp_drone_marker	= [_p, "droneMarker"] call bia_compile_script;
bia_supp_map			= [_p, "mapSupport"] call bia_compile_script;
bia_supp_infantry_team	= [_p, "infantryTeam"] call bia_compile_script;
bia_supp_spawn_heli		= [_p, "heliRequest"] call bia_compile_script;
bia_supp_veh_loadout	= [_p, "vehicleLoadout"] call bia_compile_script;
bia_supp_rearm_vehicle	= [_p, "vehicleLoadout"] call bia_compile_script;

//Enemies
_p = "scripts\enemies\";
bia_faction_units		= [_p, "factionUnits"] call bia_compile_script;
bia_faction_mix			= [_p, "factionMix"] call bia_compile_script;
bia_spawn_group			= [_p, "spawnGroup"] call bia_compile_script;
bia_cqb_control			= [_p, "cqbUnitMovement"] call bia_compile_script;
bia_group_patrol		= [_p, "groupPatrol"] call bia_compile_script;
bia_concealed_pos		= [_p, "findConcealedPos"] call bia_compile_script;
bia_set_skill			= [_p, "setSkill"] call bia_compile_script;
bia_spawn_veh_group		= [_p, "spawnVehicleGroup"] call bia_compile_script;
bia_inside_positions	= [_p, "getInsidePositions"] call bia_compile_script;
bia_hunt_target			= [_p, "huntTarget"] call bia_compile_script;
bia_add_wp				= [_p, "addWaypoint"] call bia_compile_script;
bia_get_curr_tier		= [_p, "getCurrTier"] call bia_compile_script;
bia_get_tier_cat		= [_p, "getTierCategory"] call bia_compile_script;
bia_guard_positions		= [_p, "getGuardPositions"] call bia_compile_script;
bia_compound_guards		= [_p, "compoundGuards"] call bia_compile_script;
bia_compound_patrols	= [_p, "compoundPatrols"] call bia_compile_script;

//House Raids
_p = "scripts\missions\house_raids\";
bia_house_raid_support		= [_p, "supports"] call bia_compile_script;
bia_house_raid_faction		= [_p, "determine_faction"] call bia_compile_script;
bia_house_raid_local_init	= [_p, "initPlayerLocalCode"] call bia_compile_script;
bia_house_raid_arsenal		= [_p, "adaptiveArsenal"] call bia_compile_script;

//PvP 
_p = "scripts\missions\pvp\";
bia_pvp_statics				= [_p, "spawnStatics"] call bia_compile_script;
bia_pvp_arsenals			= [_p, "arsenals"] call bia_compile_script;
bia_pvp_fortifications		= [_p, "defenderFortifications"] call bia_compile_script;
bia_pvp_location_defense	= [_p, "locationDefense"] call bia_compile_script;
bia_pvp_ai_defenders		= [_p, "spawnDefenderAI"] call bia_compile_script;
bia_pvp_ai_attackers		= [_p, "spawnAttackerAI"] call bia_compile_script;
bia_pvp_equip_players		= [_p, "equipPlayers"] call bia_compile_script;
bia_pvp_local_init			= [_p, "initPlayerLocalCode"] call bia_compile_script;
bia_pvp_mission				= [_p, "startPvPMission"] call bia_compile_script;
bia_pvp_defense				= [_p, "missionDefense"] call bia_compile_script;
bia_pvp_progress_bar		= [_p, "progressBar"] call bia_compile_script;
bia_pvp_add_win				= [_p, "addWin"] call bia_compile_script;
bia_pvp_spectator 			= [_p, "switchSpectator"] call bia_compile_script;
bia_pvp_spectators			= [_p, "handleDeadSpectators"] call bia_compile_script;
bia_pvp_conquest			= [_p, "missionDefense"] call bia_compile_script;
bia_pvp_location_conquest	= [_p, "locationConquest"] call bia_compile_script;
bia_pvp_ai_conquest			= [_p, "spawnConquestAI"] call bia_compile_script;

//Sector attacks  
_p = "scripts\missions\sector_attacks\";
bia_sectors_activate_sector			= [_p, "activateSector"] call bia_compile_script;
bia_sectors_sector_enemies			= [_p, "spawnSectorEnemies"] call bia_compile_script;
bia_sectors_sector_reinforcements	= [_p, "spawnSectorReinforcements"] call bia_compile_script;
bia_sectors_counter_attack			= [_p, "counterAttack"] call bia_compile_script;
bia_sector_attacks_local_init		= [_p, "initPlayerLocalCode"] call bia_compile_script;
bia_sector_attacks_arsenal			= [_p, "arsenal"] call bia_compile_script;
bia_sector_attacks_resp_load		= [_p, "respawnLoadout"] call bia_compile_script;



/*
//Markers
bia_activate_sector					= compileFinal preprocessFileLineNumbers "scripts\missions\sector_attacks\manageSector.sqf";
bia_sector_enemies					= compileFinal preprocessFileLineNumbers "scripts\enemies\spawnSectorEnemies.sqf";
bia_vehicle_guards					= compileFinal preprocessFileLineNumbers "scripts\enemies\spawnVehicleDefenders.sqf";
bia_get_tier_cat					= compileFinal preprocessFileLineNumbers "scripts\enemies\getTierCategory.sqf";
bia_sector_reinforcement			= compileFinal preprocessFileLineNumbers "scripts\enemies\spawnSectorReinforcements.sqf";
bia_counter_attack					= compileFinal preprocessFileLineNumbers "scripts\enemies\counterAttack.sqf";
bia_fix_stuck_veh					= compileFinal preprocessFileLineNumbers "scripts\enemies\fixStuckAtSpawn.sqf";

bia_spawn_drone						= compileFinal preprocessFileLineNumbers "scripts\support\spawnDroneSupport.sqf";
bia_control_drone					= compileFinal preprocessFileLineNumbers "scripts\support\controlDroneGunner.sqf";
bia_hq_flares						= compileFinal preprocessFileLineNumbers "scripts\support\hqFlares.sqf";
bia_cursor_support					= compileFinal preprocessFileLineNumbers "scripts\support\cursorSupport.sqf";
bia_spawn_heli						= compileFinal preprocessFileLineNumbers "scripts\support\heliRequest.sqf";
bia_veh_loadout						= compileFinal preprocessFileLineNumbers "scripts\support\vehicleLoadout.sqf";
bia_infantry_team					= compileFinal preprocessFileLineNumbers "scripts\support\infantryTeam.sqf";
bia_map_support						= compileFinal preprocessFileLineNumbers "scripts\support\mapSupport.sqf";
bia_drone_strike					= compileFinal preprocessFileLineNumbers "scripts\support\droneStrike.sqf";
bia_drone_marker					= compileFinal preprocessFileLineNumbers "scripts\support\droneMarker.sqf";
bia_check_remote					= compileFinal preprocessFileLineNumbers "scripts\support\checkRemoteController.sqf";

disable_hq_lamps					= compileFinal preprocessFileLineNumbers "scripts\hq\disableLamps.sqf";
bia_to_hq							= compileFinal preprocessFileLineNumbers "scripts\hq\teleportToHQ.sqf";
bia_equip_player					= compileFinal preprocessFileLineNumbers "scripts\equipment\respawnLoadout.sqf";
bia_equip_raider 					= compileFinal preprocessFileLineNumbers "scripts\equipment\equipUnit.sqf";
// bia_equip_raider_old				= compileFinal preprocessFileLineNumbers "scripts\equipment\equipUnit_old.sqf";
bia_mag_bullets						= compileFinal preprocessFileLineNumbers "scripts\equipment\getMagBullets.sqf";
bia_add_rand_items					= compileFinal preprocessFileLineNumbers "scripts\equipment\addRandomItems.sqf";
bia_add_item						= compileFinal preprocessFileLineNumbers "scripts\equipment\addItemEffectively.sqf";
bia_weighted_item_list				= compileFinal preprocessFileLineNumbers "scripts\equipment\randItemWeightedList.sqf";
bia_arsenal_items					= compileFinal preprocessFileLineNumbers "scripts\equipment\arsenalItems.sqf";

bia_mag_bullets						= compileFinal preprocessFileLineNumbers "scripts\equipment\loadouts\getMagBullets.sqf";
bia_num_mags						= compileFinal preprocessFileLineNumbers "scripts\equipment\loadouts\getNumberMags.sqf";
bia_add_item						= compileFinal preprocessFileLineNumbers "scripts\equipment\loadouts\addItemEffectively.sqf";
bia_mission_loadouts				= compileFinal preprocessFileLineNumbers "scripts\equipment\loadouts\missionLoadouts.sqf";
bia_class_arsenal					= compileFinal preprocessFileLineNumbers "scripts\equipment\loadouts\openClassArsenal.sqf";
bia_set_arsenal_theme				= compileFinal preprocessFileLineNumbers "scripts\equipment\loadouts\setArsenalTheme.sqf";
bia_sniper_loadout					= compileFinal preprocessFileLineNumbers "scripts\equipment\loadouts\applySniperLoadout.sqf";

//side missions 
bia_spawn_hvt						= compileFinal preprocessFileLineNumbers "scripts\missions\side_missions\spawnHVT.sqf";
bia_assassination					= compileFinal preprocessFileLineNumbers "scripts\missions\side_missions\assassination.sqf";
bia_spawn_sab_obj					= compileFinal preprocessFileLineNumbers "scripts\missions\side_missions\spawnSabotageObj.sqf";
bia_obj_destroyable					= compileFinal preprocessFileLineNumbers "scripts\missions\side_missions\destroySabotageObj.sqf";
bia_sabotage						= compileFinal preprocessFileLineNumbers "scripts\missions\side_missions\sabotage.sqf";
bia_convoy_path						= compileFinal preprocessFileLineNumbers "scripts\missions\side_missions\createConvoyPath.sqf";
bia_path_info						= compileFinal preprocessFileLineNumbers "scripts\missions\side_missions\getPathInfo.sqf";
bia_spawn_convoy					= compileFinal preprocessFileLineNumbers "scripts\missions\side_missions\spawnConvoyGrp.sqf";	
bia_convoy							= compileFinal preprocessFileLineNumbers "scripts\missions\side_missions\convoy.sqf";
bia_group_convoy					= compileFinal preprocessFileLineNumbers "scripts\missions\side_missions\grpAsConvoy.sqf";
bia_spawn_lamps						= compileFinal preprocessFileLineNumbers "scripts\missions\side_missions\spawnLamps.sqf";
bia_random_insertion				= compileFinal preprocessFileLineNumbers "scripts\missions\side_missions\randomInsertion.sqf";
bia_random_insertion_enemies		= compileFinal preprocessFileLineNumbers "scripts\missions\side_missions\randomInsertionPatrols.sqf";
bia_firefight						= compileFinal preprocessFileLineNumbers "scripts\missions\side_missions\firefight\startFirefight.sqf";
*/