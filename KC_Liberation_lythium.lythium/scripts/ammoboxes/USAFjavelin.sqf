params ["_crate"];
clearMagazineCargoGlobal _crate;  
clearItemCargoGlobal _crate;  
clearBackpackCargoGlobal _crate;  
clearWeaponCargoGlobal _crate;  

_crate addMagazineCargoGlobal ["rhs_fgm148_magazine_AT", 5];
_crate addWeaponCargoGlobal ["rhs_weap_fgm148", 1];

_crate allowDamage false;