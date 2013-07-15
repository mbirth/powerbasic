	cls
	timer on
	print"ð Sound Extractor"
	print"  written by RoboCop INDUSTRIES"
	print
	print"Grabbing file information ... "
	print"  þ Shelling to DOS ... ";
	ShellCmd$="DIR "+command$+" > SE.$$$"
	shell ShellCmd$
	print "OK"
	print"  þ Opening Temp-File ... ";
	open "I",#1,"SE.$$$"
	print "OK"
	print"  þ Reading Temp-File ... ";
	for z=1 to 5
	  line input#1,DummesZeugs$
	next z
	line input#1,DateiInfo$
	print "OK"
	print"  þ Killing Temp-File ... ";
	close #1
	kill "SE.$$$"
	open "O",#1,"SE.$$$"
	print#1,"PHYSICALLY DELETED! HARHARHAR!"
	close #1
	kill "SE.$$$"
	print "OK"
	print"  þ Calculating File-Info ... ";
	FileSize=val(mid$(DateiInfo$,14,5))*1000000+val(mid$(DateiInfo$,20,3))*1000+val(mid$(DateiInfo$,24,3))
	FileDate$=mid$(DateiInfo$,28,8)
	FileTime$=mid$(DateiInfo$,39,5)
	print"OK":locate 4,31:print "OK":locate 11,1
	ver$="("+FileDate$+" / "+FileTime$+")"

	print"Grabbing VOCs ..."
	print"  þ Opening ";command$;ver$;" ... ";
	open "B",#1,command$
	print"OK"
	print"  þ Wasting Header-Info ... ";
	AnfTime=timer
	CurFil=0
	open "O",#2,"Dummy.FCB"
	on timer(1) gosub 3
1    get$ #1,6,Look$
	seek #1,seek(1)-4
	CalcRate=1000
	CalcCnt=CalcCnt+1
	MedTime=MedTime+(Timer-AnfTime)/(Seek(1)/FileSize)
	if CalcCnt=CalcRate then CalcTime=MedTime/CalcRate:CalcCnt=0:MedTime=0
'	if LoLo=0 then LoLo=1 else LoLo=LoLo+2
'	if LoLo>=79 then LoLo=1
'	locate 24,LoLo:print Look$;" ";
	if Look$="Creati" then
	  close #2
	  CurFil=CurFil+1
	  if CurFil=1 then kill "DUMMY.FCB":print "OK":print"  þ Grabbing VOCs ... ";
	  NumChar$=mid$(str$(CurFil),2,7)
	  MedName$=NumChar$
	  if len(NumChar$)=1 then MedName$="0000"+NumChar$
	  if len(NumChar$)=2 then MedName$="000"+NumChar$
	  if len(NumChar$)=3 then MedName$="00"+NumChar$
	  if len(NumChar$)=4 then MedName$="0"+NumChar$
	  NextFile$="VOC"+MedName$+".VOC"
	  open "O",#2,NextFile$
	  print#2,"Cr";
	  Crea=1
	end if
	if Crea=1 then Crea=0:goto 1
	print#2,left$(Look$,2);
	if eof(1) then goto 2
	if inkey$=chr$(27) then goto 2
	goto 1

3	locate 18,1:print using"##########/########## \          \ ####.##/####.## ###.##";seek(1);FileSize;NextFile$;timer-AnfTime;CalcTime;(Seek(1)/FileSize)*100;
	return

2    close #1:close #2
	print"Fertig!"
