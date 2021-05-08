params ["_crate"];
clearMagazineCargoGlobal _crate;  
clearItemCargoGlobal _crate;  
clearBackpackCargoGlobal _crate;  
clearWeaponCargoGlobal _crate;  

_crate addMagazineCargoGlobal ["MRAWS_HEAT_F", 5];
_crate addWeaponCargoGlobal ["launch_MRAWS_green_F", 1];
_crate allowDamage false;