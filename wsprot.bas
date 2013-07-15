	TempDir$=environ$("TEMP")
	if Command$="" then
	  goto Syntax
	else
	  WinDir$=Command$
	  WinIniTest$=WinDir$+"\WIN.INI"
	  on error goto NotAValidPath
	  FileEx$=Dir$(WinIniTest$)
	  if FileEx$<>"" then WinDir$=Command$ else goto NotAValidPath
	  on error goto
	end if
	OpenString$=WinDir$+"\WINSTART.BAT"
	ConfigString$=WinDir$+"\WSPROT.INI"

'	Um die Ausgaben auch in der Datei %TEMP%\WSPROT.MSG zu haben, einfach
'    alle REMs in den folgenden Zeilen entfernen

'	MsgFile$=TempDir$+"\WSPROT.MSG"
	Ready$="˚"
	Warning$="!"
	DontKnow$="?"
	OnlyRead$="ˆ"
	Working$=""
'	open "A",#5,MsgFile$
'	print#5,""
'	print#5,"============================================="
'	print#5,"New Test [";date$;" / ";time$;"]:"
'	close #5
	cls
	shell "mode co80"
	SUB PrintCentered (OutLine%,Text$) STATIC
'	  MsgFile$=environ$("TEMP")+"\WSPROT.MSG"
'	  open "a",#5,MsgFile$
'	  print#5,Text$
'	  close #5
	  AddOn=(58-len(Text$))/2
	  if AddOn<0 then AddOn=0
	  Text$=Space$(AddOn)+Text$+Space$(AddOn)
	  if OutLine%=0 then
	    OL1$=OL2$
	    OL2$=OL3$
	    OL3$=OL4$
	    OL4$=OL5$
	    OL5$=OL6$
	    OL6$=Text$
	    locate 17,11:print OL1$
	    locate 18,11:print OL2$
	    locate 19,11:print OL3$
	    locate 20,11:print OL4$
	    locate 21,11:print OL5$
	    locate 22,11:print OL6$
	  else
	    locate OutLine%,11:print Text$;
	  end if
	END SUB
	goto StartHere

NoWINSTART:
	beep
	close #1
	call PrintCentered(0,"No WINSTART.BAT found, creating new one...")
	call PrintCentered(9,"Creating new WINSTART.BAT...")
	open "o",#1,OpenString$
	print#1,"@ECHO OFF"
	print#1,WinDir$;"\WSPROT.EXE ";WinDir$
	close #1
	resume Ende

NoCONFIG:
	beep
	call PrintCentered(0,"No Initialisation-File found,")
	call PrintCentered(0,"a new one will be created.")
	call PrintCentered(0,"")
	NewCONFIG=1
	resume AfterConfigTest

StartHere:
	color 9,1
	for x=1 to 25
	  for y=1 to 80
	  locate x,y:print"±";
	  next y
	next x
	color 8,0
	for x=4 to 24
	  locate x,71:print"±±";
	next x
	for y=13 to 72
	  locate 25,y:print"±";
	next y
	color 14,1
	locate 2,10:print"…";
	locate 2,70:print"ª";
	locate 24,10:print"»";
	locate 24,70:print"º";
	for x=11 to 69
	  locate 2,x:print"Õ";
	  locate 24,x:print"Õ";
	next x
	for y=3 to 23
	  locate y,10:print"∫";
	  locate y,70:print"∫";
	next y
	for x=3 to 23
	  for y=11 to 69
	  locate x,y:print" ";
	  next y
	next x
	color 15,1
	call PrintCentered(4,"Windows")
	call PrintCentered(5,"WinStart-Protector")
	color 12,1
	call PrintCentered(6,"written by RoboCop INDUSTRIES")
	color 11,1
	locate 11,15:print"- WINSTART.BAT: Size/Date"
	locate 13,15:print"- WINSTART.BAT: CheckSum"
	locate 15,15:print"- WINSTART.BAT: Attribs"
	locate 11,41:print"- WIN.INI: 'load='-Entries"
	locate 13,41:print"- WIN.INI: 'run=' -Entries"
	color 15,1
	call PrintCentered(9,"Looking for Configuration-File...")
	on error goto NoCONFIG
	  open "I",#1,ConfigString$
	  call PrintCentered(0,"Config-File found.")
	on error goto
	call PrintCentered(9,"Reading Configuration...")
	input#1,WSSize,WSDate1,WSDate2,WSDate3,WSHours,WSMins,WSAttribs,WSCheck
	input#1,LoadString$,RunString$
	close #1
	call PrintCentered(0,"Configuration read.")
AfterConfigTest:
	call PrintCentered(9,"Looking for WINSTART.BAT ...")
	on error goto NoWINSTART
	  open "I",#1,OpenString$
	  close #1
	  call PrintCentered(0,"WINSTART.BAT found.")
	  call PrintCentered(0,"")
	on error goto
	if NewCONFIG<>1 then call PrintCentered(9,"Comparing WINSTART.BAT's Size ...") else call PrintCentered(9,"Creating WINSTART.BAT's Size ...")
	call PrintCentered(0,"Size/Date-Check initiated.")
	color 31,1
	locate 11,15:print Working$;
	color 15,1
	CmdLine$="DIR "+WinDir$+"\WINSTART.BAT >"+TempDir$+"\WINLNCH.TMP"
	shell CmdLine$
	call PrintCentered(0,"InfoTempFile created.")
	TempFile$=TempDir$+"\WINLNCH.TMP"
	open "I",#1,TempFile$
	for Dummy=1 to 4
	  line input#1,dummy$
	next Dummy
	line input#1,FileData$
	if left$(FileData$,12)<>"WINSTART BAT" then line input#1,FileData$
	FileSize=val(mid$(FileData$,14,5)+mid$(FileData$,20,3)+mid$(FileData$,24,3))
	FileDate1=val(mid$(FileData$,28,2))
	FileDate2=val(mid$(FileData$,31,2))
	FileDate3=val(mid$(FileData$,34,2))
	FileHours=val(mid$(FileData$,39,2))
	FileMins=val(mid$(FileData$,42,2))
	close #1
	call PrintCentered(0,"InfoTempFile read.")
	kill TempFile$
	call PrintCentered(0,"InfoTempFile deleted.")
	if NewCONFIG=1 then
	  call PrintCentered(0,"Size/Date-Datas read, jumping to CheckSum")
	  call PrintCentered(0,"")
	  locate 11,15
	  print OnlyRead$;
	  goto 3
	end if
	if FileSize=WSSize then SizeCheck=1 else SizeCheck=2
	if FileDate1=WSDate1 and FileDate2=WSDate2 and FileDate3=WSDate3 then DateCheck=1 else DateCheck=2
	if FileHours=WSHours and FileMins=WSMins then TimeCheck=1 else TimeCheck=2
	if SizeCheck=2 or DateCheck=2 or TimeCheck=2 then fin$=Warning$:fincol=12
	if SizeCheck=1 and DateCheck=1 and TimeCheck=1 then fin$=Ready$:fincol=10
	if SizeCheck=0 or DateCheck=0 or TimeCheck=0 then fin$=DontKnow$:fincol=11
	color fincol,1
	locate 11,15:print fin$;
	color 15,1
	call PrintCentered(0,"Size/Date-Check completed.")
	call PrintCentered(0,"")
3    call PrintCentered(9,"Comparing WINSTART.BAT's Checksum ...")
	call PrintCentered(0,"CheckSum-Test initiated.")
	color 31,1
	locate 13,15:print Working$;
	color 15,1
	call PrintCentered(0,"Opening WINSTART.BAT as BINARY")
	open "B",#1,OpenString$
	x=1
4	get$ #1,1,CheckChar$
	CheckChar=ascii(CheckChar$)
	if CheckChar=-1 then CheckChar=0
	CheckSum=Checksum+(CheckChar*x)
	if CheckSum>65535 then CheckSum=CheckSum-65535
	x=x+1
	if eof(1)=0 then goto 4
	Caller$=str$(x-1)+"Bytes checked and added."
	call PrintCentered(0,Caller$)
	close #1
	call PrintCentered(0,"WINSTART.BAT closed")
	Caller$="Actually CheckSum is "+hex$(CheckSum)+"."
	call PrintCentered(0,Caller$)
	if NewCONFIG=1 then
	  call PrintCentered(0,"CheckSum read, jumping to Attribs")
	  call PrintCentered(0,"")
	  locate 13,15
	  print OnlyRead$;
	  goto 5
	end if
	if CheckSum=WSCheck then CSTest=1 else CSTest=2
	if CSTest=0 then fincol=11:fin$=DontKnow$
	if CSTest=2 then fincol=12:fin$=Warning$
	if CSTest=1 then fincol=10:fin$=Ready$
	color fincol,1
	locate 13,15
	print fin$;
	color 15,1
	call PrintCentered(0,"CheckSum test completed.")
	call PrintCentered(0,"")
5    call PrintCentered(0,"Attrib-Check initiated.")
	call PrintCentered(9,"Comparing WINSTART.BAT's Attributes ...")
	color 31,1:locate 15,15:print Working$;:color 15,1
	call PrintCentered(0,"Comparing Attributes...")
	FileAttrib=attrib(OpenString$)
	if NewCONFIG=1 then
	  call PrintCentered(0,"Attributes read, jumping to WIN.INI-Part")
	  call PrintCentered(0,"")
	  locate 15,15
	  print OnlyRead$;
	  goto 6
	end if
	call PrintCentered(0,"Attribs read, comparing...")
	if FileAttrib=WSAttribs then AtTest=1 else AtTest=2
	if AtTest=0 then fincol=11:fin$=DontKnow$
	if AtTest=2 then fincol=12:fin$=Warning$
	if AtTest=1 then fincol=10:fin$=Ready$
	locate 15,15
	color fincol,1:print fin$;
	color 15,1
	call PrintCentered(0,"Attribute-Check completed.")
	call PrintCentered(0,"")
	goto 6

NoWinIni:
	locate 11,41:color 12:print Warning$
	locate 13,41:color 12:print Warning$
	call PrintCentered(0,"WIN.INI does not exist or FileOpen error!")
	color 15
	call PrintCentered(0,"jumping to end")
	call PrintCentered(9,"WARNING: WIN.INI is corrupt")
	resume VorEnde

6    call PrintCentered(0,"WIN.INI-Check initiated.")
	call PrintCentered(9,"Checking WIN.INI-Entries...")
	color 31,1:locate 11,41:print Working$;:locate 13,41:print Working$;:color 15,1

	call PrintCentered(0,"Opening WIN.INI ...")
	IniOpen$=WinDir$+"\WIN.INI"
	on error goto NoWinIni
	open "I",#1,IniOpen$
	on error goto
	call PrintCentered(0,"Reading WIN.INI-Entries ...")
7	line input #1,InLine$
	if left$(lcase$(InLine$),9)="[windows]" then WinSect=1 else goto 7
8    line input #1,InLine$
	if left$(lcase$(InLine$),5)="load=" then LString$=InLine$
	if left$(lcase$(InLine$),4)="run=" then RString$=InLine$
	if (RString$="" or LString$="") and left$(Inline$,1)<>"[" and eof(1)=0 then goto 8
	close #1
	call PrintCentered(0,"WIN.INI closed")
	if NewCONFIG=1 then
	  call PrintCentered(0,"WIN.INI-Entries read, jumping to SAVE")
	  call PrintCentered(0,"")
	  locate 11,41:print OnlyRead$
	  locate 13,41:print OnlyRead$
	  goto WriteThemDown
	end if
	call PrintCentered(0,"Entries successfully read, comparing them...")
	if RString$=RunString$ then RCheck=1 else RCheck=2
	if RCheck=0 then fincol=11:fin$=DontKnow$
	if RCheck=2 then fincol=12:fin$=Warning$
	if RCheck=1 then fincol=10:fin$=Ready$
	locate 11,41:color fincol:print fin$;:color 15,1
	call PrintCentered(0,"Run-Entry checked")
	if LString$=LoadString$ then LCheck=1 else LCheck=2
	if LCheck=0 then fincol=11:fin$=DontKnow$
	if LCheck=2 then fincol=12:fin$=Warning$
	if LCheck=1 then fincol=10:fin$=Ready$
	locate 13,41:color fincol:print fin$;:color 15,1
	call PrintCentered(0,"Load-Entry checked")
	call PrintCentered(0,"WIN.INI-Check completed.")
	goto VorEnde

WriteThemDown:
	call PrintCentered(9,"Writing Datas to IniFile ...")
	call PrintCentered(0,"Writing File-Datas to WSPROT.INI")
	gosub WriteConfig
	call PrintCentered(0,"written!")
	goto Ende

WriteConfig:
	open "O",#1,ConfigString$
	write#1,FileSize,FileDate1,FileDate2,FileDate3,FileHours,FileMins,FileAttrib,CheckSum
	write#1,LString$,RString$
	close #1
	return

VorEnde:
	Warnings=0
	Errors=0
	Warn$=""
	Erro$=""
	if SizeCheck=2 then Warnings=Warnings+1:Warn$=Warn$+"size, "
	if DateCheck=2 then Warnings=Warnings+1:Warn$=Warn$+"date, "
	if TimeCheck=2 then Warnings=Warnings+1:Warn$=Warn$+"time, "
	if CSTest=2 then Warnings=Warnings+1:Warn$=Warn$+"checksum, "
	if AtTest=2 then Warnings=Warnings+1:Warn$=Warn$+"attribs, "
	if RCheck=2 then Warnings=Warnings+1:Warn$=Warn$+"run-entry, "
	if LCheck=2 then Warnings=Warnings+1:Warn$=Warn$+"load-entry, "
	if SizeCheck=0 then Errors=Errors+1:Erro$=Erro$+"size, "
	if DateCheck=0 then Errors=Errors+1:Erro$=Erro$+"date, "
	if TimeCheck=0 then Errors=Errors+1:Erro$=Erro$+"time, "
	if CSTest=0 then Errors=Errors+1:Erro$=Erro$+"checksum, "
	if AtTest=0 then Errors=Errors+1:Erro$=Erro$+"attribs, "
	if RCheck=0 then Errors=Errors+1:Erro$=Erro$+"run-entry, "
	if LCheck=0 then Errors=Errors+1:Erro$=Erro$+"load-entry, "
	if len(Warn$)>0 then Warn$=left$(Warn$,len(Warn$)-2)
	if len(Erro$)>0 then Erro$=left$(Erro$,len(Erro$)-2)
	call PrintCentered(0,"")
	Caller$=str$(Warnings)+" Warnings,"+str$(Errors)+" Errors"
	call PrintCentered(0,Caller$)
	if Warnings>0 then
	  call PrintCentered(0,"Warnings occured at:")
	  Caller$=Warn$+"-check(s)"
	  call PrintCentered(0,Caller$)
	end if
	if Errors>0 then
	  call PrintCentered(0,"Errors occured at:")
	  Caller$=Erro$+"-check(s)"
	  call PrintCentered(0,Caller$)
	end if
	AllInOne=Warnings+Errors
	if AllInOne=0 then goto Ende
	if RCheck=2 then
	  Caller$="Run-Entry changed from"
	  call PrintCentered(0,Caller$)
	  Caller$=RunString$+" to "+RString$
	  call PrintCentered(0,Caller$)
	end if
	if LCheck=2 then
	  Caller$=""
	  if RCheck=2 then Caller$="and "
	  Caller$=Caller$+"Load-Entry changed from"
	  call PrintCentered(0,Caller$)
	  Caller$=LoadString$+" to "+LString$
	  call PrintCentered(0,Caller$)
	end if
	color 14,1
	Caller$="Press [C]ontinue, [R]evert, [U]pdate or re[B]oot"
10	a$=inkey$
	Cnt=Cnt+1
	if Cnt=2000 then call PrintCentered(9,Caller$):sound 1000,2:Cnt=0
	if Cnt=1000 then call PrintCentered(9,Space$(len(Caller$)))
	if a$="c" or a$="C" then color 15:goto Ende
	if a$="r" or a$="R" then color 15:goto RemoveChanges
	if a$="u" or a$="U" then color 15:goto WriteThemDown
	if a$="b" or a$="B" then color 15:goto Reboot
	goto 10

RemoveChanges:
	call PrintCentered(9,"Reverting old WIN.INI ...")
	call PrintCentered(0,"")
	call PrintCentered(0,"Closing all open channels")
	CLOSE #1
	CLOSE #2
	call PrintCentered(0,"Opening WIN.INI & Temp-File")
	OPEN "I",#1,IniOpen$
	OutFile$=TempDir$+"\WININI.$$$"
	OPEN "O",#2,OutFile$
	call PrintCentered(0,"Searching & Replacing suspicious entry")
	LineNum=0:CharNum=0
11	LINE INPUT#1,TestIt$
	LineNum=LineNum+1
	if TestIt$=RString$ then
	  TestIt$=RunString$
	  call PrintCentered(0,"Suspicious Run=-entry found and replaced")
	end if
	if TestIt$=LString$ then
	  TestIt$=LoadString$
	  call PrintCentered(0,"Suspicious Load=-entry found and replaced")
	end if
	CharNum=CharNum+len(TestIt$)
	PRINT#2,TestIt$
	if eof(1) then
	  Caller$=mid$(str$(CharNum),2,15)+" chars in "+mid$(str$(LineNum),2,10)+" lines written"
	  call PrintCentered(0,Caller$)
	  close #1
	  close #2
	  call PrintCentered(0,"Opened channels closed")
	  ShellOut$="MOVE "+IniOpen$+" "+WinDir$+"\WSPROT.WIN"+" >NUL"
	  shell ShellOut$
	  call PrintCentered(0,"Suspicious WIN.INI has been copied to WSPROT.WIN")
	  ShellOut$="MOVE "+OutFile$+" "+IniOpen$+" >NUL"
	  shell ShellOut$
	  call PrintCentered(0,"Temp-File has been moved to WIN.INI")
	  call PrintCentered(0,"Old entry/entries successfully restored.")
	  goto Ende
	else
	  goto 11
	end if

Reboot:
	$INLINE "INLINES\BOOT_R.COM"
	goto Ende

NotAValidPath:
	cls
	color 12,0
	print "The Directory you entered is invalid!"

Syntax:
	print
	color 10,1:print"WinStart-Protector";:color 8,0:print
	print"not a new safety razor from Wilkinson Sword! :)"
	print
	color 7,0
	print"Syntax is as follows:":color 15,0
	print"WSPROT [Windows-Directory]":color 7,0
	print
	print"e.g. if your Windows-Dir (Win 3.0/3.1x or 95) is C:\WINDOWS,"
	print"you have to write 'WSPROT C:\WINDOWS' to your WINSTART.BAT in"
	print"your Windows-Directory in case you have WSPROT in the Path or"
	print"in the C:\WINDOWS-dir. Otherwise you must add the Dir of WSPROT"
	print"to the WINSTART.BAT, e.g.: 'C:\WSPROT\WSPROT C:\WINDOWS'."
	print
	print"At the first Check, WSPROT will show you many '!'s and will ask you, wether"
	print"to continue, update or reboot. Here you must type in an [U] to write down"
	print"the Configuration. If Windows or you ever change the WINSTART.BAT or the"
	print"load/run-entries in the WIN.INI, WSProt will show you this screen. You just"
	print"have to type in a [U]. But if you not changed the files, you could have a"
	print"Hacker-Entry in one of that files. Check them, to make sure the changes are"
	print"harmless and choose [U] again or press [R] to restore the old settings."
	print
	color 8,0
	print"Greetinx goes to DJ Tee, Calle vHH, Fred KrÅger and Mister X   ;)"
	print
	end

ReadyBeep:
	sound 750,2
	delay 3/18.2
	sound 1250,1
	delay 2/18.2
	sound 1250,1
	delay 2/18.2
	sound 1500,2
        return

Ende:
	color 15,1
	call PrintCentered(9,"Program completed.")
	call PrintCentered(0,"")
	call PrintCentered(0,"Program completed.")
	call PrintCentered(0,"Have fun at Windows...")
	call PrintCentered(0,"")
	call PrintCentered(0,"Greets to DJ Tee, Fred KrÅger and Mister X")
	locate 1,1
	gosub ReadyBeep
	end