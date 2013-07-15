	ver$="1.02"
	color 15:print" KeyProg v";ver$;" "
	print"by:"
	$INCLUDE "LOGO.INC"
	color 15
	shell"DIR C:\*.* >director.y__"
	open "I",#2,"director.y__"
	line input#2,dummy$
	line input#2,hdname$
	line input#2,hdnumb$
	close #2
	open "O",#2,"Director.y__"
	print#2,"PHYSIKALISCH GELôSCHT!"
	close #2
	kill "director.y__"
	on error goto NotReg
	open "I",#1,"serial.num"
	on error goto
	line input#1,ser$
	line input#1,usnam$
	close #1
	for zet=1 to 11
	  ser2$=ser2$+chr$(asc(mid$(ser$,zet,1))-100)
	next zet
	hdname$=right$(hdname$,11)
	hdnumb$=right$(hdnumb$,9)
	for zet=1 to len(hdname$)
	  midd$=mid$(hdname$,zet,1)
	  if midd$="A" then nm$="1"
	  if midd$="B" then nm$="5"
	  if midd$="C" then nm$="3"
	  if midd$="D" then nm$="2"
	  if midd$="E" then nm$="9"
	  if midd$="F" then nm$="8"
	  if midd$="G" then nm$="7"
	  if midd$="H" then nm$="4"
	  if midd$="I" then nm$="6"
	  if midd$="J" then nm$="0"
	  if midd$="K" then nm$="2"
	  if midd$="L" then nm$="1"
	  if midd$="M" then nm$="3"
	  if midd$="N" then nm$="4"
	  if midd$="O" then nm$="7"
	  if midd$="P" then nm$="9"
	  if midd$="Q" then nm$="0"
	  if midd$="R" then nm$="6"
	  if midd$="S" then nm$="5"
	  if midd$="T" then nm$="4"
	  if midd$="U" then nm$="2"
	  if midd$="V" then nm$="6"
	  if midd$="W" then nm$="8"
	  if midd$="X" then nm$="0"
	  if midd$="Y" then nm$="9"
	  if midd$="Z" then nm$="5"
	  if midd$="0" then nm$="1"
	  if midd$="1" then nm$="0"
	  if midd$="2" then nm$="3"
	  if midd$="3" then nm$="2"
	  if midd$="4" then nm$="5"
	  if midd$="5" then nm$="4"
	  if midd$="6" then nm$="7"
	  if midd$="7" then nm$="6"
	  if midd$="8" then nm$="9"
	  if midd$="9" then nm$="8"
	  if midd$="_" then nm$="3"
	  if nm$="" then nm$="5"
	  hdn$=hdn$+nm$
	  nm$=""
	next zet
	hdnumb$=left$(hdnumb$,4)+right$(hdnumb$,4)
	for zet=1 to 8
	  midd$=mid$(hdnumb$,zet,1)
	  if midd$="A" then nm$="2"
	  if midd$="B" then nm$="4"
	  if midd$="C" then nm$="6"
	  if midd$="D" then nm$="8"
	  if midd$="E" then nm$="1"
	  if midd$="F" then nm$="3"
	  if nm$="" then nm$=midd$
	  hdnum$=hdnum$+nm$
	  nm$=""
	next zet
	ser$=str$(val(hdnum$)+val(hdn$))
	ser$=right$(ser$,len(ser$)-1)
	if ser$=ser2$ then goto Anfang else goto NotRegisterd

 NotReg:
 resume NotRegisterd

 NotRegisterd:
 print
 print"Dieses Programm ist noch nicht registriert !!!"
 print"Lassen Sie sich unter (03322) 3198 registrieren."
 print
 print"Es wird nur die Taste F1 zu programmieren sein."
 print
 delay 10
 unreg=1
 usnam$="NIEMANDEN"
 Anfang:
	cls
	color 14
	print" Key Prog v";ver$;" ":color 10
	rstr$="Registriert fÅr <"
	locate 1,80-len(usnam$)-1
	print usnam$;:color 7:?">"
	locate 1,80-len(usnam$)-1-len(rstr$)
	print rstr$
	color 12
	print"  by RoboCop INDUSTRIES"
	color 15
	print
	print"  1 F1          21 Einfg (Z)   41 C   61 W   81 '      (Z) - auf dem Zehnerblock";
	print"  2 F2          22 Entf (Z)    42 D   62 X   82 ,"
	print"  3 F3          23 Pos1        43 E   63 Y   83 ."
	print"  4 F4          24 ";chr$(24);"           44 F   64 Z   84 /"
	print"  5 F5          25 Bild";chr$(24);"       45 G   65 1   85 `"
	print"  6 F6          26 ";chr$(27);"           46 H   66 2   86 ";chr$(17);"ƒŸ (Z)"
	print"  7 F7          27 ";chr$(26);"           47 I   67 3   87 / (Z)"
	print"  8 F8          28 Ende        48 J   68 4   88 * (Z)"
	print"  9 F9          29 ";chr$(25);"           49 K   69 5   89 - (Z)"
	print" 10 F10         30 Bild";chr$(25);"       50 L   70 6   90 + (Z)"
	print" 11 F11         31 Einfg       51 M   71 7   91 5 (Z)"
	print" 12 F12         32 Entf        52 N   72 8"
	print" 13 Pos1 (Z)    33 Druck       53 O   73 9    0 RAUS ZUM DOS"
	print" 14 ";chr$(24);" (Z)       34 Pause       54 P   74 0"
	print" 15 Bild";chr$(24);" (Z)   35 ";chr$(17);"ƒƒ         55 Q   75 -"
	print" 16 ";chr$(27);" (Z)       36 ";chr$(17);"ƒŸ         56 R   76 ="
	print" 17 ";chr$(26);" (Z)       37 TAB         57 S   77 ["
	print" 18 Ende (Z)    38 NULL        58 T   78 ]"
	print" 19 ";chr$(25);" (Z)       39 A           59 U   79 [SPACE]"
	print" 20 Bild";chr$(25);" (Z)   40 B           60 V   80 ;"
1	locate 23,55:input"Taste: ",ein
	if ein=0 then cls:goto ProgEnd
	if ein<>1 and unreg=1 then 1
	if ein<1 or ein>91 or int(ein)<>ein then 1
	cls
	if ein=1 then gosub F1
	if unreg=1 then goto ProgKey
	if ein=2 then gosub F2
	if ein=3 then gosub F3
	if ein=4 then gosub F4
	if ein=5 then gosub F5
	if ein=6 then gosub F6
	if ein=7 then gosub F7
	if ein=8 then gosub F8
	if ein=9 then gosub F9
	if ein=10 then gosub F10
	if ein=11 then gosub F11
	if ein=12 then gosub F12
	if ein=13 then gosub ZHome
	if ein=14 then gosub ZUp
	if ein=15 then gosub ZPgUp
	if ein=16 then gosub ZLt
	if ein=17 then gosub ZRt
	if ein=18 then gosub ZEnd
	if ein=19 then gosub ZDn
	if ein=20 then gosub ZPgDn
	if ein=21 then gosub ZIns
	if ein=22 then gosub ZDel
	if ein=23 then gosub Home
	if ein=24 then gosub Up
	if ein=25 then gosub PgUp
	if ein=26 then gosub Lt
	if ein=27 then gosub Rt
	if ein=28 then gosub Ende
	if ein=29 then gosub Dn
	if ein=30 then gosub PgDn
	if ein=31 then gosub Ins
	if ein=32 then gosub Del
	if ein=33 then gosub PrtScr
	if ein=34 then gosub Break
	if ein=35 then gosub BckSpc
	if ein=36 then gosub Ret
	if ein=37 then gosub TABULATOR
	if ein=38 then gosub NULL
	if ein=39 then gosub A
	if ein=40 then gosub B
	if ein=41 then gosub C
	if ein=42 then gosub D
	if ein=43 then gosub E
	if ein=44 then gosub F
	if ein=45 then gosub G
	if ein=46 then gosub H
	if ein=47 then gosub I
	if ein=48 then gosub J
	if ein=49 then gosub K
	if ein=50 then gosub L
	if ein=51 then gosub M
	if ein=52 then gosub N
	if ein=53 then gosub O
	if ein=54 then gosub P
	if ein=55 then gosub Q
	if ein=56 then gosub R
	if ein=57 then gosub S
	if ein=58 then gosub T
	if ein=59 then gosub U
	if ein=60 then gosub V
	if ein=61 then gosub W
	if ein=62 then gosub X
	if ein=63 then gosub Y
	if ein=64 then gosub Z
	if ein=65 then gosub N1
	if ein=66 then gosub N2
	if ein=67 then gosub N3
	if ein=68 then gosub N4
	if ein=69 then gosub N5
	if ein=70 then gosub N6
	if ein=71 then gosub N7
	if ein=72 then gosub N8
	if ein=73 then gosub N9
	if ein=74 then gosub N0
	if ein=75 then gosub Minus
	if ein=76 then gosub Equals
	if ein=77 then gosub BrckO
	if ein=78 then gosub BrckC
	if ein=79 then gosub Space
	if ein=80 then gosub Semicolon
	if ein=81 then gosub Appostrophy
	if ein=82 then gosub Comma
	if ein=83 then gosub Punkt
	if ein=84 then gosub Slash
	if ein=85 then gosub Appostrophy2
	if ein=86 then gosub ZRet
	if ein=87 then gosub ZSlash
	if ein=88 then gosub ZAsterisk
	if ein=89 then gosub ZMinus
	if ein=90 then gosub ZPlus
	if ein=91 then gosub Z5
	goto ProgKey

	$INCLUDE "KEYCODES.INC"

ProgKey:
	cls
	print" KeyProg v";ver$;" "
	if fle$="" then gosub InFileName
	print
	print"Taste: ";KeyString$
	print
	print"In welcher Verbindung wÅnschen Sie die Taste:"
	print
	if InitStringN$="NA" then color 8 else color 14
	print"1 - NORMAL";:if InitStringN$="NA" then print:goto 2
	if InitStringS$=InitStringN$ then print"/SHIFT";:InitStringS=1
	if InitStringC$=InitStringN$ then print"/CTRL";:InitStringC=1
	if InitStringA$=InitStringN$ then print"/ALT";:InitStringA=1
	print

2	if InitStringS=1 then color 8 else color 14
	if InitStringS$="NA" then color 8
	print"2 - SHIFT";:if InitStringS$="NA" then print:goto 3
	if InitStringC$=InitStringS$ then print"/CTRL";:InitStringC=1
	if InitStringA$=InitStringS$ then print"/ALT";:InitStringA=1
	print

3	if InitStringC=1 then color 8 else color 14
	if InitStringC$="NA" then color 8
	print"3 - CTRL";:if InitStringC$="NA" then print:goto 4
	if InitStringA$=InitStringC$ then print"/ALT";:InitStringA=1
	print

4	if InitStringA=1 then color 8 else color 14
	if InitStringA$="NA" then color 8
	print"4 - ALT"

5    ask$=inkey$:if ask$="" then 5
	if ask$="1" and InitStringN$<>"NA" and InitStringN<>1 then goto Normal
	if ask$="2" and InitStringS$<>"NA" and InitStringS<>1 then goto Shift
	if ask$="3" and InitStringC$<>"NA" and InitStringC<>1 then goto Control
	if ask$="4" and InitStringA$<>"NA" and InitStringA<>1 then goto Alt
	goto 5


	goto ProgEnd

Normal:
	cls
	print" KeyProg v";ver$;" "
	print
	color 15
	print"Taste: ";KeyString$
	print"Code : ";InitStringN$
	cde$=InitStringN$
	print
	goto MakeString

Shift:
	cls
	color 15
	print"Taste: [SHIFT]+";KeyString$
	print"Code : ";InitStringS$
	cde$=InitStringS$
	print
	goto MakeString

Control:
	cls
	color 15
	print"Taste: [CTRL]+";KeyString$
	print"Code : ";InitStringC$
	cde$=InitStringC$
	print
	goto MakeString

Alt:
	cls
	color 15
	print"Taste: [ALT]+";KeyString$
	print"Code : ";InitStringA$
	cde$=InitStringA$
	print
	goto MakeString

MakeString:
	print"Welcher Befehl soll zur Programmierung verwendet werden:"
	print"1 - PROMPT"
	print"2 - ECHO"
	print"3 - TYPE"
6	ask$=inkey$:if ask$="" then 6
	if ask$="1" then lin$="PROMPT $e[":endlin$="PROMPT $p$g"
	if ask$="2" then lin$="ECHO "+chr$(27)+"["
	if ask$="3" then lin$=chr$(27)+"["
	if val(ask$)<1 or val(ask$)>3 or int(val(ask$))<>val(ask$) then 6
	lin$=lin$+cde$+";"+chr$(34)
	input"Welcher String soll ausgegeben werden: ",ausg$
	lin$=lin$+ausg$+chr$(34)
7	input"Soll nach der Ausgabe [ENTER] ausgefÅhrt werden (J/N)";yn$
	if yn$="j" or yn$="J" then lin$=lin$+";13p":goto 8
	if yn$="n" or yn$="N" then lin$=lin$+"p":goto 8
	goto 7
8	on error goto NoFile
	open "A",#1,fle$
	on error goto
	if smf<>1 then
	  print#1,"@ECHO OFF"
	  print#1,": BATCH FILE made by KEYPROG v";ver$
	  if unreg=1 then print#1,": Unregistered Version!!!" else print#1,": Registered to <";usnam$;">"
	  print#1,": (C)1995 by RoboCop INDUSTRIES"
	  print#1,""
	end if
	print#1,lin$
	if unreg=1 then goto ProgEnd
9	print"Noch mehr Codes eingeben (J)a, in ";fle$;"; Ja, (a)ndere Datei;(N)ein ";
	input yn$
	if yn$<>"j" and yn$<>"J" and endlin$<>"" then print#1,endlin$:close #1 else close#1
	if yn$="j" or yn$="J" then goto YesSameFile
	if yn$="a" or yn$="A" then goto YesOthaFile
	if yn$="n" or yn$="N" then goto ProgEnd
	goto 9

NoFile:
	color 12
	print"UngÅltige Datei!!"
	color 15
	print
	print"Die Ausgabe-Datei ist ungÅltig."
	print
	goto ProgEnd

YesSameFile:
	cls
	endlin$=""
	InitStringN$=""
	InitStringS$=""
	InitStringC$=""
	InitStringA$=""
	KeyString$=""
	lin$=""
	ausg$=""
	smf=1
	goto Anfang

YesOthaFile:
	cls
	fle$=""
	endlin$=""
	InitStringN$=""
	InitStringS$=""
	InitStringC$=""
	InitStringA$=""
	KeyString$=""
	lin$=""
	ausg$=""
	goto Anfang

InFileName:
	input"Ausgabe-Datei (au·er bei TYPE-Mode, mei·t .BAT): ",fle$
	return

ProgEnd:
