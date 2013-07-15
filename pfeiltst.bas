cls
b=1
1 a$=inkey$:if a$="" then 1
a=a+1
locate b,a:print a$
if a>=80 then a=0:b=b+2
goto 1
