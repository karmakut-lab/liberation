// Field hospital metadata:
karma_deployableFieldHospitals_shared_fieldHospitalClassname = "Land_MedicalTent_01_NATO_generic_open_F";

// Statuses and messaging:
karma_deployableFieldHospitals_shared_statusCodes_fieldHospitalDeployed = 0;
karma_deployableFieldHospitals_shared_statusCodes_fieldHospitalAlreadyDeployed = 1;
karma_deployableFieldHospitals_shared_statusCodes_fieldHospitalRepacked = 2;
karma_deployableFieldHospitals_shared_statusCodes_playerNotOnTerrain = 3;

karma_deployableFieldHospitals_shared_messagesByStatusCode = createHashMapFromArray [
    [
        karma_deployableFieldHospitals_shared_statusCodes_fieldHospitalDeployed,
        localize "STR_KARMA_FIELD_HOSPITAL_DEPLOYED"
    ],
    [
        karma_deployableFieldHospitals_shared_statusCodes_fieldHospitalAlreadyDeployed,
        localize "STR_KARMA_FIELD_HOSPITAL_ALREADY_DEPLOYED"
    ],
    [
        karma_deployableFieldHospitals_shared_statusCodes_fieldHospitalRepacked,
        localize "STR_KARMA_FIELD_HOSPITAL_REPACKED"
    ],
    [
        karma_deployableFieldHospitals_shared_statusCodes_playerNotOnTerrain,
        localize "STR_KARMA_FIELD_HOSPITAL_MUST_BE_DEPLOYED_ON_TERRAIN"
    ]
];

karma_deployableFieldHospitals_shared_getMessageForStatusCode = {
    params ["_status_code"];
    karma_deployableFieldHospitals_shared_messagesByStatusCode getOrDefault [_status_code, "UNKNOWN STATUS"];
};