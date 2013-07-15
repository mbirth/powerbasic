      dim p$(20)
      para$=command$
      a=1:x=1
1     x$=mid$(para$,x,1)
      if x$=" " then a=a+1:x=x+1:goto 1
      p$(a)=p$(a)+x$
      if x$="" then 2
      x=x+1
      goto 1
2     if p$(1)="/?" or p$(1)="" then goto Hilfe
      x=val(p$(1))
      y=val(p$(2))
      zei=val(p$(3))
      v=val(p$(4))
      h=val(p$(5))
3     for z=6 to 20
      if p$(z)="" then text$=left$(text$,len(text$)-1):goto 4
      text$=text$+p$(z)+" "
      next z
4     color v,h,0
      versch=round(zei/2-len(text$)/2,0)
      y=y+versch
      locate x,y:print text$
      end

Hilfe:
      print"WRITE was written by RoboCop INDUSTRIES"
      print
      print"Syntax:  WRITE x y length fc bc TEXT"
      print
      print"x      - x-coordinates of the begin of the field"
      print"y      - y-coordinates -------- '' -------------"
      print"lengt  - length of the field (the TEXT will be centered)"
      print"fc     - foreground color"
      print"bc     - background color"
      print"TEXT   - the text to print out"
      print
      print"(C)1995 by RoboCop INDUSTRIES"
      end