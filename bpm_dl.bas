cls:screen 12
BPMTime=3
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
on timer(BPMTime) GOSUB CalcBPM
locate 1,1
color 10:print"SoundBlaster an Adresse ";hex$(SbPort);"h gefunden."
color 15:locate 1,1:print"                                                   "
DO
  OUT SbPort + &HC, &H20
  DO:LOOP UNTIL INP(SbPort + &HE) AND 128
  'locate 2,1:print Wert;"/";inp(sbport+&HA)
  'gosub ShowLEV
  if minus=0 then strecke=strecke+1
  if minus=1 then strecke=strecke-1
  if strecke>639 then minus=1
  if strecke<1 then minus=0
  value=(256-125+(inp(sbport+&HA)-125))/256*480
  'locate 2,1:print value;
  pset (strecke,check(strecke)),0
  if value>190 or value<290 then col=10
  if (value>155 and value<190) or (value >290 and value <325) then col=14
  if value<155 or value>325 then col=12
  col=15
  if minus=0 then ls=strecke+1 else ls=strecke-1
'          ⁄ƒ y1
  line (ls,13)-(ls,480),0		'Wer mit der MAX-Anzeige arbeitet sollte y1 auf 13 setzen
  pset (veryolds,veryoldv),8
  pset (olds,oldv),7	'Diese Zeile sollte ungeREMt bleiben
  if maxvalue<>oldmax then locate 1,8:color 14:print using "Max: ###.#";maxvalue
  if beats<>oldbeats then NoNew=0 else NoNew=NoNew+1
  oldbeats=beats
  oldmax=maxvalue		'alles mit einem 'max' in der Variablen gehîrt zur Maxerkennung
  if NoNew>=750 then maxvalue=value
  if strecke=1 then pset(0,240),0
  pset (strecke,value),col	'Wer aus 'line -' ein 'pset ' macht, und alle anderen REMs entfernt, hat auch einen coolen FX
'  line (strecke,1)-(strecke,5),12
  line (strecke,479)-(strecke,475),12
  if minus=0 then ps=strecke-1 else ps=strecke+1
'  line (ps,1)-(ps,5),4
  line (ps,479)-(ps,475),4
  if minus=0 then ps2=ps-1 else ps2=ps+1
'  line (ps2,2)-(ps2,5),0
  line (ps2,478)-(ps2,475),0
  maxvalue=max(Maxvalue,abs(value))
  if beat>0 then beat=beat-1:goto SkipIT
  FaktMax=7
  if value>=maxvalue-(maxvalue/FaktMax) then
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
    beat=50
  else
    locate 1,1
    print"      ";
  end if
SkipIT:
  veryolds=olds
  veryoldv=oldv
  olds=strecke		'Wenn man die beiden oldx's REMt erhÑlt man einen recht
  oldv=value		'lustigen Effekt!!!
  delay del
  check(strecke)=value
  'print#1,chr$(inp(sbport+&HA));
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
	Beats=0
	BPM=BPS*60
	color 10
	locate 1,20:print using"BPS: ###.##   BPM: ####.##";bps;bpm;
	return

ShowLEV:
y=3
Zeichen=176
Einheit=256/80
Wert=inp(sbport+&HA)
Einheiten=round(Wert/Einheit,0)
for x=1 to 80
  locate y,x:if x<=Einheiten then
			if x>=0 and x<=45 then color 10
			if x>45 and x<=70 then color 14
			if x>70 and x<=80 then color 12
		   else
			if x>=0 and x<=45 then color 2
			if x>45 and x<=70 then color 6
			if x>70 and x<=80 then color 4
		   end if
  print chr$(Zeichen);
  locate y+1,x
  print chr$(Zeichen);
next x
return

Ende:
screen 0:width 80
print"Programm beendet."
