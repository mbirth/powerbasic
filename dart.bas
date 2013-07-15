	print"Dart was written by"
	$INCLUDE "LOGO.INC"
	DELAY .5
Menu:
	CLS
	locate 1,1:color 15:print"ğğğ DART ğğğ by RoboCop INDUSTRIES"
	print:color 14
	print"Dieses Programm ist abgestimmt auf die DARTGAME~-Zielscheibe"
	print"von BEST sporting!"
	print:color 10
	print"W„hlen Sie eine Option:":color 15
	print" A - Spielregeln"
	print" B - Dart"
	print" C - Zielscheibe":color 12
	print" X - Ende"
	print
1	a$=inkey$:if a$="" then 1
	if a$="a" or a$="A" then goto Rules
	if a$="b" or a$="B" then goto Dart
	if a$="c" or a$="C" then goto Target
	if a$="x" or a$="X" then goto Ende
	sound 1000,.25
	goto 1

Rules:
	cls
	color 15:print"ğğğ Spielregeln ğğğ":color 14
	print
	print"Punkteverteilung:  Auge          - 50 Punkte"
	print"                   25-Ring       - 25 Punkte"
	print"                   mittlere Zone - 2x"
	print"                   „uáere Zone   - 3x"
	print
	color 10:print"                     === Taste drcken, wenn bereit ===":color 15
2	a$=inkey$:if a$="" then 2
	print"ğğğ Spielregeln ğğğ":color 14
	print
	print"Regeln:  1. Die Zielscheibe ist so aufzuh„ngen, daá die Mitte 1,72m ber dem"
	print"            Fuáboden h„ngt. Der Abstand von der Wurflinie zur Scheibe betr„gt"
	print"            2,44m, die Wurflinie darf nicht bertreten werden."
	print"         2. Jeder Spieler wirft zun„chst nur einen Dart auf die Schiebe. Der-"
	print"            jenige Spieler oder diejenige Mannschaft deren Dart dem Mittelpunkt"
	print"            am n„chsten kommt, beginnt das Spiel."
	print"         3. Jeder Spieler wirft abwechselnd 3 Darts. Treffer werden nur ge-"
	print"            wertet, wenn die Darts in der Scheibe steckenbleiben."
	print"         4. Es wird mit 301 Punkten bzw. bei Mannschaften mit 501 oder 1001"
	print"            begonnen. Von dieser Punktzahl werden die jeweils geworfenen"
	print"            Punkte abgezogen."
	print"         5. Das Spiel kann nur beendet werden, wenn ein Feld im Doppelring oder"
	print"            der Mittelpunkt getroffen wird. Mit der geworfenen Doppelziffer"
	print"            oder mit der Ziffer 50 muá exakt ";chr$(34);"Null";chr$(34);" erreicht werden."
	print"         6. Wird in der Endphase eine gr”áere Punktzahl geworfen als n”tig, um"
	print"            ";chr$(34);"Null";chr$(34);" zu erreichen, so ist die geworfene Punktzahl ungltig, die"
	print"            Punktzahl bleibt, wir sie vor dem Wurf war. Der Spieler"
	print"            (bzw. Mannschaft), der zuerst ";chr$(34);"Null";chr$(34);" erreicht hat, ist Sieger."
	print
	print
	print:color 10
	print"                     === Taste drcken, wenn bereit ===";:color 15
3	a$=inkey$:if a$="" then 3
	goto Menu

Dart:
	cls
	color 15:print"ğğğ DARTGAME ğğğ"
	print
	input"Anzahl Spieler  : ",players
	for x=1 to players
	  print"Name Spieler";x;
	  input" :",playername$(x)
	next x
	open "O",#1,"DART.GAM"
	print#1,"ğğğ DARTGAME ğğğ (by RoboCop INDUSTRIES)"
	print#1,""
	print#1,"Name         Wurf Pfeil Punkte ges.Punkte   í   "
	print#1,"============ ==== ===== ====== ========== ===== "
	cls
	color 15:print"ğğğ DARTGAME ğğğ"
	print
	for maximum=1 to 500
	  for x=1 to players
	    throw(x)=throw(x)+1
	    locate 3,1:print"Spieler";x;":  "
	    locate 4,1:print playername$(x);"          "
	    locate 5,1:print"Statistik:"
	    locate 7,1:print"Wurf Pfeil Punkte ges.Punkte   í   "
	    locate 8,1:print"==== ===== ====== ========== ======"
	    for y=1 to 3
		 arrow(x)=arrow(x)+1
		 locate 9,12:input"",points
		 points(x)=points(x)+points
		 locate 9,1:print using"#### ##### ###### ########## ###.##";throw(x);y;points;points(x);points(x)/arrow(x);
		 print #1,using"#### ##### ###### ########## ###.##";throw(x);y;points;points(x);points(x)/arrow(x);
	    next y
	  next x
	next maximum


Target:

Ende:
	cls
	color 15:print"ğğğ DART ğğğ was written by"
	$INCLUDE "LOGO.INC"
	print
	end
