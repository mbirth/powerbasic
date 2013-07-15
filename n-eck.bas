	pi=3.14159265358979323846
	screen 12
rem	window screen (0,31)-(0,39)
	cls:color 14
	print "     ˙nECK˙":color 15
	print "          by
	print "  RoboCop˙INDUSTRIES"
	print
20	input"Ecken-Anzahl =",n:q=2*pi/n:if n<3 or n>12 goto 20
	dim P(5),x(n),y(n):p(0)=N
	input"StartlÑnge   =",p(1)
50	input"EndlÑnge     =",p(2):if p(2)>=p(1) goto 50
60	input"Drehwinkel   =",p(3):d=p(3)*pi/180:if d>q/2 goto 60
	s=sin(d):c=cos(d):a=cos(q):b=sin(q)
	p(4)=b/(c*b+s-a*s):x(1)=a:y(1)=B
	print"Idealer Wert ="p(4):input"Ñndern 0/1 =";r:p(5)=p(4)
	if r=1 then input"gewÅnschter  =",p(5)
REM	--------------- Eingabe beendet ----------------------
	cls:for i=1 to n-1:a=i*q:x(i)=cos(a):y(i)=sin(a):next i
	x(0)=1:y(0)=0:x(n)=1:y(n)=0:r=p(1)
REM	------------------ Rechnen ---------------------------
150	x1=r*x(0)+160:y1=r*y(0)+130: rem Startwert
	for i=1 to n:x2=r*x(i)+160:y2=r*y(i)+130
	line (x1,y1)-(x2,y2),15:x1=x2:y1=y2
	next i
	for i=0 to n:a=x(i)*c-y(i)*s:y(i)=y(i)*c+x(i)*s:x(i)=a
	next i: r=r*p(5):if r<p(2) goto 150: rem neues n-Eck
REM  ----------------- Anzeigen ---------------------------
	locate 23,1:print"AnfangslÑnge","EndlÑnge","Drehwinkel","idealer Wert"
	locate 24,1:for i=1 to 5:print p(i),:next
	locate 25,1:input"Bitte [ENTER] drÅcken, wenn breit",FUCK$
	screen 0,0,0:cls