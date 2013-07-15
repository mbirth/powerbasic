	on error goto Fehler
	dim pname$(25)
	dim rname$(25)
	dim birth$(25)
	dim adress1$(25)
	dim adress2$(25)
	dim tele$(25)
	dim fax$(25)
	dim codenum$(25)
	dim master(25)
	dim mpasswd1$(25)
	dim mpasswd2$(25)
	cls
	color 15:print"USER VERIFICATION"
	locate 1,73:color 31:print"STRICTED";
	color 7
	print
	input "Type in tha name: ",nam$
	print
	gosub GetInfo
	color 15:print"Real Name   :";:color 7:? rname$;:color 23
	if MASTER=1 then print"      *** MASTER ACCESS ABILITY ***" else print
	color 15:print"Birthday    :";:color 7:? birth$
	color 15:print"Age (DATE$) :";:color 7:? compage$
	color 15:print"Adress      :";:color 7:? adress1$
	print"             ";adress2$
	color 15:print"Telephone   :";:color 7:? tele$
	color 15:print"FAX         :";:color 7:? fax$
	print
	try=1
	print"And now tha ";
3	print"Code-numba (";mid$(str$(try),2,20);". Try): ";
	gosub GetCode
	if try>=3 and cod$<>codenum$ then msg$="Your 3 Trys are out:":goto FuckHim
	if cod$=codenum$ and try<=3 then pass=1 else try=try+1:print:goto 3
	if MASTER=1 then goto MASTERPROG else goto CONTBOOT

GetInfo:
	msg$="Trying to cheat ??? --->"
	on error goto FuckHim
	open "I",#1,"access.dat"
1	input#1,pname$,rname$,birth$,adress1$,adress2$,tele$,fax$,codenum$,MASTER,mpasswd1$,mpasswd2$
	if pname$=nam$ then
	  datd=val(left$(date$,2))
	  datm=val(mid$(date$,4,2))
	  daty=val(right$(date$,2))
	  hed=val(left$(birth$,2))
	  hm$=mid$(birth$,5,3)
	  if hm$="Jan" then hem=1
	  if hm$="Feb" then hem=2
	  if hm$="Mar" then hem=3
	  if hm$="Apr" then hem=4
	  if hm$="May" then hem=5
	  if hm$="Jun" then hem=6
	  if hm$="Jul" then hem=7
	  if hm$="Aug" then hem=8
	  if hm$="Sep" then hem=9
	  if hm$="Oct" then hem=10
	  if hm$="Nov" then hem=11
	  if hm$="Dec" then hem=12
	  if hem=0 then hem=6
	  hey=val(right$(birth$,2))
	  compage=daty-hey
	  if datm<hem and datd<hed then compage=compage-1
	  if hed>0 and hem>0 and hey>0 then compage$=mid$(str$(compage),2,3)+" years" else compage$="<unknown>"
	  close #1:reset
	  on error goto Fehler
	  return
	else
	  goto 1
	end if

GetCode:
	cod$=""
2	a$=inkey$:if a$="" then 2
	if a$=chr$(13) then return
	cod$=cod$+a$
	print"+";
	goto 2

Fehler:
	cls
	color 31:print"!!! WARNING !!!"
	color 7
	print
	print"An error has occured. The"
	print"program will stop here and"
	print"beep! To get access to ur"
	print"system, press the reset-"
	print"Button or switch ya compu"
	print"off and then on."
	delay 10
	msg$="Ahh, an error:"
	goto FuckHim
FuckHim:
	cls
	color 10
	print msg$
	locate 5,1
	color 28,0,0
	print"  ммммм  м       ммммммм ммммм  ммммммм"
	print" л     л л       л       л    л    л"
	print" лмммммл л       лмммм   лммммп    л"
	print" л     л л       л       л  пм     л"
	print" л     л лмммммм лмммммм л   пм    л"
	color 12
	print
	print"Formatting Harddisk ..."
	sec=5
4	locate 12,1:print "... in";sec;"seconds! "
	if sec<=0 then dl=3:goto BOOTSTOP
	delay 1
	sec=sec-1
	goto 4

BOOTSTOP:
	color 31,0,0
	cls
	print"лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл";
	print"лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл";
	print"лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл";
	print"лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл";
	print"лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл";
	print"лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл";
	print"лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл";
	print"ллллллл           лллл             ллллл         ллллл          лллллллллллллллл";
	print"ллллл   ллллллллллллллллллл   лллллллл   ллллллл   ллл  ллллллл  ллллллллллллллл";
	print"ллллл   ллллллллллллллллллл   лллллллл   ллллллл   ллл  ллллллл  ллллллллллллллл";
	print"ллллл   ллллллллллллллллллл   лллллллл   ллллллл   ллл  ллллллл  ллллллллллллллл";
	print"ллллллл           ллллллллл   лллллллл   ллллллл   ллл          лллллллллллллллл";
	print"ллллллллллллллллл   ллллллл   лллллллл   ллллллл   ллл  лллллллллллллллллллллллл";
	print"ллллллллллллллллл   ллллллл   лллллллл   ллллллл   ллл  лллллллллллллллллллллллл";
	print"ллллллллллллллллл   ллллллл   лллллллл   ллллллл   ллл  лллллллллллллллллллллллл";
	print"ллллллл           ллллллллл   лллллллллл         ллллл  лллллллллллллллллллллллл";
	print"лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл";
	print"лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл";
	print"лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл";
	print"лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл";
	print"лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл";
	print"лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл";
	print"лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл";
	print"лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл";
	locate 25,1:print"лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл";
6	for tim=1 to 5
	delay dl
	for z=1 to 4
	sound 2000,1.0
	delay 1.5/18.2
	next z
	next tim
	if dl>1 then
	  dl=dl-1
	elseif dl>0.1 then
	  dl=dl-.2
	else
	  dl=0
	end if
	goto 6

CONTBOOT:
	cls
	color 31:print"BOOT VERIFICATION ... OK":color 7
	print
	system

MASTERPROG:
	cls
	color 31:print"MASTER PROGRAM START SEQUENCE ..."
	color 7
	print
	print"Enter Code #1 :";
	gosub GetCode
	if cod$<>mpasswd1$ then goto CONTBOOT
	print
	print"Enter Code #2 :";
	gosub GetCode
	if cod$<>mpasswd2$ then goto CONTBOOT
	goto MPR

MPR:
	cls
	color 15:print"*** MASTER PROGRAM ***"
	color 7
	print
	print"1 - User-Control"
	print"2 - System Files"
	print"3 - Informations"
	print"4 - Continue BOOT"
	print
7	locate 8,1:input"Ya choose :",i
	if i=1 then goto USA
	if i=2 then goto SYS
	if i=3 then goto INF
	if i=4 then goto CONTBOOT
	goto 7

USA:
	cls
	color 15:print"*** MASTER PROGRAM ***"
	color 31:print"     USER CONTROL"
	color 7
	print
	print"1 - Add a User"
	print"2 - Delete a User"
	print"3 - Change a User"
	print"4 - Back to Main Menu"
	print
8	locate 9,1:input"Ur choose :",i
	if i=1 then goto UserAdd
	if i=2 then goto UserDel
	if i=3 then goto UserChg
	if i=4 then goto MPR
	goto 8

UserAdd:
	cls
	color 15:print"*** MASTER PROGRAM ***"
	color 07:print"     USER CONTROL"
	color 31:print"      ADD A USER"
	color 7
	print
	print"--------------------------------------------------------------------------------";
10	input"Codename/ID            :",pname$
	input"Code Number            :",codenum$
	input"Real Name              :",rname$
	input"Birthday (dd. mmm yyyy):",birth$
	input"Adress #1 (Street)     :",adress1$
	input"Adress #2 (City)       :",adress2$
	input"Telephone Number       :",tele$
	input"FAX Number             :",fax$
	input"MASTER access (0/1)    :",master
	if MASTER=1 then input"MASTER Password #1     :",mpasswd1$
	if MASTER=1 then input"MASTER Password #2     :",mpasswd2$
	print"--------------------------------------------------------------------------------";
9	locate 19,1:input"Is thiz correct (Y/N/B) ?",answ$
	if answ$="y" or answ$="Y" then goto UserAddWrite
	if answ$="n" or answ$="N" then locate 6,1:goto 10
	if answ$="b" or answ$="B" then goto USA
	goto 9

UserAddWrite:
	color 15
	locate 19,1:print space$(70)
	locate 19,1:print"Opening Channel ... ";
	open "A",#1,"access.dat"
	print"OK"
	print"Writing Data ... ";
	write#1,pname$,rname$,birth$,adress1$,adress2$,tele$,fax$,codenum$,master,mpasswd1$,mpasswd2$
	print"OK"
	print"Closing Channel ... ";
	close #1:reset
	print"OK"
	print"Resetting Data ... ";
	pname$="":rname$="":birth$="":adress1$="":adress2$="":tele$="":fax$="":master=0:mpasswd1$="":mpasswd2$="":codenum$=""
	print"OK"
	color 0,7:print"User Add Complete."
	color 7,0,0
	delay 1.5
	goto USA

UserDel:
	cls
	color 15:print"*** MASTER PROGRAM ***"
	color 07:print"     USER CONTROL"
	color 31:print"    DELETE A USER"
	color 7
	print
	print"Opening Channel ... ";
	reset
	open "I",#1,"access.dat"
	print"OK"
	print"Reading User Data ... ";
	x=0
11	x=x+1
	if eof(1) then goto 12
	input#1,pname$(x),rname$(x),birth$(x),adress1$(x),adress2$(x),tele$(x),fax$(x),codenum$(x),master(x),mpasswd1$(x),mpasswd2$(x)
	goto 11
12	endx=x:on error goto Fehler:print"OK"
	print"Closing Channel ... ";
	close#1
	RESET
	print"OK"
	color 0,7:print"USER DATA INPUT COMPLETE":color 7,0,0
	delay 1.5
	goto UserDelChoose

UserDelChoose:
	locate 10,1:print"--------------------------------------------------------------------------------";
	x=1
13	locate 11,1:print"Codename/ID   : ";pname$(x);space$(40-len(pname$(x)))
	if x=1 then print"Codenumber    : ";:color 31:print"*** SECRET ***":color 7 else print"Codenumber    : ";codenum$(x);space$(40-len(codenum$(x)))
	print"Real Name     : ";rname$(x);space$(40-len(rname$(x)))
	print"Birthday      : ";birth$(x);space$(40-len(birth$(x)))
	print"Adress        : ";adress1$(x);space$(40-len(adress1$(x)))
	print"                ";adress2$(x);space$(40-len(adress2$(x)))
	print"Telephone     : ";tele$(x);space$(40-len(tele$(x)))
	print"FAX           : ";fax$(x);space$(40-len(tele$(x)))
	print"MASTER access : ";
	if master(x)=1 then print"YES" else print"NO "
	if x=1 then print"MASTER Pswrd#1: ";:color 31:print"*** SECRET ***":color 7 else print"MASTER Pswrd#1: ";mpasswd1$(x);space$(40-len(mpasswd1$(x)))
	if x=1 then print"MASTER Pswrd#2: ";:color 31:print"*** SECRET ***":color 7 else print"MASTER Pswrd#2: ";mpasswd2$(x);space$(40-len(mpasswd2$(x)))
	print"--------------------------------------------------------------------------------";
	print"  PgUp/PgDn - Look Up/Down      [ENTER] - Delete                  [ESC] - Back";
	print"--------------------------------------------------------------------------------";
14	a$=inkey$:if a$="" then 14
	if mid$(a$,2,1)="I" and x>1 then x=x-1:goto 13
	if mid$(a$,2,1)="Q" and x<endx-1 then x=x+1:goto 13
	if a$=chr$(13) then goto UserDelSelected
	if a$=chr$(27) then goto USA
	goto 14

UserDelSelected:
	locate 23,1:print space$(80);
	locate 23,1
	if rname$(x)="Markus Birth" then print"Cannot delete programmer!":delay 3:goto 13
18	input"Delete ^this^ User (Y/N) ??? ";choose$
	if choose$="y" or choose$="Y" then goto 15
	if choose$="n" or choose$="N" then goto 13
	goto 18
15	cls
	selx=x
	color 15:print"*** MASTER PROGRAM ***"
	color 07:print"     USER CONTROL"
	color 31:print"    DELETE A USER"
	print
	color 7
	print"Opening Channel ... ";
	open "O",#1,"access2.dat"
	print"OK"
	print"Writing New Data ... ";
	x=1
16	if x=selx then x=x+1:goto 16
	if x=endx then 17
	write#1,pname$(x),rname$(x),birth$(x),adress1$(x),adress2$(x),tele$(x),fax$(x),codenum$(x),master(x),mpasswd1$(x),mpasswd2$(x)
	x=x+1
	goto 16
17	print"OK"
	print"Closing Channel ... ";
	close #1
	RESET
	print"OK"
	print"Killing Original ... ";
	kill "access.dat"
	print"OK"
	print"Renaming TEMP-File ... ";
	name "access2.dat" as "access.dat"
	print"OK"
	print "Deleting Vars ... ";
	for x=1 to endx
	pname$(x)="":rname$(x)="":birth$(x)="":adress1$(x)="":adress2$(x)=""
	tele$(x)="":fax$(x)="":codenum$(x)="":master=0:mpasswd1$(x)="":mpasswd2$(x)=""
	next x
	print"OK"
	color 0,7,0
	print"USER DELETION COMPLETE"
	color 7,0,0
	delay 1.5
	goto UserDel

UserChg:
	cls
	color 15:print"*** MASTER PROGRAM ***"
	color 7:print "     USER CONTROL"
	color 31:print"     CHANGE A USER"
	color 7:print
	print"Opening Channel ... ";
	reset
	open "I",#1,"access.dat"
	print"OK"
	print"Reading User Data ... ";
	x=0
19	x=x+1
	if eof(1) then goto 20
	input#1,pname$(x),rname$(x),birth$(x),adress1$(x),adress2$(x),tele$(x),fax$(x),codenum$(x),master(x),mpasswd1$(x),mpasswd2$(x)
	goto 19
20	endx=x:print"OK"
	print"Closing Channel ... ";
	close #1
	reset
	print"OK"
	color 0,7:print"USER DATA INPUT COMPLETE":color 7,0,0
	delay 1.5
	goto UserChgChoose

UserChgChoose:
	locate 10,1:print"--------------------------------------------------------------------------------";
	x=1
21	locate 11,1:print"Codename/ID   : ";pname$(x);space$(40-len(pname$(x)))
	if x=1 then print"Codenumber    : ";:color 31:print"*** SECRET ***":color 7 else print"Codenumber    : ";codenum$(x);space$(40-len(codenum$(x)))
	print"Real Name     : ";rname$(x);space$(40-len(rname$(x)))
	print"Birthday      : ";birth$(x);space$(40-len(birth$(x)))
	print"Adress        : ";adress1$(x);space$(40-len(adress1$(x)))
	print"                ";adress2$(x);space$(40-len(adress2$(x)))
	print"Telephone     : ";tele$(x);space$(40-len(tele$(x)))
	print"FAX           : ";fax$(x);space$(40-len(fax$(x)))
	print"MASTER access : ";
	if master(x)=1 then print"YES" else print "NO "
	if x=1 then print"MASTER Pswrd#1: ";:color 31:print"*** SECRET ***":color 7 else print"MASTER Pswrd#1: ";mpasswd1$(x);space$(40-len(mpasswd1$(x)))
	if x=1 then print"MASTER Pswrd#2: ";:color 31:print"*** SECRET ***":color 7 else print"MASTER Pswrd#2: ";mpasswd2$(x);space$(40-len(mpasswd2$(x)))
	print"--------------------------------------------------------------------------------";
	print"  PgUp/PgDn - Look Up/Down      [ENTER] - Change                  [ESC] - Back";
	print"--------------------------------------------------------------------------------";
22	a$=inkey$:if a$="" then 22
	if mid$(a$,2,1)="I" and x>1 then x=x-1:goto 21
	if mid$(a$,2,1)="Q" and x<endx-1 then x=x+1:goto 21
	if a$=chr$(13) then seluser=x:goto UserChgSelected
	if a$=chr$(27) then goto USA
	goto 22

UserChgSelected:
	if seluser=1 then goto ChgRC
	cls
	color 15:print"*** MASTER PROGRAM ***"
	color 07:print"     USER CONTROL"
	color 31:print"     CHANGE A USER"
	print
27	color 7
	print"--------------------------------------------------------------------------------";
23	locate 06,1:input"Codename/ID   : ",pname$
	if pname$="" then pname$=pname$(seluser)
	locate 06,17:print pname$
	input"Codenumber    : ",codenum$
	if codenum$="" then
	  locate 7,50:print"Delete Codenumber (Y/N)?"
30	  a$=inkey$:if a$="" then goto 30
	  if a$="y" or a$="Y" then codenum$="":goto 33
	  if a$="n" or a$="N" then codenum$=codenum$(seluser):goto 33
	  goto 30
	end if
33	locate 7,17:print codenum$
	input"Real Name     : ",rname$
	if rname$="" then rname$=rname$(seluser)
	locate 8,17:print rname$
	input"Birthday      : ",birth$
	if birth$="" then birth$=birth$(seluser)
	locate 9,17:print birth$
	input"Adress #1 (St): ",adress1$
	if adress1$="" then adress1$=adress1$(seluser)
	locate 10,17:print adress1$
	input"Adress #2 (Ct): ",adress2$
	if adress2$="" then adress2$=adress2$(seluser)
	locate 11,17:print adress2$
	input"Telephone     : ",tele$
	if tele$="" then tele$=tele$(seluser)
	locate 12,17:print tele$
	input"FAX           : ",fax$
	if fax$="" then fax$=fax$(seluser)
	locate 13,17:print fax$
	input"MASTER access*: ",master$
	if master$="" then master=master(seluser) else master=val(mid$(master$,2,1))
	locate 14,17:print master
	input"MASTER Pswrd#1: ",mpasswd1$
	if mpasswd1$="" then
	  locate 15,50:print"Delete Password#1 (Y/N)?"
31	  a$=inkey$:if a$="" then 31
	  if a$="y" or a$="Y" then mpasswd1$="":goto 34
	  if a$="n" or a$="N" then mpasswd1$=mpasswd1$(seluser):goto 34
	  goto 31
	end if
34	locate 15,17:print mpasswd1$
	input"MASTER Pswrd#2: ",mpasswd2$
	if mpasswd2$="" then
	  locate 16,50:print"Delete Password#2 (Y/N)?"
32	  a$=inkey$:if a$="" then 32
	  if a$="y" or a$="Y" then mpasswd2$="":goto 35
	  if a$="n" or a$="N" then mpasswd2$=mpasswd2$(seluser):goto 35
	  goto 32
	end if
35	locate 16,17:print mpasswd2$
	print"--------------------------------------------------------------------------------";
24	locate 18,1:input"Is ^this^ correct (Y/N/B) ?",answ$
	if answ$="y" or answ$="Y" then goto UserChgWrite
	if answ$="n" or answ$="N" then goto 23
	if answ$="b" or answ$="B" then goto USA
	goto 24

UserChgWrite:
	cls
	color 15:print"*** MASTER PROGRAM ***"
	color 7:print"     USER CONTROL"
	color 31:print"    CHANGE A USER"
	color 7:print
	print"Opening Channel ... ";
	open "O",#1,"access2.dat"
	print"OK"
	print"Writing Changed Data ... ";
	x=1
25   if x=endx then 26
	if x=seluser then
	  write#1,pname$,rname$,birth$,adress1$,adress2$,tele$,fax$,codenum$,master,mpasswd1$,mpasswd2$
	  x=x+1:goto 25
	else
	  write#1,pname$(x),rname$(x),birth$(x),adress1$(x),adress2$(x),tele$(x),fax$(x),codenum$(x),master(x),mpasswd1$(x),mpasswd2$(x)
	  x=x+1:goto 25
	end if
26	print"OK"
	print"Closing Channel ... ";
	close #1
	reset
	print"OK"
	print"Killing Original ... ";
	kill "access.dat"
	print"OK"
	print"Renaming TEMP-File ... ";
	name "access2.dat" as "access.dat"
	print "OK"
	print"Deleting Vars ... ";
	for x=1 to endx
	pname$(x)="":rname$(x)="":birth$(x)="":adress1$(x)="":adress2$(x)=""
	tele$(x)="":fax$(x)="":codenum$(x)="":master=0:mpasswd1$(x)="":mpasswd2$(x)=""
	next x
	print"OK"
	color 0,7,0
	print"USER CHANGE COMPLETE"
	color 7,0,0
	delay 1.5
	goto UserChg

ChgRC:
	cls
	color 15:print"*** MASTER PROGRAM ***"
	color 07:print"     USER CONTROL"
	color 31:print"  CHANGE PROGRAMMER"
	color 7:print
	sound 2000,(18.2*1)*.23
	delay (1/18.2)*.30
	sound 2000,18.2*1
	print"If you want to change the Programmer-Info, you have to"
	print"know the MAGIC WORD!"
	print
	print"What is it ? ";
	gosub GetCode
	if cod$="BITTE" then 28
	print"Second and last Try!"
	print"The Magic Word is : ";
	gosub GetCode
	if cod$="BITTE" then 28
	goto FuckHim
28	locate 6,1
	for z=1 to 5
	print space$(80);
	next z
	locate 5,1:goto 27

SYS:
	shell"mode co80"
	cls
	color 15,0:print"*** MASTER PROGRAM ***"
	color 31,0:print"     SYSTEM FILES"
	color 7
	print
	print"1 - Look AUTOEXEC.BAT"
	print"2 - Look CONFIG.SYS"
	print"3 - Change AUTOEXEC.BAT"
	print"4 - Change CONFIG.SYS"
	print"5 - Change ACCESS.DAT"
	print"6 - Back to Main Menu"
	print
36	locate 11,1:input"Ya choose? ",i
	if i=1 then goto LookAUTO
	if i=2 then goto LookCONF
	if i=3 then goto EditAUTO
	if i=4 then goto EditCONF
	if i=5 then goto EditACCE
	if i=6 then goto MPR
	goto 36

LookAUTO:
	locate 13,1:color 0,7
	print"LOOKING ON AUTOEXEC.BAT"
	color 7,0,0
	print"Search & Run WPVIEW.EXE ... ";
	shell"C:\NORTON\NC\WPVIEW.EXE C:\AUTOEXEC.BAT"
	print"COMPLETE"
	color 0,7
	print"AUTOEXEC.BAT VIEWING SOLVED"
	color 7,0
	delay 1
	goto SYS

LookCONF:
	locate 13,1:color 0,7
	print"LOOKING ON CONFIG.SYS"
	color 7,0
	print"Search & Run WPVIEW.EXE ... ";
	shell"C:\NORTON\NC\WPVIEW.EXE C:\CONFIG.SYS"
	print"COMPLETE"
	color 0,7
	print"CONFIG.SYS VIEWING SOLVED"
	color 7,0
	delay 1
	goto SYS

EditAUTO:
	locate 13,1:color 0,7
	print"EDITING AUTOEXEC.BAT"
	color 7,0
	print"Search & Run NCEDIT.EXE ... ";
	shell"C:\NORTON\NC\NCEDIT.EXE C:\AUTOEXEC.BAT"
	print"COMPLETE"
	color 0,7
	print"AUTOEXEC.BAT EDITING SOLVED"
	color 7,0
	delay 1
	goto SYS

EditCONF:
	locate 13,1:color 0,7
	print"EDITING CONFIG.SYS"
	color 7,0
	print"Search & Run NCEDIT.EXE ... ";
	shell"C:\NORTON\NC\NCEDIT.EXE C:\CONFIG.SYS"
	print"COMPLETE"
	color 0,7
	print"CONFIG.SYS EDITING SOLVED"
	color 7,0
	delay 1
	goto SYS

EditACCE:
	locate 13,1:color 0,7
	print"EDITING ACCESS.DAT"
	color 7,0
	print"Search & Run NCEDIT.EXE ... ";
	shell"C:\NORTON\NC\NCEDIT.EXE C:\ACCESS.DAT"
	print"COMPLETE"
	color 0,7
	print"ACCESS.DAT EDITING SOLVED"
	color 7,0
	delay 1
	goto SYS

INF:
	cls
	color 15,0:print"*** MASTER PROGRAM ***"
	color 31,0:print"     INFORMATIONS"
	color 7:print
	print"1 - FreeMem on C:"
	print"2 - ChkDsk of C:"
	print"3 - Mem"
	print"4 - Back to Main Menu"
	print
37	locate 9,1:input"Your choose? ",i
	if i=1 then goto FreeMemC
	if i=2 then goto ChkDskC
	if i=3 then goto Mem
	if i=4 then goto MPR
	goto 37

FreeMemC:
	locate 11,1
	color 0,7
	print"EXECING INFO.EXE"
	color 7,0
	print"Launching C:\DOS\INFO.EXE ... ";
	shell"C:\DOS\INFO.EXE"
	color 0,7
	locate 25,33:print"LAUNCH COMPLETE";
	color 7,0
	delay 3
	goto INF

ChkDskC:
	locate 11,1
	color 0,7
	print"EXECING CHKDSK.EXE"
	color 7,0
	print"Launching C:\DOS\CHKDSK.EXE ... ";
	print
	print
	print
	print
	shell"C:\DOS\chkdsk.EXE"
	color 0,7
	locate 25,33:print"LAUNCH COMPLETE"
	color 7,0
	delay 7
	goto INF

Mem:
	locate 11,1
	color 0,7
	print"EXECING MEM.EXE"
	color 7,0
	print"Launching C:\DOS\MEM.EXE ... ";
	print
	print
	print
	print
	shell"C:\DOS\MEM.EXE"
	color 0,7
	locate 25,33:print"LAUNCH COMPLETE";
	color 7,0
	delay 7
	goto INF