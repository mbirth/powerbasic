cls
BPMTime=5
on timer(BPMTime) GOSUB CalcBPM
color 15
print"-= Beats Per Minute =-"
print"  by RoboCop INDUSTRIES"
print
print" [1] - Automatik (nicht sicher)"
print" [2] - Manuelle Eingabe (";BPMTime;"sek. lang [  0  ] im Takt drÅcken)"
print
print" [3] - Beenden!"
print
print"DrÅcken Sie die gewÅnschte Taste"
1 a$=inkey$:if a$="" then 1
if a$="1" or a$="!" then goto Automatic
if a$="2" or a$=chr$(34) then goto Manuell
if a$="3" then cls:goto Ende
goto 1

Manuell:
cls
print"-= Beats Per Minute =-"
print"    Manuelle Eingabe"
print
print"DrÅcken Sie jetzt immer im Takt die 0-Taste auf dem Numerischen"
print"Tastenfeld. Ab dem ersten Tastendruck beginnt die ZÑhlerei";BPMTime;"sek."
print"lang."
2 a$=inkey$
if a$="0" then locate 1,1:print"                          ":timer on:beats=1:goto 3
goto 2
3 a$=inkey$
if beat=0  then locate 1,1:print" BEAT "; else beat=beat-1
if BPS<>0 then goto WaitItAb
if a$="0" then locate 1,1:color 12:print"€BEAT€";:beat=1000:beats=beats+1
goto 3

WaitItAb:
cls
timer off
color 15
print using"Beats: #####";oldbeats
print using"BPS:  ###.##";bps
print using"BPM: ####.##";bpm
print
print"Ende mit Tastendruck!"
4 a$=inkey$:if a$="" or a$="0" then 4 else Ende

Automatic:
timer on
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
cls
locate 1,1
color 10:print"SoundBlaster an Adresse ";hex$(SbPort);"h gefunden."
color 15:locate 1,1:print"                                                   "
DO
  OUT SbPort + &HC, &H20
  DO:LOOP UNTIL INP(SbPort + &HE) AND 128
  value=(256-125+(inp(sbport+&HA)-125))/256*480
  locate 2,1
  color 15
  print using "Aussteuerung: ###.##";value
  if maxvalue<>oldmax then locate 1,8:color 14:print using "Max: ###.#";maxvalue
  if beats=oldbeats then NoNew=NoNew+1 else NowNew=0
  oldbeats=beats
  if NoNew=20 then maxvalue=abs(value)
  oldmax=maxvalue
  maxvalue=max(Maxvalue,abs(value))
  if beat>0 then beat=beat-1:goto SkipIT
  FaktMax=20
  if value>maxvalue-(maxvalue/FaktMax) then
    color 12
    locate 1,1
    diff=value-(maxvalue-(maxvalue/FaktMax))
    BeatStage=0
    Fakt1=50
    Fakt2=80
    Fakt3=100
    if diff>=0 and diff<=(MAXDIFF/100)*Fakt1 then BeatStage=1
    if diff>(MAXDIFF/100)*Fakt1 and diff<=(maxdiff/100)*Fakt2 then BeatStage=2
    if diff>(maxdiff/100)*Fakt2 and diff<=(maxdiff/100)*Fakt3 then BeatStage=3
    if beats/2=int(beats/2) and BeatStage=1 then print"ﬂBEAT‹";
    if beats/2<>int(beats/2) and BeatStage=1 then print"‹BEATﬂ";
    if beats/2=int(beats/2) and BeatStage=2 then print"ﬁBEAT›";
    if beats/2<>int(beats/2) and BeatStage=2 then print"›BEATﬁ";
    if BeatStage=3 then print"€€€€€€";
    maxdiff=max(maxdiff,diff)
    beats=beats+1
    beat=200
  else
    locate 1,1
    print"      ";
  end if

SkipIT:
  a$=inkey$
  if a$="+" then del=del+.01
  if a$="-" then del=del-.01:if del<0 then del=0
  if a$="*" then del=del+.1
  if a$="/" then del=del-.1:if del<0 then del=0
  if a$="0" then del=0
  if a$="1" then del=1
LOOP UNTIL a$=chr$(27)
Goto Ende

CalcBPM:
	BPS=Beats/BPMTime
	oldbeats=beats
	Beats=0
	BPM=BPS*60
	color 10
	locate 1,20:print using"BPS: ###.##   BPM: ####.##";bps;bpm;
	return

Ende:
print"Programm beendet."
