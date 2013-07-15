cls
x=1
1 locate 1,1
for z=1 to x
locate 1,z
if z<16 then color 12
if z<14 then color 14
if z<11 then color 10
st$=st$+chr$(7)
print chr$(254)
locate 2,z
print chr$(254)
next z
for y=len(st$) to 15
color 8
locate 1,y
print chr$(254)
locate 2,y
print chr$(254)
next y
2 a$=inkey$: if a$="" then 2
if a$="+" then x=x+1:st$="":goto 1
if a$="-" then X=x-1:st$="":goto 1
goto 2
