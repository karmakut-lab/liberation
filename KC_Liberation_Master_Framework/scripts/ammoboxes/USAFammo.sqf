params ["_crate"];
clearMagazineCargoGlobal _crate;  
clearItemCargoGlobal _crate;  
clearBackpackCargoGlobal _crate;  
clearWeaponCargoGlobal _crate;  

_crate addItemCargoGlobal ["rhs_mag_30Rnd_556x45_M855A1_EPM_Tracer_Red", 25];
_crate addItemCargoGlobal ["rhsusf_200rnd_556x45_mixed_box", 5];
_crate addItemCargoGlobal ["rhsusf_100Rnd_762x51_m62_tracer",5];
_crate addItemCargoGlobal ["ACE_40mm_Flare_white", 10];
_crate addItemCargoGlobal ["rhs_mag_M441_HE", 20];
_crate addItemCargoGlobal ["rhs_mag_m67", 5];
_crate addItemCargoGlobal ["rhs_mag_an_m8hc", 5];
_crate addItemCargoGlobal ["SmokeShellBlue", 3];
_crate addWeaponCargoGlobal ["rhs_weap_m72a7",2];
_crate allowDamage false;