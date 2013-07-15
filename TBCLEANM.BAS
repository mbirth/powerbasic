cls
open "I",#1,"C:\TBAV.LOG"
1 if eof(1)=0 then
    line input #1,zeile$
    if mid$(Zeile$,2,1)=":" and right$(Zeile$,2)="XE" then
	 print "Bearbeite: "+Zeile$
	 shellstr$="TBCLEAN "+left$(Zeile$,Len(Zeile$)-3)+"VXE "+left$(Zeile$,Len(Zeile$)-3)+"EXE"
	 print "S„ubere...."
	 shell shellstr$
	 print "L”sche infizierte Datei....";
	 kill left$(Zeile$,Len(Zeile$)-3)+"VXE"
	 print "OK"
	 x=x+1
    end if
  end if
goto 1
print "Komplett! ";x;" Dateien bearbeitet"
end