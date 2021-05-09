karma_trashCleanup_server_trashToProcessPerIteration = 25;
karma_trashCleanup_server_trashContainersToProcess = []; // Element structure: [_trashContainer, _creationTimestamp]
karma_trashCleanup_server_queuedTrashContainers = [];
karma_trashCleanup_server_queuedTrashContainersLock = false; // Used for preventing writes from interfering between queueing and processing.

karma_trashCleanup_server_registerTrashContainer = {
    params [
        ["_trashContainer", objNull]
    ];
    if (isNull _trashContainer) exitWith {};
    waitUntil { !karma_trashCleanup_server_queuedTrashContainersLock };
    karma_trashCleanup_server_queuedTrashContainersLock = true;
    karma_trashCleanup_server_queuedTrashContainers pushBack [_trashContainer, time];
    karma_trashCleanup_server_queuedTrashContainersLock = false;
};

[] spawn {
    while { true } do {
        private _time = time;
        private _trashIteration = 0;
        {
            private _trashContainer = _x select 0;
            private _creationTimestamp = _x select 1;
            private _isTrashOlderThanAllowedAge = _time - _creationTimestamp >= karma_trashCleanup_shared_trashRemovalThresholdInSeconds;

            if (!isNull _trashContainer) then {
                if (_isTrashOlderThanAllowedAge) then {
                    deleteVehicle _trashContainer;
                } else {
                    karma_trashCleanup_server_queuedTrashContainers pushBack _x; // Trash isn't old enough to be removed, requeue for processing.
                };
            };

            _trashIteration = _trashIteration + 1;
            if (_trashIteration % karma_trashCleanup_server_trashToProcessPerIteration == 0) then {
                sleep 1; // Take a break to avoid bogging down the server from processing too much trash at once.
            };
        } forEach karma_trashCleanup_server_trashContainersToProcess;

        karma_trashCleanup_server_trashContainersToProcess = karma_trashCleanup_server_queuedTrashContainers;
        waitUntil { !karma_trashCleanup_server_queuedTrashContainersLock };
        karma_trashCleanup_server_queuedTrashContainersLock = true;
        karma_trashCleanup_server_queuedTrashContainers = [];
        karma_trashCleanup_server_queuedTrashContainersLock = false;

        sleep 1;
    };
}