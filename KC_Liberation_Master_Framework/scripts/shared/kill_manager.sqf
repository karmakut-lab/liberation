params ["_unit", "_killer"];
TeamKillers = createHashMap;
ResistanceKillers = createHashMap;
CivilianKillers = createHashMap;
if (isNil {profileNamespace getVariable "civilian_kills_per_player"}) then { // if profilenamespace doesn't find variable it creates as 0
	profileNamespace setVariable ["civilian_kills_per_player", createHashMap];
};
if (isNil {profileNamespace getVariable "resistance_kills_per_player"}) then {
	profileNamespace setVariable ["resistance_kills_per_player", createHashMap];
};
if (isNil {profileNamespace getVariable "teamkills_per_player"}) then {
	profileNamespace setVariable ["teamkills_per_player", createHashMap];
};


if (isServer) then {

    if (KP_liberation_kill_debug > 0) then {[format ["Kill Manager executed - _unit: %1 (%2) - _killer: %3 (%4)", typeOf _unit, _unit, typeOf _killer, _killer], "KILL"] call KPLIB_fnc_log;};

    // Get Killer, when ACE enabled, via lastDamageSource
    if (KP_liberation_ace) then {
        if (local _unit) then {
            _killer = _unit getVariable ["ace_medical_lastDamageSource", _killer];
            if (KP_liberation_kill_debug > 0) then {["_unit is local to server", "KILL"] call KPLIB_fnc_log;};
        } else {
            if (KP_liberation_kill_debug > 0) then {["_unit is not local to server", "KILL"] call KPLIB_fnc_log;};
            if (isNil "KP_liberation_ace_killer") then {KP_liberation_ace_killer = objNull;};
            waitUntil {sleep 0.5; !(isNull KP_liberation_ace_killer)};
            if (KP_liberation_kill_debug > 0) then {["KP_liberation_ace_killer received on server", "KILL"] call KPLIB_fnc_log;};
            _killer = KP_liberation_ace_killer;
            KP_liberation_ace_killer = objNull;
            publicVariable "KP_liberation_ace_killer";
        };
    };

    // Failsafe if something gets killed before the save manager is finished
    if (isNil "infantry_weight") then {infantry_weight = 33};
    if (isNil "armor_weight") then {armor_weight = 33};
    if (isNil "air_weight") then {air_weight = 33};

    // BLUFOR Killer handling
    if ((side _killer) == GRLIB_side_friendly) then {

        // Increase combat readiness for kills near a capital.
        private _nearby_bigtown = sectors_bigtown select {!(_x in blufor_sectors) && (_unit distance (markerpos _x) < 250)};
        if (count _nearby_bigtown > 0) then {
            combat_readiness = combat_readiness + (0.5 * GRLIB_difficulty_modifier);
            stats_readiness_earned = stats_readiness_earned + (0.5 * GRLIB_difficulty_modifier);
            if (combat_readiness > 100.0 && GRLIB_difficulty_modifier < 2) then {combat_readiness = 100.0};
        };

        // Weights adjustments depending on what vehicle the BLUFOR killer used
        if (_killer isKindOf "Man") then {
            infantry_weight = infantry_weight + 1;
            armor_weight = armor_weight - 0.66;
            air_weight = air_weight - 0.66;
        } else {
            if ((toLower (typeOf (vehicle _killer))) in KPLIB_allLandVeh_classes) then  {
                infantry_weight = infantry_weight - 0.66;
                armor_weight = armor_weight + 1;
                air_weight = air_weight - 0.66;
            };
            if ((toLower (typeOf (vehicle _killer))) in KPLIB_allAirVeh_classes) then  {
                infantry_weight = infantry_weight - 0.66;
                armor_weight = armor_weight - 0.66;
                air_weight = air_weight + 1;
            };
        };

        // Keep within ranges
        infantry_weight = 0 max (infantry_weight min 100);
        armor_weight = 0 max (armor_weight min 100);
        air_weight = 0 max (air_weight min 100);
    };

    // Player was killed
    if (isPlayer _unit) then {
        stats_player_deaths = stats_player_deaths + 1;
        // Disconnect UAV from player on death
        _unit connectTerminalToUAV objNull;
        // Eject Player from vehicle
        if (vehicle _unit != _unit) then {moveOut _unit;};
    };

    // Check for Man or Vehicle
    if (_unit isKindOf "Man") then {

        // OPFOR casualty
        if (side (group _unit) == GRLIB_side_enemy) then {
            // Killed by BLUFOR
            if (side _killer == GRLIB_side_friendly) then {
                stats_opfor_soldiers_killed = stats_opfor_soldiers_killed + 1;
            };

            // Killed by a player
            if (isplayer _killer) then {
                stats_opfor_killed_by_players = stats_opfor_killed_by_players + 1;
            };
        };

        // BLUFOR casualty
        if (side (group _unit) == GRLIB_side_friendly) then {
            stats_blufor_soldiers_killed = stats_blufor_soldiers_killed + 1;

            // Killed by BLUFOR
            if (side _killer == GRLIB_side_friendly) then {
                stats_blufor_teamkills = stats_blufor_teamkills + 1;

                // check TK griefing
                if (name _killer in TeamKillers) then {
                    TeamKillers set [name _killer, (TeamKillers get (name _killer)) + 1];
                } else {
                    TeamKillers set [name _killer, 1];
                };
                if (TeamKillers get name _killer >= 5) then {
                    [6, [(TeamKillers get (name _killer)), (name _killer)]] remoteExec ["KPLIB_fnc_crGlobalMsg"];
                };
                // save teamkill data
                private _hashMap = ProfileNamespace getVariable "teamkills_per_player";
                if (name _killer in _hashMap) then {
                     _hashMap set [name _killer, (_hashMap get (name _killer)) + 1];
                } else {
                     _hashMap set [name _killer, 1];
                };
                ProfileNamespace setVariable ["teamkills_per_player", _hashmap];

            };
        };

        // Resistance casualty
        if (side (group _unit) == GRLIB_side_resistance) then {
            KP_liberation_guerilla_strength = KP_liberation_guerilla_strength - 1;
            stats_resistance_killed = stats_resistance_killed + 1;

            // Resistance is friendly to BLUFOR
            if ((GRLIB_side_friendly getFriend GRLIB_side_resistance) >= 0.6) then {

                // Killed by BLUFOR
                if (side _killer == GRLIB_side_friendly) then {
                    if (KP_liberation_asymmetric_debug > 0) then {[format ["Guerilla unit killed by: %1", name _killer], "ASYMMETRIC"] call KPLIB_fnc_log;};
                    [3, [(name _unit)]] remoteExec ["KPLIB_fnc_crGlobalMsg"];
                    stats_resistance_teamkills = stats_resistance_teamkills + 1;
                    [KP_liberation_cr_resistance_penalty, true] spawn F_cr_changeCR;

                    // check resistance griefing
                    if (name _killer in ResistanceKillers) then {
                        ResistanceKillers set [name _killer, (ResistanceKillers get (name _killer)) + 1];
                    } else {
                        ResistanceKillers set [name _killer, 1];
                    };
                    if (ResistanceKillers get name _killer >= 5) then {
                        [7, [(ResistanceKillers get (name _killer)), (name _killer)]] remoteExec ["KPLIB_fnc_crGlobalMsg"];
                    };
                    // save resistance kill data
                    private _hashMap = ProfileNamespace getVariable "resistance_kills_per_player";
                    if (name _killer in _hashMap) then {
                        _hashMap set [name _killer, (_hashMap get (name _killer)) + 1];
                    } else {
                        _hashMap set [name _killer, 1];
                    };
                    ProfileNamespace setVariable ["resistance_kills_per_player", _hashmap];
                };

                // Killed by a player
                if (isplayer _killer) then {
                    stats_resistance_teamkills_by_players = stats_resistance_teamkills_by_players + 1;
                };
            };
        };

        // Civilian casualty
        if (side (group _unit) == GRLIB_side_civilian) then {
            stats_civilians_killed = stats_civilians_killed + 1;

            // Killed by BLUFOR
            if (side _killer == GRLIB_side_friendly) then {
                if (KP_liberation_civrep_debug > 0) then {[format ["Civilian killed by: %1", name _killer], "CIVREP"] call KPLIB_fnc_log;};
                [2, [(name _unit)]] remoteExec ["KPLIB_fnc_crGlobalMsg"];
                [KP_liberation_cr_kill_penalty, true] spawn F_cr_changeCR;

                // check civilian griefing
                if ((name _killer) in CivilianKillers) then {
                    CivilianKillers set [name _killer, (CivilianKillers get (name _killer)) + 1];
                } else {
                    CivilianKillers set [name _killer, 1];
                };
                if (CivilianKillers get name _killer >= 5) then {
                    [8, [(CivilianKillers get (name _killer)), (name _killer)]] remoteExec ["KPLIB_fnc_crGlobalMsg"];
                };

                // save civilian kill data
                private _hashMap = ProfileNamespace getVariable "civilian_kills_per_player";
                if (name _killer in _hashMap) then {
                     _hashMap set [name _killer, (_hashMap get (name _killer)) + 1];
                } else {
                     _hashMap set [name _killer, 1];
                };
                ProfileNamespace setVariable ["civilian_kills_per_player", _hashmap];
            };

            // Killed by a player
            if (isPlayer _killer) then {
                stats_civilians_killed_by_players = stats_civilians_killed_by_players + 1;
            };
        };
    } else {
        // Enemy vehicle casualty
        if ((toLower (typeof _unit)) in KPLIB_o_allVeh_classes) then {
            stats_opfor_vehicles_killed = stats_opfor_vehicles_killed + 1;

            // Destroyed by player
            if (isplayer _killer) then {
                stats_opfor_vehicles_killed_by_players = stats_opfor_vehicles_killed_by_players + 1;
            };
        } else {
            // Civilian vehicle casualty
            if (typeOf _unit in civilian_vehicles) then {
                stats_civilian_vehicles_killed = stats_civilian_vehicles_killed + 1;

                // Destroyed by player
                if (isplayer _killer) then {
                    stats_civilian_vehicles_killed_by_players = stats_civilian_vehicles_killed_by_players + 1;
                };
            } else {
                // It has to be a BLUFOR vehicle then
                stats_blufor_vehicles_killed = stats_blufor_vehicles_killed + 1;
            };
        };
    };
} else {
    // Get Killer and send it to server, when ACE enabled, via lastDamageSource
    if (KP_liberation_ace && local _unit) then {
        if (KP_liberation_kill_debug > 0) then {[format ["_unit is local to: %1", debug_source], "KILL"] remoteExecCall ["KPLIB_fnc_log", 2];};
        KP_liberation_ace_killer = _unit getVariable ["ace_medical_lastDamageSource", _killer];
        publicVariable "KP_liberation_ace_killer";
    };
};

// Body/Wreck deletion after cleanup delay
if (isServer && !isplayer _unit) then {
    sleep GRLIB_cleanup_delay;
    hidebody _unit;
    sleep 10;
    deleteVehicle _unit;
};
addMissionEventHandler ["HandleDisconnect", {
	params ["_unit", "_id", "_uid", "_name"];
	if (_name in CivilianKillers) then {
	    CivilianKillers deleteAt _name;
	};
	if (_name in ResistanceKillers) then {
	    ResistanceKillers deleteAt _name;
	};
	if (_name in TeamKillers) then {
	    TeamKillers deleteAt _name;
	};
}];
