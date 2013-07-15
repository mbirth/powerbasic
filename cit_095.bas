WIDTH "LPT1:",255
lprint chr$(27);"1"
for n=1 to 20
read x
flag$=flag$+chr$(x)
next
lprint chr$(27);"K";chr$(20);chr$(0);flag$
flag$=""
for n=1 to 20
read x
flag$=flag$+chr$(x)
next
lprint chr$(27);"K";chr$(20);chr$(0);flag$
data 85,42,85,42,85,42,85,42,85,42
data 85,85,85,85,85,85,85,85,85,85
data 42,42,42,42,42,42,42,42,42,42
data 42,42,42,42,42,42,42,42,42,42
