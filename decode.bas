cls
open "I",#1,"USER.DAT"
line input #1,nam$
line input #1,num$
num$="Unlizensierte Kopie !!"
close #1
stp=0
1 rem cls
color 15
locate 1,1
print "Codierter USER #1: ";nam$
print "Codierter USER #2: ";num$
print
print "Decodierter #1   : ";dnam$
print "Decodierter #2   : ";dnum$
print
print "Schrittweite : ";stp
dnam$=""
dnum$=""
for z=1 to len(nam$)
  x$=mid$(nam$,z,1)
  x=asc(x$)
  soll=x+stp
  locate 4,19+z
  print chr$(soll)
  dnam$=dnam$+chr$(soll)
next z

for y=1 to len(num$)
  x$=mid$(num$,y,1)
  x=asc(x$)
  soll=x+stp
  locate 5,19+y
  print chr$(soll)
  dnum$=dnum$+chr$(soll)
next y
2 a$=inkey$:if a$="" then 2
  if a$="i" or a$="I" then gosub InputNumb:goto 1
  if a$="-" then stp=stp-1:goto 1
  if a$="+" then stp=stp+1:goto 1
  if a$=chr$(13) then locate 10,1:goto WriteErg
  if a$=chr$(27) then locate 10,1:goto Ende
  goto 2
goto 1

InputNumb:
locate 10,1
color 15:input"Geben Sie die Verschiebung ein :",stp
locate 10,1:print space$(79)
return

WriteErg:
print"Benenne USER.DAT in USER2.DAT um ... ";
name "USER.DAT" as "USER2.DAT"
print "OK"
print"Schreibe USER.DAT ... ";
open "O",#1,"USER.DAT"
print#1,"";dnam$
print#1,"";dnum$
close #1
print"OK"
print

Ende:
print"Programm-Ende."