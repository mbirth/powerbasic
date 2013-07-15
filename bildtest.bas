	screen 12
	call g(40,0)
	call g(15,0)
	for i=0 to 639 step 40
	  line (i,0)-(i+40,480),i/40,bf
	next i
	call w(0)
	call d(0,639,0,480,20,15,1)
	call w(0)
	for i=0 to 500 step 10
	  circle (320,240),i,2
	next
	call w(0)
	z=1
	for i=0 to 630 step 160
	  z=z+1
	  call m(i,i+160,z,0,240)
	next
	z=6
	for i=0 to 630 step 160
	  z=z-1
	  call m(i,i+160,z,240,479)
	next
	call w(0)
	call g(40,1)
	call d(20,620,20,460,80,80,0)
	call d(60,620,60,460,80,80,0)
	call w(0)

	SUB w(c)
	  c$=inkey$
	  do
	  loop until instat
	  if c=0 then cls
	END SUB

	SUB g(s,c)
	  cls
	  for x=0 to 639 step s
	    line (x,0)-(x,479),15
	  next
	  for y=10 to 479 step s
	    line (0,y)-(639,y),15
	  next
	  call w(c)
	END SUB

	SUB d(x1,x2,y1,y2,s1,s2,wa)
	  for x=x1 to x2 step s1
	    for y=y1 to y2 step s2
		 if wa=0 then paint (x,y),15,15 else pset (x,y)
	    next
	  next
	END SUB

	SUB m(x1,x2,s,j,k)
	  for x=x1 to x2 step s
	    line (x,j)-(x,k),15
	  next
	END SUB