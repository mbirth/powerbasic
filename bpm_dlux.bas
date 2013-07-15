cls:screen 12
BPMTime=5
'open "O",#1,"KLATSCH.RAW"
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
OuterString$="Scanne Eingangssignal...":OuterCol=15
OS=1
on timer(BPMTime) GOSUB CalcBPM
locate 1,1
color 10:print"SoundBlaster an Adresse ";hex$(SbPort);"h gefunden."
color 15:locate 1,1:print"                                                   "
DO
'######
' if ScrollIt/30=int(ScrollIt/30) then ScrollIt=ScrollIt+1 else ScrollIt=ScrollIt+1:goto SkipText
' OuterS$=SPACE$(40)+OuterString$
' Outer$=mid$(OuterS$,OS,40)
' locate 30,20:color OuterCol:print using"\                                     \";Outer$;
' OS=OS+1
' if len(Outer$)<=0 then OS=1
'######

SkipText:
  OUT SbPort + &HC, &H20
  DO:LOOP UNTIL INP(SbPort + &HE) AND 128
  strecke=strecke+1
  if strecke>639 then strecke=1
  value=(256-125+(inp(sbport+&HA)-125))/256*465
'######
' if int(value)=245 and OS<=1 then OuterCol=12:OuterString$="Kein Signal!"
' if int(value)<>245 and OS<=1 then OuterCol=15:OuterString$="Scanne Eingangssignal..."
'######
'  pset (strecke,check(strecke)),0
  if value>190 or value<290 then col=10
  if (value>155 and value<190) or (value >290 and value <325) then col=14
  if value<155 or value>325 then col=12
'  col=15
  ls=strecke+1
'                  Ú468 bzw. 480
  line (ls,12)-(ls,474),0
  pset (olds,oldv),0	'Diese Zeile sollte ungeREMt bleiben
  if maxvalue=oldmax and refresha>=100 then refresha=0:locate 1,58:print"         "; else refresha=refresha+1
  if maxvalue<>oldmax then locate 1,9:color 14:print using "Max: ###.#  Min: ###.#";maxvalue;maxvalue-(maxvalue/FaktMax);:locate 1,58:color 14:print"ðADJUSTð";
  if oldlm<>lockmax then
    locate 1,68:color 14
    if lockmax=1 then print "-=ðLOCKEDð=-"; else print "            ";
  end if
  if beats<>oldbeats then NoNew=0 else NoNew=NoNew+1
  oldmax=maxvalue		'alles mit einem 'max' in der Variablen geh”rt zur Maxerkennung
  oldbeats=beats
  if NoNew>=750 and lockmax=0 then nmaxvalue=value
  if strecke=1 then pset(0,240),0
  line -(strecke,value),col	'Wer aus 'line -' ein 'pset ' macht, und alle anderen REMs entfernt, hat auch einen coolen FX
  if lockmax=0 and nmaxvalue=maxvalue then nmaxvalue=max(Maxvalue,abs(value))
  if nmaxvalue<maxvalue then maxvalue=maxvalue-1
  if nmaxvalue>maxvalue then maxvalue=maxvalue+1
  if abs(nmaxvalue-maxvalue)<1 then maxvalue=nmaxvalue
'######
'  if maxvalue<>oldmc then
'    line (oldmc,475)-(oldmc,480),0
'    oldmc=maxvalue
'    line (maxvalue,475)-(maxvalue,480),15
'  end if
'######
  if beat>0 then beat=beat-1:goto SkipIT
  FaktMax=7
  if value>=maxvalue-(maxvalue/FaktMax) then
    color 12
    locate 1,1
    diff=value-(maxvalue-(maxvalue/FaktMax))
    BeatStage=0
    Fakt1=60
    Fakt2=90
    Fakt3=100
    if diff>=0 and diff<=(MAXDIFF/100)*Fakt1 then BeatStage=1
    if diff>(MAXDIFF/100)*Fakt1 and diff<=(maxdiff/100)*Fakt2 then BeatStage=2
    if diff>(maxdiff/100)*Fakt2 and diff<=(maxdiff/100)*Fakt3 then BeatStage=3
    if beats/2=int(beats/2) and BeatStage=1 then print"ÜBEATÜ";
    if beats/2<>int(beats/2) and BeatStage=1 then print"ßBEATß";
    if beats/2=int(beats/2) and BeatStage=2 then print"ÞBEATÝ";
    if beats/2<>int(beats/2) and BeatStage=2 then print"ÝBEATÞ";
    if BeatStage=3 then print"ÛÛÛÛÛÛ";
    maxdiff=max(maxdiff,diff)
    beats=beats+1
    beat=50
  else
    locate 1,1
    print"      ";
  end if

SkipIT:
  olds=strecke		'Wenn man die beiden oldx's REMt erh„lt man einen recht
  oldv=value		'lustigen Effekt!!!
  delay del
  check(strecke)=value
  oldlm=lockmax
  lpress=0
  a$=inkey$
  if a$=" " then nmaxvalue=value
  if a$="+" then nmaxvalue=maxvalue+1
  if a$="-" then nmaxvalue=maxvalue-1
  if a$="*" then nmaxvalue=maxvalue+10
  if a$="/" then nmaxvalue=maxvalue-10
  if (a$="l" or a$="L") and lockmax=0 and lpress=0 then lockmax=1:lpress=1 else lpress=0
  if (a$="l" or a$="L") and lockmax=1 and lpress=0 then lockmax=0:lpress=1 else lpress=0
LOOP UNTIL a$=chr$(27)
Goto Ende

CalcBPM:
	BPS=Beats/BPMTime
	Beats=0
	BPM=BPS*60
	color 10
	locate 1,33:print using"BPS: ##.##  BPM: ###.##  ";bps;bpm;
	return

Ende:
screen 0:width 80
print"Programm beendet."
