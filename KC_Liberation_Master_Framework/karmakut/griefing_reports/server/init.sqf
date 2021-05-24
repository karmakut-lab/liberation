private _civKillsPerPlayer = createHashMap;
private _friendlyKillsPerPlayer = createHashMap;
addMissionEventHandler ["EntityKilled", 
{
 params ["_killed", "_killer", "_instigator"];
 if (isNull _instigator) then {_instigator = UAVControl vehicle _killer select 0}; // UAV/UGV player operated road kill
 if (isNull _instigator) then {_instigator = _killer}; // player driven vehicle road kill
 if ((side group _killed == civilian) && (isPlayer _instigator)) then { 
    systemChat format ["%1 killed a civilian.", name _instigator];
    if (name _instigator in _civKills) then {
        private currentKills = _civKills get name _instigator;
        _civKills set [name _instigator, currentKills+1];
    }
    else {
        _civKills set [name _instigator, 1];
    };
    if ((_civKills get name _instigator) => 5) then {
        systemChat format ["%1 killed a total of %2 civilians.", name _instigator, _civKills get name _instigator];
    };
 };
 if ((isPlayer _killed) && (isPlayer _instigator) && (name _killed != name _instigator)) then {
    systemChat format ["%1 killed a friendly.", name _instigator];
    if (name _instigator in _friendlyKills) then {
        private currentKills = _friendlyKills get name _instigator;
        _friendlyKills set [name _instigator, currentKills+1];
    }
    else {
        _friendlyKills set [name _instigator, 1];
    };
    if ((_friendlyKills get name _instigator) >= 5) then {
        systemChat format ["%1 killed a total of %2 friendlies.", name _instigator, _civKills get name _instigator];
    };
 };
}];