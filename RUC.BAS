   cls
   print "-=ðþ Olson Software Help Tools Cracker þð=-"
   print
   print "RUC.INI format:"
   print chr$(34)+"helpfile"+chr$(34)+","+chr$(34)+"name"+chr$(34)+",countstart"
   print
   print "helpfile is needed for REGUTIL.EXE"
   print "name is the desired name"
   print "countstart is the starting number from which to try"
   print
   print "Reading infos ... ";
   open "I",#1,"RUC.INI"
   input #1,hf$,nam$,x
   close #1
   print "OK ("+hf$+";"+nam$+";"+right$(str$(x),len(str$(x))-1)+")"
   print "Cracking sequence begins (ESC breaks):"
Again:
   locate 12,1:print "þ";
   x$=right$(str$(x),len(str$(x))-1)
   print "þ";
   open "A",#1,"regutil.out"
   print "þ";
   print #1,chr$(13)+"["+x$+"] ";
   print "þ";
   close #1
   print "þ";
   print"ð "+x$+" ð";
   shel$="regutil.exe "+hf$+" "+chr$(34)+nam$+chr$(34)+" "+x$+" >>regutil.out"
   print "þ";
   shell shel$
   print "þ";
   x=x+1
   print "þ OK";
   if inkey$=chr$(27) then end
   locate 12,1:print space$(79);
   goto Again
