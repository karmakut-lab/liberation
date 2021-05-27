params ["_crate"];

while {alive _crate} do {
    clearMagazineCargoGlobal _crate;
    clearWeaponCargoGlobal _crate;
    clearItemCargoGlobal _crate;
    clearBackpackCargoGlobal _crate;

    _crate allowDamage false;
    _crate addWeaponCargoGlobal ["rhs_weap_M136", 20];
    _crate addMagazineCargoGlobal ["rhs_fgm148_magazine_AT", 4];
    _crate addWeaponCargoGlobal ["rhs_weap_fgm148", 2];
    _crate addMagazineCargoGlobal ["MRAWS_HEAT_F", 12];
    _crate addWeaponCargoGlobal ["launch_MRAWS_green_F", 4];
    _crate addMagazineCargoGlobal ["rhs_fim92_mag", 6];
    _crate addWeaponCargoGlobal ["rhs_weap_fim92", 2];

    sleep 3600;
};