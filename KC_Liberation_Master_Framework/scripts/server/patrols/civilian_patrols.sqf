if ( GRLIB_civilian_activity > 0 ) then {
    for [ {_i=0}, {_i < GRLIB_civilians_amount}, {_i=_i+1} ] do {
      if (KP_liberation_civ_rep <= -80) then {
          if (random [1,5,10] > 3) then {
              [] spawn manage_one_VBIED_patrol;
          } else {
              [] spawn manage_one_civilian_patrol;
          };
      }
      else {
        [] spawn manage_one_civilian_patrol;
      };
    };
};
