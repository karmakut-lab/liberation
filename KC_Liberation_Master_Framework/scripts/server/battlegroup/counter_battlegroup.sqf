if (isNil "infantry_weight") then {infantry_weight = 60;};	//As a percentage of the group, 60% Infantry	original mix 33/33/33
if (isNil "armor_weight") then {armor_weight = 25;};	// 25% Armour
if (isNil "air_weight") then {air_weight = 15;};	// 15% Air units

sleep 900;	// How long until it checks, in seconds 900=15 mins	original 1800
private _sleeptime = 0;
private _target_player = objNull;
private _target_pos = "";
while {GRLIB_csat_aggressivity >= 0.75 && GRLIB_endgame == 0} do {		//unmodified
    _sleeptime = (600 + (random 900)) / (([] call KPLIB_fnc_getOpforFactor) * GRLIB_csat_aggressivity);	//When aggressiveness is above 90%, only sleep 600 (10 mins)+ up to 15 mins (10-25 mins max)	orignal 30-60mins

    if (combat_readiness >= 50) then {_sleeptime = _sleeptime * 0.75;};	//If C/R is above 50%, the sleep time is x0.75 (900x.75=675 seconds/ 10:15) before considering sending an attack	original mix 80/90/95
    if (combat_readiness >= 75) then {_sleeptime = _sleeptime * 0.60;};	//C/R above 75%, sleep (900x0.60=540s / 9:00)
    if (combat_readiness >= 90) then {_sleeptime = _sleeptime * 0.50;};	//C/R above 90%, sleep (900x0.50=450s / 7:30)

    sleep _sleeptime;

    waitUntil {sleep 5;
        combat_readiness >= 70 && {armor_weight >= 50 || air_weight >= 50}	// When C/R is over 70% change composition to 
    };

    _target_player = objNull;
    {
        if (
            (armor_weight >= 50 && {(objectParent _x) isKindOf "Tank"})	//unmodified
            || (air_weight >= 50 && {(objectParent _x) isKindOf "Air"})	//unmodified
        ) exitWith {
            _target_player = _x;
        };
    } forEach (allPlayers - entities "HeadlessClient_F");

    if (!isNull _target_player) then {
        _target_pos = [99999, getPos _target_player] call KPLIB_fnc_getNearestSector;	// get the sector for where to send the air to loiter over
        if !(_target_pos isEqualTo "") then {
            [_target_pos] spawn spawn_air;
        };
    };
};
