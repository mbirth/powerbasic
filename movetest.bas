x=.028
dim z(256)
tim=50
cls
color 15
locate 5,1:print"Programming ASCII-Codes ... ";
let z(1)=32
let z(2)=250
let z(3)=249
let z(4)=7
let z(5)=254
print "codes programmed"
print "Counting values ... ";
a=1
1 if z(a)=0 and z(a+1)=0 then maxz=a-1:goto 2 else a=a+1:goto 1
2 print "counted:";maxz;"values found"
print "Playing sequence";tim;"times ... ";
cx=csrlin
cy=pos(0)
atim=1

Anfang:
for y=1 to maxz
  locate 1,1
  print chr$(z(y))
  delay x
next y
t1=atim/10
t2=t1-int(t1)
t3=t2*10
t3=round(t3,0)
tim$=str$(atim)+"th"
if t3=3 and int(atim/10)<>1 then tim$=str$(atim)+"rd"
if t3=2 and int(atim/10)<>1 then tim$=str$(atim)+"nd"
if t3=1 and int(atim/10)<>1 then tim$=str$(atim)+"st"
if atim>1 then s$="s" else s$=""
locate cx,cy:print"seq. now played";tim$;" time";s$;"  "
tim$=""
if atim=tim then goto Ende else atim=atim+1:goto Anfang

Ende:
locate cx,cy
print"sequence played";tim;"times               "
print"Shutting Down ... ";
print"program completely shutted down. Bye!"