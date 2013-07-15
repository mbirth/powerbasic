	ver$="1.3"
	BeginCheck=10000
	print"Scanning for Checksum .";
	shell "DIR BOOTINFO.EXE > BOOTINFO.TMP"
	print".";
	for x=1 to len(command$)
	  if File=0 then LogFile$=LogFile$+mid$(command$,x,1)
	  if File=1 then OutText$=OutText$+mid$(command$,x,1)
	  if mid$(command$,x+1,1)=" " then File=1
	next x
	print".";
	open "I",#1,"BOOTINFO.TMP"
	for z=1 to 5
	  line input#1,DummesZeugs$
	next z
	print".";
	line input#1,DateiInfo$
	close #1
	kill "BOOTINFO.TMP"
	print".";
	open "O",#1,"BOOTINFO.TMP"
	print#1,"PHYSICALLY DELETED! HARHARHAR!"
	close #1
	kill "BOOTINFO.TMP"
	print".";
	FileSize=val(mid$(DateiInfo$,14,5))*1000000+val(mid$(DateiInfo$,20,3))*1000+val(mid$(DateiInfo$,24,3))
	FileDate$=mid$(DateiInfo$,28,8)
	FileTime$=mid$(DateiInfo$,39,5)
	ver$=ver$+"   ("+FileDate$+" / "+FileTime$+")"
	open "BOOTINFO.EXE" FOR BINARY AS #1
	get$ #1,256,CheckSum$
	print".";
	CheckSumme=0
	get$ #1,BeginCheck-1,Dummy$
	Dummy$=""
	for x=BeginCheck to FileSize step 4
	  if x=23738 or x=23740 then goto HereIsNext
	  get$ #1,2,CheckSum$
	  CurrentCheckSumL=ASCII(left$(CheckSum$,1))
	  CurrentCheckSumR=ASCII(right$(CheckSum$,1))
	  if CurrentCheckSumL=-1 then CurrentCheckSumL=0
	  if CurrentCheckSumR=-1 then CurrentCheckSumR=0
	  CheckSumme=CheckSumme+CurrentCheckSumL+CurrenCheckSumR
	  if CheckSumme>65535 then CheckSumme=-65535+CheckSumme
HereIsNext:
	next x
	close #1
	CheckSum$=hex$(CheckSumme)
	print". ";
	IF FileSize<>0025488 then goto FileSizeAlert
	if CheckSum$<>"9055" then goto CheckSumAlert
	print"Veryfied (";mid$(str$(FileSize),2,20);" / ";CheckSum$;")"
	IF COMMAND$="" THEN GOTO Syntax
	sound 750,2
	delay 3/18.2
	sound 1250,1
	delay 2/18.2
	sound 1250,1
	delay 2/18.2
	sound 1500,2
	color 7:print"Writing BootInfo .";
	open "A",#1,LogFile$
	print".";
	dat$=mid$(date$,4,2)+"."+mid$(date$,1,2)+"."+mid$(date$,7,4)
	OutText$=dat$+" / "+time$+"   "+OutText$
	print".";
	print#1,OutText$
	print".";
	close #1
	print". ";
	print"Written (";mid$(str$(len(OutText$)),2,4);" Chars)"
	goto Ende

Syntax:
	$INCLUDE "LOGO.INC"
	color 14
	print"another program from RoboCop INDUSTRIES"
	print:color 10
	print"BootInfo - v";ver$:color 15
	print
	print"Syntax: BootInfo [Log-File] [Information]"
	print:color 7
	print"Log-File      - Filename of the Log-File"
	print"                If it exists the entry will be added."
	print"Information   - The Text, which will be written to the Log-File"
	goto Ende

CheckSumAlert:
	print"Alert [CheckSum does not match (";CheckSum$;")]"
	goto VirusAlert

FileSizeAlert:
	print"Alert [FileSize does not match (";mid$(str$(FileSize),2,20);")]"
	goto VirusAlert

VirusAlert:
	$INCLUDE "LOGO.INC"
	color 28
	print
	print"VIRUS ALERT!!!!!!!"
	color 12
	print
	print"The File-Checksum is changed, possibly a virus"
	print"infected this file or some HACKERs have done it's work."
	print:color 26
	print"This program locks up in 5 seconds...";
	for y=1 to 30
	  for x=1 to 500 step 75
	    sound 750+x,.5
	  next x
	next y
	color 10
	print"LOCKED UP"
	delay 1.5
	sound 750,1
	sound 1250,1
	print"BOOT UP Sequence engaged, please confirm..."
	delay 1
	sound 1250,1
	sound 1500,2
	sound 800,3
	print"BOOT UP Sequence confirmed. Boot.";
	for x=1 to 4
	  delay 1
	  print ".";
	next x
	print
	$INLINE "INLINES\BOOT_R.COM"



Ende: