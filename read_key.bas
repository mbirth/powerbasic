	shell"mode co80"
	$include "TIMECALC.INC"
Anfang:
	stp=25
	dim tir(stp)
	open "O",#1,"READ_KEY.OUT"
	print#1,"נננ Ausgabedatei von READ_KEY.OUT נננ"
	print#1,""
	print#1,"Z    - Zeichen"
	print#1,"CHR$ - ASCII-Code"
	print#1,"Att  - Attribut (0-255)"
	print#1,"Fr   - Vordergrundfarbe (errechnet)"
	print#1,"Ba   - Hintergrundfarbe (errechnet)"
	print#1,""
	print#1,"Z CHR$  Att Fr Ba"
	print#1,"- ----  --- -- --"
	cls:randomize timer
3	'a=int(rnd(1)*256)
	'b=int(rnd(1)*32)
	'c=int(rnd(1)*8)
	durchg=durchg+1
	a=a+1
	if a=256 then a=0:b=b+1
	if b=32 then b=0:c=c+1
	if c=8 then close #1:end
	locate 1,1:color b,c:print chr$(a)
	oft=25
	if durchg/oft<>int(durchg/oft) then goto 4
	durchgmax=65536
	per=(durchg/durchgmax)*100
	gosub CalcPercent
4	ke=screen(1,1)
	attr=screen(1,1,1)
	locate 2,1:color 15,0
	print "ASCII-Code: ";ke;"    Zeichen: ";chr$(ke)
	print "Attribut  : ";attr
	print
	back=0:front=0
	battr=attr
	if attr<128 then goto LowAttribute
	if attr>127 and attr<256 then goto HighAttribute

LowAttribute:
1	if attr/16>=1 then
	  back=back+1
	  if back>7 then back=back-1:exit if
	  attr=attr-16
	  goto 1
	end if
	front=attr
	goto ShowIt

HighAttribute:
	attr=attr-128
2	if attr/16>=1 then
	  back=back+1
	  if back>7 then back=back-1:exit if
	  attr=attr-16
	  goto 2
	end if
	front=attr+16
	goto ShowIt


ShowIt:
	if inkey$=chr$(27) then close #1:end
	print "Vordergrundfarbe: ";front
	print "Hintergrundfarbe: ";back
	print using"Zeit seit Start: ##:##";mn,sc
	print using"Vorauss Ende   : ##:##";bm,bs
	print using"Geschafft      : ### %";per
	print#1,using "! ####  ### ## ##";chr$(ke),ke,battr,front,back
	goto 3
