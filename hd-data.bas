color 1,1
cls
color 14,1
locate 5,5:print "       HEADS "
locate 7,5:print "   CYLINDERS "
locate 9,5:print "     SECTORS "
locate 12,5:print"        SIZE "
locate 17,5:print"LANDING ZONE "
color 11,1
locate 9,27:print"* 512 Bytes"
locate 12,32:print"Bytes"
locate 13,32:print"kBytes"
locate 14,32:print"MBytes"
locate 15,32:print"GBytes"
color 15,1
locate 5,40:print "Up/Down    - Switch between HEADS,"
locate 6,40:print "             CYLINDERS and SECTORS"
locate 7,40:print "Right/Left - Increase  /  decrease"
locate 8,40:print "             selected value"
locate 9,40:print "[ENTER]    - enter value directly"
locate 10,40:print"[ESC]ape   - Quit this nice proggy"
color 16,7:locate 2,27:print" HARDDISK-SIZE-CALCULATOR "
gosub PrintItOut
1 a$=inkey$:if a$="" then 1
if a$=chr$(27) then goto Ende
if mid$(a$,2,1)="H" and active>1 then active=active-1
if mid$(a$,2,1)="P" and active<3 then active=active+1
if active=1 then value=heads
if active=2 then value=cylinders
if active=3 then value=sectors
if mid$(a$,2,1)="M" and value<999999 then Incr Value
if mid$(a$,2,1)="K" and value>0 then Decr Value
if a$=chr$(13) and active<>0 then gosub InputIt
if active=1 then heads=value
if active=2 then cylinders=value
if active=3 then sectors=value
gosub PrintItOut
goto 1

InputIt:
locate 19,10:color 14,1:print"Enter the new value for ";
if active=1 then print"HEADS";
if active=2 then print"CYLINDERS";
if active=3 then print"SECTORS";
print " :";
oldvalue=value
color 11,1:input "",value
if value=0 then value=oldvalue
if value>999999 then value=oldvalue
locate 19,10:print space$(70);
return

PrintItOut:
color 0,3
locate 5,19:print using "######";heads
locate 7,19:print using "######";cylinders
locate 9,19:print using "######";sectors
color 11+16,1
if active=0 then goto 2
if active=1 then l=5
if active=2 then l=7
if active=3 then l=9
locate 5,18:if l=5 then print chr$(16); else print " ";
locate 7,18:if l=7 then print chr$(16); else print " ";
locate 9,18:if l=9 then print chr$(16); else print " ";
locate 5,25:if l=5 then print chr$(17); else print " ";
locate 7,25:if l=7 then print chr$(17); else print " ";
locate 9,25:if l=9 then print chr$(17); else print " ";
2 color 0,7
locate 17,18:print using "#######";cylinders+1
sizeb=heads*cylinders*sectors*512
sizek=sizeb/1024
sizem=sizek/1024
sizeg=sizem/1024
locate 12,18
if sizeb<9999999999 then print using ",,,,,,,,,,,,,";sizeb else color 12,7:print"* OVERFLOW * ":color 0,7
locate 13,18
if sizek<9999999999 then print using ",,,,,,,,,,,,,";sizek else color 12,7:print"* OVERFLOW * ":color 0,7
locate 14,18
if sizem<9999999999 then print using ",,,,,,,,,,,,,";sizem else color 12,7:print"* OVERFLOW * ":color 0,7
locate 15,18
if sizeg<9999999999 then print using ",,,,,,,,,,,,,";sizeg else color 12,7:print"* OVERFLOW * ":color 0,7
return

Ende:
color 7,0
cls
print "READY."
end