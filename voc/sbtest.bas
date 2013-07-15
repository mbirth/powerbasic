
call interrupt 7

for x=1 to 9
if x=1 then print"AX: ";
if x=2 then print"BX: ";
if x=3 then print"CX: ";
if x=4 then print"DX: ";
if x=5 then print"SI: ";
if x=6 then print"DI: ";
if x=7 then print"BP: ";
if x=8 then print"DS: ";
if x=9 then print"ES: ";
?reg(x)
next x
print"----------------------------"