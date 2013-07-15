1	'Programm: HALLO.BAS
2	'Funktion: Sprachausgabe mit BASIC
3	'Sprache : GW-Basic
4	'Autor   : John Lupton
6	input r:
7	if r>0 then z=int(1193280! / R)
10	f=1850:i=97:dim d(f):b=.2
20	out 67,182:out 66,z and 255:
21	out 66,z\256:h=inp(i) or 3:
22	out i,h:l=inp(i) and 252:
23	out i,l
30	key(1) on: key(2) on: key(5) on:
31	key(6) on: on key(1) gosub 200:
32	on key(2) gosub 210:
33	on key(5) gosub 220:
34	on key(6) gosub 230
40	while a>-1
50	  read a:if a=0 then a=1
60	  d(a+a1)=1:a1=a1+a
70	wend
80	while inkey$=""
90	  for t=1 to f step b
100	    if d(t) then out i,h
110	    if s>0 then for n=2 to s:next n
120	    out i,l
130	  next t
140	wend
150	out i,l:end
200	s=s-2
210	s=s+1:return
220	b=b+.005:return
230	b=b-.005:if b<.005 then b=.005
240	return
500	data 374,21,4,,5,15,,4,6,6,,9,4,,5,,12,
501	data 4,6,11,,4,,,4,,10,5,,5,,8,,5,6,
502	data 8,,5,,5,,8,6,,,6,6,,,6,,,9,,,,8,
503	data 9,3,8,12,,19,,,56,24,11,28,,,9,,9,
504	data ,,7,2,10,,2,6,3,9,,,,6,,,10,,,,7,,
505	data 11,,,7,,11,,10,11,,9,,10,,7,,13,,
510	data 7,,12,,,7,,12,,8,,12,,8,,12,,8,,11
511	data ,,,7,,,11,,,7,,,10,,,8,,11,,,8,,10
512	data ,,,8,,,10,,9,,10,,,8,,,9,,,8,,,9,,
513	data ,9,,10,,9,,10,,9,,10,,5,5,10,,,9,,
514	data 9,,,9,,10,,,9,11,,,20,,,,21,,14,8,
515	data ,,14,9,,,23,,,27,,33,-1