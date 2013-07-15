$ERROR BOUNDS
	ver$="1.12"
SetColors:
	schwarz=0
	blau=1
	grun=2
	zyan=3
	rot=4
	lila=5
	braun=6
	hgrau=7
	grau=8
	hblau=9
	hgrun=10
	hzyan=11
	hrot=12
	hlila=13
	gelb=14
	weiss=15
	bschwarz=16
	bblau=17
	bgrun=18
	bzyan=19
	brot=20
	blila=21
	bbraun=22
	bhgrau=23
	bgrau=24
	bhblau=25
	bhgrun=26
	bhzyan=27
	bhrot=28
	bhlila=29
	bgelb=30
	bweiss=31
	shell "mode co80"
	cls
	'goto 1
	color hgrun
	print "LIFE v";ver$;" was written by"
	$include"logo.inc"
	color weiss
	print
	print "Simulation einer Bakterienkultur"
	$include "serial.inc"

NotReg:
	resume NotRegisterd

NotRegisterd:
	print
	print "Dieses Programm ist noch nicht registriert!!!"
	print "Sie kînnen nur 3 Generationen sehen und das Programm"
	print "wird eine Standard Bakterienkolonie verwenden!"
	print
	print "Lassen Sie sich unter (03322) 3198 registrieren!"
	delay 10
	usnam$="NIEMANDEN"
	unreg=1
	goto Anfang

Anfang:
	cls
	txt$="LIFE - Bakterienkulturen v"+ver$+", Registriert fÅr <"+usnam$+">"
	locate 24,40-(len(txt$)/2):print txt$;
1    if unreg=0 then goto HoleData
	maxx=5
	maxy=5
	bakt=254
	bcol=15
	nobak=250
	nbcol=7
	birth=254
	bicol=14
	death=254
	dcol=12+16
	dim b(maxx+1,maxy+1)
	dim u(maxx+1,maxy+1)
	dim s(maxx+1,maxy+1)
	dim s2(maxx+1,maxy+1)
	for y=0 to maxy+1
	  for x=0 to maxx+1
	    b(x,y)=0
	    u(x,y)=0
	  next x
	next y

	data "* *  " '1
	data " **  " '2
	data " *   " '3
	data "     " '4
	data "     " '5

	for y=1 to maxy
	  read a$
	  for x=1 to maxx
	    if mid$(a$,x,1)="*" then b(x,y)=1 else b(x,y)=0
	  next x
	next y
AfterHoleData:
	gen=1
	gosub ShowBakt
2	for y=1 to maxy
	  for x=1 to maxx
	    u(x,y)=0
	    if x-1>0 and y-1>0 then u(x,y)=b(x-1,y-1)
	    if y-1>0 then u(x,y)=u(x,y)+b(x,y-1)
	    if y-1>0 then u(x,y)=u(x,y)+b(x+1,y-1)
	    u(x,y)=u(x,y)+b(x+1,y)+b(x+1,y+1)+b(x,y+1)
	    if x-1>0 then u(x,y)=u(x,y)+b(x-1,y+1)+b(x-1,y)
	  next x
	next y
	for y=1 to maxy
	  for x=1 to maxx
	    if b(x,y)<>0 and (u(x,y)<2 or u(x,y)>3) then b(x,y)=3
	    if u(x,y)=3 and b(x,y)=0 then b(x,y)=2
	  next x
	next y
	gen=gen+1
	addx=addx+maxx+1
	if addx>80-maxx then addx=0:addy=addy+maxy+2
	if addy>24-maxy then
	  if dauer=0 then gosub WaitState
	  locate 1,1
	  addx=0
	  addy=0
	end if
	color hgrun
	gosub ShowBakt
	if weiter=1 then goto 2
	if gleich=maxx*maxy then goto Gleichbleibend
	if tod=0 then goto Todesfall
	if puls=maxx*maxy then goto Pulsierend
	if gen=3 and unreg=1 then goto ENDE
	goto 2

Gleichbleibend:
	locate 24,1:print space$(80);
	locate 24,1:color hgrun:print"Die Kultur hat nach";gen-1;"Generation(en) eine konstante Anordnung gefunden!";
	gosub WaitState
	locate 24,1:print space$(80);
	color weiss:locate 24,40-(len(txt$)/2):print txt$;
	weiter=1
	goto 2

Todesfall:
	locate 24,1:print space$(80);
	locate 24,1:color hrot:print"Die Kultur ist nach";gen-1;"Generation(en) ausgestorben!";
	gosub WaitState
	locate 24,1:print space$(80);
	color weiss:locate 24,40-(len(txt$)/2):print txt$;
	weiter=1
	goto 2

Pulsierend:
	locate 24,1:print space$(80);
	locate 24,1:color gelb:print"Die Kultur hat nach";gen-2;"Generation(en) eine pulsierende Anordnung gefunden!";
	gosub WaitState
	locate 24,1:print space$(80);
	color weiss:locate 24,40-(len(txt$)/2):print txt$;
	weiter=1
	goto 2

ShowBakt:
	color hgrun
	locate addy+maxy+1,(addx+(maxx/2))-1
	print using "###";gen;
	for y=1 to maxy
	  for x=1 to maxx
	    color weiss
	    locate y+addy,x+addx
	    if b(x,y)=0 then color nbcol:print chr$(nobak)
	    if b(x,y)=1 then color bcol:print chr$(bakt)
	    if b(x,y)=2 then color bicol:print chr$(birth):b(x,y)=1
	    if b(x,y)=3 then color dcol:print chr$(death):b(x,y)=0
	  next x
	next y
	gleich=0
	tod=0
	puls=0
	for y=1 to maxy
	  for x=1 to maxx
	    if b(x,y)=s(x,y) then gleich=gleich+1
	    if b(x,y)=s2(x,y) then puls=puls+1
	    tod=tod+b(x,y)
	  next x
	next y
	for y=1 to maxy
	  for x=1 to maxx
	    s2(x,y)=s(x,y)
	    s(x,y)=b(x,y)
	  next x
	next y
	if inkey$=chr$(27) then goto ENDE
	return

WaitState:
	waitmsg$="+ - Weiter, D - Dauernd, [ESC] - Andere Datei"
	locate 25,80-len(waitmsg$)
	color bgelb
	print waitmsg$;
3	a$=inkey$: if a$="" then 3
	if a$="+" then locate 25,80-len(waitmsg$):print space$(len(waitmsg$));:return
	if a$="D" or a$="d" then locate 25,80-len(waitmsg$):print space$(len(waitmsg$));:dauer=1:return
	if a$=chr$(27) then locate 25,80-len(waitmsg$):print space$(len(waitmsg$));:run
	sound 2000,.5
	goto 3

HD:
	resume HoleData

NoFileFound:
	color bhrot:print"Keine Datendatei(en) im aktuellen Verzeichnis."
	resume next

HoleData:
	cls
	dim file$(50)
	locate 1,1
	color weiss
	on error goto NoFileFound
	fle$(1)=dir$("*.LIF")
	for x=1 to len(fle$(1))
	  if mid$(fle$(1),x,1)="." then exit for
	  file$(1)=file$(1)+mid$(fle$(1),x,1)
	next x
	for fle=2 to 50
	  fle$(fle)=dir$
	  file$(fle)=""
	  for x=1 to len(fle$(fle))
	    if mid$(fle$(fle),x,1)="" then file$(fle)="":exit for
	    if mid$(fle$(fle),x,1)="." then exit for
	    file$(fle)=file$(fle)+mid$(fle$(fle),x,1)
	  next x
	  if file$(fle)="" then maxfle=fle-1:exit for
	next fle
	x=1
52	color hgrau
	locate 1,3:print using "\      \";file$(x-1)
	color weiss
	locate 1,14:print using "\     \";file$(x)
	color hgrau
	locate 1,25:print using "\     \";file$(x+1)
	if x>1 then locate 1,1:color bgelb:print chr$(27) else locate 1,1:color bhrot:print chr$(26)
	if x<maxfle then locate 1,34:color bgelb:print chr$(26) else locate 1,34:color bhrot:print chr$(27)
	locate 3,1:color weiss:print "Benutzen Sie die Cursortasten zum AuswÑhlen einer Datei!"
	print:print"F1 bringt Sie in den Editor-Modus und [ESC] beendet das Programm."
50	a$=inkey$:if a$="" then 50
	if mid$(a$,2,1)="M" and x<maxfle then x=x+1:goto 52
	if mid$(a$,2,1)="K" and x>1 then x=x-1:goto 52
	if mid$(a$,2,1)=";" then goto EditYaOwn
	if a$=chr$(27) then cls:color 15:end
	if a$=chr$(13) then file$=file$(x)+".LIF":goto 51
	goto 50
51	on error goto HD
	open "I",#1,file$
	on error goto
	input#1,maxx
	input#1,maxy
	input#1,bakt,bcol
	input#1,nobak,nbcol
	input#1,birth,bicol
	input#1,death,dcol
	dim b(maxx+1,maxy+1)
	dim u(maxx+1,maxy+1)
	dim s(maxx+1,maxy+1)
	dim s2(maxx+1,maxy+1)
	for y=0 to maxy+1
	  for x=0 to maxx+1
	    b(x,y)=0
	    u(x,y)=0
	  next x
	next y
	for y=1 to maxy
	  input#1,a$
	  for x=1 to maxx
	    if mid$(a$,x,1)="*" then b(x,y)=1 else b(x,y)=0
	  next x
	next y
	close #1
	cls
	goto AfterHoleData

EditYaOwn:
	cls
	color hrot
	print " Edit-Modus "
	print
	color weiss
	print"Bitte geben Sie die gefragten Daten ein:"
61	locate 4,1:input "Breite (X, 1-80): ",maxx
	if maxx<1 or maxx>80 then 61
62	locate 5,1:input "LÑnge  (Y, 1-23): ",maxy
	if maxy<1 or maxy>23 then 62
	print "Zeichen fÅr Bakterie: ":gax=23:gay=6:gosub HoleASCII
	bakt=asccode
	print "Farbe fÅr Bakterie: ":gax=21:gay=7:gosub HoleCOL
	bcol=colcode
	print "Z. fÅr leeres Feld: ":gax=21:gay=8:gosub HoleASCII
	nobak=asccode
	print "F. fÅr leeres Feld: ":gax=21:gay=9:gosub HoleCOL
	nbcol=colcode
	print "Z. fÅr neue Bakterie: ":gax=23:gay=10:gosub HoleASCII
	birth=asccode
	print "F. fÅr neue Bakterie: ":gax=23:gay=11:gosub HoleCOL
	bicol=colcode
	print "Z. fÅr gestorbende Bakterie: ":gax=30:gay=12:gosub HoleASCII
	death=asccode
	print "F. fÅr gest. Bakterie: ":gax=24:gay=13:gosub HoleCOL
	dcol=colcode
	print
	color hgrun:print"Sind diese Daten richtig (J/N)? ";
69	a$=inkey$:if a$="" then 69
	if a$="j" or a$="J" then print "J":print:goto 39
	if a$="n" or a$="N" then print "N":print:goto EditYaOwn
	goto 69
39	print"Im folgenden kînnen Sie das Feld aufbauen!"
	print"Mit den Cursortasten bewegen Sie den Cursor (_), und"
	print"mit der [SPACE]-Taste kînnen Sie eine Bakterie setzen, bzw. entfernen"
	print"und mit [ESC]ape kînnen Sie das Ganze abspeichern."
	print
	print"Mit Tastendruck geht's weiter..."
79	a$=inkey$:if a$="" then 79
	goto EditField

HoleCOL:
	c=0
	color gelb
	if gay>1 then over=screen(gay-1,gax+5):locate gay-1,gax+5:print chr$(25);
	if gay<24 then under=screen(gay+1,gax+5):locate gay+1,gax+5:print chr$(24);
74	c1=c
	if c=1 then c1=33
	if c=0 then c1=32
	color c1-2:locate gay,gax+3:print "€"
	if c=0 then c3=32 else c3=c
	color c3-1:locate gay,gax+4:print "€"
	color c:locate gay,gax+5:print "€"
	if c=31 then c2=-1 else c2=c
	locate gay,gax+6:color c2+1:print "€"
	c4=c
	if c=30 then c4=-1
	if c=31 then c4=-2
	locate gay,gax+7:color c4+2:print "€"
	locate gay,gax:color gelb:print chr$(27);
	locate gay,gax+10:print chr$(26);
73	a$=inkey$:if a$="" then 73
	if mid$(a$,2,1)="M" and c<31 then c=c+1:goto 74
	if mid$(a$,2,1)="M" and c=31 then c=0:goto 74
	if mid$(a$,2,1)="K" and c>0 then c=c-1:goto 74
	if mid$(a$,2,1)="K" and c=0 then c=31:goto 74
	if a$=chr$(13) then
	  color hgrun
	  if gay>1 then locate gay-1,gax+5:print chr$(25);
	  if gay<24 then locate gay+1,gax+5:print chr$(24);
	  locate gay,gax:print chr$(26)
	  locate gay,gax+10:print chr$(27)
	  for cox=gax to gax+3 step 1
	    locate gay,cox
	    print " ";chr$(26);
	    locate gay,(gax+9)-(cox-gax)
	    print chr$(27);" ";
	    delay .1
	  next cox
	  color weiss
	  if gay>1 then locate gay-1,gax+5:print chr$(over);
	  if gay<24 then locate gay+1,gax+5:print chr$(under);
	  for cox=gax+3 to gax step -1
	    locate gay,cox
	    color hgrun
	    print chr$(26);
	    color c:print "€";
	    color hgrun:print chr$(27);" "
	    delay .25
	  next cox
	  let colcode=c:color weiss
	  return
	end if
	goto 73




HoleASCII:
	x=0
	color gelb
	if gay>1 then over=screen(gay-1,gax+5):locate gay-1,gax+5:print chr$(25);
	if gay<24 then under=screen(gay+1,gax+5):locate gay+1,gax+5:print chr$(24);
64   x1=x
	if x=0 then x1=256
	if x=1 then x1=257
	color grau
	locate gay,gax+3:print using "!";chr$(x1-2)
	if x=0 then x3=256 else x3=x
	color hgrau
	locate gay,gax+4:print using "!";chr$(x3-1)
	color weiss
	locate gay,gax+5:print using "!";chr$(x)
	color hgrau
	if x=255 then x2=-1 else x2=x
	locate gay,gax+6:print using "!";chr$(x2+1)
	color grau
	x4=x
	if x=255 then x4=-1
	if x=254 then x4=-2
	locate gay,gax+7:print using "!";chr$(x4+2)
	locate gay,gax
	color gelb:print chr$(27)
	locate gay,gax+10:print chr$(26)
63	a$=inkey$:if a$="" then 63
	if mid$(a$,2,1)="M" and x<255 then x=x+1:goto 64
	if mid$(a$,2,1)="M" and x=255 then x=0:goto 64
	if mid$(a$,2,1)="K" and x>0 then x=x-1:goto 64
	if mid$(a$,2,1)="K" and x=0 then x=255:goto 64
	if a$=chr$(13) then
	  color hgrun
	  if gay>1 then locate gay-1,gax+5:print chr$(25);
	  if gay<24 then locate gay+1,gax+5:print chr$(24);
	  locate gay,gax:print chr$(26)
	  locate gay,gax+10:print chr$(27)
	  for cox=gax to gax+3 step 1
	    locate gay,cox
	    print " ";chr$(26);
	    locate gay,(gax+9)-(cox-gax)
	    print chr$(27);" ";
	    delay .1
	  next cox
	  if gay>1 then locate gay-1,gax+5:print chr$(over);
	  if gay<24 then locate gay+1,gax+5:print chr$(under);
	  for cox=gax+3 to gax step -1
	    locate gay,cox
	    color hgrun
	    print chr$(26);
	    color weiss
	    print chr$(x);
	    color hgrun
	    print chr$(27);" "
	    delay .25
	  next cox
	  let asccode=x:color weiss
	  return
	end if
	goto 63

EditField:
	dim b(maxx,maxy)
	x=1
	y=1
	cls
91   locate 1,1
	color hgrau
	for cx=1 to maxy
	  for cy=1 to maxx
	    locate cx,cy
	    if b(cy,cx)=0 then print "˙" else print "˛"
	  next cy
	next cx
	locate x,y:color weiss
	if b(y,x)=0 then print "˘"; else print "€";
90	a$=inkey$:if a$="" then 90
	if mid$(a$,2,1)="H" and x>1 then x2=x:x=x-1:goto 91
	if mid$(a$,2,1)="P" and x<maxx then x2=x:x=x+1:goto 91
	if mid$(a$,2,1)="K" and y>1 then y2=y:y=y-1:goto 91
	if mid$(a$,2,1)="M" and y<maxy then y2=y:y=y+1:goto 91
	if (a$=" " or a$=chr$(13)) and b(y,x)=0 then b(y,x)=1:goto 91
	if (a$=" " or a$=chr$(13)) and b(y,x)=1 then b(y,x)=0:goto 91
	if a$=chr$(27) then goto SaveData
	goto 90

SaveData:
	cls
	color hrot:print " Edit-Modus "
	color weiss
	print
	print"Bitte Dateinamen (max. 8 Zeichen) ohne Erweiterung eingeben, unter"
	print"dem das erstellte Gebilde gespeichert werden soll:"
100	input"Dateiname: ",file$
	file$=file$+".LIF"
	on error goto IOFE
	open "O",#2,file$
	on error goto
	print
	color hgrun:print "Die Daten werden gesichert ... ";
	write#2,maxx
	write#2,maxy
	write#2,bakt,bcol
	write#2,nobak,nbcol
	write#2,birth,bicol
	write#2,death,dcol
	for y=1 to maxy
	  writ$=""
	  for x=1 to maxx
	    if b(x,y)=1 then writ$=writ$+"*" else writ$=writ$+" "
	  next x
	  write#2,writ$
	next y
	print#2,chr$(26)
	print#2,"LIFE-DAT-File created by LIFE.EXE"
	print#2,"Copyright of LIFE.EXE (C)1995-96 by RoboCop INDUSTRIES"
	close #2
	print "OK"
	cls
	run

IOFE:
	resume 100

ENDE:
	rem Hier ist Schlu·!
	locate 24,1:print space$(80);
	locate 24,1:end