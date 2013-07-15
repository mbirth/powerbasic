cls
screen 0
color 15


oldposx=1:oldposy=1
npos=4:hpos=12+16
nneg=9:hneg=11+16
nneu=8:hneu=15+16


color 14
print"-=˛ Elektrische Felder ˛=-"
print
color 7
print"      Editor geschrieben von RoboCop <RoboCop@EarthCorp.com>"
color 15
print

EnterFile:
input"Dateiname (z.B. project5)([ENTER] fÅr neue Datei): ",finame$
finame$=finame$+".elf"
cls
screen 12
if finame$=".elf" then goto HierWeiter1
on error goto FileNotEx
  open "I",#1,finame$
  close #1
  open "B",#1,finame$
HierWeiter1:
on error goto SomeError
locate 1,1:color nneg:print"˛";:color 8:print" negativ"
locate 2,1:color npos:print"˛";:color 8:print" positiv"
locate 3,1:color nneu:print"˛";:print" neutral"
locate 5,1:color 14:print"+/-"
locate 6,2:color 8:print"Ladung"
locate 8,1:color 14:print"0"
locate 9,2:color 8:print"neutral"
locate 11,1:color 14:print"Cursor"
locate 12,2:color 8:print"bewegen"
locate 14,1:color 14:print"[ESC]"
locate 15,2:color 8:print"fertig!"
dim col(50,30)
dim num(50,30)
dim onum(50,30)
dim ocol(50,30)
for x=1 to 50
  for y=1 to 30
    color 8:locate y,x+14:print"˙";
    if done=0 then locate y,66:print str$(y);:if y<10 then locate y,11:print str$(y); else locate y,10:print str$(y);
    if done=0 then locate y,14:print"≥";:locate y,65:print"≥";:oldy=y
    if x=2 then done=1
    if finame$<>".elf" then get$ #1,1,ch$ else ch$=chr$(0)
    locate y,x+14
    if asc(ch$)<128 then col(x,y)=npos:num(x,y)=asc(ch$)
    if asc(ch$)>128 then col(x,y)=nneg:num(x,y)=256-asc(ch$)
    if asc(ch$)=0 then col(x,y)=nneu
    color col(x,y)
    if num(x,y)<>0 then print right$(str$(num(x,y)),1); else print"˙";
    onum(x,y)=num(x,y)
    ocol(x,y)=col(x,y)
    if finame$<>".elf" then if eof(1) then exit for
  next y
  if finame$<>".elf" then if eof(1) then exit for
next x
if finame$<>".elf" then close #1
newposx=1:newposy=1:gosub ShowNewPos
2 a$=inkey$:if a$="" then goto 2
skey$=right$(a$,1)
if a$=chr$(27) then goto WannaSave
if ((a$="9" OR skey$="I") AND newposy>1 AND newposx<50) then newposy=newposy-1:newposx=newposx+1
if ((a$="8" OR skey$="H") AND newposy>1) then newposy=newposy-1
if ((a$="7" OR skey$="G") AND newposy>1 AND newposx>1) then newposy=newposy-1:newposx=newposx-1
if ((a$="6" OR skey$="M") AND newposx<50) then newposx=newposx+1
if ((a$="4" OR skey$="K") AND newposx>1) then newposx=newposx-1
if ((a$="3" OR skey$="Q") AND newposy<30 AND newposx<50) then newposy=newposy+1:newposx=newposx+1
if ((a$="2" OR skey$="P") AND newposy<30) then newposy=newposy+1
if ((a$="1" OR skey$="O") AND newposy<30 AND newposx>1) then newposy=newposy+1:newposx=newposx-1
if a$="0" OR skey$="R" then col(newposx,newposy)=nneu:num(newposx,newposy)=0
if a$="+" then
  x=newposx:y=newposy
  OK=0
  if col(x,y)=nneu AND OK=0 then num(x,y)=1:col(x,y)=npos:OK=1
  if col(x,y)=nneg AND OK=0 then num(x,y)=num(x,y)-1:OK=1:if num(x,y)=0 then col(x,y)=nneu
  if col(x,y)=npos AND OK=0 AND num(x,y)<9 then num(x,y)=num(x,y)+1:OK=1
end if
if a$="-" then
  x=newposx:y=newposy
  OK=0
  if col(x,y)=nneu AND OK=0 then num(x,y)=1:col(x,y)=nneg:OK=1
  if col(x,y)=nneg AND OK=0 AND num(x,y)<9 then num(x,y)=num(x,y)+1:OK=1
  if col(x,y)=npos AND OK=0 then num(x,y)=num(x,y)-1:OK=1:if num(x,y)=0 then col(x,y)=nneu
end if
gosub ShowNewPos
goto 2

ShowNewPos:
locate OldposY,OldposX+14
color col(OldposX,OldposY)
if num(OldposX,OldposY)=0 then print "˙"; else print right$(str$(num(OldposX,OldposY)),1);
locate NewPosY,NewPosX+14
color col(NewPosX,NewPosY)
if num(NewPosX,NewPosY)=0 then
  color hneu:print"˘";
else
  if col(NewPosX,NewPosY)=nneg then color hneg
  if col(NewPosX,NewPosY)=npos then color hpos
  print right$(str$(num(NewPosX,NewPosY)),1);
end if
OldposX=NewposX
OldposY=NewposY
locate 1,73
color 14:print using"X## Y##";newposx;newposy;
return

WannaSave:
screen 0
cls
color 14
print "-=˛ Elektrische Felder ˛=-"
color 7
print "      Editor geschrieben von RoboCop <RoboCop@EarthCorp.com>"
print
color 15
for x=1 to 50
  for y=1 to 30
    if num(x,y)<>onum(x,y) OR col(x,y)<>ocol(x,y) then ChangedFlag=1:exit for
  next y
  if ChangedFlag=1 then exit for
next x
if ChangedFlag=1 then
  color 12:print"ACHTUNG!! Daten wurden verÑndert. ";
Question:
  color 15:print"énderungen speichern (J/N)? ";
3 a$=inkey$:if a$="" then 3
  if a$="j" or A$="J" then print "J":goto SaveItNow
  if a$="n" or a$="N" then print "N":goto DontSave
  sound 600,1
  goto 3
else
  color 15:print"Es wurde nix verÑndert....beende Programm."
  goto HereUpToQuit
end if

DontSave:
print "Sind Sie sich sicher (J/N)? ";
4 a$=inkey$:if a$="" then 4
  if a$="j" or a$="J" then print "J":goto HereUpToQuit
  if a$="n" or a$="N" then print "N":goto Question
  sound 600,1
  goto 4

SaveItNow:
color 14:print "˛ Speichern"
color 15
print
print "Dateiname (z.B. project6)([ENTER] fÅr ";finame$;"): ";
input "",fi2name$
fi2name$=fi2name$+".elf"
if fi2name$=".elf" then fi2name$=finame$
print "Speichere ... ";
open "B",#1,fi2name$
for x=1 to 50
  for y=1 to 30
    countr=countr+1
    locate csrlin,15:print using"###%";(countr/(50*30))*100;
    if col(x,y)=npos then put$ #1,chr$(num(x,y))
    if col(x,y)=nneg then put$ #1,chr$(256-num(x,y))
    if col(x,y)=nneu then put$ #1,chr$(0)
  next y
next x
print " - OK"
print "Speichere Einstellungen ...";
put$ #1,chr$(0)+"ngeClipboardChain"+chr$(1)+chr$(0)+"¯"
for x=1 to 7
  put$ #1,chr$(0)
next x
put$ #1,chr$(6)+chr$(13)+chr$(4)
for x=1 to 5
  put$ #1,chr$(0)
next x
put$ #1,"ö"+chr$(1)+chr$(1)+chr$(1)+chr$(2)+chr$(0)+">"+chr$(1)+chr$(1)+chr$(1)+chr$(2)+">"+chr$(1)+chr$(1)+chr$(1)+chr$(2)
put$ #1,chr$(0)+chr$(0)+"R"+chr$(10)+"ChangeMenu"+chr$(1)+chr$(0)
put$ #1,chr$(0)+chr$(1)
for x=1 to 6
  put$ #1,chr$(0)
next x
put$ #1,chr$(6)+chr$(13)+chr$(4)
for x=1 to 5
  put$ #1,chr$(0)
next x
put$ #1,"ö"+chr$(1)+chr$(1)+chr$(1)+chr$(5)+chr$(0)+">"+chr$(1)+chr$(1)+chr$(1)+chr$(2)+">"+chr$(1)+chr$(1)+chr$(1)+chr$(2)
put$ #1,"Ó"+chr$(1)+chr$(1)+chr$(1)+chr$(2)+">"+chr$(1)+chr$(1)+chr$(1)+chr$(2)+">"+chr$(1)+chr$(1)+chr$(1)+chr$(2)+chr$(0)
put$ #1,chr$(0)+"R"+chr$(14)+"ChangeSelector"+chr$(1)+chr$(0)+chr$(8)+chr$(1)
for x=1 to 6
  put$ #1,chr$(0)
next x
put$ #1,chr$(6)+chr$(13)+chr$(4)
for x=1 to 5
  put$ #1,chr$(0)
next x
put$ #1,">"+chr$(1)+chr$(1)+chr$(1)+chr$(2)+chr$(0)+">"+chr$(1)+chr$(1)+chr$(1)+chr$(2)+">"+chr$(1)
put$ #1,chr$(1)+chr$(1)+chr$(2)+chr$(0)+chr$(0)+"R"+chr$(14)+"CheckDlgButton"+chr$(1)+chr$(0)+chr$(16)+chr$(1)
for x=1 to 6
  put$ #1,chr$(0)
next x
put$ #1,chr$(6)+chr$(13)+chr$(4)
for x=1 to 9
  put$ #1,chr$(0)
next x
put$ #1,chr$(3)+chr$(0)+">"+chr$(1)+chr$(1)+chr$(1)+chr$(2)+"*"+chr$(1)+chr$(1)+chr$(1)+chr$(2)+">"+chr$(1)+chr$(1)+chr$(1)+chr$(2)
put$ #1,chr$(0)+chr$(0)+"R"+chr$(13)+"CheckMenuItem"+chr$(1)+chr$(0)+chr$(24)+chr$(1)
for x=1 to 6
  put$ #1,chr$(0)
next x
put$ #1,chr$(6)+chr$(13)+chr$(4)+chr$(0)+chr$(0)
close #1
print " OK"
goto HereUpToQuit

FileNotEx:
color 12:print"FEHLER!! Diese Datei existiert nicht!"
color 15
resume EnterFile

SomeError:
color 12:print"FEHLER!! Es ist ein unbekannter Fehler aufgetreten."
color 15:print"Versuchen Sie es mit einer anderen Datendatei."
resume HereUpToQuit

HereUpToQuit:
print
print "Programm beendet."