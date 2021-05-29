karma_deployableRadioExtenders_server_radioExtendersByPlayerUID = createHashMap;

karma_deployableRadioExtenders_server_deployRadioExtender = {
    params [
        ["_player", objNull]
    ];

    if (isNull _player) exitWith {};

    private _playerUID = getPlayerUID _player;
    private _existingRadioExtender = karma_deployableRadioExtenders_server_radioExtendersByPlayerUID getOrDefault [_playerUID, objNull];
    if (!isNull _existingRadioExtender) exitWith {
        [
            karma_deployableRadioExtenders_shared_statusCodes_radioExtenderAlreadyDeployed,
            _playerUID,
            _existingRadioExtender
        ] remoteExecCall ["karma_deployableRadioExtenders_client_handleRadioExtenderDeploymentResponse"];
    };

    private _distanceFromPlayerToTerrain = getPosATL _player select 2;
    if (_distanceFromPlayerToTerrain > 0.1) exitWith {
        [
            karma_deployableRadioExtenders_shared_statusCodes_playerNotOnTerrain,
            _playerUID
        ] remoteExecCall ["karma_deployableRadioExtenders_client_handleRadioExtenderDeploymentResponse"];
    };

    private _playerPosition = position _player;
    private _playerDirection = direction _player;
    private _radioExtender = karma_deployableRadioExtenders_shared_radioExtenderClassname createVehicle _playerPosition;
    _radioExtender allowDamage false;
    _radioExtender setDir _playerDirection;
    _radioExtender setPos (_playerPosition vectorAdd (vectorDir _player));
    _radioExtender setVariable ["karma_ownerUID", _playerUID, true];
    karma_deployableRadioExtenders_server_radioExtendersByPlayerUID set [_playerUID, _radioExtender];

    [
        karma_deployableRadioExtenders_shared_statusCodes_radioExtenderDeployed,
        _playerUID,
        _radioExtender
    ] remoteExecCall ["karma_deployableRadioExtenders_client_handleRadioExtenderDeploymentResponse"];
};

karma_deployableRadioExtenders_server_repackRadioExtender = {
    params [
        ["_player", objNull]
    ];

    if (isNull _player) exitWith {};

    private _playerUID = getPlayerUID _player;
    private _radioExtender = karma_deployableRadioExtenders_server_radioExtendersByPlayerUID getOrDefault [_playerUID, objNull];
    karma_deployableRadioExtenders_server_radioExtendersByPlayerUID deleteAt _playerUID;
    if (!isNull _radioExtender) then {
        deleteVehicle _radioExtender;
    };

    [
        karma_deployableRadioExtenders_shared_statusCodes_radioExtenderRepacked,
        _playerUID
    ] remoteExecCall ["karma_deployableRadioExtenders_client_handleRadioExtenderRepackResponse"];
};