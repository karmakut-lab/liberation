while {true} do
{
private ["_reserved_units", "_reserved_uids", "_uid"];

waitUntil {!isNull player};
sleep 1;
waitUntil {(vehicle player) == player};
sleep 1;
waitUntil {(getPlayerUID player) != ""};


// Variable Name of the Player Character to be restricted. //
_reserved_units = [Zeus_1,Zeus_2,Zeus_3,Zeus_4];


// The player UID is a 17 digit number found in the profile tab. //
_reserved_uids =
[
    "76561198009578451",
    "76561198029603889",
    "76561198128972595",
    "76561198035901368",
    "76561198010961319",
    "76561197966129199",
    "76561198874160679",
    "76561198372265841"
];


// Stores the connecting player's UID //
_uid = getPlayerUID player;




if ((player in _reserved_units)&& !(_uid in _reserved_uids)) then
    {
    titleText ["", "BLACK OUT"];
    sleep 2;
    endMission "END1";
    };  
 };
 
 sleep 3600;

