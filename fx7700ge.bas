$COMPILE UNIT
sub Drawfx
   screen 7
   for z=10 to 107
   pset (z,10),7
   pset (z,75),7
   next z
   for z=10 to 75
   pset (10,z),7
   pset (107,z),7
   next z
end sub
