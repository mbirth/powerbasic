cls
screen 12
call WriteLn("Calculating and Drawing Graphic, please wait ... ( )",30,80)
for z=400 to 480 step 2
pset (0,z),0
for s=1 to 640 step 2
if st=0 then st=1
st=st+.01
if st>=5 then st=1
locate 30,64
if st>=1 then st$="-"
if st>=2 then st$="\"
if st>=3 then st$="|"
if st>=4 then st$="/"
print st$;
anz$=" Aktuelle Pos.: Z"+mid$(str$(z),2,5)+" S"+mid$(str$(s),2,5)+"  Farbe: "+str$(farbe)+" "
call WriteLn(anz$,29,80)
farbe=0  'farbe=int(rnd(1)*256)+1
pset (s,z),farbe    'line -(s,z),farbe
next s
next z
locate 1,80:print" ";
call WriteLn("Graphic contruction complete.",30,80)
goto Ende

sub WriteLn (s$,x,ymax) SHARED PUBLIC
  locate x,(ymax/2)-len(s$)/2
  print s$;
end sub

Ende: