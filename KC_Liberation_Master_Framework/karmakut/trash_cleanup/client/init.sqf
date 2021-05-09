// Add an event handler to the player to 
player addEventHandler ["InventoryClosed", {
    params [
        ["_unit", objNull],
        ["_targetContainer", objNull]
    ];
    if (
        !isNull _targetContainer && 
        typeOf _targetContainer in karma_trashCleanup_shared_trashContainerClassnames
    ) then {
        [_targetContainer] remoteExec ["karma_trashCleanup_server_registerTrashContainer", 2];
    };
}];