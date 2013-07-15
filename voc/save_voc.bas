cls
open "O",#1,"SAVE_VOC.RAW"
FOR SbPort = &H210 to &H280 STEP &H10
  OUT SbPort + &H6, 1
  FOR a = 1 to 10:next
  OUT SbPort + &H6, 0
  FOR a = 1 to 100
    IF INP(SbPort + &HA) = &HAA THEN GOTO SbFound
  NEXT
NEXT
PRINT "kein SoundBlaster => Ende..."
END

SbFound:
locate 1,1
color 10:print"SoundBlaster an Adresse ";hex$(SbPort);"h gefunden."
print"Beginne Speichern, Abbruch mit [ESC]!"
DO
  OUT SbPort + &HC, &H20
  DO:LOOP UNTIL INP(SbPort + &HE) AND 128
  value=inp(sbport+&HA)
  print#1,chr$(value);
LOOP UNTIL inkey$=chr$(27)
Goto Ende

Ende:
print"Programm beendet."
