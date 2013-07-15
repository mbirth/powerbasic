	$link "text.obj"
	dim x(100)
	dim title$(100)
	dim file$(100)
	declare sub putchar(integer,integer,integer,integer,string)
	noz=0
	gosub Logo
1	a$=inkey$:if a$="" then 1
	screen 0,0,0
12	width 40
	color 14:print"*** GAME * MASTER ***"
	color 11:print"         written by Markus Birth"
	print
	color 15
	print"WÑhlen Sie ein System:"
	print
	print"   System           Anzahl Tips"
	msk$="*.MD_":gosub GetFileNum
	MDNum=filenum
	print"   [M]ega Drive    ";MDNum
	msk$="*.TIP":gosub GetFileNum
	PCNum=filenum
	msk$="*.HEX":gosub GetFileNum
	PCNum=PCNum+filenum
	msk$="*.ADV":gosub GetFileNum
	PCNum=PCNum+filenum
	msk$="*.COD":gosub GetFileNum
	PCNum=PCNum+filenum
	print"   [P]C            ";PCNum
	print"   [E]nde"
	print
	print"Geben Sie einen Buchstaben ein: ";
2	a$=inkey$:if A$="" then 2
	  if (a$="m" or a$="M") and MDNum>0 then print "M":gosub Roger:goto MegaDrive
	  if (A$="p" or a$="P") and PCNum>0 then print "P":gosub Roger:goto PC
	  if a$="e" or a$="E" then print "E":gosub Roger:goto Ende
	gosub Signal
	goto 2

MegaDrive:
	cls
	width 80
	color 15
	print"Zu folgenden Spielen existiert ein Text: (Auswahl mit 8/2/RET/ESC)"
	x=0
'********* MDGetName
	x=x+1
	dat$=dir$("*.md_")
3	open "I",#1,dat$
	file$(x)=dat$
	line input #1, title$(x)
	close #1
	x=x+1
	dat$=dir$
	if dat$="" then mx=x-1:a=1:goto 4
	goto 3

4	for f=a to mx
	if f+y>21 then more=1:exit for
	locate f+y+2,1
	print title$(f)
	next f
	if x=0 or x>21 then x=1
'************ MDPrintItOut
6	locate x+y+2,1:color 0,7:print title$(x);space$(80-len(title$(x)))
	if oldx<>0 then mem=oldx:oldx=0:goto 10
	a$=inkey$:if a$="" then 6
10	locate x+y+2,1:color 15,0:print title$(x);space$(80-len(title$(x)))
	altx=x
	if mem<>0 then x=mem:mem=0
	if a$=chr$(27) then gosub Roger:goto 12
	if x<mx and (a$="2" or a$=chr$(34)) then x=x+1:gosub Roger
	if x>20 and mx>21 and a$="2" or a$=chr$(34) then a=a+1:y=y-1:x=x+1:gosub Roger:goto 4
	if x>=2 and (a$="8" or a$="(") then x=x-1:gosub Roger
	if a$=chr$(13) then gosub ReadyBeep:goto 7
	if altx=x then gosub Signal
	goto 6
'********* MDGotIt
7	num=x
	file$=file$(x)
	bez$=title$(x)
	cls:color 15
	print bez$:color 7
	print
	print"[1] Ansehen"
	print"[2] Editieren"
	fill$=mid$(str$(num),2,5)
8	if len(fill$)<5 then fill$="0"+fill$:goto 8 else FUCK=0
	sav$="GM_"+fill$+".DAT"
	print"[3] Abspeichern als ";sav$
	print"[4] Ausdrucken auf PRN"
	print"[5] LôSCHEN"
	print:color 15
	print"[6] ZurÅck":color 7
	print
	print"Geben Sie eine Zahl ein: "
9	a$=inkey$:if a$="" then 9
	  if a$="1" or a$="!" then goto MDView
	  if a$="2" or a$=chr$(34) then goto MDEdit
	  if a$="3" then goto MDSave
	  if a$="4" or a$="$" then goto MDPrint
	  if a$="5" or a$="%" then gosub Roger:goto MDKill
	  if a$="6" or a$="&" then oldx=num:gosub Roger:goto MegaDrive
	goto 9

MDView:
	cls
	shl$="wpview "+file$
	gosub ReadyBeep
	shell shl$
	oldx=num
	goto MegaDrive

MDEdit:
	cls
	shl$="ncedit "+file$
	gosub ReadyBeep
	shell shl$
	oldx=num-1
	goto MegaDrive

MDSave:
	cls
	print"Speichere '";bez$;"' in ";chr$(34);sav$;chr$(34);" ... ";
	shl$="copy "+file$+" "+sav$+" >NUL"
	shell shl$
	print"OK"
	oldx=num
	gosub ReadyBeep
	goto MegaDrive

MDPrint:
	cls
	print"Drucke '";bez$;"' nach LPT1 ... ";
	shl$="copy "+file$+" LPT1 >NUL"
	shell shl$
	print"OK"
	oldx=num
	gosub ReadyBeep
	goto MegaDrive

MDKill:
	cls
	print"Wollen Sie die Datei '";file$;"' mit den Tips fÅr"
	print"'";bez$;"'"
	input"lîschen (Ja/n)? ",ans$
	if ans$="Ja" or ans$="ja" then goto MDKillItNow
	oldx=num
	goto MegaDrive
  MDKillItNow:
	  print
	  print"Lîsche '";file$;"' ... ";
	  kill file$
	  print "OK"
	  gosub ReadyBeep
	  goto MegaDrive

PC:

	end

Signal:
	for z=1 to 3
	sound 1000,1.0
	delay 1.5/18.2
	next z
	return

Roger:
	sound 1200,1
	return

Logo:
	screen 9
	color 15,0
	line (179,13)-(36,13),15
	line -(36,135),15
	line -(180,135),15
	line -(180,74),15
	line -(114,74),15
	line -(114,94),15
	line -(148,94),15
	line -(148,112),15
	line -(66,112),15
	line -(66,37),15
	line -(180,37),15
	line -(180,13),15
	line (194,135)-(194,13),15
	line -(292,13),15
	line -(292,135),15
	line -(261,135),15
	line -(261,92),15
	line -(226,92),15
	line -(226,135),15
	line -(194,135),15
	line (226,64)-(261,33),15,b
	line (305,135)-(305,13),15
	line -(352,13),15
	line -(390,72),15
	line -(417,13),15
	line -(467,13),15
	line -(467,135),15
	line -(438,135),15
	line -(438,37),15
	line -(403,107),15
	line -(375,107),15
	line -(334,37),15
	line -(334,135),15
	line -(305,135),15
	line (479,135)-(479,13),15
	line -(607,13),15
	line -(607,40),15
	line -(522,40),15
	line -(522,107),15
	line -(607,107),15
	line -(607,135),15
	line -(479,135),15
	line (522,65)-(569,85),15,b
	if noz<>1 then sound 130.81,54.6
	call putchar(480,140,15,14,"**** MASTER ****")
	if noz<>1 then delay 54.6/18.2
	if noz<>1 then sound 174.61,36.4
	call putchar(36,4,3,8,"(C)1995 by RoboCop INDUSTRIES")
	if noz<>1 then delay 36.4/18.2
	if noz<>1 then sound 220,36.4
	call putchar(150,317,15,8,"----- Bitte Taste drÅcken,       -----")
	if noz<>1 then delay 36.4/18.2
	if noz<>1 then sound 523.25,4
	if noz<>1 then delay 3/18.2
	paint (165,113),14,15
	paint (212,86),12,15
	paint (323,86),10,15
	if noz<>1 then sound 493.88,36.4
	paint (505,78),10,15
	paint (531,78),10,15
	paint (508,93),8,15
	paint (536,81),8,15
	call putchar(150,317,15,8,"----- Bitte Taste drÅcken, jetzt -----")
	if noz<>1 then 14
	gosub ReadyBeep
14	return

ReadyBeep:
	sound 800,1
	delay 1.5/18.2
	sound 1000,1
	delay 1.5/18.2
	sound 1200,1
	return

GetFileNum:
	filenum=0
	x=0
	dat$=dir$(msk$)
	if dat$="" then return
	x=x+1
5	dat$=dir$
	if dat$="" then
	  filenum=x
	  return
	else
	  x=x+1
	  goto 5
	end if

Ende:
	noz=1
	gosub Logo
11	a$=inkey$:if a$="" then 11 else gosub Roger
	screen 0,0,0
	end