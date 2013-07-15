$COMPILE EXE
REM Printing Calculator
REM Selbsttest
	color 15,0:print"ğğğğ Printing Calculator ğğğğ";:color 7,0
	print"    was written by"
	print"ÜÜÜÜ   ÜÜÜ  ÜÜÜÜ   ÜÜÜ       ÜÜÜÜ  ÜÜÜ  ÜÜÜÜ"
	print"Û   Û Û   Û  Û  Û Û   Û     Û     Û   Û Û   Û"
	print"ÛßÛß  Û   Û  ÛßßÜ Û   Û     Û     Û   Û Ûßßß"
	print"Û  Û  Û   Û  Û  Û Û   Û     Û     Û   Û Û"
	print"ß   ß  ßßß  ßßßß   ßßß       ßßßß  ßßß  ß"
	print"I    N    D    U    S    T    R    I    E   S"
	print
	print"Teste PCALC.EXE auf Viren. Dieser Test kann bis zu 30sek dauern!"
	print
	print"Test auf Viren l„uft...";
	gosub CheckFile
	goto Start  'if sum=1744 then print"OK":goto Start
	   print"fehlgeschlagen"
	   color 14:print
	   print"Irgendetwas stimmt mit der Datei PCALC.EXE nicht!"
	   print"šberprfen Sie folgende Sachverhalte:"
	   print"  ş Haben Sie sie nicht ver„ndert?"
	   print"  ş Haben Sie sie nicht umbenannt (Diese Datei MUá PCALC.EXE heissen)?"
	   print"  ş Haben Sie vielleicht einen Virus in Ihrem System?"
	   print
	   print"Wenn keiner dieser Sachverhalte zutrifft, dann fordern Sie eine"
	   print"neue PCALC.EXE bei Ihrer Bezugsquelle an!"
	   end
Start:
REM Aufbau des Tastenfeldes
	print"Aufbau der Textgrafik..."
	screen ,,1
	mstat$=" "
	tb=0
	color 15,0
	shell"loadfont <pcalc.fnt"
	locate 3,40:print"ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
	locate 4,40:print"³à 88888888888.³"
	locate 5,40:print"ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
	locate 8,43:print"ÚÄÄÄÄÄ¿ ÚÄÄÄÄÄ¿ ÚÄÄÄÄÄ¿"
	locate 9,43:print"ÀÄÄÄÄÄÙ ÀÄÄÄÄÄÙ ÀÄÄÄÄÄÙ"
	locate 7,43:print"  TAB    P/ NP    OFF"
	color 3
	for x=11 to 20 step 3
	locate x,60:print"ÚÄÄÄ¿"
	locate x+2,60:print"ÀÄÄÄÙ"
	if x>=17 then color 12
	if x<17 then color 7
	locate x,26:print"ÚÄÄÄ¿"
	locate x+2,26:print"ÀÄÄÄÙ"
	color 3
	next x
	locate 12,60:print"³ Mæ³"
	locate 15,60:print"³ Mç³"
	locate 18,60:print"³ Mè³"
	locate 21,60:print"³ M*³"
	color 7
	locate 12,26:print"³ é ³"
	locate 15,26:print"³ % ³"
	color 12
	locate 18,26:print"³ CE³"
	locate 21,26:print"³ONC³"
	color 7
	locate 20,32:print"ÚÄÄÄÄ¿"
	locate 21,32:print"³  0 ³"
	locate 22,32:print"ÀÄÄÄÄÙ"
	for x=11 to 17 step 3
	locate x,33:print"ÚÄÄÄ¿"
	locate x+1,33:print"³";18-x;"³"
	locate x+2,33:print"ÀÄÄÄÙ"
	locate x,38:print"ÚÄÄÄ¿"
	locate x+1,38:print"³";19-x;"³"
	locate x+2,38:print"ÀÄÄÄÙ"
	locate x,43:print"ÚÄÄÄ¿"
	locate x+1,43:print"³";20-x;"³"
	locate x+2,43:print"ÀÄÄÄÙ"
	next x
	locate 20,38:print"ÚÄÄÄ¿"
	locate 21,38:print"³ 00³"
	locate 22,38:print"ÀÄÄÄÙ"
	locate 20,43:print"ÚÄÄÄ¿"
	locate 21,43:print"³ . ³"
	locate 22,43:print"ÀÄÄÄÙ"
	for x=11 to 20 step 3
	locate x,54:print"ÚÄÄÄ¿"
	locate x+2,54:print"ÀÄÄÄÙ"
	if x<17 then
	  locate x,49:print"ÚÄÄÄ¿"
	  locate x+2,49:print"ÀÄÄÄÙ"
	end if
	next x
	locate 17,49:print"ÚÄÄÄ¿"
	locate 18,49:print"³   ³"
	locate 19,49:print"³ + ³"
	locate 20,49:print"³   ³"
	locate 21,49:print"³   ³"
	locate 22,49:print"ÀÄÄÄÙ"
	locate 12,49:print"³ x ³"
	locate 15,49:print"³ - ³"
	locate 12,54:print"³ \ ³"
	locate 15,54:print"³ = ³"
	locate 18,54:print"³#/P³"
	locate 21,54:print"³ * ³"
	color 0,3:locate 24,1
	print"[ENTER]-*   M+-Mæ       M--Mç   MO-Mè            M[ENTER]-M*    ^-é             ";
	locate 25,1
	print"[TAB]-TAB   C-ON/C      X-CE    #-00    P-#/P    Q-P/NP         [ESC]-OFF       ";
	screen ,,1,1
	color 15,0
	locate 4,41:print"              "
	num$="0"
	gosub WriteN
REM Hauptroutine
1	a$=inkey$
	if a$="" then 1
	if a$="#" then a$="00"
	if a$=chr$(13) then goto Summe
	if a$="M" or a$="m" then goto Memory
	if A$="^" or a$="ø" then lprint:goto 1
	if a$="q" or a$="Q" then goto SwitchPrint
	if a$="P" or a$="p" then goto PrintDisp
	if a$=chr$(7) then goto SwitchTAB
	if a$="c" or a$="C" then goto ReLaunch
	if a$="x" or A$="X" then locate 4,41:print"            ":num$="0":gosub WriteN:goto 1
	if a$=chr$(27) then end
	if num$="0" then num$=a$ else num$=num$+a$
	gosub WriteN
	goto 1



end

Summe:
Memory:
SwitchPrint:
SwitchTAB:
PrintDisp:
ReLaunch:
end



WriteN:
REM Ausw„hlen der Anzeigeart
	if tb=0 then gosub WriteNumb
	if tb=1 then gosub WriteNumb0
	if tb=2 then gosub WriteNumb2
	if tb=3 then gosub WriteNumb3
	if tb=4 then gosub WriteNumb4
	if tb=5 then gosub WriteNumbA
	return

WriteNumb:
REM Anzeigen der Zahl im Display (mstat$=Status des M/-/E & num=Zahl)
	color 15,0
	locate 4,41:print mstat$;" ";
	locate 4,42+(11-len(num$))
	if val(num$)=int(val(num$)) then prt$=num$+"." else prt$=num$+" "
	print prt$
	return


WriteNumb0:
REM Anzeigen der Zahl im Display (mstat$=Status des M/-/E & num=Zahl)mit TAB0
	color 15,0
	locate 4,41:print mstat$;:print using" ##########. ";num
	return

WriteNumb2:
REM Anzeigen der Zahl im Display (mstat$=Status des M/-/E & num=Zahl)mit TAB2
	color 15,0
	locate 4,41:print mstat$;:print using" ########.## ";num
	return

WriteNumb3:
REM Anzeigen der Zahl im Display (mstat$=Status des M/-/E & num=Zahl)mit TAB3
	color 15,0
	locate 4,41:print mstat$;:print using" #######.### ";num
	return

WriteNumb4:
REM Anzeigen der Zahl im Display (mstat$=Status des M/-/E & num=Zahl)mit TAB4
	color 15,0
	locate 4,41:print mstat$;:print using" ######.#### ";num
	return

WriteNumbA:
REM Anzeigen der Zahl im Display (mstat$=Status des M/-/E & num=Zahl)mit TABAUTO
	color 15,0
	locate 4,41:print mstat$;:print using" ########.## ";num
	return

PrintNumb:
REM Ausdrucken der Zahl im Display (oper$=Operator & num=Zahl
	lprint using"##########,. ";num;:lprint oper$
	return

CheckFile:
'	open "I",#1,"compiled\PCALC\PCALC.EXE"
'	for z=1 to 999999
'	  if eof(1) then exit for
'	  line input #1,lin$
'	  for x=1 to len(lin$)
'	    sum=sum+asc(mid$(lin$,x,1))
'	  next x
'	next z
'	close #1
	return