rem Arabische Zahlen -> Roem. Zahlen
DIM ein$(15), fuenf$(15)
DATA I,V,X,L,C,D,M,I)),((I)),I)))
for i=1 to 5:read ein$(i), fuenf$(i):next i
for i=6 to 15:ein$(i)="("+ein$(i-1)+")"
fuenf$(i)=fuenf$(i-1)+")":next i
do: input "Dezimalzahl, Stop mit 0"; z$
l=len(z$)
for i=1 to l:m=l-i+1
ziffer=val(mid$(z$,i,1))
select case ziffer
case 1 to 3
for j=1 to ziffer: rom$=rom$+ein$(m):next j
case 4
rom$=rom$+ein$(m)+fuenf$(m)
case 5
rom$=rom$+fuenf$(m)
case 6 to 8
rom$=rom$+fuenf$(m)
for j=6 to ziffer: rom$=rom$+ein$(m):next j
case 9
rom$=rom$+ein$(m)+ein$(m+1)
end select
next i
print rom$
rom$=""
loop until val(z$)<1
