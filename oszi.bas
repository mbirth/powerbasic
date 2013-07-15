cls:screen 12
maxh=320
maxv=240
dim check(640)
FOR SbPort = &H210 to &H280 STEP &H10
  OUT SbPort + &H6, 1
  FOR a = 1 to 10:next
  OUT SbPort + &H6, 0
  FOR a = 1 to 100
    IF INP(SbPort + &HA) = &HAA THEN GOTO SbFound
  NEXT
NEXT
PRINT "kein SoundBlaster => Ende..."
END

SbFound:
Strecke=640-maxh-(maxh/2)
pset (strecke,240),0
locate 1,1
color 10:print"SoundBlaster an Adresse ";hex$(SbPort);"h gefunden."
locate 30,1:print "+/- Breite   Bi";chr$(24);"/Bi";chr$(25);" beides   L/S Fenster speichern/laden   *// H”he";
DO

SkipText:
  ANFx=640/2-maxh/2
  ANFy=480/2-maxv/2
  if maxh<>oldmaxh or maxv<>oldmaxv then gosub PaintWindow
  oldmaxh=maxh
  oldmaxv=maxv
  OUT SbPort + &HC, &H20
  DO:LOOP UNTIL INP(SbPort + &HE) AND 128
  strecke=strecke+1
  if strecke>maxh+ANFx then strecke=ANFx
  value=(256-125+(inp(sbport+&HA)-125))/256*maxv
  value=value+ANFy
  pset (strecke,check(strecke)),0
  pset (strecke,value),15
  check(strecke)=value
  a$=inkey$
  if a$="+" then maxh=maxh+2
  if a$="-" then maxh=maxh-2
  if a$="*" then maxv=maxv+2
  if a$="/" then maxv=maxv-2
  if mid$(a$,2,1)="I" then maxh=maxh+2:maxv=maxv+2
  if mid$(a$,2,1)="Q" then maxh=maxh-2:maxv=maxv-2
  if a$="s" or a$="S" then gosub SaveWindow
  if a$="l" or a$="L" then gosub LoadWindow
LOOP UNTIL a$=chr$(27)
Goto Ende

SaveWindow:
open "O",#1,"OSZI.WIN"
write#1,maxh,maxv
close #1
return

LoadWindow:
open "I",#1,"OSZI.WIN"
input#1,maxh,maxv
close #1
return

PaintWindow:
ANF2x=640/2-oldmaxh/2
ANF2y=480/2-oldmaxv/2
line (ANF2x-4,ANF2y-4)-(ANF2x+oldmaxh+4,ANF2y+oldmaxv+4),0,BF
line (ANFx-1,ANFy)-(ANFx+maxh+1,ANFy+maxv+2),9,B
return


Ende:
screen 0:width 80
print"Programm beendet."
