	ON ERROR GOTO FEHL
	color 15
	print"Dark Forces Voice Name Changer (DFVNC) v1.00"
	print"                               written by RoboCop INDUSTRIES"
	color 7
	PARA$=COMMAND$
	IF PARA$="+4933223198 NUM2NAM" THEN GOTO NumbersToNames
	IF PARA$="+4933223198 NAM2NUM" THEN GOTO NamesToNumbers
	GOTO Syntax
FEHL:
	print
	print"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	print"!!            WARNUNG            !!"
	print"!! Ein  Fehler  ist  aufgetreten !!"
	print"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	goto GanzEnde

NumbersToNames:
	print"Gew„hlte Funktion: ";:color 14:print"Nummer ==> Name"
	color 7
	OPEN "I",#1,"NAMES.LST"
	OPEN "O",#2,"DFVNC.LOG"
	on error goto FEHLER
	PRINT#2,"þ LOG-Datei vom Dark Forces Voice Name Changer v1.00"
	print#2,"þ von RoboCop INDUSTRIES"
	print#2,"þ"
	print#2,"þ Gew„hlte Funktion: NUM2NAM"
	print#2,"---------------------------------------------------"
	X=1
1	line input#1,FIL$
	x$=mid$(str$(x),2,20)+".VOC"
	print"Benenne ";x$;" in ";FIL$;" um ... ";
	print#2,X$;" ===> ";FIL$;" ... ";
	name x$ as fil$
	print "OK"
	print#2,"OK"
	x=x+1
	if eof(1) then
	  print#2,"þ <EOLF - End Of List File >"
	  goto Ende
	end if
	goto 1

NamesToNumbers:
	print"Gew„hlte Funktion: ";:color 14:print"Name ==> Nummer"
	color 7
	OPEN "I",#1,"NAMES.LST"
	OPEN "O",#2,"DFVNC.LOG"
	ON ERROR GOTO FEHLER
	PRINT#2,"þ LOG-Datei vom Dark Forces Voice Name Changer v1.00"
	print#2,"þ von RoboCop INDUSTRIES"
	print#2,"þ"
	print#2,"þ Gew„hlte Funktion: NAM2NUM"
	print#2,"---------------------------------------------------"
	X=1
2	line input#1,FIL$
	x$=MID$(str$(x),2,20)+".VOC"
	print"Benenne ";FIL$;" in ";X$;" um ... ";
	print#2,FIL$;" ===> ";X$;" ... ";
	name fil$ as x$
	print "OK"
	print#2,"OK"
	x=x+1
	if eof(1) then
	  print#2,"þ <EOLF - End Of List File >"
	  goto Ende
	end if
	goto 2

FEHLER:
	print#2,""
	print#2,"==================================================="
	PRINT#2,"                   !!!WARNUNG!!!"
	print#2,"Ein unbekannter Fehler ist  aufgetreten! Vielleicht"
	print#2,"haben Sie die FALSCHE FUNKTION gew„hlt. Wenn es das"
	print#2,"nicht  war, k”nnen  wir  Ihnen  auch  nicht helfen."
	print#2,"==================================================="
	color 12
	print
	print"==================================================="
	PRINT"                   !!!WARNUNG!!!"
	print"Ein unbekannter Fehler ist  aufgetreten! Vielleicht"
	print"haben Sie die FALSCHE FUNKTION gew„hlt. Wenn es das"
	print"nicht  war, k”nnen  wir  Ihnen  auch  nicht helfen."
	print"==================================================="
	color 7
	goto GanzEnde

	Syntax:
	print
	print"Syntax: DFVNC [Serialnummer] [Funktion]
	print
	print"        Serialnummer - Ihre Serialnummer"
	print"        Funktion     - gewnschte Funktion:"
	print"                       NUM2NAM - Nummern zu Namen"
	print"                                 (z.B.: 1.VOC => DOOR2-1.VOC, ...)"
	print"                       NAM2NUM - Namen zu Nummern"
	print"                                 (z.B.: DOOR2-2.VOC => 2.VOC, ...)"
	print
	goto GanzEnde

Ende:
	print#2,"þ Programm beendet."

GanzEnde:
