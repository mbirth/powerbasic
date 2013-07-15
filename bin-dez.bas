shell "mode co80"
cls
gosub StatusPaint
memo=26:memo$="Bitte warten...":gosub StatusDisp
locate 1,1
color 14:print"Umrechnungen BIN/DEZ written by RoboCop INDUSTRIES"
color 15:print
print"W„hlen Sie eine Umrechnung:";:color 31:print"_":for z=0 to 7500:next z
locate 3,28:print" "
print"_":for z=0 to 7500:next z:locate 4,1:print" "
texta$="[1] DEZimal in BIN„r"
textb$="[2] BIN„r in DEZimal"
for z=1 to 20
locate 5,z:color 15
print mid$(texta$,z,1);:color 31:print"_"
for x=0 to 500:next x
next z
for x=0 to 7500:next x
locate 5,21:print" "
locate 6,1:color 31:print"_"
for x=0 to 7500:next x
locate 6,1:print" "
for z=1 to 20
locate 7,z:color 15
print mid$(textb$,z,1);:color 31:print"_"
for x=0 to 500:next x
next z
for x=0 to 7500:next x
locate 7,21:print" "
color 31:print"_"
for x=0 to 7500:next x
locate 8,1:print" "
texta$="Geben Sie eine Zahl ein: "
for z=1 to 25
locate 9,z:color 15
print mid$(texta$,z,1);:color 31:print"_"
for x=0 to 500:next x
next z
Anfang:
memo=14:memo$="Ziffer eingeben!":gosub StatusDisp
1 a$=inkey$:if a$="" then 1
if a$="1" then goto DezToBin
if a$="2" then goto BinToDez
goto 1

DezToBin:
locate 9,26:color 15:print"1";:color 31:print"_"
memo=26:memo$="Bitte warten...":gosub StatusDisp
for z=0 to 5000:next z
textb$="  -  Dezimal in Bin„r umrechnen"
for z=1 to 31
locate 9,26+z:color 15
print mid$(textb$,z,1);:color 31:print"_"
for x=0 to 500:next x
next z
cls
gosub StatusPaint
memo=14:memo$="Bitte Zahl eingeben":gosub StatusDisp
locate 1,1
color 10:print"Umrechnen von Dezimal in Bin„r"
color 12:print"             This program was written by RoboCop INDUSTRIES"
color 0:print"Wenn du diesen Text lesen kannst, hast du das hier ausgedruckt oder bist in"
print"der Datei! Und das sollst du nicht! Geh weg, laá mich in ruh'!"
print"Fick dich ins Knie!"
color 15
input"Geben Sie eine Dezimale Zahl ein: ",dez
memo=26:memo$="Bitte warten...":gosub StatusDisp
zhl=0
erg$=""
erg=0
mx=67108864
for z=1 to 27
if zhl+mx>dez then mx=mx/2:if erg=1 then erg$=erg$+"0":goto 2 else goto 2
erg$=erg$+"1":erg=1:zhl=zhl+mx:mx=mx/2
2 next z
memo=10:memo$="Bitte Taste drcken":gosub StatusDisp
color 15:locate 8,1
print"Die Bin„rzahl lautet :";erg$
3 a$=inkey$:if a$="" then 3
goto EndAsk

BinToDez:
locate 9,26:color 15:print"2";:color 31:print"_"
memo=26:memo$="Bitte warten...":gosub StatusDisp
for z=0 to 5000:next z
textb$="  -  Bin„r in Dezimal umrechnen"
for z=1 to 31
locate 9,26+z:color 15
print mid$(textb$,z,1);:color 31:print"_"
for x=0 to 500:next x
next z
cls
gosub StatusPaint
memo=14:memo$="Bitte Code eingeben":gosub StatusDisp
locate 1,1
color 10:print"Umrechnen von Bin„r in Dezimal"
color 12:print"             This program was written by RoboCop INDUSTRIES"
color 0:print"Wenn du diesen Text lesen kannst, hast du das hier ausgedruckt oder bist in"
print"der Datei! Und das sollst du nicht! Geh weg, laá mich in ruh'!"
print"Fick dich ins Knie!"
color 15
input"Geben Sie einen Bin„r-Code ein: ",bn$
memo=26:memo$="Bitte warten...":gosub StatusDisp
mx=1
for z=0-len(bn$) to -1
zhl$=mid$(bn$,z*-1,1)
if zhl$="1" then erg=erg+mx:goto 5
if zhl$="0" then goto 5
5 mx=mx*2:next z
memo=10:memo$="Bitte Taste drcken":gosub StatusDisp
color 15:locate 8,1
print"Die Dezimalzahl lautet: ";erg
7 a$=inkey$:if a$="" then 7
goto EndAsk

EndAsk:
memo=12:memo$="J oder N drcken":gosub StatusDisp
locate 10,1
color 14
print"Wollen Sie noch eine Umrechnung machen [J/N] ?"
4 a$=inkey$:if a$="" then 4
if a$="j" or a$="J" then goto Begin
if a$="n" or a$="N" then goto Ende
goto 4

Begin:
cls
gosub StatusPaint
memo=14:memo$="Ziffer eingeben!":gosub StatusDisp
locate 1,1:color 14:print"Umrechnen von BIN„r- und DEZimal-Zahlen"
color 10:print"                     written by RoboCop INDUSTRIES"
print
print
color 15:print"[1] Umrechnen von DEZ in BIN"
print
print"[2] Umrechnen von BIN in DEZ"
print
print"Geben Sie eine Zahl ein: "
goto Anfang

StatusDisp:
locate 24,3:color memo
for z=len(memo$) to 21
memo$=memo$+" "
next z
print memo$;
return

StatusPaint:
locate 21,1:color 15:print"ÚÄÄÄÄÄÄÄÄ¿"
locate 22,1:color 15:print"³ Status º"
locate 23,1:color 15:print"ÆÍÍÍÍÍÍÍÍÊÍÍÄÄÄÄÄÄÄÄÄÄÄÄ¿"
locate 24,1:color 15:print"³ --------------------- º";
locate 25,1:color 15:print"ÀÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼";
return

Ende:
color 15
cls
locate 1,1
end