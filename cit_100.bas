	dim matrix(15,15):lx=1:ly=1
	dim wert(15)
	dim wert$(15)
	for x=1 to 11
	  for y=1 to 9
	    matrix(x,y)=0
	  next y
	next x
	cls:screen 12:color 15
	print"נננ CITIZEN 120D נננ"
	print
	gosub ShowIt
2	locate lx+2,ly
	if matrix(ly,lx)=0 then color 30:print"‏" else color 26:print"±"
	color 15
1	a$=inkey$:if a$="" then 1
	if mid$(a$,2,1)="P" and lx<9 then lx=lx+1:gosub ShowIt:goto 2
	if mid$(a$,2,1)="H" and lx>1 then lx=lx-1:gosub ShowIt:goto 2
	if mid$(a$,2,1)="K" and ly>1 then ly=ly-1:gosub ShowIt:goto 2
	if mid$(a$,2,1)="M" and ly<11 then ly=ly+1:gosub ShowIt:goto 2
	if a$=" " and matrix(ly,lx)=0 then matrix(ly,lx)=1:gosub ShowIt:goto 2
	if a$=" " and matrix(ly,lx)=1 then matrix(ly,lx)=0:gosub ShowIt:goto 2
	if a$=chr$(27) then goto Fertig
	goto 1

ShowIt:
	for x=1 to 11
	  for y=1 to 9
	    locate y+2,x
	    if matrix(x,y)=1 then color 15:print"Û"
	    if matrix(x,y)=0 then color 8:print"ת"
	  next y
	next x
	return

Fertig:
	for x=1 to 11
	  for y=1 to 9
	    locate y+2,x
	    if matrix(x,y)=1 then color 15:print"Û"
	    if matrix(x,y)=0 then color 8:print"ת"
	  next y
	next x
	for x=1 to 11
	  for y=1 to 9
	    if y=1 and matrix(x,y)=1 then wert=wert+128
	    if y=2 and matrix(x,y)=1 then wert=wert+64
	    if y=3 and matrix(x,y)=1 then wert=wert+32
	    if y=4 and matrix(x,y)=1 then wert=wert+16
	    if y=5 and matrix(x,y)=1 then wert=wert+8
	    if y=6 and matrix(x,y)=1 then wert=wert+4
	    if y=7 and matrix(x,y)=1 then wert=wert+2
	    if y=8 and matrix(x,y)=1 then wert=wert+1
	    if y=9 and matrix(x,y)=1 then wert=wert+0
	  next y
	  wert(x)=wert
	  wert=0
	next x
	for x=1 to 11
	  wert$(x)=using$("###",wert(x))
	next x:color 10
	for x=1 to 11
	  for y=12 to 14
	    locate y,x
	    print mid$(wert$(x),y-11,1);
	  next y
	  locate 15,x:color 11:print chr$(wert(x));:color 10
	next x
	for x=1 to 11
	  for y=1 to 9
	    if matrix(x,y)=1 then pset (x+150,y+45),15
	  next y
	next x
5	locate 17,1:input"ASCII-Code: ",asci
	if asci<32 or asci>126 then 5
	locate 17,20:print"Altes Zeichen: ";chr$(asci)
6	locate 18,1:input"Stimmt das (Ja/Nein/Anderer ASCII-Code)? ",YN$
	if yn$="j" or yn$="J" then goto JaStimmt
	if yn$="n" or yn$="N" then goto 2
	if yn$="a" or yn$="A" then goto 5
	goto 6
JaStimmt:
	color 10
	print"Sende Daten ... ";
	lprint chr$(27);":";chr$(0);chr$(0);chr$(0);
	lprint chr$(27);"=";chr$(15);chr$(0);chr$(20);chr$(asci);chr$(0);chr$(0);
	for x=1 to 11
	  lprint chr$(wert(x));
	next x
	lprint
	lprint chr$(27);"I";chr$(4);
	lprint "נננ CITIZEN 120D נננ       ";
	lprint "Neues Zeichen: ";chr$(asci)
	print "OK"
7	locate 20,1:print"Noch ein Zeichen programmieren (J/N)? ",YN$
	if YN$="j" or YN$="J" then run
	if YN$="n" or YN$="N" then goto Ende
	goto 7

Ende:
	screen 0,0,0:color 15:print"נננ CITIZEN 120D נננ  was written by RoboCop INDUSTRIES"
	print
	end
