$INCLUDE "LOGO.INC"
$INCLUDE "PBWINDOW.INC"
	if command$="SKIP" or command$="skip" then goto SkipIt
	color 15
	Lin=csrlin-1
	txt$="proudly presents"
	txt$(1)=txt$
	gosub WriteText
	txt$="The WINDOWS FOR WORKGROUPS 3.11 - Multiple Configuration Launcher"
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
	txt$="The WINDOWS FOR WORKGROUPS 3.11 - Multiple Configuration Launcher"
	locate csrlin,40-int(len(txt$)/2):print txt$
	goto Program

Program:
	Item$(0)="[Konfiguration w„hlen]"
	Item$(1)="Photo Finish v2.0"
	Item$(2)="Photo Finish v3.0"
	Item$(3)="PC Paintbrush"
	Lin=17
	call MakeWindow (15,9,5,63,ColAttr%(11,0),2,4,2)
	call TitleWindow (1,"[Information]")
	txt$="Zum Abbrechen [ESC] drcken, ansonsten eine Auswahl treffen"
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
7	Call MakeMenu (3,3,ColAttr%(11,1),ColAttr%(0,4),4,4,2,1,5,Item$())
	Call RemoveWindow
	if CurntPos%=0 then goto BreakItUp
	if CurntPos%=1 then goto PF2
	if CurntPos%=2 then goto PF3
	if CurntPos%=3 then goto PCP
	if CurntPos%=4 then goto
	if CurntPos%=5 then goto

PF2:
	Title$="Photo Finish 2.0"
	PickInfo$="Pick"
	goto ChangeWININI

PF3:
	Title$="Photo Finish 3.0"
	PickInfo$="Pick"
	goto ChangeWININI

PCP:
	Title$="PC Paintbrush"
	PickInfo$="Pick"
	goto ChangeWININI

ChangeWININI:
	call MakeWindow(5,5,15,70,ColAttr%(14,1),1,4,1)
	WinTit$="[Editing C:\WINDOWS\SYSTEM.INI]ÄÄÄ[Mode: "+ShortInfo$+"]"
	call TitleWindow(1,WinTit$)
	per%=0
	color 14,1
	locate 7,8:print"Erstelle Sicherheitskopie von Ausgangs-Datei ... ";
	CopyOrd$="COPY C:\WINDOWS\SYSTEM.INI C:\WINDOWS\SYSTEM.WL_ /V /Y >NUL"
	shell CopyOrd$
	print "OK"
	locate 8,8:print"™ffne Eingabe-Datei ... ";
	open "I",#1,"C:\WINDOWS\SYSTEM.INI"
	print "OK"
	locate 9,8:print"™ffne Temp-Datei ... ";
	open "O",#2,"C:\WINDOWS\WL.$$$"
	print "OK"
	zeil=1
6	line input#1,dummy$
	if eof(1) then 5 else zeil=zeil+1:goto 6
5    close #1:open "I",#1,"C:\WINDOWS\SYSTEM.INI"
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
	locate 11,8:print"Schlieáe Eingabe-Datei ... ";
	close #1
	print"OK"
	locate 12,8:print"Schlieáe Temp-Datei ... ";
	close #2
	print "OK"
	locate 13,8:print"L”sche alte SYSTEM.INI ... ";
	kill "C:\WINDOWS\SYSTEM.INI"
	print "OK"
	locate 14,8:print"Benenne Temp-Datei in SYSTEM.INI um ... ";
	name "C:\WINDOWS\WL.$$$" as "C:\WINDOWS\SYSTEM.INI"
	print "OK"
	locate 16,8:print"Operation abgeschlossen!"
	delay 1
	call RemoveWindow
	color 15,0
	locate 24,1:print:print
	locate 24,1
	execute "WIN.COM :"
	end

CheckForParam:
	if left$(zei$,len(PickInfo$)+2)=PickInfo$+"1=" and tit$=Title$ then raus$=PickInfo$+"1="
	if left$(zei$,len(PickInfo$)+2)=PickInfo$+"2=" and tit$=Title$ then raus$=PickInfo$+"2="
	if left$(zei$,len(PickInfo$)+2)=PickInfo$+"3=" and tit$=Title$ then raus$=PickInfo$+"3="
	if left$(zei$,len(PickInfo$)+2)=PickInfo$+"4=" and tit$=Title$ then raus$=PickInfo$+"4="
	return

ShowGraph:
	locate 10,57:print using"### %";per%
	locate 10,35:print"°°°°°°°°°°°°°°°°°°°°"
	locate 10,35
	for z=0 to per%/5
	  if tst=1 then print "²"; else tst=1
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