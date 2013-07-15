	 randomize timer
	 color 15:print"˙TEXT-MAKER˙";
	 color 7:print" written by RoboCop˙INDUSTRIES"
	 print
5     x(1)=csrlin:rem aktuelle Zeile
	 y(1)=pos(0):rem aktuelle Spalte
	 color 12:print"öberlege ..."
	 a$(1)="der":a$(2)="die":a$(3)="das":a$(4)="ein":a$(5)="alle":a$(6)="kein"
	 b$(1)="Frau":b$(2)="Mann":b$(3)="Kind":b$(4)="Esel":b$(5)="Baum"
	 c$(1)="ist":c$(2)="war":c$(3)="sind":c$(4)="wird"
	 d$(1)="lustig":d$(2)="traurig":d$(3)="mÅde":d$(4)="brav"
	 e$(1)="alt":e$(2)="jung":e$(3)="schîn":e$(4)="braun":e$(5)="gut"
	 f$(1)="und":f$(2)="oder":f$(3)="aber":f$(4)="auch"
	 g$(1)="und":g$(2)="oder":g$(3)="aber":g$(4)="auch"
	 h$(1)="haben":h$(2)="kaufen":h$(3)="essen":h$(4)="hîren"
	 i$(1)="FrÅchte":i$(2)="Obst":i$(3)="Mîbel":i$(4)="Radio"
	 j$(1)="und":j$(2)="oder":j$(3)="aber":j$(4)="auch"
	 k$(1)="und":k$(2)="oder":k$(3)="aber":k$(4)="auch"
	 REM Hauptprogramm

	 WortA:
	 a=round((rnd*5)+1,0)
	 art$=a$(a)
	 text$=text$+art$+" "
	 x=round((rnd*1)+1,0)
	 if x=1 then WortE
	 if x=2 then WortB

	 WortB:
	 a=round((rnd*4)+1,0)
	 subs$=b$(a)
	 if art$="die" or art$="alle" and subs$="Mann" then subs$="MÑnner"
	 if art$="das" and subs$="Mann" then subs$="MÑnnlein"
	 text$=text$+subs$+" "
	 x=round((rnd*2)+1,0)
	 if x=1 then WortC
	 if x=2 then WortH
	 if x=3 then WortJ

	 WortC:
	 a=round((rnd*3)+1,0)
	 text$=text$+c$(a)+" "
	 goto WortD

	 WortD:
	 a=round((rnd*3)+1,0)
	 text$=text$+d$(a)+" "
	 x=round((rnd*1)+1,0)
	 if x=1 then Fertig
	 if x=2 then WortF

	 WortE:
	 a=round((rnd*4)+1,0)
	 text$=text$+e$(a)+" "
	 x=round((rnd*1)+1,0)
	 if x=1 then WortB
	 if x=2 then WortG

	 WortF:
	 a=round((rnd*3)+1,0)
	 text$=text$+f$(a)+" "
	 x=round((rnd*2)+1,0)
	 if x=1 then WortD
	 if x=2 then WortC
	 if x=3 then WortA

	 WortG:
	 a=round((rnd*3)+1,0)
	 text$=text$+g$(a)+" "
	 goto WortE

	 WortH:
	 a=round((rnd*3)+1,0)
	 text$=text$+h$(a)+" "
	 goto WortI

	 WortI:
	 a=round((rnd*3)+1,0)
	 text$=text$+i$(a)+" "

	 x=round((rnd*1)+1,0)
	 if x=1 then Fertig
	 if x=2 then WortK

	 WortJ:
	 a=round((rnd*3)+1,0)
	 text$=text$+j$(a)+" "
	 goto WortA

	 WortK:
	 a=round((rnd*3)+1,0)
	 text$=text$+k$(a)+" "
	 x=round((rnd*3)+1,0)
	 if x=1 then WortI
	 if x=2 then WortH
	 if x=3 then WortC
	 if x=4 then WortA

	 Fertig:
	 locate x(1)-1,y(1):color 7:print text$:text$=""
	 if schon=1 then end else schon=1:goto 5