	color 15:print"ððð MakeRegister ððð"
	print
2	input"Manuelle oder Automatische Eingabe (M/A)";ask$
	if ask$="M" or ask$="m" then goto Manual
	if ask$="A" or ask$="a" then goto Automatic
	goto 2
10	shell"DIR C:\*.* >makereg.tmp"
	open "I",#1,"makereg.tmp"
	line input#1,dummy$
	line input#1,hdname$
	line input#1,hdnumb$
	close #1
	open "O",#1,"makereg.tmp"
	print#1,"PHYSIKALISCH GEL™SCHTE DATEI!!!"
	close #1
	kill "makereg.tmp"
	hdname$=right$(hdname$,11)
	hdnumb$=right$(hdnumb$,9)
5	for zet=1 to len(hdname$)
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
	?"Codierter HD-Name : ";hdn$
	?"Codierte HD-Nummer: ";hdnum$
	ser$=str$(val(hdnum$)+val(hdn$))
	ser$=right$(ser$,len(ser$)-1)
	?"Registrationscode : ";ser$
	for zet=1 to len(ser$)
	  serf$=serf$+chr$(asc(mid$(ser$,zet,1))+100)
	next zet
	?"Fertiger Code     : ";serf$
	?"ASC-Code          :"
	?
	for zet=1 to len(serf$)
	  ?asc(mid$(serf$,zet,1));" ";
	next zet
	print
	color 10
	print
	print"In der 2. Zeile der SERIAL.NUM ";:color 12:print"muá";:color 10
	print" der Name des Benutzers stehen!"
	color 15
	goto Ende

Manual:
	print
	input"Laufwerksbezeichnung (C): ",hdname$
	input"Laufwerksnummer (auch C): ",hdnumb$
	print
	goto 5

Automatic:
	print
	goto 10

Ende:
	print
	input"Soll die SERIAL.NUM geschrieben werden (J/N) ";yn$
	if yn$="j" or yn$="J" then goto WriteSER
	if yn$="n" or yn$="N" then goto ProgEnd
	goto Ende

WriteSER:
	print
	input"Benutzernamen eingeben: ";unam$
	open "O",#1,"SERIAL.NUM"
	print#1,serf$
	print#1,unam$
	close #1
	print
	print"FERTIG!"
	goto ProgEnd

ProgEnd: