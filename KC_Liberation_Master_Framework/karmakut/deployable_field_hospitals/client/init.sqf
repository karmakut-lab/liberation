karma_deployableFieldHospitals_client_currentDeployedFieldHospital = objNull;
karma_deployableFieldHospitals_client_isPerformingAction = false;
karma_deployableFieldHospitals_client_actionAnimation = "Acts_TreatingWounded05";

// Give the player an action to deploy a medical tent.
player addAction [
    ["<t color='#FFFF00'>", localize "STR_KARMA_DEPLOY_FIELD_HOSPITAL", "</t><img size='2' image='res\ui_build.paa'/>"] joinString "",
    { [] call karma_deployableFieldHospitals_client_deployFieldHospital; },
    nil,
    -750,
    false,
    true,
    "",
    "
        !karma_deployableFieldHospitals_client_isPerformingAction &&
        alive player &&
        vehicle player == player &&
        isNull karma_deployableFieldHospitals_client_currentDeployedFieldHospital &&
        (getPosATL player select 2) < 0.1 &&
        player getVariable ['ace_medical_medicclass', 0] == 2;
    "
];

// Handle field hospital deployment:
karma_deployableFieldHospitals_client_deployFieldHospital = {
    [] spawn {
        karma_deployableFieldHospitals_client_isPerformingAction = true;
        player playMoveNow karma_deployableFieldHospitals_client_actionAnimation;
        sleep 15;
        [player] remoteExecCall ["karma_deployableFieldHospitals_server_deployFieldHospital", 2];
        player playActionNow "Stand";
        karma_deployableFieldHospitals_client_isPerformingAction = false;
    };
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
        _fieldHospital addAction [
            ["<t color='#FFFF00'>", localize "STR_KARMA_REPACK_FIELD_HOSPITAL", "</t>"] joinString "",
            { [] call karma_deployableFieldHospitals_client_repackFieldHospital; },
            nil,
            -750,
            false,
            true,
            "",
            "
                !karma_deployableFieldHospitals_client_isPerformingAction &&
                alive player &&
                vehicle player == player &&
                player getVariable ['ace_medical_medicclass', 0] == 2 &&
                getPlayerUID player == (_target getVariable ['karma_ownerUID', '']);
            "
        ];
    };
};

// Handle field hospital repacking:
karma_deployableFieldHospitals_client_repackFieldHospital = {
    [] spawn {
        karma_deployableFieldHospitals_client_isPerformingAction = true;
        player playMoveNow karma_deployableFieldHospitals_client_actionAnimation;
        sleep 15;
        [player] remoteExecCall ["karma_deployableFieldHospitals_server_repackFieldHospital", 2];
        player playActionNow "Stand";
        karma_deployableFieldHospitals_client_isPerformingAction = false;
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