MainMenu:
cls
Beats=0
InpBeats=10
ATime=0:ETime=0
BPS=0:BPM=0
color 15
print"-=ð Beats Per Minute ð=-"
print"  by RoboCop INDUSTRIES"
print
print" [RET] - Manuelle Eingabe (";InpBeats;"x [  0  ] im Takt drcken)"
print
print" [ESC] - Beenden!"
print
print"Drcken Sie die gewnschte Taste"
1 a$=inkey$:if a$="" then 1
if a$=chr$(13) then goto Manuell
if a$=chr$(27) then cls:goto Ende
goto 1

Manuell:
cls
print"-=ð Beats Per Minute ð=-"
print"    Manuelle Eingabe"
print
print"Drcken Sie jetzt immer im Takt die 0-Taste auf dem Numerischen"
print"Tastenfeld. Ab dem ersten Tastendruck beginnt die Z„hlerei";InpBeats;"Beats"
print"lang."
2 a$=inkey$
if a$="0" then ATime=timer:beats=1:cls:locate 2,1:print"============":locate 4,1:print"BPS:  ---.--":print"BPM: ----.--":goto 3
goto 2
3 a$=inkey$
locate 3,1:color 15:print using"Time: ###.## (#####.## to #####.##)";timer-ATime;ATime;timer
locate 1,1:print using"Beats: #####";beats
if beat=0  then locate 1,15:color 12:print" BEAT "; else beat=beat-1
if a$="0" then locate 1,15:color 12:print"ÛBEATÛ";:beat=500:beats=beats+1
if beats>=InpBeats then locate 1,15:print"      ":ETime=timer:goto WaitItAb
goto 3

WaitItAb:
BPS=Beats/(ETime-ATime)
BPM=BPS*60
color 15
locate 1,1
print using"Beats: #####";Beats
print"============"
print using"Time: ###.## (#####.## to #####.##)";ETime-ATime,ATime,ETime
print using"BPS:  ###.##";BPS
print using"BPM: ####.##";BPM
print
print"Weiter mit Tastendruck!"
4 a$=inkey$:if a$="" or a$="0" then 4 else MainMenu

Ende:
print"Programm beendet."
