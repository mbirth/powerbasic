cls
open "O",#1,"GRFTEST3.OUT"
print#1,"OUTPUT-Datei von GRFTEST3.BAS"
print#1,""
print#1,"Die Datei hat folgendes Format:"
print#1,"X  : Zufalls X-Koordinate"
print#1,"Y  : Zufalls Y-Koordinate"
print#1,"0/1: X,Y schon belegt NEIN/JA"
print#1,"#  : Nummer der schon belegten Pixel (640x480)"
print#1,""
open "O",#2,"GRFTEST3.OU2"
print#2,"OUTPUT-Datei von GRFTEST3.BAS"
print#2,""
print#2,"Die Datei hat folgendes Format:"
print#2,"0/1: Pixel schon belegt NEIN/JA"
print#2,""
dim o(640)
dim p(480)
screen 12
locate 1,1
1 x1=int(rnd(1)*640)
x2=int(rnd(1)*640)
y1=int(rnd(1)*480)
y2=int(rnd(1)*480)
far=int(rnd(1)*256)
line (x1,y1)-(x2,y2),far,BF
if inkey$=" " then 2
goto 1

2 REM Fucking Hostile is back
for g=1 to 640*480
randomize timer
5 x=int(rnd(1)*640)
y=int(rnd(1)*480)
if inkey$=chr$(27) then end
if o(x)=255 and p(y)=255 and o(x+1)=255 and p(y+1)=255 then
  locate 30,1:print using "X ###   Y ###   0/1:#   _#######/307200";x;y;0;g;
  print#1,using"X ###   Y ###   0/1:#   _#######/307200";x;y;0;g
  print#2,"0";
  goto 5
else
  line (x,y)-(x+1,y+1),0,BF:o(x)=255:p(y)=255:o(x+1)=255:p(y+1)=255
  locate 30,1:print using "X ###   Y ###   0/1:#   _#######/307200";x;y;1;g;
  print#1,using "X ###   Y ###   0/1:#   _#######/307200";x;y;1;g
  print#2,"1";
end if
next g
