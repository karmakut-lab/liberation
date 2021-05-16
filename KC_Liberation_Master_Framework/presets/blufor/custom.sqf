/*
    Needed Mods:
    - RHS USAF

    Optional Mods:
    - F-15C
    - F/A-18
    - USAF Main Pack
    - USAF Fighters Pack
    - USAF Utility Pack
*/

/*
    --- Support classnames ---
    Each of these should be unique.
    The same classnames for different purposes may cause various unpredictable issues with player actions.
    Or not, just don't try!
*/
FOB_typename = "Land_Cargo_HQ_V3_F";                                    // This is the main FOB HQ building.
FOB_box_typename = "B_Slingload_01_Cargo_F";                            // This is the FOB as a container.
FOB_truck_typename = "rhsusf_M1078A1P2_B_D_CP_fmtv_usarmy";             // This is the FOB as a vehicle.
Arsenal_typename = "B_supplyCrate_F";                                   // This is the virtual arsenal as portable supply crates.
Respawn_truck_typename = "rhsusf_M1085A1P2_B_D_Medical_fmtv_usarmy";    // This is the mobile respawn (and medical) truck.
huron_typename = "rhsusf_CH53E_USMC_D";                                          // This is Spartan 01, a multipurpose mobile respawn as a helicopter.
crewman_classname = "rhsusf_army_ocp_combatcrewman";                    // This defines the crew for vehicles.
pilot_classname = "rhsusf_army_ocp_helipilot";                          // This defines the pilot for helicopters.
KP_liberation_little_bird_classname = "RHS_MELB_MH6M";                  // These are the little birds which spawn on the Freedom or at Chimera base.
KP_liberation_boat_classname = "B_Boat_Transport_01_F";                 // These are the boats which spawn at the stern of the Freedom.
KP_liberation_truck_classname = "rhsusf_M977A4_BKIT_usarmy_d";          // These are the trucks which are used in the logistic convoy system.
KP_liberation_small_storage_building = "ContainmentArea_02_sand_F";     // A small storage area for resources.
KP_liberation_large_storage_building = "ContainmentArea_01_sand_F";     // A large storage area for resources.
KP_liberation_recycle_building = "Land_RepairDepot_01_tan_F";           // The building defined to unlock FOB recycling functionality.
KP_liberation_air_vehicle_building = "B_Radar_System_01_F";             // The building defined to unlock FOB air vehicle functionality.
KP_liberation_heli_slot_building = "Land_HelipadSquare_F";              // The helipad used to increase the GLOBAL rotary-wing cap.
KP_liberation_plane_slot_building = "Land_TentHangar_V1_F";             // The hangar used to increase the GLOBAL fixed-wing cap.
KP_liberation_supply_crate = "CargoNet_01_box_F";                       // This defines the supply crates, as in resources.
KP_liberation_ammo_crate = "B_CargoNet_01_ammo_F";                      // This defines the ammunition crates.
KP_liberation_fuel_crate = "CargoNet_01_barrels_F";                     // This defines the fuel crates.

/*
    --- Friendly classnames ---
    Each array below represents one of the 7 pages within the build menu.
    Format: ["vehicle_classname",supplies,ammunition,fuel],
    Example: ["B_APC_Tracked_01_AA_F",300,150,150],
    The above example is the NATO IFV-6a Cheetah, it costs 300 supplies, 150 ammunition and 150 fuel to build.
    IMPORTANT: The last element inside each array must have no comma at the end!
*/
infantry_units = [
];

light_vehicles = [
    ["rhsusf_mrzr4_d",25,0,25],                                            // MRZR 4
    ["rhsusf_m1025_d",25,0,25],                                            // M1025A2
    ["rhsusf_m1025_d_m2",100,50,50],                                     // M1025A2 (M2)
    ["rhsusf_m1025_d_Mk19",100,75,50],                                   // M1025A2 (Mk19)
    ["rhsusf_m998_d_2dr_fulltop",25,0,25],                                 // M1097A2 (2D)
    ["rhsusf_m998_d_2dr_halftop",25,0,25],                                 // M1097A2 (2D / open back)
    ["rhsusf_M1083A1P2_B_D_fmtv_usarmy",25,0,25],
    ["rhsusf_M1220_usarmy_d",200,0,100],                                  // M1220
    ["rhsusf_M1220_M2_usarmy_d",200,50,100],                              // M1220 (M2)
    ["rhsusf_M1220_MK19_usarmy_d",200,75,100],                            // M1220 (Mk19)
    ["rhsusf_M1232_usarmy_d",200,0,100],                                  // M1232
    ["rhsusf_M1232_M2_usarmy_d",200,50,100],                              // M1232 (M2)
    ["rhsusf_M1232_MK19_usarmy_d",200,75,100],                            // M1232 (Mk19)
    ["rhsusf_M1230a1_usarmy_d",200,0,100],                                // M1230A1 (MEDEVAC)
    ["rhsusf_M1237_M2_usarmy_d",225,50,100],                              // M1237 (O-GKP / M2)
    ["rhsusf_M1083A1P2_D_open_fmtv_usarmy",100,0,100],                    // M1083A1P2 Transport
    ["rhsusf_M1083A1P2_D_fmtv_usarmy",100,0,100],                         // M1083A1P2 Transport (Covered)
    ["rhsusf_M1083A1P2_D_flatbed_fmtv_usarmy",100,0,100],                 // M1083A1P2
    ["rhsusf_M977A4_BKIT_usarmy_d",150,0,100],                            // M977A4 BKIT
    ["rhsusf_M977A4_BKIT_M2_usarmy_d",150,50,100],                        // M977A4 BKIT (HMG)
    ["rhsusf_M1117_D",150,200,75],                                        // M1117 ASV
    ["rhsusf_M1240a1_mk19_usmc_d",175,75,75],                            // M1240A1 M-ATV  (MK19)
    ["rhsusf_M1240a1_mk19crows_usmc_d",200,150,75],                       // M1240A1 M-ATV  (MK19 Crows)
    ["rhsusf_M1240a1_m240_usmc_d",175,25,75],                            // M1240A1 M-ATV  (M240)
    ["rhsusf_M1240a1_m2_usmc_d",175,50,75],                              // M1240A1 M-ATV  (M2)
    ["rhsusf_M1240a1_m2crows_usmc_d",200,100,75],                         // M1240A1 M-ATV  (M2 Crows)
    ["rhsusf_M1245_m2crows_socom_d",200,100,75],                          // M1245 M-ATV Socom (M2 Crows)
    ["rhsusf_M1245_mk19crows_socom_d",200,150,75],                        // M1245 M-ATV Socom (MK19 Crows)
    ["B_Boat_Transport_01_F",100,0,25],                                  // Assault Boat
    ["B_Boat_Armed_01_minigun_F",200,150,75],                             // Speedboat Minigun
    ["rhsusf_mkvsoc",250,300,100],                                       // Mk.V SOCOM
    ["B_SDV_01_F",100,0,50]                                              // SDV
];

heavy_vehicles = [
    ["UK3CB_B_AAV_US_DES",300,100,150],                           // AAV-7A1
    ["UK3CB_B_LAV25_US_DES",400,200,200],                         // LAV25
    ["rhsusf_m1a1aimd_usarmy",1000,1000,500],                     // M1A1 AIM 
    ["rhsusf_m1a2sep1d_usarmy",1250,1000,500],                    // M1A2 SEP v1 (Operations)
	["rhsusf_m1a2sep1tuskiid_usarmy",1500,1250,750]              // Tusk
];

air_vehicles = [
    ["RHS_AH1Z",750,750,300],                                        // AH-1Z Viper
    ["RHS_UH1Y_UNARMED_d",300,0,300],                                            // UH-1Y (Unarmed)
    ["RHS_UH1Y_FFAR_d",300,150,300],                                          // UH-1Y (Rockets)
	["RHS_UH1Y_d",300,200,300],                                          // UH-1Y (MG)
    ["RHS_UH60M_MEV2",300,0,300],                                        // UH-60M MEV2
    ["rhsusf_CH53E_USMC_D",400,100,400],                                     	 // CH-53E Super Stallion
    ["rhsusf_CH53E_USMC_GAU21_D",400,100,400],                                     	 // CH-53E Super Stallion (GAU21)
	["USAF_C130J",1000,0,1000],
    ["USAF_C17",2000,0,2000],                                             // C-17 Globemaster III
    ["USAF_A10",1500,1500,750],                                     	 // A-10C Thunderbolt II
	["USAF_AC130U",3000,3000,1500]
];

static_vehicles = [
    ["RHS_M2StaticMG_MiniTripod_D",25,50,0],                             // Mk2 HMG .50
    ["RHS_M2StaticMG_D",25,50,0],                                        // Mk2 HMG .50 (Raised)
    ["RHS_MK19_TriPod_D",25,75,0],                                       // Mk19 GMG 20mm
    ["RHS_TOW_TriPod_D",50,150,0],                                       // TOW (AT)
    ["RHS_Stinger_AA_pod_D",50,150,0],                                   // Stinger (AA)
    ["RHS_M252_D",100,250,0],                                             // M252 Mortar
    ["RHS_M119_D",250,500,0]                                             // M119A2
];

buildings = [
    ["Land_Billboard_F",0,0,0],
    ["SignAd_Sponsor_F",0,0,0],
	["Land_Sign_WarningNoWeapon_F",0,0,0],
    ["Land_Cargo_House_V3_F",100,0,0],
    ["Land_Cargo_Patrol_V3_F",200,0,0],
    ["Land_Cargo_Tower_V3_F",300,0,0],
    ["Flag_NATO_F",0,0,0],
    ["Flag_US_F",0,0,0],
    ["FlagCarrierINDFOR_EP1",0,0,0],
    ["FlagCarrierBLUFOR_EP1",0,0,0],
    ["FlagCarrierOPFOR_EP1",0,0,0],
    ["FlagCarrierWhite_EP1",0,0,0],
    ["Flag_FD_Purple_F",0,0,0],
    ["Flag_FD_Orange_F",0,0,0],
    ["Land_Medevac_house_V1_F",200,0,0],
    ["Land_Medevac_HQ_V1_F",200,0,0],
    ["TFAR_Land_Communication_F",500,0,0],
    ["CamoNet_BLUFOR_F",0,0,0],
    ["CamoNet_BLUFOR_open_F",0,0,0],
    ["CamoNet_BLUFOR_big_F",0,0,0],
    ["Land_MedicalTent_01_NATO_generic_open_F",0,0,0],
    ["Land_PortableLight_single_F",0,0,0],
    ["Land_PortableLight_double_F",0,0,0],
    ["Land_LampSolar_F",0,0,0],
    ["Land_LampHalogen_F",0,0,0],
    ["Land_LampStreet_small_F",0,0,0],
    ["Land_LampAirport_F",0,0,0],
    ["Land_HelipadCircle_F",0,0,0],                                     // Strictly aesthetic - as in it does not increase helicopter cap!
    ["Land_HelipadRescue_F",0,0,0],                                     // Strictly aesthetic - as in it does not increase helicopter cap!
    ["PortableHelipadLight_01_blue_F",0,0,0],
    ["PortableHelipadLight_01_green_F",0,0,0],
    ["PortableHelipadLight_01_red_F",0,0,0],
    ["Land_CampingChair_V1_F",0,0,0],
    ["Land_CampingChair_V2_F",0,0,0],
    ["Land_CampingTable_F",0,0,0],
    ["MapBoard_altis_F",0,0,0],
    ["MapBoard_stratis_F",0,0,0],
    ["Land_Pallet_MilBoxes_F",0,0,0],
    ["Land_PaperBox_open_empty_F",0,0,0],
    ["Land_PaperBox_open_full_F",0,0,0],
    ["Land_PaperBox_closed_F",0,0,0],
    ["Land_DieselGroundPowerUnit_01_F",0,0,0],
    ["Land_ToolTrolley_02_F",0,0,0],
    ["Land_WeldingTrolley_01_F",0,0,0],
    ["Land_Workbench_01_F",0,0,0],
    ["Land_GasTank_01_blue_F",0,0,0],
    ["Land_GasTank_01_khaki_F",0,0,0],
    ["Land_GasTank_01_yellow_F",0,0,0],
    ["Land_GasTank_02_F",0,0,0],
    ["Land_BarrelWater_F",0,0,0],
    ["Land_BarrelWater_grey_F",0,0,0],
    ["Land_WaterBarrel_F",0,0,0],
    ["Land_WaterTank_F",0,0,0],
    ["Land_BarGate_01_open_F",0,0,0],
    ["Land_BagFence_Round_F",10,0,0],
    ["Land_BagFence_Short_F",10,0,0],
    ["Land_BagFence_Long_F",10,0,0],
    ["Land_BagFence_Corner_F",10,0,0],
    ["Land_BagFence_End_F",10,0,0],
    ["Land_BagBunker_Small_F",50,0,0],
    ["Land_BagBunker_Large_F",100,0,0],
    ["Land_BagBunker_Tower_F",150,0,0],
    ["Land_HBarrier_1_F",10,0,0],
    ["Land_HBarrier_3_F",10,0,0],
    ["Land_HBarrier_5_F",10,0,0],
    ["Land_HBarrier_Big_F",10,0,0],
    ["Land_HBarrierWall4_F",10,0,0],
    ["Land_HBarrierWall6_F",10,0,0],
    ["Land_HBarrierWall_corner_F",10,0,0],
    ["Land_HBarrierWall_corridor_F",10,0,0],
    ["Land_HBarrierTower_F",100,0,0],
    ["Land_CncBarrierMedium_F",10,0,0],
    ["Land_CncBarrierMedium4_F",10,0,0],
    ["Land_Concrete_SmallWall_4m_F",10,0,0],
    ["Land_Concrete_SmallWall_8m_F",10,0,0],
    ["Land_CncShelter_F",10,0,0],
    ["Land_CncWall1_F",10,0,0],
    ["Land_CncWall4_F",10,0,0],
    ["Land_Sign_WarningMilitaryArea_F",0,0,0],
    ["Land_Sign_WarningMilAreaSmall_F",0,0,0],
    ["Land_Sign_WarningMilitaryVehicles_F",0,0,0],
    ["Land_Razorwire_F",0,0,0],
    ["Land_ClutterCutter_large_F",0,0,0]
];

support_vehicles = [
    [Arsenal_typename,0,200,0],
    [FOB_box_typename,500,500,0],
    [FOB_truck_typename,500,500,100],
    [KP_liberation_small_storage_building,0,0,0],
    [KP_liberation_large_storage_building,0,0,0],
    [KP_liberation_recycle_building,250,0,0],
    [KP_liberation_air_vehicle_building,1000,0,0],
    [KP_liberation_heli_slot_building,250,0,0],
    [KP_liberation_plane_slot_building,500,0,0],
    ["ACE_medicalSupplyCrate_advanced",25,0,0],
    ["ACE_Box_82mm_Mo_HE",0,50,0],
    ["ACE_Box_82mm_Mo_Smoke",0,25,0],
    ["ACE_Box_82mm_Mo_Illum",0,25,0],
    ["Box_NATO_Ammo_F",0,5,0],
    ["VirtualReammoBox_camonet_F",0,500,0],
    ["ACE_Wheel",10,0,0],
    ["ACE_Track",10,0,0],
    ["B_APC_Tracked_01_CRV_F",500,100,300],                             // CRV-6e Bobcat
    ["rhsusf_M1078A1R_SOV_M2_D_fmtv_socom",300,50,100],                // M1078A1R SOV
    ["B_Truck_01_Repair_F",300,0,100],                                   // HEMTT Repair
    ["B_Truck_01_fuel_F",300,0,300],                                    // HEMTT Fuel
    ["B_Truck_01_ammo_F",300,300,100],                                   // HEMTT Ammo
    ["B_Slingload_01_Repair_F",100,0,0],                                // Huron Repair
    ["B_Slingload_01_Fuel_F",100,0,500],                                 // Huron Fuel
    ["B_Slingload_01_Ammo_F",100,500,0]                                  // Huron Ammo
];

/*
    --- Squads ---
    Pre-made squads for the commander build menu.
    These shouldn't exceed 10 members.
*/

// Light infantry squad.
blufor_squad_inf_light = [
];

// Heavy infantry squad.
blufor_squad_inf = [
];

// AT specialists squad.
blufor_squad_at = [
];

// AA specialists squad.
blufor_squad_aa = [
];

// Force recon squad.
blufor_squad_recon = [
];

// Paratroopers squad (The units of this squad will automatically get parachutes on build)
blufor_squad_para = [
];

/*
    --- Elite vehicles ---
    Classnames below have to be unlocked by capturing military bases.
    Which base locks a vehicle is randomized on the first start of the campaign.
*/
elite_vehicles = [
    "rhsusf_mkvsoc",                                                    // Mk.V SOCOM
    "rhsusf_m1a1aimd_usarmy",                                                 // M1A1 Aim
    "rhsusf_m1a2sep1d_usarmy",                                          // M1A2 SEP v1
	"rhsusf_CH53E_USMC_GAU21_D"                                         // CH53E GAU21
    "RHS_AH1Z",                                                        // AH1Z Viper
    "USAF_A10",                                     	                // A-10
	"USAF_AC130U",
	"rhsusf_m1a2sep1tuskiid_usarmy"                                     
];
