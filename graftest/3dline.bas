cls
screen 12
delay 1
def fn y(x,z)=exp(-x^2-z^2)
puanz=15              'Anzahl Punkte pro Linie
wz=1                  'Winkel von Z- zur X-Achse
masz=1                'Stauch/Streckfaktor fÅr Z-Achsenteilung
projzx=cos(wz)*masz:projzy=sin(wz)*masz    'Projektion Z-Achse
xuntg=-3:xobg=3:xl=xobg-xuntg
yuntg=0:yobg=1:yl=yobg-yuntg
zuntg=-3:zobg=3:zl=zobg-zuntg
masx=5000/(xl+zl*projzx)
masy=5000/(yl+zl*projzy)
for z=zobg to zuntg step -zl/puanz
  pset ((zobg-z)*projzx*masx,(fn y(xuntg,zobg)-yuntg-projzy*(z-zobg))*masy)
  for x=xuntg to xobg step xl/puanz
    y=fn y(x,z)
    xk=(x-xuntg-projzx*(z-zobg))*masx
    yk=(y-yuntg-projzy*(z-zobg))*masy
    line -(xk,yk)
    pset (xk,yk)
  next x
next z