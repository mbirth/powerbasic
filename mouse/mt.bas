color 7,1
laun$="MTLAUNCH.BAT"
cls
locate 10,1:color 14,1
print"ษออ Abfrage อออออออออป"
for a=11 to 16
locate a,1:print"บ"
locate a,22:print"บ"
next a
print"ศออออออออออออออออออออผ"
locate 13,23:print"ษออ Tasten ออออออออออออออป"
locate 14,23:print"บ ฺฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฟ บ"
locate 15,23:print"บ ณ      ณ      ณ      ณ บ"
locate 16,23:print"บ ณ      ณ      ณ      ณ บ"
locate 17,23:print"บ รฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤด บ"
locate 18,23:print"บ ณ Artec              ณ บ"
locate 19,23:print"บ ณ                    ณ บ"
locate 20,23:print"บ ณ                    ณ บ"
locate 21,23:print"บ ณ                    ณ บ"
locate 22,23:print"บ ------8<-------8<----- บ"
locate 23,23:print"ศออออออออออออออออออออออออผ"
locate 10,23
print"ษออ Koordinaten ออออออออออออออออออออออออออออออออออออป"
locate 11,23
print"บ":locate 11,75:print"บ"
locate 12,23
print"ศอออออออออออออออออออออออออออออออออออออออออออออออออออผ"
locate 12,5
color 15,7
print"      OK      ";:color 8,1:print"Ü"
locate 13,6:print"฿฿฿฿฿฿฿฿฿฿฿฿฿฿"
locate 15,5:color 15,7
print"    CANCEL    ";:color 8,1:print"Ü"
locate 16,6:print"฿฿฿฿฿฿฿฿฿฿฿฿฿฿"
locate 1,1:color 14,1
print"ษออ Status ออออออออออออออออออออออออออออออป"
for a=2 to 5
locate a,1
print"บ                                        บ"
next a
print"ศออออออออออออออออออออออออออออออออออออออออผ"
defint a-z
def seg=0
mseg=256*peek(207)+peek(206)
mouse=256*peek(205)+peek(204)+2
if mseg or  (mouse-2) then DrvInst else DrvNInst

DrvNInst:
status$="Maus-Treiber nicht installiert"
status=12
gosub WriteStatus
delay .5
status$="Bitte installieren"
status=15
gosub WriteStatus
delay .5
status$="Programm wird unterbrochen!"
status=11
gosub WriteStatus
end

DrvInst:
def seg=mseg
if peek(mouse-2)=207 then DrvNInst
status=11
status$="Suche Treiber..."
gosub WriteStatus
m1%=0
call absolute mouse(m1%,m2%,m3%,m4%)
status$="Maustreiber nicht resident!":status=12:if m1=-1 then status$="Maustreiber resident. ("+right$(str$(m2%),1)+" Tasten)":status=10
gosub WriteStatus
status=11
status$="Maus-Cursor einstellen..."
gosub WriteStatus
m1=10:m2=0:m3=3:m4=5
call absolute mouse(m1%,m2%,m3%,m4%)
status=11
status$="Maus-Cursor sichtbar machen..."
gosub WriteStatus
m1=1
call absolute mouse(m1%,m2%,m3%,m4%)
REM Ja, wo is' denn unser Muschen?
ReadKoord:
m1=3
call absolute mouse(m1%,m2%,m3%,m4%)
status=11
status$=""
if m2%=1 then status$="l     "
if m2%=2 then status$="    r "
if m2%=3 then status$="l   r "
if m2%=4 then status$="  m   "
if m2%=5 then status$="l m   "
if m2%=6 then status$="  m r "
if m2%=7 then status$="l m r "
if status$="" then goto NoSWrite
status$=status$+"bei x"+str$(m3)+", y"+str$(m4)+" gedrckt"
if status$=oldstat$ then NoSWrite
oldstat$=status$
gosub WriteStatus
NoSWrite:
gosub PaintButt
butt=m2:x=m3:y=m4
gosub WriteKoord
if y=88 and x>=32 and x<=136 and butt=1 then LoadProg
if y=112 and x>=32 and x<=136 and butt=1 then Beenden
goto ReadKoord

WriteStatus:
statusa$=statusb$
statusa=statusb
statusb$=statusc$
statusb=statusc
statusc$=statusd$
statusc=statusd
statusd$=left$(status$,38)
if len(statusd$)<38 then for a=len(statusd$) to 38:statusd$=statusd$+" ":next a
statusd=status
locate 2,3
color statusa,1
print statusa$
locate 3,3
color statusb,1
print statusb$
locate 4,3
color statusc,1
print statusc$
locate 5,3
color statusd,1
print statusd$
return

WriteKoord:
locate 11,25
color 11,1
print"Knopf-Status: ";butt;"         X: ";m3;"        Y: ";m4
return

PaintButt:
a=0:b=0:c=0
if m2=1 then a=1
if m2=2 then c=1
if m2=3 then a=1:c=1
if m2=4 then b=1
if m2=5 then a=1:b=1
if m2=6 then b=1:c=1
if m2=7 then a=1:b=1:c=1
ButtA1:
if a<>1 then goto ButtA0
locate 15,26:print"ฒฒฒฒฒฒ"
locate 16,26:print"ฒฒฒฒฒฒ"
goto ButtB1
ButtA0:
locate 15,26:print"      "
locate 16,26:print"      "
ButtB1:
if b<>1 then goto ButtB0
locate 15,33:print"ฒฒฒฒฒฒ"
locate 16,33:print"ฒฒฒฒฒฒ"
goto ButtC1
ButtB0:
locate 15,33:print"      "
locate 16,33:print"      "
ButtC1:
if c<>1 then goto ButtC0
locate 15,40:print"ฒฒฒฒฒฒ"
locate 16,40:print"ฒฒฒฒฒฒ"
return
ButtC0:
locate 15,40:print"      "
locate 16,40:print"      "
return

Beenden:
status=11
status$="Maus-Cursor unsichtbar machen..."
gosub WriteStatus
m1=2
call absolute mouse(m1%,m2%,m3%,m4%)
status=12
status$="Programm beendet."
gosub WriteStatus
end

LoadProg:
status=11
status$="Maus-Cursor unsichtbar machen..."
gosub WriteStatus
m1=2
call absolute mouse(m1%,m2%,m3%,m4%)
status=14
status$="Beenden und Starten von "+laun$+"..."
gosub WriteStatus
color 15,0,0
cls
execute laun$