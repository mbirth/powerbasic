cls
screen 12
locate 1,1
1 x1=int(rnd(1)*640)
x2=int(rnd(1)*640)
y1=int(rnd(1)*480)
y2=int(rnd(1)*480)
far=int(rnd(1)*256)
line (x1,y1)-(x2,y2),far,BF
zahl=zahl+1
locate 30,1:print"Anzahl Rechtecke: ";zahl;
if inkey$=" " then 2
goto 1

2 REM Fucking Hostile is back

goto Fade
'goto RoboCop
'goto ARoboCop

RoboCop:
for x=0 to 480 step 2
line (0,x)-(640,x),0
next x
goto Ende

ARoboCop:

' 1 Zeile Schrift = 16 Pixel
' 1 Buchstabe     = 8 Pixel
'=> Schrift       = 8x16

z=50
for x=0 to 640 step 2
line (x,0)-(x,480),0
next x
goto Ende

Fade:
an=.5
st=1
for g=1 to 9
an=an*2
st=st*2
gosub DoIt
9 a$=inkey$:if a$="" then 9
 if a$="r" or a$="R" then exit for
next g

goto Ende

DoIt:
z=an-st
s=an-st
6 REM FuckHost
z=z+st
s=s+st
if z>480 then 7
line (0,z)-(640,z),0
7 line (s,0)-(s,480),0
if s>640 and z>480 then return
goto 6

Ende: