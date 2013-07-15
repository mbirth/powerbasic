	CLS
	input"Datei (*.SSC): ",OutFile$
	print"Bereite Ausgabe vor.";
	open "I",#1,OutFile$
	print".";
	open "B",#2,OutFile$
	print".";
	line input#1,Header$
	input#1,HWide$,VWide$,ScrMo$
	if val(ScrMo$)>=0 and val(ScrMo$)<=10 then LastLine=24 else LastLine=30
	print".";
	close #1
	print".";
	HWide=val(HWide$)
	VWide=val(VWide$)
	ScreenMode=val(ScrMo$)
	print".";
	get$ #2,19,Dummy$
	Dummy$=""
	print".vorbereitet"
	delay .5
	cls
	screen ScreenMode
	locate LastLine-1,1:print"HeaderInfo: ";Header$;
	locate LastLine,1:print space$(40);
	locate LastLine,1:print"Lese und Zeige Bild.";
	HeadLengt=len(Header$)+4
	Schritt=13
	Skale=int(HWide*VWide/Schritt)
	get$ #2,HeadLengt,Dummy$
	for y=1 to VWide
	  for x=1 to HWide
	    get$ #2,1,PixCol$
	    incr Pixel,1
	    PixCol=ascii(PixCol$)
	    if PixCol=-1 then PixCol=0
	    pset(x,y),PixCol
	    if Pixel/Skale=int(Pixel/Skale) then print".";
	  next x
	next y
	print".fertig";
1	a$=inkey$:if a$="" then 1
