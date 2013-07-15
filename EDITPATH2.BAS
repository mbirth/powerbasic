CLS
shell "mode co80"
DIM PATH$(40)
$INCLUDE "LOGO.INC"
color 15
print
print"ððð EditPath ððð by RoboCop INDUSTRIES"
print
print"Lese Path-Variable ... ";
PATH$=ENVIRON$("PATH")
BACKUP$=PATH$
print "OK"
if PATH$="" then
  print
  print"Pfad-Variable ist leer! Neu anlegen (J/N)?"
  gosub InpKey
  if a$="j" or a$="J" then goto NewPath
  if A$="n" or A$="N" then goto Ende
end if
print"Splitte Path-String ... ";
x=1
for y=1 to 255
  IF MID$(PATH$,y,2)=";" or mid$(path$,y,2)="" then PATHs=x:exit for
  IF MID$(PATH$,y,1)=";" then x=x+1:goto 2
  PATH$(x)=PATH$(x)+mid$(PATH$,y,1)
2next y
print "OK"
goto EditPath

NewPath:
PATHs=1
PATH$(1)="C:\DOS"
goto EditPath

InpKey:
1 A$=INKEY$:IF A$="" THEN 1
  RETURN

EditPath:
chosen=1
oldchosen=1
oldy=1
cls:color 15,1
print"ððð EditPath ððð by RoboCop INDUSTRIES                              [ESC] - Ende";

EP:
locate 25,1:color 14,1:print space$(80);
color 15,0
y=1
for x=1 to PATHs
  if x+2-z>22 and y<>41 then y=41:z=20:goto 4
  if x+2-z>22 and y=41 then end
4 locate x+2-z,y
  print using"## \                                   \";x;PATH$(x);
  locate x+3-z,y
  print space$(40);
next x
z=0
ShowPaths:
color 15,0
locate oldchosen+2-oldz,oldy:print using"## \                                   \";oldchosen;PATH$(oldchosen);
if chosen<=20 then y=1:z=0 else y=41:z=20
oldchosen=chosen:oldy=y:oldz=z
locate chosen+2-z,y
color 0,4:print using"## \                                   \";chosen;PATH$(chosen);
gosub InpKey
KeyIn$=MID$(A$,2,1)
if KeyIn$="H" and chosen>1 then sound 1000,.5:chosen=chosen-1
if KeyIn$="P" and chosen<PATHs then sound 1000,.5:chosen=chosen+1
if KeyIn$="K" and chosen>20 then sound 1000,.5:chosen=chosen-20
if KeyIn$="M" and chosen<21 and PATHs>=chosen+20 then sound 1000,.5:chosen=chosen+20
if KeyIn$="R" and PATHs<40 then sound 1500,1:goto InsertOne
if KeyIn$="S" and PATHs>1 then sound 800,1:goto RemoveChosen
if KeyIn$="G" and chosen>1 then sound 1000,.5:chosen=1
if KeyIn$="O" and chosen<PATHs then sound 1000,.5:chosen=PATHs
if a$=chr$(13) then sound 800,1:delay 1/18.2:sound 1500,1:goto EditSelected
if a$=chr$(27) then for a=1 to 3:sound 1000,1:delay 2/18.2:next a:goto WriteItDown
goto ShowPaths

InsertOne:
PATHs=PATHs+1
for x=PATHs to chosen STEP -1
  PATH$(x)=PATH$(x-1)
next x
path$(chosen)=""
goto EP

RemoveChosen:
PATHs=PATHs-1
for x=chosen to PATHs
  PATH$(x)=PATH$(x+1)
next x
if PATHs+1=chosen then chosen=chosen-1:oldchosen=1
goto EP


EditSelected:
color 15,0
BAKPATH$=PATH$(chosen)
' locate 24,1:print PATH$(chosen);
locate 24,1:input ;"Neuer Pfad: ",PATH$(chosen)
locate 24,1:print space$(80);
if PATH$(chosen)="" then
  color 14,1
  locate 25,19:print"Keine Eingabe, L”schen oder Behalten (L/B)?";
  for a=1 to 3:sound 1000,1:delay 2/18.2:next a
6 gosub InpKey
  if a$="l" or a$="L" then sound 800,1:PATH$(chosen)="":goto 7
  if a$="b" or a$="B" then sound 1500,1:PATH$(chosen)=BAKPATH$:goto 7
  sound 1000,1
  goto 6
7end if
goto EP



WriteItDown:
Down$="@SET PATH="
locate 25,18:color 30,1
print"Wollen Sie die Žnderungen schreiben (J/N)?";
5gosub InpKey
if A$="j" or a$="J" then sound 1500,1:Zustand$="Neue PATH-Variable geschrieben.":goto YoSchreiben
if a$="n" or A$="N" then sound 800,1:Zustand$="Alte PATH-Variable beibehalten.":goto Nee
sound 1000,1
goto 5

YoSchreiben:
for x=1 to PATHs
  Down$=Down$+PATH$(x)+";"
next x
open "O",#1,"EDITPATH.BAT"
PRINT#1,Down$
close #1
goto Ende

Nee:
Down$="@SET PATH="
Down$=Down$+BACKUP$
open "O",#1,"EDITPATH.BAT"
PRINT#1,Down$
close #1
goto Ende

Ende:
color 15,0
cls:color 15,1
print"ððð EditPath ððð by RoboCop INDUSTRIES                                          ";
color 15,0
print
print Zustand$
print
print"Vielen Dank fr die Benutzung von EditPath!"
print
print"Bitte rufen Sie EDITPATH.BAT auf."
end