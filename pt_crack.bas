color 14,1:cls
mess$="M*** PowerTOOLS 3.6 Crack v1.0 ***":gosub PS
color 15,1
mess$="M          written by RoboCop IND.":gosub PS
color 11,1
print
mess$="MP - PowerTOOLS-Pfad „ndern":gosub PS
mess$="MA - Zeit anzeigen         ":gosub PS
mess$="MC - Zeit „ndern           ":gosub PS
mess$="M--------------------------":gosub PS
mess$="MESC - ENDE":gosub PS
print
mess$="MBitte den gew. Buchstaben eingeben.":gosub PS
locate csrlin,37:print "Wahl:";
1 a$=inkey$:if a$="" then 1
    a$=ucase$(a$)
    if a$="P" then print a$:goto ChangePTPath
    if a$="A" then print a$:goto ShowPTTime
    if a$="C" then print a$:goto ChangePTTime
    if a$=chr$(27) then print "[ESC]":sound 600,.5:goto Quit
  sound 1000,.5
goto 1

PTPathNotRight:
  sound 800,.5:delay .1
  color 12:locate 19,1:mess$="Mððð DER PFAD IST NICHT RICHTIG ððð":gosub PS
  color 11
  sound 800,.5:delay .1:sound 800,.5
  delay 2:locate 19,1:mess$="M                                  ":gosub PS
  PTPath$=""
  locate 11,1
  resume ChangePTPath

Back2Menu:
  for x=12 to 24
    locate x,1:print space$(80);
  next x
  color 11
  locate 11,42:print " "
  locate 11,42
  goto 1

ChangePTPath:
  locate csrlin+1,1:for x=1 to 80:o$=o$+"ð":next x:print o$:o$=""	'line 14
  locate 15,1:print"Geben Sie den Pfad ein, indem sich PowerTOOLS befindet:"
  print "Bsp.: 'C:\AOL30I\PWRTOOLS'":color 15
  OPTPath$=PTPath$
  input ">",PTPath$
  for x=14 to 17:locate x,1:print space$(80);:next x:print
  PTPath$=PTPath$+"\PWRTOOLS.LIC"
  if PTPath$="\PWRTOOLS.LIC" then PTPath$=OPTPath$:goto Back2Menu
  on error goto PTPathNotRight
  open "R",#1,PTPath$
  on error goto




ShowPTTime:
ChangePTTime:
Quit:


goto Ende


PS:
  mes$=right$(mess$,len(mess$)-1)
  ind$=left$(mess$,1)
  if ind$="M" then locate csrlin,40-len(mes$)/2
  if ind$="L" then locate csrlin,1
  if ind$="R" then locate csrlin,80-len(mes$)
  print mes$;
  locate csrlin+1,1
return

Ende: