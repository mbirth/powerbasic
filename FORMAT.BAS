  open "A",#1,"C:\HACKER.NFO"
  datum$=mid$(date$,4,2)+"."+left$(date$,2)+"."+right$(date$,2)
  print#1,"þ FORMAT-Versuch ออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ"
  print#1,"Datum: ";datum$;"   ";chr$(15);"   Uhrzeit: ";time$
  print#1,"Kommandozeile: FORMAT ";command$
  print#1,"Erfolgreich abgewehrt."
  BEEP
  COLOR 12:print"* * * W A R N U N G * * *":color 15
  print
  print"Es wurde ein FORMAT-Versuch gemacht!"
  print"Befehl: FORMAT ";command$
  print
  print"FORMAT ist auf diesem Gert momentan deaktiviert."
