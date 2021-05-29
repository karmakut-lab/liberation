karma_deployableRadioExtenders_client_currentDeployedRadioExtender = objNull;
karma_deployableRadioExtenders_client_isPerformingAction = false;
karma_deployableRadioExtenders_client_actionAnimation = "Acts_TreatingWounded05";
karma_deployableRadioExtenders_client_actionDurationInSeconds = 10; // This can't be longer than 24 seconds (limitation of the BIS_fnc_holdActionAdd function).

karma_deployableRadioExtenders_client_initializePlayer = {
    private _deployActionId = [
        player, // target
        ["<t color='#FFFF00'>", localize "STR_KARMA_DEPLOY_RADIO_EXTENDER", "</t>"] joinString "", // title
        "res\ui_build.paa", // idleIcon
        "res\ui_build.paa", // progressIcon
        "
            alive player &&
            vehicle player == player &&
            isNull karma_deployableRadioExtenders_client_currentDeployedRadioExtender &&
            (getPosATL player select 2) < 0.1 &&
            player getVariable ['karma_canDeployRadioExtender', false];
        ", // conditionShow
        "true", // conditionProgress
        {
            karma_deployableRadioExtenders_client_isPerformingAction = true;
            player playMoveNow karma_deployableRadioExtenders_client_actionAnimation;
        }, // codeStart
        {}, // codeProgress
        {
            [player] remoteExecCall ["karma_deployableRadioExtenders_server_deployRadioExtender", 2];
            player playActionNow "Stand";
            karma_deployableRadioExtenders_client_isPerformingAction = false;
        }, // codeCompleted
        {
            player playActionNow "Stand";
            karma_deployableRadioExtenders_client_isPerformingAction = false;
        }, // codeInterrupted
        [], // arguments
        karma_deployableRadioExtenders_client_actionDurationInSeconds, // duration
        100, // priority
        false, // removeCompleted
        false, // showUnconscious
        false // showWindow
    ] call BIS_fnc_holdActionAdd;

    player setVariable ["karma_deployableRadioExtenders_deployActionId", _deployActionId];
};

karma_deployableRadioExtenders_client_handleRadioExtenderDeploymentResponse = {
    params [
        ["_statusCode", -1],
        ["_ownerUID", ""],
        ["_radioExtender", objNull]
    ];

    if (getPlayerUID player == _ownerUID) then {
        karma_deployableRadioExtenders_client_currentDeployedRadioExtender = _radioExtender;
        hint (_statusCode call karma_deployableRadioExtenders_shared_getMessageForStatusCode);
    };

    if (!isNull _radioExtender) then {
        // Add the repack action to the radio extender.
        [
            _radioExtender, // target
            ["<t color='#FFFF00'>", localize "STR_KARMA_REPACK_RADIO_EXTENDER", "</t>"] joinString "", // title
            "res\ui_build.paa", // idleIcon
            "res\ui_build.paa", // progressIcon
            "
                alive player &&
                vehicle player == player &&
                player getVariable ['karma_canDeployRadioExtender', false] &&
                getPlayerUID player == (_target getVariable ['karma_ownerUID', '']);
            ", // conditionShow
            "true", // conditionProgress
            {
                karma_deployableRadioExtenders_client_isPerformingAction = true;
                player playMoveNow karma_deployableRadioExtenders_client_actionAnimation;
            }, // codeStart
            {}, // codeProgress
            {
                [player] remoteExecCall ["karma_deployableRadioExtenders_server_repackRadioExtender", 2];
                player playActionNow "Stand";
                karma_deployableRadioExtenders_client_isPerformingAction = false;
            }, // codeCompleted
            {
                player playActionNow "Stand";
                karma_deployableRadioExtenders_client_isPerformingAction = false;
            }, // codeInterrupted
            [], // arguments
            karma_deployableRadioExtenders_client_actionDurationInSeconds, // duration
            100, // priority
            false, // removeCompleted
            false, // showUnconscious
            false // showWindow
        ] call BIS_fnc_holdActionAdd;
    };
};

karma_deployableRadioExtenders_client_handleRadioExtenderRepackResponse = {
    params [
        ["_statusCode", -1],
        ["_ownerUID", objNull]
    ];

    if (getPlayerUID player == _ownerUID) then {
        karma_deployableRadioExtenders_client_currentDeployedRadioExtender = objNull;
        hint (_statusCode call karma_deployableRadioExtenders_shared_getMessageForStatusCode);
    };
};

[] call karma_deployableRadioExtenders_client_initializePlayer;
player addEventHandler ["Respawn", {
    params ["_unit", "_corpse"];
    if (player != unit) exitWith {};
    private _deployActionId = _corpse getVariable ["karma_deployableRadioExtenders_deployActionId", -1];
    if (_deployActionId == -1) exitWith {};
    [_corpse, _deployActionId] call BIS_fnc_holdActionRemove;
    [] call karma_deployableRadioExtenders_client_initializePlayer;
}];