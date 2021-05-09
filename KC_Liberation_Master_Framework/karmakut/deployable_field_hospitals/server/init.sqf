karma_deployableFieldHospitals_server_fieldHospitalsByPlayerUID = createHashMap;

karma_deployableFieldHospitals_server_deployFieldHospital = {
    params [
        ["_player", objNull]
    ];

    if (isNull _player) exitWith {};

    private _playerUID = getPlayerUID _player;
    private _existingFieldHospital = karma_deployableFieldHospitals_server_fieldHospitalsByPlayerUID getOrDefault [_playerUID, objNull];
    if (!isNull _existingFieldHospital) exitWith {
        [
            karma_deployableFieldHospitals_shared_statusCodes_fieldHospitalAlreadyDeployed,
            _playerUID,
            _existingFieldHospital
        ] remoteExecCall ["karma_deployableFieldHospitals_client_handleFieldHospitalDeploymentResponse"];
    };

    private _distanceFromPlayerToTerrain = getPosATL _player select 2;
    if (_distanceFromPlayerToTerrain > 0.1) exitWith {
        [
            karma_deployableFieldHospitals_shared_statusCodes_playerNotOnTerrain,
            _playerUID
        ] remoteExecCall ["karma_deployableFieldHospitals_client_handleFieldHospitalDeploymentResponse"];
    };

    private _playerPosition = position _player;
    private _playerDirection = direction _player;
    private _fieldHospital = karma_deployableFieldHospitals_shared_fieldHospitalClassname createVehicle _playerPosition;
    _fieldHospital allowDamage false;
    _fieldHospital setDir _playerDirection;
    _fieldHospital setPos _playerPosition;
    [_fieldHospital] call KPLIB_fnc_addObjectInit;
    _fieldHospital setVariable ["karma_ownerUID", _playerUID, true];
    karma_deployableFieldHospitals_server_fieldHospitalsByPlayerUID set [_playerUID, _fieldHospital];

    [
        karma_deployableFieldHospitals_shared_statusCodes_fieldHospitalDeployed,
        _playerUID,
        _fieldHospital
    ] remoteExecCall ["karma_deployableFieldHospitals_client_handleFieldHospitalDeploymentResponse"];
};

karma_deployableFieldHospitals_server_repackFieldHospital = {
    params [
        ["_player", objNull]
    ];

    if (isNull _player) exitWith {};

    private _playerUID = getPlayerUID _player;
    private _fieldHospital = karma_deployableFieldHospitals_server_fieldHospitalsByPlayerUID getOrDefault [_playerUID, objNull];
    karma_deployableFieldHospitals_server_fieldHospitalsByPlayerUID deleteAt _playerUID;
    if (!isNull _fieldHospital) then {
        deleteVehicle _fieldHospital;
    };

    [
        karma_deployableFieldHospitals_shared_statusCodes_fieldHospitalRepacked,
        _playerUID
    ] remoteExecCall ["karma_deployableFieldHospitals_client_handleFieldHospitalRepackResponse"];
};