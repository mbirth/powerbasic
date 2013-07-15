	CLS
	color 15
	print"ррр MiniTETRIS ррр by RoboCop INDUSTRIES"
	color 7
	print
	print"Setze Dimensionen ... ";
	dim lin$(12)
	dim Choose1$(8,12)
	dim Choose2$(8,12)
	print"gesetzt"
	print"Lade Highscores ... ";
	open "B",#1,"HIGHSCOR.E"
	get$ #1,29,Dummy$
	get$ #1,1,CHS1$
	get$ #1,9,Dummy$
	get$ #1,1,CHS2$
	get$ #1,19,Dummy$
	get$ #1,1,CHS3$
	get$ #1,4,Dummy$
	get$ #1,2,ML$
	CodedHS$=CHS1$+CHS2$+CHS3$
	ML1$=left$(ML$,1)
	ML2$=right$(ML$,1)
	ml1=ascii(ml1$)
	ml2=ascii(ml2$)
	if ml1=-1 then ml1=0
	if ml2=-1 then ml2=0
	MaxLines=ml1+(ml2*256)
	byte1=ascii(left$(CodedHS$,1))
	byte2=ascii(mid$(CodedHS$,2,1))
	byte3=ascii(right$(CodedHS$,1))
	if byte1=-1 then byte1=0
	if byte2=-1 then byte2=0
	if byte3=-1 then byte3=0
	HS=byte3+(byte2*256)+(byte1*65536)
	print"geladen"
	print"Speichere aktuellen Font ... ";
	shell"SAVEFONT >ORIGINAL.FNT"
	print"gespeichert"
	print"Lade Font ... ";
	shell"LOADFONT <TETRIS.FNT"
	print"geladen"
	print"Setze Zeichenabstand ... ";
	shell"CHRWIDTH 8"
	print"gesetzt"
	delay .5
	cls
	color 15
	Rahmen=0
	HG=1
	Spielfeld=7
	Zeichen=0
	Knopf=4
	frei=25
	color ,HG
	cls
	print
	print
	print space$(frei);:color Rahmen,HG:?" ЬЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЬ "
	print space$(frei);:color Rahmen,Spielfeld:?"ЫЫЫЫЫЫЯЯЯЯЯЯЯЯЯЯЯЯЯЯЯЯЯЯЫЫЫЫЫЫ";:color Rahmen,HG:?"    ";chr$(27);" - Links"
	print space$(frei);"ЫЫЫЫЫ";:color Zeichen,Spielfeld:?"  LDNFSSCGHF NFXJ #$";:color Rahmen,HG:?"ЫЫЫЫЫ    ";chr$(26);" - Mechts"
	print space$(frei);"ЫЫЫЫЫ";:color Zeichen,Spielfeld:?" 8I8I8I8I8I  YVVV   ";:color Rahmen,HG:?"ЫЫЫЫЫ    ";chr$(24);" - Motieren / Start"
	print space$(frei);"ЫЫЫЫЫ";:color Zeichen,Spielfeld:?"  [][][][][][][][]  ";:color Rahmen,HG:?"ЫЫЫЫЫ    ";chr$(25);" - Munter / Select"
	print space$(frei);"ЫЫЫЫЫ";:color Zeichen,Spielfeld:?"  [][][][][][][][]  ";:color Rahmen,HG:?"ЫЫЫЫЫ    ™ - ™ause"
	print space$(frei);"ЫЫЫЫЫ";:color Zeichen,Spielfeld:?"  [][][][][][][][]  ";:color Rahmen,HG:?"ЫЫЫЫЫ    S - Ber„usche"
	print space$(frei);"ЫЫЫЫЫ";:color Zeichen,Spielfeld:?"  [][][][][][][][]  ";:color Rahmen,HG:?"ЫЫЫЫЫ    M - Meset"
	print space$(frei);"ЫЫЫЫЫ";:color Zeichen,Spielfeld:?"  [][][][][][][][]  ";:color Rahmen,HG:?"ЫЫЫЫЫ{FSC} - Fnde"
	print space$(frei);"ЫЫЫЫЫ";:color Zeichen,Spielfeld:?"  [][][][][][][][]  ";:color Rahmen,HG:?"ЫЫЫЫЫ"
	print space$(frei);"ЫЫЫЫЫ";:color Zeichen,Spielfeld:?"  [][][][][][][][]  ";:color Rahmen,HG:?"ЫЫЫЫЫ"
	print space$(frei);"ЫЫЫЫЫ";:color Zeichen,Spielfeld:?"  [][][][][][][][]  ";:color Rahmen,HG:?"ЫЫЫЫЫ"
	print space$(frei);"ЫЫЫЫЫ";:color Zeichen,Spielfeld:?"  [][][][][][][][]  ";:color Rahmen,HG:?"ЫЫЫЫЫ"
	print space$(frei);"ЫЫЫЫЫ";:color Zeichen,Spielfeld:?"  [][][][][][][][]  ";:color Rahmen,HG:?"ЫЫЫЫЫ"
	print space$(frei);"ЫЫЫЫЫ";:color Zeichen,Spielfeld:?"  [][][][][][][][]  ";:color Rahmen,HG:?"ЫЫЫЫЫ"
	print space$(frei);"ЫЫЫЫЫ";:color Zeichen,Spielfeld:?"  [][][][][][][][]  ";:color Rahmen,HG:?"ЫЫЫЫЫ"
	print space$(frei);:color Rahmen,Spielfeld:?"ЫЫЫЫЫЫЬЬЬЬЬЬЬЬЬЬЬЬЬЬЬЬЬЬЫЫЫЫЫЫ":color Rahmen,HG
	print space$(frei);:color Rahmen,Knopf:?"ЫЫЯ  ЯЫЫЫЫЯ  ЯЫЫЫЫЫЯЯЫЫЯ   ЯЫЫ":color Rahmen,HG
	print space$(frei);:color Rahmen,Knopf:?"ЫЫЬ  ЬЫЫЫЫЬ  ЬЫЫЫЯЯЬЬЫЫ     ЫЫ":color Rahmen,HG
	print space$(frei);:color Rahmen,Knopf:?"ЫЫЫЫЫЫЯ  ЯЫЫЫЫЫЯЯЬЬЫЫЫЫЫЬЬЬЫЫЫ":color Rahmen,HG
	print space$(frei);:color Rahmen,Knopf:?"ЫЫЫЫЫЫЬ  ЬЫЫЫЫЫЬЬЫЫЫЫЫЫЫЫЫЫЫЫЫ":color Rahmen,HG
	print space$(frei);"ЯЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЯ":color Rahmen,HG
	snd=0
	pause=1
	Chosen=1
	gosub UpDate1st

	delay .1
	scores=HS
	gosub WriteScores
	delay .1
	lines=MaxLines
	gosub WriteLines
	delay .1
	for x=1 to 12
	  lin$(x)="00000000"
	next x
	gosub WritePlayField
	delay .1
	nex$="0000"
	gosub WriteNext
	delay .1
	pause=0
	gosub UpDate1st
	delay .1
	Choose1$(1,01)="# # # # "
	Choose1$(1,02)="       #"
	Choose1$(1,03)="#       "
	Choose1$(1,04)="    #  #"
	Choose1$(1,05)="#  ##   "
	Choose1$(1,06)="    #  #"
	Choose1$(1,07)="#   #   "
	Choose1$(1,08)="    #  #"
	Choose1$(1,09)="#   #   "
	Choose1$(1,10)="   ### #"
	Choose1$(1,11)="#       "
	Choose1$(1,12)=" # # # #"
	Choose1$(2,01)="# # # # "
	Choose1$(2,02)="       #"
	Choose1$(2,03)="#       "
	Choose1$(2,04)="   ##  #"
	Choose1$(2,05)="# #  #  "
	Choose1$(2,06)="     # #"
	Choose1$(2,07)="#   #   "
	Choose1$(2,08)="   #   #"
	Choose1$(2,09)="# #     "
	Choose1$(2,10)="  #### #"
	Choose1$(2,11)="#       "
	Choose1$(2,12)=" # # # #"
	Choose1$(3,01)="# # # # "
	Choose1$(3,02)="       #"
	Choose1$(3,03)="#       "
	Choose1$(3,04)="  ###  #"
	Choose1$(3,05)="#    #  "
	Choose1$(3,06)="     # #"
	Choose1$(3,07)="# ###   "
	Choose1$(3,08)="     # #"
	Choose1$(3,09)="#    #  "
	Choose1$(3,10)="  ###  #"
	Choose1$(3,11)="#       "
	Choose1$(3,12)=" # # # #"
	Choose1$(4,01)="# # # # "
	Choose1$(4,02)="       #"
	Choose1$(4,03)="#       "
	Choose1$(4,04)="  #    #"
	Choose1$(4,05)="# #  #  "
	Choose1$(4,06)="  #  # #"
	Choose1$(4,07)="# ####  "
	Choose1$(4,08)="     # #"
	Choose1$(4,09)="#    #  "
	Choose1$(4,10)="     # #"
	Choose1$(4,11)="#       "
	Choose1$(4,12)=" # # # #"

	Choose2$(1,01)=" # # # #"
	Choose2$(1,02)="#       "
	Choose2$(1,03)="       #"
	Choose2$(1,04)="#   #   "
	Choose2$(1,05)="   ##  #"
	Choose2$(1,06)="#   #   "
	Choose2$(1,07)="    #  #"
	Choose2$(1,08)="#   #   "
	Choose2$(1,09)="    #  #"
	Choose2$(1,10)="#  ###  "
	Choose2$(1,11)="       #"
	Choose2$(1,12)="# # # # "
	Choose2$(2,01)=" # # # #"
	Choose2$(2,02)="#       "
	Choose2$(2,03)="       #"
	Choose2$(2,04)="#  ##   "
	Choose2$(2,05)="  #  # #"
	Choose2$(2,06)="#    #  "
	Choose2$(2,07)="    #  #"
	Choose2$(2,08)="#  #    "
	Choose2$(2,09)="  #    #"
	Choose2$(2,10)="# ####  "
	Choose2$(2,11)="       #"
	Choose2$(2,12)="# # # # "
	Choose2$(3,01)=" # # # #"
	Choose2$(3,02)="#       "
	Choose2$(3,03)="       #"
	Choose2$(3,04)="# ###   "
	Choose2$(3,05)="     # #"
	Choose2$(3,06)="#    #  "
	Choose2$(3,07)="  ###  #"
	Choose2$(3,08)="#    #  "
	Choose2$(3,09)="     # #"
	Choose2$(3,10)="# ###   "
	Choose2$(3,11)="       #"
	Choose2$(3,12)="# # # # "
	Choose2$(4,01)=" # # # #"
	Choose2$(4,02)="#       "
	Choose2$(4,03)="       #"
	Choose2$(4,04)="# #     "
	Choose2$(4,05)="  #  # #"
	Choose2$(4,06)="# #  #  "
	Choose2$(4,07)="  #### #"
	Choose2$(4,08)="#    #  "
	Choose2$(4,09)="     # #"
	Choose2$(4,10)="#    #  "
	Choose2$(4,11)="       #"
	Choose2$(4,12)="# # # # "

10   ShowScores=ShowScores+2
	for x=1 to 12
	  lin$(x)=Choose1$(Chosen,x)
	next x
	gosub WritePlayField
	if ShowScores=6 then gosub WriteScores
	if ShowScores=12 then ShowScores=0:gosub WriteLines
	delay .15
	for x=1 to 12
	  lin$(x)=Choose2$(Chosen,x)
	next x
	gosub WritePlayField
	delay .15
	a$=inkey$
	if mid$(a$,2,1)="P" then Chosen=Chosen+1:if Chosen=9 then Chosen=1:goto 10
	if mid$(a$,2,1)="H" then goto GameSelected
	if (a$="s" or a$="S") and snd=1 then snd=0:gosub UpDate1st:goto 10
	if (a$="s" or a$="S") and snd=0 then snd=1:gosub UpDate1st:goto 10
	if a$=chr$(27) then goto Ende
	goto 10







1	a$=inkey$:if a$="" then 1
	goto Ende


WritePlayField:
	for y=1 to 12
	  for x=1 to 8
	    x$=mid$(lin$(y),x,1)
	    if x$="#" then WL$=WL$+"[]" else wl$=wl$+"  "
	  next x
	  locate 5+y,frei+8
	  print using "\               \";WL$
	  wl$=""
	next y
	return

WriteNext:
	for x=1 to 5
	  x$=mid$(nex$,x,1)
	  if x$="0" then NXT$=NXT$+" "
	  if x$="1" then NXT$=NXT$+"A"
	  if x$="2" then NXT$=NXT$+"Y"
	  if x$="3" then NXT$=NXT$+"V"
	  if x$="#" then col=Zeichen+16
	  if x$="" then col=Zeichen
	next x
	locate 5,frei+19
	color col,Spielfeld
	print nxt$
	color Zeichen,Spielfeld
	nxt$=""
	return

UpDate1st:
	color Zeichen,Spielfeld
	locate 4,frei+24
	if pause=0 then print"  "
	if pause=1 then print"#$"
	locate 4,frei+6
	if snd=0 then print" "
	if snd=1 then print chr$(14):gosub MODESound
	return

MODESound:
	sound 1100,1
	sound 990,1
	sound 810,1
	sound 510,1
	return

WriteScores:
	locate 4,frei+8
	color Zeichen,Spielfeld
	print"     SCGHF NFXJ"
	locate 5,frei+7
	sco$=using$("#####",scores)
	for x=1 to len(sco$)
	  x$=mid$(sco$,x,1)
	  if x$=" " then scores$=scores$+"бљ"
	  if x$="0" then scores$=scores$+"0P"
	  if x$="1" then scores$=scores$+"1Q"
	  if x$="2" then scores$=scores$+"2W"
	  if x$="3" then scores$=scores$+"3E"
	  if x$="4" then scores$=scores$+"4R"
	  if x$="5" then scores$=scores$+"5T"
	  if x$="6" then scores$=scores$+"6Z"
	  if x$="7" then scores$=scores$+"7U"
	  if x$="8" then scores$=scores$+"8I"
	  if x$="9" then scores$=scores$+"9O"
	next x
	if scores=0 then scores$="бљбљбљ0P0P"
	print scores$
	sco$=""
	scores$=""
	return

WriteLines:
	locate 4,frei+8
	color Zeichen,Spielfeld
	print"LDNFS          "
	locate 5,frei+7
	lin$=using$("###  ",lines)
	for x=1 to len(lin$)
	  x$=mid$(lin$,x,1)
	  if x$=" " then lines$=lines$+"бљ"
	  if x$="0" then lines$=lines$+"0P"
	  if x$="1" then lines$=lines$+"1Q"
	  if x$="2" then lines$=lines$+"2W"
	  if x$="3" then lines$=lines$+"3E"
	  if x$="4" then lines$=lines$+"4R"
	  if x$="5" then lines$=lines$+"5T"
	  if x$="6" then lines$=lines$+"6Z"
	  if x$="7" then lines$=lines$+"7U"
	  if x$="8" then lines$=lines$+"8I"
	  if x$="9" then lines$=lines$+"9O"
	next x
	print lines$
	lin$=""
	lines$=""
	return

GameSelected:

Ende:
	color 15,0
	cls
	print"ррр MiniTETRIS ррр by RoboCop INDUSTRIES"
	print
	color 7,0
	print"Speichere aktuellen Font ... gespeichert"
	print"Lade Font ... geladen"
	print"Setze Zeichenabstand ... gesetzt"
	print"Stelle Font wieder her ... ";
	SHELL "LOADFONT <ORIGINAL.FNT"
	print"hergestellt"
	print"Stelle Zeichenabstand wieder her ... ";
	SHELL "CHRWIDTH 7"
	print"hergestellt"
	print