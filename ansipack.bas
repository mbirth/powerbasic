	cls
	maxzei=50
	maxwert=100
	$include "logo.inc"
	color 15:print"ððð ANSI-PACKer ððð v";ver$;" by RoboCop INDUSTRIES"
	print
	print"Dieses Programm sucht in ANSI-Dateien (meiát mit .ANS Endung) nach"
	print"doppelten Deklarationen. (z.B.: 0;36m°0;37m± ==> 0;36m°37m±)!"

TryAgain:
	print
	color 14
	input"Dateiname (mit Endung): ",fil$
	if fil$="" then goto ENDE
	on error goto WheresTheFile
	open "I",#1,fil$
	close #1
	on error goto
	outfil$=""
	for x=1 to len(fil$)
	  if mid$(fil$,x,1)="." then exit for
	  outfil$=outfil$+mid$(fil$,x,1)
	next x
	if len(outfil$)<8 then outfil$=outfil$+"2.ANS" else outfil$=left$(outfil$,7)+"2.ANS"
	print"Ausgabedatei          : ";outfil$
	color 10:print"[G]ut so!                   ";
	color 12:print"[Ž]ndern!?":color 14
1	a$=inkey$:if a$="" then 1
	if a$="g" or a$="G" then goto 2
	if a$="„" or a$="Ž" then goto 3
	goto 1

WheresTheFile:
	print
	color 28:print"Datei nicht gefunden!!!"
	color 12:print"šberprfen Sie den Dateinamen auf Richtigkeit!"
	delay 5
	resume TryAgain

3	print
	input"Ausgabedatei (mit Endung): ",outfil$
	goto 2
2    color 15
	print
	print"DIMensioniere Variablen auf";maxzei;"Zeilen ... ";
	dim zeile$(maxzei)
	dim wert$(maxwert,10)
	print"Variablen dimensioniert"
	print"™ffne Eingabedatei ... ";
	open "I",#1,fil$
	print"Datei ge”ffnet"
	print"™ffne Ausgabedatei ... ";
	open "O",#2,outfil$
	print"Datei ge”ffnet"
	anzw=0
	print"Lese Eingabedatei ein ...";
	x=1
4	line input#1,zeile$(x)
	if eof(1) then zeilen=x else x=x+1:goto 4
	print zeilen;"Zeilen eingelesen"
	print "Lese Werte ein ...";
	for zei=1 to zeilen
	  for xpos=1 to len(zeile$(zei))
	    x$=mid$(zeile$(zei),xpos,1)
	    if vlue=1 then value$=value$+x$
	    if x$="m" then vlue=0:y=y+1:gosub ScrambleIt
	    if x$="[" then vlue=1
	  next xpos
	next zei
	maxw=y
	print anzw;"Werte in";y;"Wertegruppen gelesen"







	goto ENDE

ScrambleIt:
	z=1
	x=1
10	if mid$(value$,x,1)=";" then anzw=anzw+1:z=z+1:x=x+1:if x=len(value$) then value$="":return else goto 10
	wert$(y,z)=wert$(y,z)+mid$(value$,x,1)
	x=x+1:if x=len(value$) then value$="":return else goto 10










ENDE:
	print
	print"Fahre Programm herunter ... ";
	close #1
	close #2
	print"Programm heruntergefahren."
	print
	end