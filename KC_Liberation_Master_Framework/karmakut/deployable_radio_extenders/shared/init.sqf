karma_deployableRadioExtenders_shared_radioExtenderClassname = "tfw_rf3080Object";

// Statuses and messaging:
karma_deployableRadioExtenders_shared_statusCodes_radioExtenderDeployed = 0;
karma_deployableRadioExtenders_shared_statusCodes_radioExtenderAlreadyDeployed = 1;
karma_deployableRadioExtenders_shared_statusCodes_radioExtenderRepacked = 2;
karma_deployableRadioExtenders_shared_statusCodes_playerNotOnTerrain = 3;

karma_deployableRadioExtenders_shared_messagesByStatusCode = createHashMapFromArray [
    [
        karma_deployableRadioExtenders_shared_statusCodes_radioExtenderDeployed,
        localize "STR_KARMA_RADIO_EXTENDER_DEPLOYED"
    ],
    [
        karma_deployableRadioExtenders_shared_statusCodes_radioExtenderAlreadyDeployed,
        localize "STR_KARMA_RADIO_EXTENDER_ALREADY_DEPLOYED"
    ],
    [
        karma_deployableRadioExtenders_shared_statusCodes_radioExtenderRepacked,
        localize "STR_KARMA_RADIO_EXTENDER_REPACKED"
    ],
    [
        karma_deployableRadioExtenders_shared_statusCodes_playerNotOnTerrain,
        localize "STR_KARMA_RADIO_EXTENDER_MUST_BE_DEPLOYED_ON_TERRAIN"
    ]
];

karma_deployableRadioExtenders_shared_getMessageForStatusCode = {
    params ["_statusCode"];
    karma_deployableRadioExtenders_shared_messagesByStatusCode getOrDefault [_statusCode, "UNKNOWN STATUS"];
};