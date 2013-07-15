screen 12
cls
maxx=640
maxy=480
line (maxx/2,0)-(maxx/2,maxy)
line (0,maxy/2)-(maxx,maxy/2)
pset (maxx/2,maxy/2)
for l=1 to 125
  y=l^2
  x=(maxx/2)+l
  y=(maxy/2)-y
  line -(x,y)
next l