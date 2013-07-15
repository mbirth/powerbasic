dim MaxLines(12)
for s=0 to 12
  screen 0,0,0
  width 80
  gosub PrintNA
  screen s
  cls
  on error goto MaxHere
  for x=1 to 50
    locate x,1
    print"Linie ";x;
  next x
1 delay .5
next s
goto Ende

PrintNA:
xpos=22
y=11
locate y,xpos
color 28
for block=0 to 37
  print"€";
next block
locate y+1,xpos
color 28:print"€€";:color 14:print using"  VideoMode ## is not available_!";s;:print"  ";:color 28:print"€€"
locate y+2,xpos
for block=0 to 37
  print"€";
next block
color 15
MaxLines(s)=0
return

MaxHere:
  MaxLines(s)=x-1
  locate MaxLines(s),20:print "Modus";s;
  resume 1

Ende:
screen 0,0,0
for s=0 to 12
  ModeInfo$="n/a"
  if s=0 then ModeInfo$="Textmodus"
  if s=1 then ModeInfo$="320x200x4"
  if s=2 then ModeInfo$="640x200x4 / 720x348x2"
'  if s=3 then ModeInfo$="720x348x2"
  if s=7 then ModeInfo$="320x200x16"
  if s=8 then ModeInfo$="640x200x16"
  if s=9 then ModeInfo$="640x350x16"
'  if s=10 then ModeInfo$="640x350x16m"
  if s=11 then ModeInfo$="640x480x256m"
  if s=12 then ModeInfo$="640x480x256"
  MaxLines$=mid$(str$(MaxLines(s)),2,20)+" Zeilen"
  if ModeInfo$="n/a" then MaxLines$="n/a"
  PO$=using$("Modus ##",s)
  PO$=PO$+using$(" (\                   \)",ModeInfo$)
  print PO$;": ";MaxLines$
next s
color 14+16,0
Ausgabe$="Bitte eine Taste drÅcken, wenn bereit"
locate 20,(80-len(Ausgabe$))/2
print Ausgabe$
999 if inkey$="" then 999