codeunit 50099 "BC6_Barcode Mngt AutoID"
{
    var
        IntegerOk: Boolean;
        DigitValueArrayF11: array[10, 3] of Char;
        DigitValueArrayF13: array[15, 2] of Char;
        DigitValueArrayF14: array[14] of Char;
        LeadingDigit: Char;
        i: Integer;
        j: Integer;
        Encoding: Text[12];

    procedure EncodeBarcodeEAN13(FromEAN13Bar: Text[13]; var EAN13Txt: Text[13]) EAN13Bar: Text[120]
    begin
        EAN13Bar := '';
        IF (FromEAN13Bar = '') THEN
            EXIT;

        IF STRLEN(FromEAN13Bar) > 13 THEN
            EXIT;

        FOR i := 1 TO STRLEN(FromEAN13Bar) DO BEGIN
            IntegerOk := EVALUATE(j, FORMAT(FromEAN13Bar[i]));
            IF NOT IntegerOk THEN
                EXIT;
        END;

        EAN13Txt := FromEAN13Bar;
        Encoding := '';
        LeadingDigit := FromEAN13Bar[1];
        LoadEncoding();

        j := 0;
        EAN13Bar := FORMAT(FindCharF13(FromEAN13Bar[1]));
        EAN13Bar += FORMAT(DigitValueArrayF14[1]);
        FOR i := 1 TO STRLEN(Encoding) DO BEGIN
            j := i + 1;
            EAN13Bar += FORMAT(FindCharF11(FromEAN13Bar[j], Encoding[i]));
            IF i = 6 THEN
                EAN13Bar += FORMAT(DigitValueArrayF14[2]);
        END;
        EAN13Bar += FORMAT(DigitValueArrayF14[1]);
        EXIT(EAN13Bar);

    end;

    procedure LoadEncoding()
    begin
        CASE LeadingDigit OF
            '0':
                Encoding := 'AAAAAACCCCCC';
            '1':
                Encoding := 'AABABBCCCCCC';
            '2':
                Encoding := 'AABBABCCCCCC';
            '3':
                Encoding := 'AABBBACCCCCC';
            '4':
                Encoding := 'ABAABBCCCCCC';
            '5':
                Encoding := 'ABBAABCCCCCC';
            '6':
                Encoding := 'ABBBAACCCCCC';
            '7':
                Encoding := 'ABABABCCCCCC';
            '8':
                Encoding := 'ABABBACCCCCC';
            '9':
                Encoding := 'ABBABACCCCCC';
        END;

        DigitValueArrayF11[1, 1] := '0';
        DigitValueArrayF11[2, 1] := '1';
        DigitValueArrayF11[3, 1] := '2';
        DigitValueArrayF11[4, 1] := '3';
        DigitValueArrayF11[5, 1] := '4';
        DigitValueArrayF11[6, 1] := '5';
        DigitValueArrayF11[7, 1] := '6';
        DigitValueArrayF11[8, 1] := '7';
        DigitValueArrayF11[9, 1] := '8';
        DigitValueArrayF11[10, 1] := '9';

        DigitValueArrayF11[1, 2] := 'A';
        DigitValueArrayF11[2, 2] := 'B';
        DigitValueArrayF11[3, 2] := 'C';
        DigitValueArrayF11[4, 2] := 'D';
        DigitValueArrayF11[5, 2] := 'E';
        DigitValueArrayF11[6, 2] := 'F';
        DigitValueArrayF11[7, 2] := 'G';
        DigitValueArrayF11[8, 2] := 'H';
        DigitValueArrayF11[9, 2] := 'I';
        DigitValueArrayF11[10, 2] := 'J';

        DigitValueArrayF11[1, 3] := 'K';
        DigitValueArrayF11[2, 3] := 'L';
        DigitValueArrayF11[3, 3] := 'M';
        DigitValueArrayF11[4, 3] := 'N';
        DigitValueArrayF11[5, 3] := 'O';
        DigitValueArrayF11[6, 3] := 'P';
        DigitValueArrayF11[7, 3] := 'Q';
        DigitValueArrayF11[8, 3] := 'R';
        DigitValueArrayF11[9, 3] := 'S';
        DigitValueArrayF11[10, 3] := 'T';

        DigitValueArrayF13[1, 1] := '0';
        DigitValueArrayF13[2, 1] := '1';
        DigitValueArrayF13[3, 1] := '2';
        DigitValueArrayF13[4, 1] := '3';
        DigitValueArrayF13[5, 1] := '4';
        DigitValueArrayF13[6, 1] := '5';
        DigitValueArrayF13[7, 1] := '6';
        DigitValueArrayF13[8, 1] := '7';
        DigitValueArrayF13[9, 1] := '8';
        DigitValueArrayF13[10, 1] := '9';
        DigitValueArrayF13[11, 1] := ' ';
        DigitValueArrayF13[12, 1] := ' ';
        DigitValueArrayF13[13, 1] := ' ';
        DigitValueArrayF13[14, 1] := ' ';
        DigitValueArrayF13[15, 1] := ' ';

        DigitValueArrayF13[1, 2] := 'U';
        DigitValueArrayF13[2, 2] := 'V';
        DigitValueArrayF13[3, 2] := 'W';
        DigitValueArrayF13[4, 2] := 'X';
        DigitValueArrayF13[5, 2] := 'Y';
        DigitValueArrayF13[6, 2] := 'u';
        DigitValueArrayF13[7, 2] := 'v';
        DigitValueArrayF13[8, 2] := 'w';
        DigitValueArrayF13[9, 2] := 'x';
        DigitValueArrayF13[10, 2] := 'y';
        DigitValueArrayF13[11, 2] := ' ';
        DigitValueArrayF13[12, 2] := ' ';
        DigitValueArrayF13[13, 2] := ' ';
        DigitValueArrayF13[14, 2] := ' ';
        DigitValueArrayF13[15, 2] := ' ';


        DigitValueArrayF14[1] := '(';
        DigitValueArrayF14[2] := '*';
        DigitValueArrayF14[3] := ')';
        DigitValueArrayF14[4] := '+';
        DigitValueArrayF14[5] := '!';
        DigitValueArrayF14[6] := ' ';
        DigitValueArrayF14[7] := '`';
        DigitValueArrayF14[8] := '^';
        DigitValueArrayF14[9] := '|';
        DigitValueArrayF14[10] := '>';
        DigitValueArrayF14[11] := '<';
        DigitValueArrayF14[13] := '-';
        DigitValueArrayF14[14] := '~';
    end;

    procedure FindCharF13(FromASCIIChar: Char) ToASCIIChar: Char
    var
        Finded: Boolean;
        k: Integer;
    begin
        k := 0;
        Finded := FALSE;
        WHILE ((NOT Finded) AND
               (k < ARRAYLEN(DigitValueArrayF13, 1))) DO BEGIN
            k += 1;
            IF (DigitValueArrayF13[k, 1] = FromASCIIChar) THEN BEGIN
                Finded := TRUE;
                ToASCIIChar := DigitValueArrayF13[k, 2];
            END;
        END;
    end;

    procedure FindCharF11(FromASCIIChar: Char; FromSetChar: Char) ToASCIIChar: Char
    var
        Finded: Boolean;
        k: Integer;
    begin
        k := 0;
        Finded := FALSE;
        WHILE ((NOT Finded) AND
               (k < ARRAYLEN(DigitValueArrayF11, 1))) DO BEGIN
            k += 1;
            IF (DigitValueArrayF11[k, 1] = FromASCIIChar) THEN BEGIN
                Finded := TRUE;
                CASE FromSetChar OF
                    'A':
                        ToASCIIChar := DigitValueArrayF11[k, 1];
                    'B':
                        ToASCIIChar := DigitValueArrayF11[k, 2];
                    'C':
                        ToASCIIChar := DigitValueArrayF11[k, 3];
                END;
            END;
        END;
    end;

    procedure EncodeBarcode39(From39BarCode: Text[50]) "39BarCode": Text[50]
    var
        BarCode39Ok: Boolean;
        k: Integer;
    begin
        "39BarCode" := '';
        BarCode39Ok := TRUE;
        FOR k := 1 TO STRLEN(From39BarCode) DO
            BarCode39Ok := BarCode39Ok OR
                           CheckCharBarcode39(From39BarCode[k]);

        IF BarCode39Ok THEN
            "39BarCode" := CopyStr('*' + From39BarCode + '*', 1, MaxStrLen("39BarCode"));

        EXIT("39BarCode");
    end;

    procedure CheckCharBarcode39(FromASCIIChar: Char): Boolean
    begin
        IF FromASCIIChar IN ['0' .. '9'] THEN
            EXIT(TRUE);

        IF FromASCIIChar IN ['A' .. 'Z'] THEN
            EXIT(TRUE);

        CASE FromASCIIChar OF
            '-':
                EXIT(TRUE);
            '.':
                EXIT(TRUE);
            ' ':
                EXIT(TRUE);
            '$':
                EXIT(TRUE);
            '/':
                EXIT(TRUE);
            '+':
                EXIT(TRUE);
            '%':
                EXIT(TRUE);
        END;

        EXIT(FALSE);
    end;
}

