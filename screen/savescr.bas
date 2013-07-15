	CLS
	input"Bilddatei (*.EXE): ",Includer$
	input"Ausgabedatei (*.SSC): ",OutFile$
	input"Bildschirmmodus (0-12): ",ScreenMode
	input"Capturebereich, Breite: ",HWide
	input"Capturebereich, H”he  : ",VWide
	screen ScreenMode
	if ScreenMode>=0 and ScreenMode<=10 then LastLine=24 else LastLine=30
	locate LastLine,1
	print"Lese und Schreibe Bild.";
	line (0,0)-(HWide,VWide),1,B
	print".";
	LastPos=POS(0)
	locate 1,1
	shell Includer$
	locate LastLine,LastPos
	print".";
	open "O",#1,OutFile$
	print".";
	print#1,"RoboCop INDUSTRIES SaveScrFile (Horizontal/Vertical/ScrMode)"
	print#1,chr$(34);
	print#1,using "####";HWide;
	print#1,chr$(34);",";chr$(34);
	print#1,using "####";VWide;
	print#1,chr$(34);",";chr$(34);
	print#1,using "##";ScreenMode;
	print#1,chr$(34);chr$(26)
	print ".";
	LastPoint=POS(0)
	for y=1 to VWide
	  for x=1 to HWide
	    PixData=POINT(x,y)
	    if PixData=-1 then PixData=0
	    print#1,chr$(PixData);
	  next x
	next y
	locate LastLine,LastPoint
	print".";
	close #1
	print".fertig";