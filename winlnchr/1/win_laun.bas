      cls
      color 15:print"˙WINDOWS˙v3.11-Launcher˙"
      color 14:print"written by RoboCop INDUSTRIES"
      color 7
      print
      print"WÑhlen Sie einen Grafikmodus:"
      print
      print"No   H x B x c  Schrift fÅr"
      color 10:print" 1 ";:color 7:print" 640x480x256 normal"
      color 10:print" 2 ";:color 7:print" 640x480x256 gro·"
      color 10:print" 3 ";:color 7:print" 800x600x 16 normal"
      color 10:print" 4 ";:color 7:print" 800x600x 16 gro·"
      color 10:print" 5 ";:color 7:print" 800x600x256 normal"
      color 10:print" 6 ";:color 7:print" 800x600x256 gro·"
      color 10:print" 7 ";:color 7:print"1024x768x 16 normal"
      color 10:print" 8 ";:color 7:print"1024x768x 16 gro·"
      color 10:print" 9 ";:color 7:print"1024x768x256 normal"
      color 10:print" 0 ";:color 7:print"1024x768x256 gro·"
      end
      print
      print"Geben Sie eine Zahl ein!"
1     a$=inkey$:if a$="" then 1
      if a$="1" or a$="!" then goto ModeA
      if a$="2" or a$=chr$(34) then goto ModeB
      if a$="3" or a$=chr$(21) then goto ModeC
      if a$="4" or a$="$" then goto ModeD
      if a$="5" or a$="%" then goto ModeE
      if a$="6" or a$="&" then goto ModeF
      if a$="7" or a$="/" then goto ModeG
      if a$="8" or a$="(" then goto ModeH
      if a$="9" or a$=")" then goto ModeI
      if a$="0" or a$="=" then goto ModeJ
      goto 1

ModeA:
      print:print"Setze Variablen ... ";
      dsp1$="display.drv=T480.DRV"
      dsp2$="display.drv=TRIDENT TVGA 640x480x256c"
      font$="font
      print"OK"
      print"Erstelle neue INI-Datei ... ";
      gosub ChangeINI
      print"Starte WINDOWS v3.11 ... "
      goto Launch

ModeB:
      print:print"Setze Variablen...";
      dsp1$="display.drv=W800.DRV"
      dsp2$="display.drv=TRIDENT TVGA 800x600 16-color"
      print"gesetzt"
      print"Erstelle neue INI-Datei...";
      gosub ChangeINI
      print"Starte WINDOWS v3.11..."
      goto Launch

ModeC:
      print:print"Setze Variablen...";
      dsp1$="display.drv=T1024.DRV"
      dsp2$="display.drv=TRIDENT TVGA8900 1024x768 256-color"
      print"gesetzt"
      print"Erstelle neue INI-Datei...";
      gosub ChangeINI
      print"Starte WINDOWS v3.11..."
      goto Launch

ChangeINI:
      open "I",#1,"C:\WINDOWS\SYSTEM.INI"
      open "O",#2,"C:\WINDOWS\SYSTEM.IN_"
      print:color 15:print"Status                   aktuelle Zeile                                 b b-d":color 7
      x=csrlin
      locate x,1
2     line input#1,zle$
      if left$(zle$,6)="[boot]" then b=1
      if left$(zle$,18)="[boot.description]" then bd=1
      ers$=zle$
      if left$(zle$,11)="display.drv" and b=1 then ers$=dsp1$:flag=1:fl=1
      if left$(zle$,11)="display.drv" and bd=1 then ers$=dsp2$:flag=2:fl=1
      st$="Suche nach Zeile..."
      if fl=1 then st$="Zeile geÑndert.     Neu:":fl=0
      rem  print "Status                   aktuelle Zeile                                 b b-d":color 7
      print using"\                      \ \                                            \ # #";st$;ers$;b;bd
      if flag=2 then b=0
      print#2,ers$
      locate x,1
      if flag=1 then locate x+1,1
      if flag=2 then locate x+2,1
      if eof(1)<>0 then
	print"fertig."+space$(73)
	close #1
	close #2
	return
      else
	goto 2
      end if

Launch:
      kill "C:\WINDOWS\SYSTEM.INI"
      name "C:\WINDOWS\SYSTEM.IN_" AS "C:\WINDOWS\SYSTEM.INI"
      print"OK"
      execute "WIN.COM :"