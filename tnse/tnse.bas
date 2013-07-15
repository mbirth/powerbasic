	cls
	print"ð Terra Nova Sound Extractor"
	print"  written by RoboCop INDUSTRIES"
	print
	print"Extracts VOC-Files from the RESBRKxx-Files but works with all others, too."
	print"Syntax: TNSE RESBRKxx.RES      where xx is the number of the resource"
	print
	print"Opening ";command$;" ... ";
	open "B",#1,command$
	print"OK"
	CurFil=0
	open "O",#2,"Dummy.FCB"
1    get$ #1,6,Look$
	seek #1,seek(1)-4
	locate 8,1:print using"Byte ##########, \         \ ... ";seek(1);NextFile$;
'	if LoLo=0 then LoLo=1 else LoLo=LoLo+2
'	if LoLo>=79 then LoLo=1
'	locate 9,LoLo:print Look$;" ";
	if Look$="Creati" then
	  close #2
	  CurFil=CurFil+1
	  if CurFil=1 then kill "DUMMY.FCB"
	  NextFile$="VOC"+mid$(str$(CurFil),2,7)+".VOC"
	  open "O",#2,NextFile$
	  print#2,"Cr";
	  Crea=1
	end if
	if Crea=1 then Crea=0:goto 1
	print#2,left$(Look$,2);
	if eof(1) then goto 2
	goto 1
2    close #1:close #2
	print"Fertig!"
