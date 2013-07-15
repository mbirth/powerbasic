$INCLUDE "LOGO.INC"
$INCLUDE "PBWINDOW.INC"
	if command$="SKIP" or command$="skip" then goto SkipIt
	color 15
	Lin=csrlin-1
	txt$="proudly presents"
	txt$(1)=txt$
	gosub WriteText
	txt$="The Paintbrush Pick Info Remover"
	txt$(2)=txt$
	print
	Lin=csrlin-1
	delay 1
	gosub WriteText
	delay 1
	color 9
	Anf1=40-int(len(txt$(1))/2)+1
	Anf2=40-int(len(txt$(2))/2)+1
	locate Lin-1,Anf1:print txt$(1)
	locate Lin,Anf2:print txt$(2)
	delay .15
	color 3
	locate Lin-1,Anf1:print txt$(1)
	locate Lin,Anf2:print txt$(2)
	delay .15
	color 11
	locate Lin-1,Anf1:print Txt$(1)
	locate Lin,Anf2:print txt$(2)
	delay .15
	color 15
	locate Lin-1,Anf1:print txt$(1)
	locate Lin,Anf2:print txt$(2)
	goto Program

WriteText:
	AnfLocX=40-int(len(txt$)/2)
	x=1
1	if x>0 then LetA$=mid$(txt$,x,1)
	if x>1 then LetB$=mid$(txt$,x-1,1)
	if x>2 then LetC$=mid$(txt$,x-2,1)
	if x>3 then LetD$=mid$(txt$,x-3,1)
	if x>4 then LetE$=mid$(txt$,x-4,1)
	if x>0 then color 15:locate Lin,AnfLocX+x:print LetA$
	if x>1 then color 11:locate Lin,AnfLocX+x-1:print LetB$
	if x>2 then color 3:locate Lin,AnfLocX+x-2:print LetC$
	if x>3 then color 9:locate Lin,AnfLocX+x-3:print LetD$
	if x>4 then color 1:locate Lin,AnfLocX+x-4:print LetE$
	x=x+1:if x>len(txt$)+4 then 2 else delay .05:goto 1
2	delay 1
	color 15:locate Lin,AnfLocX+1:print txt$
	delay .1:color 11:locate Lin,AnfLocX+1:print txt$
	delay .1:color  3:locate Lin,AnfLocX+1:print txt$
	delay .1:color  9:locate Lin,AnfLocX+1:print txt$
	delay .1:color  1:locate Lin,AnfLocX+1:print txt$
	return

SkipIt:
	color 15
	txt$="proudly presents"
	locate csrlin-1,40-int(len(txt$)/2):print txt$
	txt$="The Paintbrush Pick Info Remover"
	locate csrlin,40-int(len(txt$)/2):print txt$
	goto Program

Program:
	Item$(0)="[Programm wÑhlen]"
	gosub PF2:test=1
	gosub CheckForPresence
	gosub PF3:test=2
	gosub CheckForPresence
	gosub PCP:test=3
	gosub CheckForPresence
	Lin=17
	call MakeWindow (15,9,5,63,ColAttr%(11,0),2,4,2)
	call TitleWindow (1,"[Information]")
	txt$="Zum Abbrechen [ESC] drÅcken, ansonsten eine Auswahl treffen"
	if command$="skip" or command$="SKIP" then
	  locate Lin,40-int(len(txt$)/2)
	  color 15,0
	  print txt$
	  goto 7
	end if
	gosub WriteText:delay 1
	color 9:locate 17,AnfLocX+1:print txt$:delay .15
	color 3:locate 17,AnfLocX+1:print txt$:delay .15
	color 11:locate 17,AnfLocX+1:print txt$:delay .15
	color 15:locate 17,AnfLocX+1:print txt$
7	Call MakeMenu (3,3,ColAttr%(11,1),ColAttr%(0,3),4,4,2,1,3,Item$())
	if CurntPos%=0 then ag=0:goto BreakItUp
	if CurntPos%=1 and right$(Item$(1),17)<>"[nicht vorhanden]" then ag=0:gosub PF2:goto 20 else ag=1:goto 7
	if CurntPos%=2 and right$(Item$(2),17)<>"[nicht vorhanden]" then ag=0:gosub PF3:goto 20 else ag=1:goto 7
	if CurntPos%=3 and right$(Item$(3),17)<>"[nicht vorhanden]" then ag=0:gosub PCP:goto 20 else ag=1:goto 7
20	if ag=0 then Call RemoveWindow
	goto ChangeWININI

CheckForPresence:
	open "I",#1,"C:\WINDOWS\WIN.INI"
10	if eof(1) then close #1:return
	line input#1,dummy$
	if left$(dummy$,1)="[" then
	  tit$=""
	  for dummy=2 to 80
	    if mid$(dummy$,dummy,1)="]" then exit for else tit$=tit$+mid$(dummy$,dummy,1)
	  next dummy
	else
	  goto 10
	end if
	if tit$=Title$ then Item$(test)=ProgInfo$:close #1:return else Item$(test)=ProgInfo$+" [nicht vorhanden]":goto 10

PF2:
	Title$="PhotoFinish"
	ProgInfo$="Photo Finish 2.0"
	PickInfo$=lcase$("Pick")
	return

PF3:
	Title$="Photo Finish 3.0"
	ProgInfo$="Photo Finish 3.0"
	PickInfo$=lcase$("Pick")
	return

PCP:
	Title$="PC Paintbrush"
	ProgInfo$="PC Paintbrush 1.0"
	PickInfo$=lcase$("Pick")
	return

ChangeWININI:
	call MakeWindow(5,5,15,70,ColAttr%(14,1),1,4,1)
	WinTit$="[Editing C:\WINDOWS\WIN.INI]ƒƒƒ[Mode: "+Title$+"]"
	call TitleWindow(1,WinTit$)
	per%=0
	color 14,1
	locate 7,8:print"Erstelle Sicherheitskopie von Ausgangs-Datei ... ";
	CopyOrd$="COPY C:\WINDOWS\WIN.INI C:\WINDOWS\WIN.PPR /V /Y >NUL"
	shell CopyOrd$
	print "OK"
	locate 8,8:print"ôffne Eingabe-Datei ... ";
	open "I",#1,"C:\WINDOWS\WIN.INI"
	print "OK"
	locate 9,8:print"ôffne Temp-Datei ... ";
	open "O",#2,"C:\WINDOWS\PPR.$$$"
	print "OK"
	zeil=1
6	line input#1,dummy$
	if eof(1) then 5 else zeil=zeil+1:goto 6
5    close #1:open "I",#1,"C:\WINDOWS\WIN.INI"
	locate 10,8:print "Bearbeite Temp-Datei ... ";  '10,33 ist HIER
	gosub ShowGraph
	aktz=1
3	line input#1,zei$
	if left$(zei$,1)="[" then
	  tit$=""
	  for g=2 to 80
	    if mid$(zei$,g,1)="]" then exit for else tit$=tit$+mid$(zei$,g,1)
	  next g
	  per%=(aktz/zeil)*100
	  gosub ShowGraph
	  print#2,zei$
	  locate 11,8:print"Momentane Gruppe: ";tit$
	else
	  raus$=zei$
	  gosub CheckForParam
	  print#2,raus$
	end if
	if eof(1) then goto 4
	aktz=aktz+1
	goto 3
4	locate 11,8:print space$(64)
	locate 11,8:print"Schlie·e Eingabe-Datei ... ";
	close #1
	print"OK"
	locate 12,8:print"Schlie·e Temp-Datei ... ";
	close #2
	print "OK"
	locate 13,8:print"Lîsche alte WIN.INI ... ";
	kill "C:\WINDOWS\WIN.INI"
	print "OK"
	locate 14,8:print"Benenne Temp-Datei in WIN.INI um ... ";
	name "C:\WINDOWS\PPR.$$$" as "C:\WINDOWS\WIN.INI"
	print "OK"
	locate 16,8:print"Operation abgeschlossen!"
	delay 1
	call RemoveWindow
	color 15,0
	locate 24,1:print:print
	locate 24,1
	print"Alle Pick-EintrÑge von ";chr$(34);Title$;chr$(34);" wurden entfernt!"
	print
	end

CheckForParam:
	if lcase$(left$(zei$,len(PickInfo$)+2))=PickInfo$+"1=" and tit$=Title$ then raus$=PickInfo$+"1="
	if lcase$(left$(zei$,len(PickInfo$)+2))=PickInfo$+"2=" and tit$=Title$ then raus$=PickInfo$+"2="
	if lcase$(left$(zei$,len(PickInfo$)+2))=PickInfo$+"3=" and tit$=Title$ then raus$=PickInfo$+"3="
	if lcase$(left$(zei$,len(PickInfo$)+2))=PickInfo$+"4=" and tit$=Title$ then raus$=PickInfo$+"4="
	return

ShowGraph:
	locate 10,57:print using"### %";per%
	locate 10,35:print"∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
	locate 10,35
	for z=0 to per%/5
	  if tst=1 then print "≤"; else tst=1
	next z
	return

BreakItUp:
	locate 24,1:print:print
	call MakeWindow(10,27,5,26,ColAttr%(14,1),5,4,2)
	call TitleWindow(1,"[Information]")
	color 12,1:locate 12,29:print"Programm abgebrochen !"
	if command$="skip" or command$="SKIP" then locate 24,1:end
	delay 1.75
	call RemoveWindow
	locate 24,1:end