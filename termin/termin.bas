	ver$="2.10"
	IniFile$=environ$("TEMP")
	IniFile$=IniFile$+"\TERMIN.INI"
	if command$="/?" then goto Help
	dim zeile$(500)
	dim choice$(50)
	open "I",#1,"TERMIN.LST"
	now$=mid$(date$,4,2)+"."+left$(date$,2)+"."+right$(date$,2)
	Day=val(mid$(date$,4,2))
	Month=val(left$(date$,2))
	Year=val(right$(date$,2))
	for Addi=1 to 5
	  NDay=Day+Addi
	  NMonth=Month

	  if Day+Addi>28 and Month=2 and int(Year/4)<>Year/4 then
	    NMonth=Month+1
	    if Feb28=0 and F28=0 then Feb28=Addi-1:F28=1
	    NDay=Addi-Feb28
	  end if

	  if Day+Addi>29 and Month=2 and int(Year/4)=Year/4 then
	    NMonth=Month+1
	    if Feb29=0 and F29=0 then Feb29=Addi-1:F29=1
	    NDay=Addi-Feb29
	  end if

	  if Day+Addi>30 and (Month=4 or Month=6 or Month=9 or Month=11) then
	    NMonth=Month+1
	    if Month30=0 and M30=0 then Month30=Addi-1:M30=1
	    NDay=Addi-Month30
	  end if

	  if Day+Addi>31 and (Month=1 or Month=3 or Month=5 or Month=7 or Month=8 or Month=10 or Month=12) then
	    NMonth=Month+1
	    if Month31=0 and M31=0 then Month31=Addi-1:M31=1
	    if NMonth=13 then NMonth=1:NYear=Year+1:NDay=Addi-Month31 else NDay=Addi-Month31
	  end if

	  if NYear=0 then NYear=Year
	  NDay$=str$(1000+NDay)
	  NMonth$=str$(1000+NMonth)
	  NYear$=Str$(1000+NYear)

	  Now$(Addi)=using$("\\",right$(NDay$,2))+"."
	  Now$(Addi)=Now$(Addi)+using$("\\",right$(NMonth$,2))+"."
	  Now$(Addi)=Now$(Addi)+using$("\\",right$(NYear$,2))
	next Addi


	color 15,0,0:print" TERMIN v";ver$;"  by RC                                       Datum: ";now$;
	color 8,0,0:print "TERMIN /? fÅr Hilfe":color 14,0,0
	x=1
2	line input#1,zeile$(x)
	if eof(1) then maxb=x:close #1:goto 1 else x=x+1:goto 2
	MESS$="Termin(e) heute:"
1	for x=1 to maxb
	  if left$(zeile$(x),1)="'" then goto 999
	  bdate$=left$(zeile$(x),6)
	  bdate2$=left$(zeile$(x),8)
	  bname$=mid$(zeile$(x),8,60)
	  bname2$=mid$(zeile$(x),10,60)
	  if bdate2$=now$ then gosub PrintItOut2
	  if bdate$=left$(now$,6) and Date2=0 then gosub PrintItOut1
	  Date2=0
999	next x
	if FoundIt=0 then color 7,,9:print"Kein(e) heutigen Termin(e) gefunden."
	if inkey$="a" or inkey$="A" then goto AddIt
	if inkey$="c" or inkey$="C" then goto ClearIt
	if FoundIt=1 then FoundSomething=1
	goto CommonSearch

PrintItOut1:
	color ,,15:num=num+1
	if PrintedNow=0 then
	  color 14
	  print MESS$
	  PrintedNow=1
	end if
	if CS=0 then BDC=15
	if CS=2 or CS=3 or CS=4 then BDC=14
	if CS=1 then BDC=12
	if CS=5 then BDC=10
	color 15:print num;
	color BDC:if BDC=15 then print "Ø"; else print " ";
	print bdate$;
	color 10:print "   ";bname$;
	color 15
	if BDC=15 then print " Æ" else print
	FoundIt=1
	color ,,0
	return

PrintItOut2:
	color ,,15:Date2=1:num=num+1
	if PrintedNow=0 then
	  color 15
	  print MESS$
	  PrintedNow=1
	end if
	IF CS=0 or CS=2 or CS=3 or CS=4 then BDC=14
	if CS=1 then BDC=12
	if CS=5 then BDC=10
	color 15:print num;
	color BDC:if BDC=15 then print "Ø"; else print " ";
	print bdate2$;
	color 10:print " ";bname2$;
	color 15
	if BDC=15 then print " Æ" else print
	FoundIt=1
	color ,,0
	return

SomethingFound:
	print
	color 15
	print "    €€€€€€BESTéTIGUNG€€€€€€"
3	for x=1 to 50
	  wt=5
	  if x>0 and x<=wt then color ,,0
	  if (x>wt and x<=2*wt) or (x>9*wt and x<=10*wt) then color ,,1
	  if (x>2*wt and x<=3*wt) or (x>8*wt and x<=9*wt) then color ,,9
	  if (x>3*wt and x<=4*wt) or (x>7*wt and x<=8*wt) then color ,,3
	  if (x>4*wt and x<=5*wt) or (x>6*wt and x<=7*wt) then color ,,7
	  if x>5*wt and x<=6*wt then color ,,11
	  a$=inkey$
	  if a$="a" or a$="A" then Add=1:exit for
	  if a$="c" or a$="C" then Clr=1:exit for
	  if a$<>"" then Response=1:exit for
	next x
	if Add=1 then goto AddIt
	if Clr=1 then goto ClearIt
	if Response=1 then return
	goto 3

AddIt:
	color 15,0,0:print:print:print "Termin hinzufÅgen"
	print
	input"Datum (TT.MM.[JJ])                  : ",dat$
	input"Terminbeschreibung (max. 60 Zeichen): ",termin$
	open "A",#1,"TERMIN.LST"
	OutIt$=dat$+" "+termin$
	print#1,OutIt$
	close #1
	print
	color 10:print"Noch einen Termin addieren (J/N)?":print
5	a$=inkey$:if a$="" then 5
	if a$="j" or a$="J" then goto AddIt else goto Ende

ClearIt:
	color 15,0,0:print:print:print "Termin lîschen"
	print
	input"Datum (TT.MM.) : ",dat$
	print"Suche ...";
	open "I",#1,"TERMIN.LST"
	x=1
6    if eof(1) then close #1:print "OK":goto 7
	line input#1,zeile$
	if left$(zeile$,len(dat$))=dat$ then choice$(x)=zeile$:x=x+1:goto 6 else goto 6
7	maxx=x-1
	print" fertig"
	color 10:print:print"Mîglichkeit(en):":color 15
	for x=1 to maxx
	  print x;"  ";choice$(x)
	next x
	print
	color 12
	IpString$="Zahl von 0 bis "+mid$(str$(maxx),2,40)+" eingeben und [ENTER] drÅcken"
8	print IpString$;:input ": ",choice
	if choice<0 or choice >maxx then print "Falsche Eingabe!":goto 8
	if choice=0 then color 10:print"Update abgebrochen.":goto 13
	color 10:print"Update lÑuft ...";
	open "I",#1,"TERMIN.LST"
	open "O",#2,"TERMIN.$$$"
9	line input#1,zeile$
	if zeile$<>choice$(choice) then print#2,zeile$
	if eof(1) then goto 10 else goto 9
10	close #1:close #2:kill "termin.lst"
	name "Termin.$$$" as "termin.lst"
	color 15:print" komplett"
13	print
	color 10:print"Noch einen Termin lîschen (J/N)?":print
11	a$=inkey$:if a$="" then 11
	if a$="j" or a$="J" then goto ClearIt else goto Ende

Help:
	cls
	now$=mid$(date$,4,2)+"."+left$(date$,2)+"."+right$(date$,2)
	color 15,0,0:print" TERMIN v";ver$;"  by RC                                       Datum: ";now$;
	color 8,0,0:print "TERMIN /? fÅr diesen Hilfebildschirm":color 7,0,0
	print"TERMIN Version ";ver$;" ist fÅr den Einsatz in der AUTOEXEC.BAT gedacht. Es
	print"speichert Termine ab und zeigt sie beim Starten des Rechners an. Und:"
	color 12+16
	print"* NEU *** NEU *** NEU *** NEU *** NEU *** NEU *** NEU *** NEU *** NEU *** NEU *"
	color 7
	print"Es zeigt seit der Version 2.00 die Termine der nÑchsten 5 Tage an und gibt eine"
	print"Tonfolge aus. Je mehr der Ton piept desto kurzfristiger ist der Termin. Wenn"
	print"ein Termin auf den nÑchsten Tag fÑllt wird auch um BestÑtigung gebeten! Das"
	print"schînste aber ist, es belegt keinen Speicher. Und seit der Version 2.10 nervt"
	print"Sie TERMIN nur noch jedes 5te mal. Aber jetzt kommen wir zu den hei·en Tasten"
	print"(Hotkeys). Sie sind gleich nach dem Start oder bei der 'Bitte eine Taste drÅk-"
	print"ken'-Meldung zu drÅcken:"
	color 14
	print"(A)dd     - Addiert einen Termin"
	print"(C)lear   - Lîscht einen Termin"
	print"[SPACE]   - BestÑtigung, bei Meldung"
	color 7
	print"Datumsangaben sind in der Form TT.MM.JJ zu machen, z.B.:"
	print"31.12.88 - Der 31. Dezember 1988, oder"
	print"31.12.   - Der 31. Dezember (wird jedes Jahr angezeigt)"
	color 9
	print"Wenn Sie manuell in der TERMIN.LST herumwerkeln, kînnen Sie Kommentare mit"
	print"einem Appostroph (') einleiten. Dadurch wird die Suche etwas beschleunigt."
	print:color 7
	print"So und nun zurÅck zu Ihrem OS ..."
	goto Ende

CommonSearch:
FoundIt=0
MESS$="Termin(e) in den nÑchsten 5 Tagen:"
12 for CS=1 to 5
	for x=1 to maxb
	  if left$(zeile$(x),1)="'" then goto 998
	  bdate$=left$(zeile$(x),6)
	  bdate2$=left$(zeile$(x),8)
	  bname$=mid$(zeile$(x),8,60)
	  bname2$=mid$(zeile$(x),10,60)
	  if bdate2$=now$(CS) then gosub PrintItOut2:for g=1 to 6-CS:sound 1000,.5:delay 1/18.2:next g
	  if bdate$=left$(now$(CS),6) and Date2=0 then gosub PrintItOut1:for g=1 to 6-CS:sound 1000,.5:delay 1/18.2:next g
	  Date2=0
	  if CS=1 and FoundIt=1 then FoundSomething=1
998	next x
    next CS
	if FoundIt=0 then color 7,,9:print"Kein(e) Termin(e) in den nÑchsten 5 Tagen gefunden."
	if inkey$="a" or inkey$="A" then goto AddIt
	if inkey$="c" or inkey$="C" then goto ClearIt
	on error goto IniNotExist
ResumeHere:
	open "I",#5,IniFile$
	input #5,OlDate$,Counter
	close #5
	on error goto
	if Counter/5=int(Counter/5) then Counter=0
	if OlDate$<>Date$ and len(OlDate$)>5 then Counter=0
	if Counter=0 then
	  if FoundSomething=1 then gosub SomethingFound
	  Counter=Counter+1
	  open "O",#5,IniFile$
	  write#5,Date$,Counter
	  close #5
	else
	  Counter=Counter+1
	  open "O",#5,IniFile$
	  write#5,Date$,Counter
	  close #5
	end if
	goto Ende

IniNotExist:
	open "O",#7,IniFile$
	write#7,Date$,0
	close #7
	resume ResumeHere

Ende:
	print:color ,0,0
	end