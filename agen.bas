DECLARE SUB MakePat (Zw$, ZwF%, ZwB%)
DECLARE SUB MakeANSI (offen%)
DECLARE FUNCTION InsPat$ (Zahl%)
DECLARE FUNCTION PosOK% (Up%, Max%)
DECLARE SUB MakeSITS (eingabe$, laenge%)
CONST MaxEin = 70
CONST MaxAus = 80
DIM zeile AS STRING * MaxEin
DIM SHARED Result AS STRING * MaxAus
DIM SHARED ResultF(MaxAus + 1), ResultB(MaxAus + 1) AS INTEGER
DIM minpat AS INTEGER
DIM Patlen AS INTEGER
DIM veil AS INTEGER
RANDOMIZE TIMER
CONST maxpat = 10

CONST Zeichen = "°±²Û"
CONST Zeichenk = 4
CONST FColor = 16
CONST BColor = 8
CLS
PRINT " AGEN V111.111á"
PRINT " (c) Arndt Grass"
PRINT : PRINT
INPUT "Filename"; datei$
INPUT "Wie soll die ANSI-Ausgabedatei heiáen"; ausdatei$
nustart:
OPEN datei$ FOR INPUT AS #1
veil = FREEFILE
OPEN ausdatei$ FOR OUTPUT AS veil
minpat = 5
DO
        PRINT "Wie lang soll das Pattern gew„hlt werden (min."; minpat; " max."; maxpat; ")";
        INPUT Patlen
LOOP UNTIL (Patlen <= maxpat) AND (Patlen >= minpat)
WHILE NOT EOF(1)
        LINE INPUT #1, zeile
        Result = ""
        FOR i = 1 TO MaxAus
            ResultF(i) = 0
            ResultB(i) = 0
        NEXT i
        CALL MakeSITS(zeile, Patlen)
        CALL MakeANSI(veil)
WEND
CLOSE
COLOR 1, 0
PRINT
PRINT " (W)iederholen oder (S)peichern und Ende?"
repeat:
ink$ = ""
WHILE ink$ = ""
  ink$ = INKEY$
WEND
IF UCASE$(ink$) = "S" THEN
        CLS
        END
ELSEIF UCASE$(ink$) = "W" THEN
       GOTO nustart
ELSE
     GOTO repeat
END IF

SUB delpat (pattern$, PatPosition%, Aktuell%, change%)

   FOR i = 1 TO change%
        IF PatPosition% = Aktuell% THEN
                pattern$ = LEFT$(pattern$, Aktuell% - 1)
                Aktuell% = Aktuell% - 1
                PatPosition% = PosOK%(PatPosition%, Aktuell%)
        ELSE
                pattern$ = LEFT$(pattern$, PatPosition% - 1) + RIGHT$(pattern$, Aktuell% - PattPosition%)
                Aktuell% = Aktuell% - 1
        END IF
   NEXT i
END SUB

FUNCTION InsPat$ (Zahl%)
        Zw$ = ""
        FOR i = 1 TO Zahl%
            Zw$ = Zw$ + CHR$(Start + INT(Ende * RND))
        NEXT i
        InsPat$ = Zw$
END FUNCTION

SUB MakeANSI (offen%)
    FOR i = 1 TO LEN(Result)
        p$ = CHR$(27) + "[0;"
        IF ResultF(i) > 7 THEN
            p$ = p$ + "1;"
            ResultF(i) = ResultF(i) - 8
        END IF
        p$ = p$ + "3" + CHR$(48 + ResultF(i)) + ";4" + CHR$(48 + ResultB(i)) + "m" + MID$(Result, i, 1)
        COLOR ResultF(i), ResultB(i)
        PRINT MID$(Result, i, 1);
        PRINT #offen%, p$;
    NEXT
    PRINT #offen%, CHR$(13);




END SUB

SUB MakePat (Zw$, ZwF%, ZwB%)

    Zw$ = MID$(Zeichen, INT(Zeichenk * RND) + 1, 1)
    ZwB% = INT(RND * BColor)
        DO
            ZwF% = INT(RND * FColor)
        LOOP UNTIL ZwF% <> ZwB%

END SUB

SUB MakeSITS (eingabe$, laenge%)
DIM Vore%(20), Back(20) AS INTEGER
DIM RanDot(20) AS STRING * 1
DIM PatPos AS INTEGER

    'Pattern generieren
    FOR ii = 1 TO laenge%
        CALL MakePat(RanDot(ii), Vore%(ii), Back(ii))
    NEXT ii
    Aktuell% = laenge%

        level% = 0
        FOR i = 1 TO Aktuell% 'Leerpattern schreiben
            MID$(Result, i) = RanDot(i)
            ResultF(i) = Vore%(i)
            ResultB(i) = Back(i)
        NEXT i

        PatPos = 1 'Erste Patternposition festlegen
        FOR i = 1 TO LEN(eingabe$) 'Eingabe abarbeiten
            a$ = MID$(eingabe$, i, 1)
            IF a$ = " " THEN neuLevel% = 0 ELSE neuLevel% = VAL(a$)
            IF neuLevel% <> level% THEN
               IF level% > neuLevel% THEN
                        change% = level% - neuLevel%
                        FOR j = Aktuell% TO PatPos STEP -1
                            RanDot(j + change%) = RanDot(j)
                            Vore%(j + change%) = Vore%(j)
                            Back(j + change%) = Back(j)
                        NEXT
                        FOR j = 0 TO change% - 1
                            RanDot(j + PatPos) = MID$(Zeichen, INT(Zeichenk * RND) + 1, 1)
                            Back(j + PatPos) = INT(RND * BColor)
                            DO
                                Vore%(j + PatPos) = INT(RND * FColor)
                            LOOP UNTIL Back(j + PatPos) <> Vore%(j + PatPos)
                        NEXT
                        Aktuell% = Aktuell% + change%
               ELSE 'neulevel kleiner level
                        change% = neuLevel% - level%
                        FOR k = 1 TO change%
                            FOR j = PatPos TO Aktuell% - 1
                                RanDot(j) = RanDot(j + 1)
                                Vore%(j) = Vore%(j + 1)
                                Back(j) = Back(j + 1)
                            NEXT
                            Aktuell% = Aktuell% - 1
                            PatPos = PosOK%(PatPos, Aktuell%)
                         NEXT k
               END IF
               level% = neuLevel%
            END IF
            MID$(Result, i + laenge%) = RanDot(PatPos)
            ResultF(i + laenge%) = Vore%(PatPos)
            ResultB(i + laenge%) = Back(PatPos)
            PatPos = PatPos + 1
            PatPos = PosOK%(PatPos, Aktuell%)
        NEXT i

END SUB

FUNCTION PosOK% (Up%, Max%)
       
        IF Up% > Max% THEN
                PosOK% = 1
        ELSE
                PosOK% = Up%
        END IF

END FUNCTION

