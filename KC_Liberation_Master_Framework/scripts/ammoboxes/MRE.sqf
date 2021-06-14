params ["_crate"];

while {alive _crate} do {
    clearMagazineCargoGlobal _crate;
    clearWeaponCargoGlobal _crate;
    clearItemCargoGlobal _crate;
    clearBackpackCargoGlobal _crate;

    _crate allowDamage false;
    _crate addItemCargoGlobal  ["ACE_Canteen", 50];
	_crate addItemCargoGlobal  ["ACE_WaterBottle", 100];
	_crate addItemCargoGlobal  ["ACE_MRE_BeefStew", 50];
	_crate addItemCargoGlobal  ["ACE_MRE_ChickenTikkaMasala", 50];
	_crate addItemCargoGlobal  ["ACE_MRE_ChickenHerbDumplings", 50];
	_crate addItemCargoGlobal  ["ACE_MRE_CreamChickenSoup", 50];
	_crate addItemCargoGlobal  ["ACE_MRE_CreamTomatoSoup", 50];
	_crate addItemCargoGlobal  ["ACE_MRE_LambCurry", 50];
	_crate addItemCargoGlobal  ["ACE_MRE_MeatballsPasta", 50];
	_crate addItemCargoGlobal  ["ACE_MRE_SteakVegetables", 50];
	_crate addItemCargoGlobal  ["ACE_Humanitarian_Ration", 50];

    sleep 1800;
};