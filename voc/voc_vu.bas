' VOiCe - VU - Meter
' by RoboCop INDUSTRIES
dim sig$(51,200)
dim sig(51,200)
dim ym(51)
cls
print:print
print"™ffne Datei ";:color 30:print"... ":color 7
OPEN "I",#1,"BAD_DAY.V_C"
locate 3,13:print"... OK"
print"Lese Daten [Zeile:      Zeichen:     ( )  Zeichen ges.:        ] ";:color 30:print"...":color 7
for z=1 to 10
  if eof(1) then exit for
  line input #1,ZLE$
  e=len(zle$)
  for x=1 to e
    if x>=401 then exit for
	SIG$(z,x)=mid$(zle$,x,1)
	zeiges=zeiges+1
	locate 1,66:print using"###.#kB Memory";fre(0)/1024
	locate 2,66:print using"###.#kB   free";fre(-1)/1024
	locate 3,66:print using"##### B unused";fre(-2)
	locate 4,18:print using ": ###  Zeichen: ### (!)  Zeichen ges.: ######";z,x,sig$(z,x),zeiges;
  next x
  ym(z)=x
next z
zm=z
print" ] ... OK"
print"Konvertiere Daten [Zeichen:    ASCII:      Kurve: ñ     Wert:     ] ";:color 30:print"...":color 7
for z=1 to zm
  for x=1 to ym(z)
    sig(z,x)=0
    f=ascii(sig$(z,x))
    sig(z,x)=f-128
    locate 1,66:print using"###.#kB Memory";fre(0)/1024
    locate 2,66:print using"###.#kB   free";fre(-1)/1024
    locate 3,66:print using"##### B unused";fre(-2)
    locate 5,27:print using": !  ASCII: ###  Kurve: +###  Wert: ###";sig$(z,x),f,sig(z,x),abs(sig(z,x));
  next x
next z
print " ] ... OK"
print"Zeige Daten [Kurve: ñ     Wert:      Aussteuerung:    ] ";:color 30:print"...":color 7
locate 1,1:color 8:print "þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ"
locate 1,1:color 12:print"ANF"
locate 1,31:print"MID"
locate 1,62:print"END"
oldx=1
for z=1 to zm
  for y=1 to ym(z)
    a=sig(z,y)/2
    a=abs(a)
    x=round(a,0)
    if x<1 then x=1:if x>64 then x=64
    for h=1 to x
	 if h<64 and h>=52 then far=12
	 if h<52 and h>=35 then far=14
	 if h<35 and h>=0 then far=10
	 b$="þ"
	 if h=1 then b$="A"
	 if h=32 then b$="M"
	 if h=64 then b$="E"
	 locate 1,h:color far:print b$;:color 8
    next h
    for i=h to 64
	 b$="þ"
	 if i=1 then b$="A"
	 if i=32 then b$="M"
	 if i=64 then b$="E"
	 locate 1,i:print b$;
    next i
    color 7:locate 6,19:print using": +###  Wert: ###  Aussteuerung: ##";sig(z,y),abs(sig(z,y)),x;
  next y
next z
color 7:print" ] ... OK"