codeunit 50099 "Barcode Mngt AutoID"
{
    // -----------------------------------------------
    // Prodware -www.prodware.fr
    // -----------------------------------------------
    // 
    // //>>  CNE4.01
    // A:FE01 01.09.2011 : Bin Label Print
    // 
    // A:FE03 01.09.2011 : Item Label Print
    //                   - EAN13 Encode To Print


    trigger OnRun()
    begin
    end;

    var
        Correspondances: array[83, 2] of Char;
        i: Integer;
        j: Integer;
        pos: Integer;
        trouve: Boolean;
        CharTxt: Text[13];
        Char2: Char;
        f: Integer;
        LeadingDigit: Char;
        Encoding: Text[12];
        IntegerOk: Boolean;
        DigitValueArrayF11: array[10, 3] of Char;
        DigitValueArrayF13: array[15, 2] of Char;
        DigitValueArrayF14: array[14] of Char;

    [Scope('Internal')]
    procedure EncodeBarcodeEAN13(FromEAN13Bar: Text[13]; var EAN13Txt: Text[13]) EAN13Bar: Text[120]
    begin
        EAN13Bar := '';
        IF (FromEAN13Bar = '') THEN
            EXIT;

        // Check Integer Char
        IF STRLEN(FromEAN13Bar) > 13 THEN
            EXIT;

        FOR i := 1 TO STRLEN(FromEAN13Bar) DO BEGIN
            IntegerOk := EVALUATE(j, FORMAT(FromEAN13Bar[i]));
            IF NOT IntegerOk THEN
                EXIT;
        END;

        EAN13Txt := FromEAN13Bar;
        // EAN13Bar := FromEAN13Bar;
        Encoding := '';
        LeadingDigit := FromEAN13Bar[1];
        // MESSAGE('%1',FORMAT(LeadingDigit));
        LoadEncoding;

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

        // EAN13 CheckDigit
        /*Checksum := 0;
        FOR i := 1 TO STRLEN(EAN13Bar) DO
          BEGIN
            currentchar := EAN13Bar[i];
            Checksum := Checksum + (i * currentchar);
        END;
        ChecksumRes := Checksum MOD 13;*/

        // EAN13
        EXIT(EAN13Bar);

    end;

    [Scope('Internal')]
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

        // F11 - Character Set A UPC / EAN barcodes with human readable characters
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

        // F11 -Character Set B UPC / EAN barcodes with human readable characters
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

        // F11 -Character Set C UPC / EAN barcodes with human readable characters
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

        // F13 - Character UPC / EAN numbers and characters without barcodes
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

        // F13 - Character UPC / EAN numbers and characters without barcodes
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


        // F14 - UPC / EAN guard patterns and special characters.
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
        // DigitValueArrayF14[12] := ''';
        DigitValueArrayF14[13] := '-';
        DigitValueArrayF14[14] := '~';
    end;

    [Scope('Internal')]
    procedure FindCharF13(FromASCIIChar: Char) ToASCIIChar: Char
    var
        k: Integer;
        Finded: Boolean;
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

    [Scope('Internal')]
    procedure FindCharF11(FromASCIIChar: Char; FromSetChar: Char) ToASCIIChar: Char
    var
        k: Integer;
        Finded: Boolean;
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

    [Scope('Internal')]
    procedure "-- Code39 --"()
    begin
    end;

    [Scope('Internal')]
    procedure EncodeBarcode39(From39BarCode: Text[50]) "39BarCode": Text[50]
    var
        "Sum": Integer;
        k: Integer;
        BarCode39Ok: Boolean;
    begin
        "39BarCode" := '';
        BarCode39Ok := TRUE;
        FOR k := 1 TO STRLEN(From39BarCode) DO
            BarCode39Ok := BarCode39Ok OR
                           CheckCharBarcode39(From39BarCode[k]);

        IF BarCode39Ok THEN
            "39BarCode" := '*' + From39BarCode + '*';

        EXIT("39BarCode");
    end;

    [Scope('Internal')]
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

