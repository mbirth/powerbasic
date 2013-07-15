$COMPILE EXE
	on error goto 4
	comm$=command$
	msg$="Befehl oder Dateiname nicht gefunden                                           "+chr$(13)
	wdi$="Ungltiges Verzeichnis                                                         "+chr$(13)
	x=1
1	x$=mid$(comm$,x,1)
	if x$=chr$(32) or x$="" then x=x+1:goto 2
	c1$=c1$+x$
	x=x+1
	goto 1
2	x$=mid$(comm$,x,1)
	if x$=chr$(32) or x$="" then x=x+1:goto 3
	c2$=c2$+x$
	x=x+1
	goto 2
3	if c1$="" then goto Syntax
	pass$=c1$
	if c2$="" then LogIt=0 else LogIt=1:file$=c2$
	if LogIt=1 then open "A",#1,file$
	if LogIt=1 then print#1,""
	if LogIt=1 then print#1,"ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ"
	if LogIt=1 then print#1,"ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²²²²²²²²²±±±±±±±±±±±±±±±±±±±±²²²²²²²²ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
	if LogIt=1 then print#1,"ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²²±±±±±±±±±°°°°°°°°°°°°°°°°°°±±±±±±±±²²ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
	if LogIt=1 then print#1,"ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²²±±°°°°°°°°° CSAFE-LOG-FILE °°°°°°°°±±²²ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
	if LogIt=1 then print#1,"ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²²±±°° (C)1995 by RoboCop INDUSTRIES °°±±²²ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
	if LogIt=1 then print#1,"ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²²±±°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°±±²²ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
	if LogIt=1 then print#1,"ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²²±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±²²ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
	if LogIt=1 then print#1,"ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß"
	if LogIt=1 then print#1,"Datum: ";date$;"    Uhrzeit: ";time$;"    Passwort: ";pass$
	if LogIt=1 then print#1,""
	if LogIt=1 then print#1,"Datum      Uhrzeit  Eingabe                                           getan?"
	if LogIt=1 then print#1,"ğğğğğğğğğğ ğğğğğğğğ ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ ğğğğğğ"
	color 7
4	print curdir$;:input ">",eingabe$(1),eingabe$(2),eingabe$(3),eingabe$(4),eingabe$(5),eingabe$(6)
	if eingabe$(6)<>"" then eingabe$=eingabe$(1)+","+eingabe$(2)+","+eingabe$(3)+","+eingabe$(4)+","+eingabe$(5)+","+eingabe$(6):goto 5
	if eingabe$(5)<>"" then eingabe$=eingabe$(1)+","+eingabe$(2)+","+eingabe$(3)+","+eingabe$(4)+","+eingabe$(5):goto 5
	if eingabe$(4)<>"" then eingabe$=eingabe$(1)+","+eingabe$(2)+","+eingabe$(3)+","+eingabe$(4):goto 5
	if eingabe$(3)<>"" then eingabe$=eingabe$(1)+","+eingabe$(2)+","+eingabe$(3):goto 5
	if eingabe$(2)<>"" then eingabe$=eingabe$(1)+","+eingabe$(2):goto 5
	if eingabe$(1)<>"" then eingabe$=eingabe$(1):goto 5
5	if eingabe$=pass$ then goto OKEnde
	if lcase$(eingabe$)="cls" then goto ClearScreen
	if LogIt=1 then stat$="NEIN":gosub WriteLog
	print msg$
	goto 4

ClearScreen:
	if LogIt=1 then stat$="JA":gosub WriteLog
	cls
	goto 4

WriteLog:
	if len(eingabe$)>49 then eingabe$=left$(eingabe$,46)+"..."
	if LogIt=1 then print#1,using "\        \ \      \ \                                               \ \    \";date$;time$;eingabe$;stat$
	return

Syntax:
	color 10:print"-=ğ CSAFE v2.00 ğ=-":color 15
	print
	print"Syntax: ";:color 14:?"CSAFE Passwort [Log-Datei]":color 7
	print
	print"ùPasswort  - Das Passwort, das eingegeben werden muá"
	print"ùLog-Datei - Die Datei, in die die Eingaben geschrieben werden sollen"
	print:color 12
	print"(C)1995 by Markus Birth":color 7
	goto Ende

OKEnde:
	stat$="ENDE"
	if LogIt=1 then gosub WriteLog
	print"Befehl oder Dateiname nicht gefunden"
	goto Ende

Ende:
