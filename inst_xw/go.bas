Start:
     color 1,1
     cls
     color 0,3
     print"                         X-Wing Installationsprogramm                           "
     color 7,0
     locate 25,1
     color 7,0:print"1";:color 0,3:print"      ";
     for z=2 to 9
     color 7,0:print left$(str$(z),2);
     color 0,3:print"      ";
     next z
     color 7,0:print" 10";:color 0,3:print"      ";
     defint m
     def seg=0
     mseg=256*peek(207)+peek(206)
     mouse=256*peek(205)+peek(204)+2
     if mseg or  (mouse-2) then mse=1 else mse=0
     if mse<>1 then 1
     def seg=mseg
     if peek(mouse-2)=207 then mse=0:goto 1
     m1%=0
     call absolute mouse(m1%,m2%,m3%,m4%)
     mse=0
     if m1=-1 then mse=1
1    color 0,7
     locate 3,3
     if mse=1 then print" MAUSUNTERSTšTZUNG " else print"                   "
     locate 3,23
     if mse=1 then
       print m2%;"Tasten "
       m1=1:call absolute mouse(m1%,m2%,m3%,m4%)
       m1=10:m2=0:m3=2:m4=5:call absolute mouse(m1%,m2%,m3%,m4%)
     else
       print "          "
     end if
  DriveAsk:
     locate 25,2:color 0,3:print"LW C:";
     locate 25,10:print"LW D:";
     locate 25,18:print"LW E:";
     locate 25,26:print"LW F:";
     locate 25,34:print"LW G:";
     locate 25,75:print"Ende";
     locate 5,2:color 11,1:print"Bitte drcken Sie die F-Taste mit der Nummer, die vor der Laufwerksbezeichnung"
     print" des gewnschten Ziellaufwerks steht";
     if mse=1 then print" oder klicken Sie die Fl„che an." else print"."
     locate 6,2
     print"Es werden w„hrend der Installation ca. 25,5 MB sp„ter ca. 17 MB ben”tigt."
     ReadKoord1:
     if mse=0 then 2
     m1=3
     call absolute mouse(m1%,m2%,m3%,m4%)
     x=m3:y=m4:butt=m2
2    a$=inkey$
     if a$="" and butt=0 then ReadKoord1
     f$=mid$(a$,2,1)
     lw$=""
     if f$=";" or (butt>0 and x>=0 and x<=48 and y=192) then LW$="C"
     if f$="<" or (butt>0 and x>=64 and x<=112 and y=192) then lw$="D"
     if f$="=" or (butt>0 and x>=128 and x<=176 and y=192) then lw$="E"
     if f$=">" or (butt>0 and x>=192 and x<=240 and y=192) then lw$="F"
     if f$="?" or (butt>0 and x>=256 and x<=304 and y=192) then lw$="G"
     if f$="D" or (butt>0 and x>=576 and x<=632 and y=192) then goto Beenden
     if lw$="" then ReadKoord1
     locate 5,2:color 0,1:print space$(78):print space$(79):print space$(79)
     locate 5,2:color 11,1:print"Ziellaufwerk:  C   D   E   F   G"
     color 0,3
     if lw$="C" then locate 5,16:?" C "
     if lw$="D" then locate 5,20:?" D "
     if lw$="E" then locate 5,24:?" E "
     if lw$="F" then locate 5,28:?" F "
     if lw$="G" then locate 5,32:?" G "
     locate 25,2:print"      ";
     locate 25,10:print"      ";
     locate 25,18:print"      ";
     locate 25,26:print"      ";
     locate 25,34:print"      ";
     locate 25,75:print"      ";
     gosub MemTest
     if mry=1 then locate 5,36:color 0,3:print" OK ":goto MemOK
     if mry=0 then
       locate 9,2:color 11,1:print"Der Speicherplatz auf Laufwerk ";lw$;" reicht nicht aus."
       print" Folgende Informationen wurden ermittelt:"
       print using" þ Ben”tigt     : ,,,,,,,,,,,,";17*(1024^2)
       print " þ Frei auf ";lw$;:print using":  :  ,,,,,,,,,,,";frei*1000
       print using" þ Noch ben”tigt:  ,,,,,,,,,,,";(17*(1024^2))-(frei*1000)
       print
       print" W„hlen Sie ein anderes Laufwerk oder beenden Sie."
       goto DriveAsk
     end if

     MemOK:
     color 11,1
     locate 9,2:print space$(78):print space$(79):print space$(79):print space$(79):print space$(79):print space$(79):print space$(79)
     locate 7,2:print"Verzeichnis : ";
     color 0,3:print"\                                               "
     locate 7,16:input "\",verz$
     verz$="\"+verz$
     pfad$=lw$+":"+verz$
     color 12,1:locate 9,2:print"Sollen die obigen Einstellungen verwendet werden?"
     color 0,7:locate 14,2:print"     JA     ";:color 8,1:?"Ü"
     color 0,7:locate 14,17:print"   ŽNDERN   ";:color 8,1:?"Ü"
     color 0,7:locate 14,32:print"    ENDE    ";:color 8,1:?"Ü"
     for z=3 to 33 step 15
     locate 15,z:print"ßßßßßßßßßßßß"
     next z
     color 0,3
     locate 25,2:print"JA";
     locate 25,10:print"ŽNDERN";
     locate 25,75:print"Ende";
     color 11,1:locate 16,2:print"Bitte F1,F2,F10 oder [ENTER] drcken";
     if mse=1 then print" oder einen Knopf oder einen Bereich":print" in der F-Leiste mit der Maus anklicken." else print"."
     ReadKoord2:
     if mse=0 then 3
     m1=3
     call absolute mouse(m1%,m2%,m3%,m4%)
     x=m3:y=m4:butt=m2
3    a$=inkey$
     if a$="" and butt=0 then ReadKoord2
     f$=mid$(a$,2,1)
     wahl$=""
     if f$=";" or (butt>0 and x>=0 and x<=48 and y=192) or (butt>0 and x>=8 and x<=96 and y=104) then wahl$="J":c=2
     if f$="<" or (butt>0 and x>=64 and x<=112 and y=192) or (butt>0 and x>=128 and x<=216 and y=104) then wahl$="Ž":c=17
     if f$="D" or (butt>0 and x>=576 and x<=632 and y=192) or (butt>0 and x>=248 and x<=336 and y=104) then wahl$="E":c=32
     if wahl$="" then ReadKoord2
     locate 14,c:color 7,1
     print" ÜÜÜÜÜÜÜÜÜÜÜÜ"
     locate 15,c
     print" ßßßßßßßßßßßß"
     locate 16,2:print space$(79);
     locate 17,2:print space$(79);
     delay 1
     if wahl$="J" then InstallRout
     if wahl$="Ž" then Start
     if wahl$="E" then Beenden

     InstallRout:
     mkdir pfad$
     exec$="C:\DEICE.COM "+lw$+" "+verz$
     color 15,0
     cls
     color 0,3
     print"                         X-Wing Installationsprogramm                           ";
     color 15,0
     print
     shell exec$
     goto Ende

     Beenden:
     color 15,0
     cls
     color 0,3
     locate 1,1
     print"                         X-Wing Installationsprogramm                           ";
     color 11,1
     print"Installation abgebrochen...                                                     ";
     end

     Ende:
     shell "Del C:\RAR.cfg >NUL"
     shell "Del C:\rar.exe >NUL"
     shell "del C:\deice.com >NUL"
     shell "del C:\go.exe >NUL"

     color 15,0
     cls
     color 0,3
     locate 1,1
     print"                         X-Wing Installationsprogramm                           ";
     color 11,1
     print"Installation beendet...                                                         ";
     print space$(80);
     print"Viel Spaá noch mit X-Wing, B-Wing und Imperial Pursuits!                        ";
     print"Start von alledem mit <XWING>                                                   ";
     shell "Del c:\inst.exe >NUL"
     end

     MemTest:
     shell"Chkdsk "+lw$+": >C:\MEMCHK.XW"
     open "I",#1,"C:\MEMCHK.XW"
     locate 5,1
     color 14,0
4    line input#1,ZEILE$
     if mid$(zeile$,15,24)="Byte auf dem Datentr„ger" then memory=0 else goto 4
     close #1
     kill "C:\MEMCHK.XW"
     frei$=left$(zeile$,13)
     mem$=mid$(frei$,1,5)+mid$(frei$,7,3)+mid$(frei$,11,3)
     frei=val(mem$)/1000
     kbfrei=val(mem$)/(1024^2)
     if kbfrei<25.5 then mry=0
     if kbfrei>=25.5 then mry=1
     return