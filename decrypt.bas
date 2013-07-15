	cls
	open "I",#1,"TRICK.DAT"
	dim l$(80)
	line input#1,line1$
	close #1
	locate 1,1:color 15:print"Original:  ";line1$
	for x=1 to len(line1$)
	  l$(x)=mid$(line1$,x,1)
	next x
	locate 2,1:color 15:print"Crypted :  ";:color 7
	for x=1 to len(line1$)
	  print l$(x);
	next x
	x=1
2	  locate 2,11+x:color 14:print l$(x)
1	  a$=inkey$: if a$="" then 1
	  if a$="+" then l$(x)=chr$(asc(l$(x))+1):goto 2
	  if a$="-" then l$(x)=chr$(asc(l$(x))-1):goto 2
	  if a$=chr$(27) then 3
	  if a$=chr$(8) then locate 2,11+x:color 7:print l$(x):x=x-1:goto 2
	  if a$=chr$(13) then color 15:locate 2,11+x:print l$(x):x=x+1:if x>len(line1$) then 3 else goto 2
3	print:color 15
	print"ASCII-Werte:"
	for x=1 to len(line1$)
	  print asc(l$(x));
	next x
	print
	print"Schreibe Daten in DECRYPT.OUT ... ";
	open "o",#1,"decrypt.out"
	print#1,"No C O ASC ASO Diff"
	for x=1 to len(line1$)
	  unt=asc(l$(x))-asc(mid$(line1$,x,1))
	  print #1, using "## ! ! ### ### +###";x;mid$(line1$,x,1);l$(x);asc(mid$(line1$,x,1));asc(l$(x));unt
	next x
	print"OK"
	close #1

