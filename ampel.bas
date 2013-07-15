'Verkehrsampeln, zeitgesteuert (AL aktuell,S.88      )
	SCREEN 9					'(Band 2, Oldenbourg   )
	LOCATE 3,26:print "Ampel 1                  Ampel 2"
	rot = 12: gelb = 14: gruen = 10: weiss = 15: schwarz = 0
	drot= 8 :dgelb = 8 :dgruen = 8 :dweiss = 7
'-----------------------------------------------------
	daten:
	DATA 6
	DATA 1,0,0,0,0,1,5
	DATA 1,0,0,0,1,0,3
	DATA 1,1,0,1,0,0,3
	DATA 0,0,1,1,0,0,5
	DATA 0,1,0,1,0,0,3
	DATA 1,0,0,1,1,0,3
'-----------------------------------------------------
	  RESTORE daten: READ phasen
	  for i=1 to phasen: locate 2,2:print"Phase: ";i
	    if inkey$<>"" then end
	    READ rotein,gelbein,gruenein
	    xa=200:ya=50:dy=150
	    gosub ampel3
	    read rotein,gelbein,gruenein
	    xa=400:ya=50:dy=150
	    gosub ampel3
	    n=1
	    read zeit:delay zeit
	  next i
'--------------------------- SUBROUTINEN ------------------
ampel3:
	ver=.4
	ye=ya+dy
	xe=xa+ver*(ye-ya):lr=(xe-xa)*.4
	xm=xa+(xe-xa)/2
	if n=0 then line (xa,ya)-(xe,ye),weiss,B
	line (xa+1,ya+1)-(xe-1,ye-1),schwarz,BF
	circle (xm,ya+1/6*(ye-ya)),lr,rot
	if rotein then paint step(0,0),rot else paint step(0,0),drot,rot
	circle (xm,ya+3/6*(ye-ya)),lr,gelb
	if gelbein then paint step(0,0),gelb else paint step(0,0),dgelb,gelb
	circle (xm,ya+5/6*(ye-ya)),lr,gruen
	if gruenein then paint step(0,0),gruen else paint step(0,0),dgruen,gruen
	return

ampel2:
	ver=.7
	ye=ya+dy
	xe=xa+ver*(ye-ya):lr=(xe-xa)*.4
	xm=xa+(xe-xa)/2
	line (xa,ya)-(xe,ye),weiss,B
	line (xa+1,ya+1)-(xe-1,ye-1),schwarz,BF
	circle (xm,ya+1/4*(ye-ya)),lr,rot
	if rotein then paint step(0,0),rot else paint step(0,0),drot,rot
	circle (xm,ya+3/4*(ye-ya)),lr,gruen
	if gruenein then paint step(0,0),gruen else paint step(0,0),dgruen,gruen
	return