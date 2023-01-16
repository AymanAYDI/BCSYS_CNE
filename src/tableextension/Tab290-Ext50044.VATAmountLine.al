tableextension 50044 "BC6_VATAmountLine" extends "VAT Amount Line" //290
{
    fields
    {
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'DEEE HT Amount', comment = 'FRA="Montant HT DEEE"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80804; "BC6_DEEE VAT Amount"; Decimal)
        {
            Caption = 'DEEE VAT Amount', comment = 'FRA="Montant TVA DEEE"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80805; "BC6_DEEE TTC Amount"; Decimal)
        {
            Caption = 'DEEE TTC Amount', comment = 'FRA="Montant TTC DEEE"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)', comment = 'FRA="Montant HT DEEE (DS)"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80808; "BC6_DEEE Amount (LCY) for Stat"; Decimal)
        {
            Caption = 'DEEE Amount (LCY) for Stat', comment = 'FRA="Montant DEEE (DS) pour Stat"';
            DataClassification = CustomerContent;
        }
    }

    procedure GetTotalVATDEEEAmount(): Decimal
    var
        VATDEEEAmount: Decimal;
    begin
        VATDEEEAmount := 0;
        IF FIND() THEN
            REPEAT
                VATDEEEAmount := VATDEEEAmount + "BC6_DEEE VAT Amount";
            UNTIL NEXT() = 0;
        EXIT(VATDEEEAmount);
    end;

    procedure GetTotalAmountDEEEInclVAT(): Decimal
    var
        AmountInclVATDEEE: Decimal;
    begin
        AmountInclVATDEEE := 0;

        IF FIND() THEN
            REPEAT
                AmountInclVATDEEE := AmountInclVATDEEE + "BC6_DEEE TTC Amount";
            UNTIL NEXT() = 0;
        EXIT(AmountInclVATDEEE);
    end;
}
