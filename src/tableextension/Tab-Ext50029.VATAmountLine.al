tableextension 50029 "BC6_VATAmountLine" extends "VAT Amount Line"
{
    fields
    {
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'DEEE HT Amount';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80804; "BC6_DEEE VAT Amount"; Decimal)
        {
            Caption = 'DEEE VAT Amount';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80805; "BC6_DEEE TTC Amount"; Decimal)
        {
            Caption = 'DEEE TTC Amount';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80808; "BC6_DEEE Amount (LCY) for Stat"; Decimal)
        {
            Description = 'DEEE1.00';
        }
    }

    procedure InsertNewLine(VATIdentifier: Code[10]; VATCalcType: Option; TaxGroupCode: Code[10]; UseTax: Boolean; TaxRate: Decimal; IsPositive: Boolean; IsPrepayment: Boolean)
    begin
        INIT;
        "VAT Identifier" := VATIdentifier;
        "VAT Calculation Type" := VATCalcType;
        "Tax Group Code" := TaxGroupCode;
        "Use Tax" := UseTax;
        "VAT %" := TaxRate;
        Modified := TRUE;
        Positive := IsPositive;
        "Includes Prepayment" := IsPrepayment;
        INSERT;
    end;

    procedure "-DEE"()
    begin
    end;

    procedure GetTotalVATDEEEAmount(): Decimal
    var
        VATDEEEAmount: Decimal;
    begin
        //<<DEEE1.00
        VATDEEEAmount := 0;
        IF FIND('-') THEN
            REPEAT
                VATDEEEAmount := VATDEEEAmount + "BC6_DEEE VAT Amount";
            UNTIL NEXT = 0;
        EXIT(VATDEEEAmount);
        //>>DEEE1.00
    end;

    procedure GetTotalAmountDEEEInclVAT(): Decimal
    var
        AmountInclVATDEEE: Decimal;
    begin
        //<<DEEE1.00
        AmountInclVATDEEE := 0;

        IF FIND('-') THEN
            REPEAT
                AmountInclVATDEEE := AmountInclVATDEEE + "BC6_DEEE TTC Amount";
            UNTIL NEXT = 0;
        EXIT(AmountInclVATDEEE);
        //>>DEEE1.00
    end;

    procedure CopyFromSalesInvLine(SalesInvLine: Record "113")
    begin
        "VAT Identifier" := SalesInvLine."VAT Identifier";
        "VAT Calculation Type" := SalesInvLine."VAT Calculation Type";
        "Tax Group Code" := SalesInvLine."Tax Group Code";
        "VAT %" := SalesInvLine."VAT %";
        "VAT Base" := SalesInvLine.Amount;
        "VAT Amount" := SalesInvLine."Amount Including VAT" - SalesInvLine.Amount;
        "Amount Including VAT" := SalesInvLine."Amount Including VAT";
        "Line Amount" := SalesInvLine."Line Amount";
        IF SalesInvLine."Allow Invoice Disc." THEN
            "Inv. Disc. Base Amount" := SalesInvLine."Line Amount";
        "Invoice Discount Amount" := SalesInvLine."Inv. Discount Amount";
        Quantity := SalesInvLine."Quantity (Base)";
        "Calculated VAT Amount" :=
          SalesInvLine."Amount Including VAT" - SalesInvLine.Amount - SalesInvLine."VAT Difference";
        "VAT Difference" := SalesInvLine."VAT Difference";
    end;

    procedure CopyFromSalesCrMemoLine(SalesCrMemoLine: Record "115")
    begin
        "VAT Identifier" := SalesCrMemoLine."VAT Identifier";
        "VAT Calculation Type" := SalesCrMemoLine."VAT Calculation Type";
        "Tax Group Code" := SalesCrMemoLine."Tax Group Code";
        "VAT %" := SalesCrMemoLine."VAT %";
        "VAT Base" := SalesCrMemoLine.Amount;
        "VAT Amount" := SalesCrMemoLine."Amount Including VAT" - SalesCrMemoLine.Amount;
        "Amount Including VAT" := SalesCrMemoLine."Amount Including VAT";
        "Line Amount" := SalesCrMemoLine."Line Amount";
        IF SalesCrMemoLine."Allow Invoice Disc." THEN
            "Inv. Disc. Base Amount" := SalesCrMemoLine."Line Amount";
        "Invoice Discount Amount" := SalesCrMemoLine."Inv. Discount Amount";
        Quantity := SalesCrMemoLine."Quantity (Base)";
        "Calculated VAT Amount" := SalesCrMemoLine."Amount Including VAT" - SalesCrMemoLine.Amount - SalesCrMemoLine."VAT Difference";
        "VAT Difference" := SalesCrMemoLine."VAT Difference";
    end;

    procedure CopyFromServInvLine(ServInvLine: Record "5993")
    begin
        "VAT Identifier" := ServInvLine."VAT Identifier";
        "VAT Calculation Type" := ServInvLine."VAT Calculation Type";
        "Tax Group Code" := ServInvLine."Tax Group Code";
        "VAT %" := ServInvLine."VAT %";
        "VAT Base" := ServInvLine.Amount;
        "VAT Amount" := ServInvLine."Amount Including VAT" - ServInvLine.Amount;
        "Amount Including VAT" := ServInvLine."Amount Including VAT";
        "Line Amount" := ServInvLine."Line Amount";
        IF ServInvLine."Allow Invoice Disc." THEN
            "Inv. Disc. Base Amount" := ServInvLine."Line Amount";
        "Invoice Discount Amount" := ServInvLine."Inv. Discount Amount";
        Quantity := ServInvLine."Quantity (Base)";
        "Calculated VAT Amount" :=
          ServInvLine."Amount Including VAT" - ServInvLine.Amount - ServInvLine."VAT Difference";
        "VAT Difference" := ServInvLine."VAT Difference";
    end;

    procedure CopyFromServCrMemoLine(ServCrMemoLine: Record "5995")
    begin
        "VAT Identifier" := ServCrMemoLine."VAT Identifier";
        "VAT Calculation Type" := ServCrMemoLine."VAT Calculation Type";
        "Tax Group Code" := ServCrMemoLine."Tax Group Code";
        "VAT %" := ServCrMemoLine."VAT %";
        "VAT Base" := ServCrMemoLine.Amount;
        "VAT Amount" := ServCrMemoLine."Amount Including VAT" - ServCrMemoLine.Amount;
        "Amount Including VAT" := ServCrMemoLine."Amount Including VAT";
        "Line Amount" := ServCrMemoLine."Line Amount";
        IF ServCrMemoLine."Allow Invoice Disc." THEN
            "Inv. Disc. Base Amount" := ServCrMemoLine."Line Amount";
        "Invoice Discount Amount" := ServCrMemoLine."Inv. Discount Amount";
        Quantity := ServCrMemoLine."Quantity (Base)";
        "Calculated VAT Amount" :=
          ServCrMemoLine."Amount Including VAT" - ServCrMemoLine.Amount - ServCrMemoLine."VAT Difference";
        "VAT Difference" := ServCrMemoLine."VAT Difference";
    end;

    //Unsupported feature: Deletion (ParameterCollection) on "CheckVATDifference(PROCEDURE 11).NewPricesIncludingVAT(Parameter 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "InitGlobals(PROCEDURE 4).NewPricesIncludingVAT(Parameter 1002)".


    //Unsupported feature: Property Deletion (AsVar) on "CopyFrom(PROCEDURE 8).FromVATAmountLine(Parameter 1000)".


    //Unsupported feature: Property Modification (Name) on "CopyFrom(PROCEDURE 8).FromVATAmountLine(Parameter 1000)".


    //Unsupported feature: Property Modification (Subtype) on "CopyFrom(PROCEDURE 8).FromVATAmountLine(Parameter 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "GetTotalVATAmount(PROCEDURE 5).VATAmount(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "GetTotalInvDiscAmount(PROCEDURE 9).InvDiscAmount(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "GetTotalVATBase(PROCEDURE 14).VATBase(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "GetTotalAmountInclVAT(PROCEDURE 17).AmountInclVAT(Variable 1002)".

}

