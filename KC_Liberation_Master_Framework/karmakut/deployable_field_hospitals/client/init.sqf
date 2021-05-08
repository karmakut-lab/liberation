karma_deployableFieldHospitals_client_currentDeployedFieldHospital = objNull;

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
        vehicle player == player &&
        player getVariable ['ace_medical_medicclass', 0] == 2 &&
        isNull karma_deployableFieldHospitals_client_currentDeployedFieldHospital;
    "
];

// Handle field hospital deployment:
karma_deployableFieldHospitals_client_deployFieldHospital = {
    [player] remoteExecCall ["karma_deployableFieldHospitals_server_deployFieldHospital", 2];
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
                vehicle player == player &&
                player getVariable ['ace_medical_medicclass', 0] == 2 &&
                getPlayerUID player == (_target getVariable ['karma_ownerUID', '']);
            "
        ];
    };
};

// Handle field hospital repacking:
karma_deployableFieldHospitals_client_repackFieldHospital = {
    [player] remoteExecCall ["karma_deployableFieldHospitals_server_repackFieldHospital", 2];
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