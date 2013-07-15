screen 12
anfh=val(left$(time$,2))
anfm=val(mid$(time$,4,2))
anfs=val(right$(time$,2))
dim x(1552)
dim y(1552)
a1=1:b1=1
a2=1:b2=2
if abs(a1*b2-a2*b1)<>1 then end
$INCLUDE "plus.inc"
rem locate 1,10:print "TEST"
rem locate 2,10:print " IT "
rem locate 3,10:print "OUT"
goto SkipIt
	line (58,0)-(108,50),15,bf

	for x=58 to 108 step 2
	  line (x,0)-(x,50),0
	next x
	for y=0 to 50 step 2
	  line (58,y)-(108,y),0
	next y

SkipIt:
xb=58
for y=0 to 50
  for x=0 to 50
    if point (xb+x,y)=15 then x(p)=x:y(p)=y:p=p+1
  next x
next y
do
  xb=xb+58:if xb>590 then xb=0:yb=yb+58
  if yb>425 then xb=0:yb=0:gosub Druck
  for z=0 to p-1
    x=(x(z)*a1+y(z)*b1)
    y=(x(z)*a2+y(z)*b2)
    x=(a1+b1)*50-x
	  x(z)=x-int(x/51)*51
	  y(z)=y-int(y/51)*51
	 pset (xb+x(z),yb+y(z)),15
  next z
  gosub ShowPer
  if inkey$=chr$(27) then end
  v=v+1
  line (0,0)-(50,50),15,b
  locate 2,6-len(str$(v)):print V
loop until v=72
end

ShowPer:
nowh=val(left$(time$,2))
nowm=val(mid$(time$,4,2))
nows=val(right$(time$,2))
unth=nowh-anfh
untm=nowm-anfm
unts=nows-anfs
if unts<0 then untm=untm-1:unts=60-abs(unts)
if untm<0 then unth=unth-1:untm=60-abs(untm)
sekl=(unth*3600)+(untm*60)+unts
if iper=0 then gosub InitPer
per%=(v/71)*100
per=(v/71)
if per>0 then rsek=sekl/per
if per%>=0 and per%<70 then col=10
if per%>=70 and per%<92 then col=14
if per%>=92 and per%<101 then col=12
for bar=lastper%*6 to per%*6 step 2
  line (spx+bar,spy)-(spx+bar,spy+30),col
next bar
lastper%=per%
locate 23,75:print using "### %";per%;
if int(rsek/3600)>=1 then rhour=int(rsek/3600):rsek=rsek-(rhour*3600) else rhour=0
if int(rsek/60)>=1 then rmin=int(rsek/60):rsek=rsek-(rmin*60) else rmin=0
if unth<10 then let unth$="0"+mid$(str$(unth),2,1) else let unth$=mid$(str$(unth),2,2)
if untm<10 then let untm$="0"+mid$(str$(untm),2,1) else let untm$=mid$(str$(untm),2,2)
if unts<10 then let unts$="0"+mid$(str$(unts),2,1) else let unts$=mid$(str$(unts),2,2)
if rhour<10 then let rhour$="0"+mid$(str$(rhour),2,1) else let rhour$=mid$(str$(rhour),2,2)
if rmin<10 then let rmin$="0"+mid$(str$(rmin),2,1) else let rmin$=mid$(str$(rmin),2,2)
if rsek<10 then let rsek$="0"+mid$(str$(rsek),2,1) else let rsek$=mid$(str$(rsek),2,2)
locate 24,72:print using "\\:\\:\\";unth$;untm$;unts$;
locate 25,72:print using "\\:\\:\\";rhour$;rmin$;rsek$;
locate 3,6-len(str$(per%)):print per%;
return

InitPer:
iper=1
spx=10:spy=450
for pbar=spx to spx+600 step 6
  line (pbar,spy-1)-(pbar,spy-5),15
next pbar
line (spx,spy-1)-(spx,spy-20),10
line (spx+150,spy-1)-(spx+150,spy-10),10
line (spx+300,spy-1)-(spx+300,spy-15),10
line (spx+450,spy-1)-(spx+450,spy-10),14
line (spx+600,spy-1)-(spx+600,spy-20),12
return

Druck:
  sound 700,10
   do:loop while not inkey$<>""
  cls:xb=58
return