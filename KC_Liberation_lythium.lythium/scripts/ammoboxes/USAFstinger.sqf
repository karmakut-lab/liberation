params ["_crate"];
clearMagazineCargoGlobal _crate;  
clearItemCargoGlobal _crate;  
clearBackpackCargoGlobal _crate;  
clearWeaponCargoGlobal _crate;  

_crate addMagazineCargoGlobal ["rhs_fim92_mag", 5];
_crate addWeaponCargoGlobal ["rhs_weap_fim92", 1];
_crate allowDamage false;