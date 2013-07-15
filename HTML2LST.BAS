	dim eta(1000)
	cls
	print"þ HTML to List"
	print
	print"Converts HTML-File of a germany.net-Userlist into a Textfile"
	print
	shell "DIR gnusers.htm >html2lst.tmp"
	open "I",#1,"html2lst.tmp"
	for x=1 to 6:line input #1,dat$:next x
	close #1
	kill "html2lst.tmp"
	size$=mid$(dat$,16,3)+mid$(dat$,20,3)+mid$(dat$,24,3)
	size=val(Size$)
	size=size-63422
	open "I",#1,"gnusers.htm"
	open "O",#2,"gnusers.txt"
	for x=1 to 10:line input#1,dummy$:next x
	starttime=timer
1	line input #1,dat$
	bytecount=bytecount+Len(dat$)
	l=l+1
	if dat$="</pre>" or dat$="</PRE>" then goto Ende
	for x=1 to 20
	  x$=mid$(dat$,x,3)
	  if x$="<b>" or x$="<B>" then a=x:exit for
	next x
	ot$=    mid$(dat$,a+8,10)		'Usernumber
	ot$=ot$+mid$(dat$,a+26,99)		'Username and City
	if inkey$=chr$(27) then end
	if timer-1>oldtim then gosub ShowEta:oldtim=timer
	if ot$<>"" then print #2,ot$
	if eof(1) then goto Ende else goto 1

ShowEta:
	pro=int((bytecount/size)*100)
	if pro>0 then
	  tim=int(timer-starttime)
	  eta=int(tim/(bytecount/size))
	  if pro>5 then
	    ect=ect+1
	    eta(ect)=eta
	    for y=1 to ect:etb=etb+eta(ect):next y:eta=etb/ect:etb=0
	  end if
	  tm=int(tim/60)
	  ts=int(tim)-tm*60
	  em=int(eta/60)
	  es=int(eta)-em*60
	end if
	locate csrlin,1:print using "Bytes: #######/#######(Zeile: ######) ###% Zeit: ";bytecount;size;l;pro;
	if tm<10 then print using "0#_.";tm; else print using "##_.";tm;
	if ts<10 then print using "0#   ETA: ";ts; else print using "##   ETA: ";ts;
	if em<10 then print using "0#_.";em; else print using "##_.";em;
	if es<10 then print using "0#";es; else print using "##";es;
	print "      ";
	return

Ende:
	print
	print"Programm beendet."
	end
