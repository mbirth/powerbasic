dim x$(12)
color 15:print"Bitte drÅcken Sie [Prog]+[Esc] zusammen.":color 7
for y=1 to 12
for z=1 to 20
1 a$=inkey$:if a$="" then 1
if a$=chr$(27) then exit for
x$(y)=x$(y)+a$
next z
next y
input SHIT$
print
color 15:print"Folgende Codes wurden von der Tastatur gelesen:":color 7
for z=1 to 12
?x$(z)
next z
print
color 15:print"Folgende Befehle mÅssten die öbersetzung sein:":color 7
open "O",#1,"KEYPRO.TAB"
for z=1 to 12
?#1,x$(z)
next z
