Mode=8					'vidmode to use
Lines=25					'number of lines in desired vidmode
Columns=80				'number of columns in desired vidmode
TakesPerLine=Columns/40		'calculates loops per line
BGCol=0					'enables backgroundcolorchange

if BGCol=1 then BG1=1:BG2=2:BG3=3:BG4=4 else BG1=0:BG2=0:BG3=0:BG4=0

screen Mode
WoAllesBegann:
x=x+1
color  9,BG1:print" ±²Û";		'Bargraph forward
color  9,BG3:print"± ";
color 11,BG3:print"±Û";
color 11,BG2:print"²±";
color 10,BG2:print"±Û";
color 14,BG2:print"±²Û";
color 14,BG4:print"²±";
color 12,BG4:print"±²Û";
delay .05
color 12,BG4:print"Û²±";		'Bargraph backward
color 14,BG4:print"±²";
color 14,BG2:print"Û²±";
color 10,BG2:print"Û±";
color 11,BG2:print"±²";
color 11,BG3:print"Û±";
color  9,BG3:print" ±";
color  9,BG1:print"Û²± ";
delay .1
if inkey$=chr$(27) then end
if x=(Lines-1)*TakesPerLine then locate Lines,1
if x=Lines*TakesPerLine then color 15,0,0:end else goto WoAllesBegann
