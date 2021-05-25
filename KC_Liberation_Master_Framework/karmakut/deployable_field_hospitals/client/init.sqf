karma_deployableFieldHospitals_client_currentDeployedFieldHospital = objNull;
karma_deployableFieldHospitals_client_isPerformingAction = false;
karma_deployableFieldHospitals_client_actionAnimation = "Acts_TreatingWounded05";
karma_deployableFieldHospitals_client_actionDurationInSeconds = 24; // This can't be longer than 24 seconds (limitation of the BIS_fnc_holdActionAdd function).

karma_deployableFieldHospitals_client_initializePlayer = {
    private _deployActionId = [
        player, // target
        ["<t color='#FFFF00'>", localize "STR_KARMA_DEPLOY_FIELD_HOSPITAL", "</t>"] joinString "", // title
        "res\ui_build.paa", // idleIcon
        "res\ui_build.paa", // progressIcon
        "
            alive player &&
            vehicle player == player &&
            isNull karma_deployableFieldHospitals_client_currentDeployedFieldHospital &&
            (getPosATL player select 2) < 0.1 &&
            player getVariable ['ace_medical_medicclass', 0] == 2;
        ", // conditionShow
        "true", // conditionProgress
        {
            karma_deployableFieldHospitals_client_isPerformingAction = true;
            player playMoveNow karma_deployableFieldHospitals_client_actionAnimation;
        }, // codeStart
        {}, // codeProgress
        {
            [player] remoteExecCall ["karma_deployableFieldHospitals_server_deployFieldHospital", 2];
            player playActionNow "Stand";
            karma_deployableFieldHospitals_client_isPerformingAction = false;
        }, // codeCompleted
        {
            player playActionNow "Stand";
            karma_deployableFieldHospitals_client_isPerformingAction = false;
        }, // codeInterrupted
        [], // arguments
        karma_deployableFieldHospitals_client_actionDurationInSeconds, // duration
        100, // priority
        false, // removeCompleted
        false, // showUnconscious
        false // showWindow
    ] call BIS_fnc_holdActionAdd;

    player setVariable ["karma_deployableFieldHospitals_deployActionId", _deployActionId];
};

karma_deployableFieldHospitals_client_handleFieldHospitalDeploymentResponse = {
    params [
        ["_statusCode", -1],
        ["_ownerUID", ""],
        ["_fieldHospital", objNull]
    ];

    if (getPlayerUID player == _ownerUID) then {
        karma_deployableFieldHospitals_client_currentDeployedFieldHospital = _fieldHospital;
        hint (_statusCode call karma_deployableFieldHospitals_shared_getMessageForStatusCode);
    };

    if (!isNull _fieldHospital) then {
        // Add the repack action to the field hospital.
        [
            _fieldHospital, // target
            ["<t color='#FFFF00'>", localize "STR_KARMA_REPACK_FIELD_HOSPITAL", "</t>"] joinString "", // title
            "res\ui_build.paa", // idleIcon
            "res\ui_build.paa", // progressIcon
            "
                alive player &&
                vehicle player == player &&
                player getVariable ['ace_medical_medicclass', 0] == 2 &&
                getPlayerUID player == (_target getVariable ['karma_ownerUID', '']);
            ", // conditionShow
            "true", // conditionProgress
            {
                karma_deployableFieldHospitals_client_isPerformingAction = true;
                player playMoveNow karma_deployableFieldHospitals_client_actionAnimation;
            }, // codeStart
            {}, // codeProgress
            {
                [player] remoteExecCall ["karma_deployableFieldHospitals_server_repackFieldHospital", 2];
                player playActionNow "Stand";
                karma_deployableFieldHospitals_client_isPerformingAction = false;
            }, // codeCompleted
            {
                player playActionNow "Stand";
                karma_deployableFieldHospitals_client_isPerformingAction = false;
            }, // codeInterrupted
            [], // arguments
            karma_deployableFieldHospitals_client_actionDurationInSeconds, // duration
            100, // priority
            false, // removeCompleted
            false, // showUnconscious
            false // showWindow
        ] call BIS_fnc_holdActionAdd;
    };
};

karma_deployableFieldHospitals_client_handleFieldHospitalRepackResponse = {
    params [
        ["_statusCode", -1],
        ["_ownerUID", objNull]
    ];

    if (getPlayerUID player == _ownerUID) then {
        karma_deployableFieldHospitals_client_currentDeployedFieldHospital = objNull;
        hint (_statusCode call karma_deployableFieldHospitals_shared_getMessageForStatusCode);
    };
};

[] call karma_deployableFieldHospitals_client_initializePlayer;
player addEventHandler ["Respawn", {
    params ["_unit", "_corpse"];
    if (player != unit) exitWith {};
    private _deployActionId = _corpse getVariable ["karma_deployableFieldHospitals_deployActionId", -1];
    if (_deployActionId == -1) exitWith {};
    [_corpse, _deployActionId] call BIS_fnc_holdActionRemove;
    [] call karma_deployableFieldHospitals_client_initializePlayer;
}];