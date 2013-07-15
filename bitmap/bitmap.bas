	CLS
	shell "mode co80"
	$INCLUDE "PBWINDOW.INC"
	goto Weiter
	$INCLUDE "FX_WRITE.INC"

Weiter:
	$INCLUDE "LOGO.INC"
'	goto StartUp
	TXT$="presents"
	Lin=CSRLIN-1
	gosub WriteText
	print
	TXT$="The BitMaP-Brother"
	Lin=csrlin-1
	gosub WriteText
	delay 1
	goto StartUp

FileNotExist:
	close #1
	Msg$=Msg$+"FEHLER!"
	call PrtWindow(5,2,Msg$)
	call MakeWindow(10,20,6,40,ColAttr%(12,4),5,4,2)
	call TitleWindow(2,"[ Fehler 001 ]")
	for x=1 to 3
	  sound 1000,1
	  delay 1.5/18.2
	next x
	call PrtCWindow(2,"Diese Datei existiert nicht!")
	call PrtCWindow(3,"Geben Sie eine existierende an.")
	call TitleWindow(5," Taste ... ")
3	a$=inkey$:if a$="" then 3
	call RemoveWindow
	call PrtWindow(5,2,"                                        ")
	if NoError=0 then resume NeedInput else goto NeedInput

StartUp:
	call MakeWindow(10,18,11,44,ColAttr%(15,1),4,4,1)
	call TitleWindow(1,"[ The Bitmap-Brother ]")
	call PrtWindow(2,2,"Geben Sie die Datei an, welche nach BMPs")
NeedInput:
	call PrtWindow(3,2,"durchsucht werden soll:                 ")
	locate 13,44:color 14,1
	input "",File$
	File$=ucase$(File$)
	if File$="Q" then goto Ende
	Msg$="™ffne '"+File$+"' ... "
	on error goto FileNotExist
	call PrtWindow(5,2,Msg$)
	open "B",#1,File$
	on error goto
	DOS$="DIR "+File$+" >BITMAP.$$1"
	shell DOS$
	open "I",#2,"BITMAP.$$1"
	for x=1 to 6
	line input #2,FileInfo$
	next x
	close #2
	kill "BITMAP.$$1"
	FileSize=(val(mid$(FileInfo$,16,3))*1000000)+(val(mid$(FileInfo$,20,3))*1000)+(val(mid$(FileInfo$,24,3)))
	if FileSize=0 then NoError=1:kill File$:goto FileNotExist
	Msg$="™ffne '"+File$+"' ... ge”ffnet"
	call PrtWindow(5,2,Msg$)
	call PrtWindow(6,2,"Durchsuche Datei ... ")
	call MakeWindow(5,5,16,64,ColAttr%(15,1),1,4,1)
	call TitleWindow(1,"[ Durchsuche Datei ... ]")
	ONSymb1=219
	ONSymb2=178
	ONSymb3=177
	ONSymb4=176
	OFSymb=250
	call PrtWindow(2,2,"Starte Scan ...")
	StartUpHour=val(mid$(Time$,1,2))
	StartUpMinu=val(mid$(time$,4,2))
	StartUpSeco=val(mid$(time$,7,2))
	Time$="00:00:00"
	Msg$="Byte XXXXXXXXX von "+using$("#########",FileSize)
	call PrtWindow(4,2,Msg$)
	Msg$=""
	for x=1 to 60
	  Msg$=Msg$+chr$(OFSymb)
	next x
	call PrtWindow(6,2,Msg$)
	call PrtWindow(7,2,"0             2              5              7              1")
	call PrtWindow(8,2,"              5              0              5              0")
	call PrtWindow(9,2,"                                                           0")
	ActBytes=1
StartSearch:
	gosub UpDisp
	Get$ #1,54,Search$
	Se$=mid$(search$,30,25)
	s$=mid$(search$,30,1)
	sf$=""
	for x=1 to 25
	  sf$=sf$+s$
	next x
	nulla$=mid$(search$,10,1)
	nullb$=mid$(search$,22,1)
	nullc$=mid$(search$,26,1)
	null=ascii(nulla$)+ascii(nullb$)+ascii(nullc$)
	nullb=0
	for x=29 to 54
	  nullb=nullb+ascii(mid$(search$,x,1))
	next x
	nullc=ascii(mid$(search$,1,1))+ascii(mid$(search$,2,1))
	nullc=nullc+ascii(mid$(search$,3,1))+ascii(mid$(search$,19,1))
	nullc=nullc+ascii(mid$(search$,23,1))
	if Se$=sf$ and null=0 and nullb=0 and nullc<>0 then
	  BMPs=BMPs+1
	  if BMPs=1 then B$="" else B$="s"
	  Msg$=using$("####",BMPs)+" BMP"+B$+" gefunden "
	  call PrtWindow(12,2,Msg$)
	  OFile$=mid$(str$(BMPs),2,10)+".BMP"
	  Size$=mid$(Search$,3,8)
	  V1$=Size$:gosub BVar:Size$=V2$
	  Wid$=mid$(Search$,19,4)
	  V1$=Wid$:gosub BVar:Wid$=V2$
	  Hei$=mid$(Search$,23,4)
	  V1$=Hei$:gosub BVar:Hei$=V2$
	  Bits$=mid$(Search$,29,1)
	  gosub WriteBMP
	end if
	ActBytes=ActBytes+1
	seek #1,ActBytes
	goto StartSearch



	goto Ende

BVar:
	  V2$=""
	  for x=len(V1$) to 1 step -1
	    V2$=V2$+mid$(V1$,x,1)
	  next x
	  return

Hex2Dec:
'	H=&H$

WriteBMP:
	open "O",#2,OFile$
	close #2
	return

UpDisp:
	Msg$="Byte "+using$("#########",ActBytes)
	call PrtWindow(4,2,Msg$)
	if ShowPer=10 then ShowPer=0 else SkipPer
	Percent=ActBytes/FileSize
	Blocks=Percent*60
11	if Blocks>=1 then Blocks=Blocks-1:Per$=Per$+Chr$(ONSymb1):goto 11
	B1=Blocks
12	if Blocks/.75>=1 then Blocks=Blocks-int(Blocks/.75)*.75:Per$=Per$+Chr$(ONSymb2):goto 12
	B2=Blocks
13	if Blocks/.5>=1 then Blocks=Blocks-int(Blocks/.5)*.5:Per$=Per$+Chr$(ONSymb3):goto 13
	B3=Blocks
14	if Blocks/.25>=1 then Blocks=Blocks-int(Blocks/.25):Per$=Per$+Chr$(ONSymb4):goto 14
	B4=Blocks
	call PrtWindow(6,2,Per$)
	Per$=""
SkipPer:
	ShowPer=ShowPer+1
	Msg$="Zeit: "+Time$
	call PrtWindow(10,2,Msg$)
	if Percent>0 then else goto SkipRTime
	HD=val(mid$(time$,1,2))
	MD=val(mid$(time$,4,2))
	SD=val(mid$(time$,7,2))
	TiDiff=HD*100+MD+(SD/100)/.6
	ATime=(ATime+TiDiff)/2
	if Now<300 then SkipRTime else Now=0
	RTime=ATime/Percent
	RTime2=int(Rtime)
	RH=int(Rtime2/100)
	RM=int(RTime2-RH*100)
	RS=(Rtime-Rtime2)*100*.6
	if RS>=59.5 then RM=RM+1:RS=RS-59.5
	if RM>=59.5 then RH=RH+1:RM=RM-59.5
	rH$=mid$(str$(int(RH)),2,2)
	rM$=mid$(str$(int(RM)),2,2)
	rS$=mid$(str$(int(RS)),2,2)
	if inkey$=chr$(27) then end
	if len(rH$)<2 then RH$="0"+rh$
	if len(rM$)<2 then RM$="0"+rm$
	if len(rS$)<2 then RS$="0"+rs$
	TEnd$=RH$+":"+RM$+":"+RS$
	Msg$="vorr. Ende: "+TEnd$
	call PrtWindow(10,25,Msg$)
SkipRTime:
	Now=Now+1
	if ActBytes>=FileSize then Ende
	return



Ende:
	NowHour=val(mid$(time$,1,2))
	NowMinu=val(mid$(time$,4,2))
	NowSeco=val(mid$(time$,7,2))
	TimeNow$=using$("##:",StartUpHour+NowHour)+using$("##:",StartUpMinu+NowMinu)+using$("##",StartUpSeco+NowSeco)
	Time$=TimeNow$