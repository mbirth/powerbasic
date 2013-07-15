cls:screen 12
'open "O",#1,"KLATSCH.RAW"
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
locate 1,1
color 10:print"SoundBlaster an Adresse ";hex$(SbPort);"h gefunden."
color 15:print
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
'  col=15        'ÚÄ y1
  if minus=0 then ls=strecke+1 else ls=strecke-1
  line (ls,0)-(ls,480),0		'Wer mit der MAX-Anzeige arbeitet sollte y1 auf 13 setzen
'  pset (veryolds,veryoldv),8
  pset (olds,oldv),7	'Diese Zeile sollte ungeREMt bleiben
'  if maxvalue<>oldmax then locate 1,1:color 15:print "Max:";maxvalue
'  oldmax=maxvalue		'alles mit einem 'max' in der Variablen geh”rt zur Maxerkennung
  if strecke=1 then pset(0,240),0
  line -(strecke,value),col	'Wer aus 'line -' ein 'pset ' macht, und alle anderen REMs entfernt, hat auch einen coolen FX
'  maxvalue=max(Maxvalue,abs(value))
'  veryolds=olds
'  veryoldv=oldv
  olds=strecke		'Wenn man die beiden oldx's REMt erh„lt man einen recht
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