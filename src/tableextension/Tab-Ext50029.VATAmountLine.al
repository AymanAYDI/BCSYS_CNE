tableextension 50029 "BC6_VATAmountLine" extends "VAT Amount Line"
{
    fields
    {
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'DEEE HT Amount';

            Editable = false;
        }
        field(80804; "BC6_DEEE VAT Amount"; Decimal)
        {
            Caption = 'DEEE VAT Amount';

            Editable = false;
        }
        field(80805; "BC6_DEEE TTC Amount"; Decimal)
        {
            Caption = 'DEEE TTC Amount';

            Editable = false;
        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)';

            Editable = false;
        }
        field(80808; "BC6_DEEE Amount (LCY) for Stat"; Decimal)
        {

        }
    }

    procedure InsertNewLine(VATIdentifier: Code[10]; VATCalcType: Option; TaxGroupCode: Code[10]; UseTax: Boolean; TaxRate: Decimal; IsPositive: Boolean; IsPrepayment: Boolean)
    begin
        INIT();
        "VAT Identifier" := VATIdentifier;
        "VAT Calculation Type" := VATCalcType;
        "Tax Group Code" := TaxGroupCode;
        "Use Tax" := UseTax;
        "VAT %" := TaxRate;
        Modified := TRUE;
        Positive := IsPositive;
        "Includes Prepayment" := IsPrepayment;
        INSERT();
    end;

    procedure "-DEE"()
    begin
    end;

    procedure GetTotalVATDEEEAmount(): Decimal
    var
        VATDEEEAmount: Decimal;
    begin
        VATDEEEAmount := 0;
        IF FIND('-') THEN
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

        IF FIND('-') THEN
            REPEAT
                AmountInclVATDEEE := AmountInclVATDEEE + "BC6_DEEE TTC Amount";
            UNTIL NEXT() = 0;
        EXIT(AmountInclVATDEEE);
    end;

}

