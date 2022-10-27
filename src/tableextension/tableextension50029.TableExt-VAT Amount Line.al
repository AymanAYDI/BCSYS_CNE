tableextension 50029 tableextension50029 extends "VAT Amount Line"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //>>DEEE1.00
    // DEEE:JNPA 01/01/2007 : eco taxe
    //           - Add fields 80802 et 80804..80808
    //           - Update function InsertLine
    //           - Add function GetTotalVATDEEEAmount and GetTotalAmountDEEEInclVAT
    // ------------------------------------------------------------------------
    fields
    {
        field(19; "Tax Category"; Code[10])
        {
            Caption = 'Tax Category';
        }
        field(80802; "DEEE HT Amount"; Decimal)
        {
            Caption = 'DEEE HT Amount';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80804; "DEEE VAT Amount"; Decimal)
        {
            Caption = 'DEEE VAT Amount';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80805; "DEEE TTC Amount"; Decimal)
        {
            Caption = 'DEEE TTC Amount';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80806; "DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80808; "DEEE Amount (LCY) for Stat"; Decimal)
        {
            Description = 'DEEE1.00';
        }
    }


    //Unsupported feature: Code Modification on "CheckVATDifference(PROCEDURE 11)".

    //procedure CheckVATDifference();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InitGlobals(NewCurrencyCode,NewAllowVATDifference,NewPricesIncludingVAT);
    IF NOT AllowVATDifference THEN
      TESTFIELD("VAT Difference",0);
    IF ABS("VAT Difference") > Currency."Max. VAT Difference Allowed" THEN
    #5..12
            Text005,FIELDCAPTION("VAT Difference"),
            GLSetup.FIELDCAPTION("Max. VAT Difference Allowed"),GLSetup."Max. VAT Difference Allowed");
      END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    InitGlobals(NewCurrencyCode,NewAllowVATDifference);
    #2..15
    */
    //end;


    //Unsupported feature: Code Modification on "InitGlobals(PROCEDURE 4)".

    //procedure InitGlobals();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetCurrency(NewCurrencyCode);
    AllowVATDifference := NewAllowVATDifference;
    PricesIncludingVAT := NewPricesIncludingVAT;
    GlobalsInitialized := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF GlobalsInitialized THEN
      EXIT;

    SetCurrency(NewCurrencyCode);
    AllowVATDifference := NewAllowVATDifference;
    GlobalsInitialized := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "InsertLine(PROCEDURE 1)".

    //procedure InsertLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ("VAT Base" <> 0) OR ("Amount Including VAT" <> 0) THEN BEGIN
      Positive := "Line Amount" >= 0;
      VATAmountLine := Rec;
    #4..10
        "VAT Difference" := "VAT Difference" + VATAmountLine."VAT Difference";
        "VAT Amount" := "Amount Including VAT" - "VAT Base";
        "Calculated VAT Amount" := "Calculated VAT Amount" + VATAmountLine."Calculated VAT Amount";
        MODIFY;
      END ELSE BEGIN
        "VAT Amount" := "Amount Including VAT" - "VAT Base";
        INSERT;
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..13

        //>>MIGRATION NAV 2013
        //JNP DEEE
        //IF "Is Line Submitted"=2 THEN BEGIN
          "DEEE HT Amount":="DEEE HT Amount"+VATAmountLine."DEEE HT Amount" ;
          "DEEE VAT Amount":="DEEE VAT Amount"+VATAmountLine."DEEE VAT Amount" ;
          "DEEE TTC Amount":="DEEE TTC Amount"+VATAmountLine."DEEE TTC Amount" ;
        //END ;
        //<<MIGRATION NAV 2013

    #14..16

        //>>MIGRATION NAV 2013
        //JNP DEEE
        "DEEE HT Amount":=VATAmountLine."DEEE HT Amount" ;
        "DEEE VAT Amount":=VATAmountLine."DEEE VAT Amount" ;
        "DEEE TTC Amount":=VATAmountLine."DEEE TTC Amount" ;
        //<<MIGRATION NAV 2013

    #17..19
    */
    //end;


    //Unsupported feature: Code Modification on "VATAmountText(PROCEDURE 3)".

    //procedure VATAmountText();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF FIND('-') THEN
      IF NEXT = 0 THEN
        IF "VAT %" <> 0 THEN
          EXIT(STRSUBSTNO(Text000,"VAT %"));
    EXIT(Text001);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF COUNT = 1 THEN BEGIN
      FINDFIRST;
      IF "VAT %" <> 0 THEN
        EXIT(STRSUBSTNO(Text000,"VAT %"));
    END;
    EXIT(Text001);
    */
    //end;

    //Unsupported feature: Property Modification (Name) on "CopyFrom(PROCEDURE 8)".



    //Unsupported feature: Code Modification on "CopyFrom(PROCEDURE 8)".

    //procedure CopyFrom();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DELETEALL;
    IF FromVATAmountLine.FIND('-') THEN
      REPEAT
        Rec := FromVATAmountLine;
        INSERT;
      UNTIL FromVATAmountLine.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "VAT Identifier" := PurchInvLine."VAT Identifier";
    "VAT Calculation Type" := PurchInvLine."VAT Calculation Type";
    "Tax Group Code" := PurchInvLine."Tax Group Code";
    "Use Tax" := PurchInvLine."Use Tax";
    "VAT %" := PurchInvLine."VAT %";
    "VAT Base" := PurchInvLine.Amount;
    "VAT Amount" := PurchInvLine."Amount Including VAT" - PurchInvLine.Amount;
    "Amount Including VAT" := PurchInvLine."Amount Including VAT";
    "Line Amount" := PurchInvLine."Line Amount";
    IF PurchInvLine."Allow Invoice Disc." THEN
      "Inv. Disc. Base Amount" := PurchInvLine."Line Amount";
    "Invoice Discount Amount" := PurchInvLine."Inv. Discount Amount";
    Quantity := PurchInvLine."Quantity (Base)";
    "Calculated VAT Amount" :=
      PurchInvLine."Amount Including VAT" - PurchInvLine.Amount - PurchInvLine."VAT Difference";
    "VAT Difference" := PurchInvLine."VAT Difference";
    */
    //end;


    //Unsupported feature: Code Modification on "GetTotalVATAmount(PROCEDURE 5)".

    //procedure GetTotalVATAmount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    VATAmount := 0;
    IF FIND('-') THEN
      REPEAT
        VATAmount := VATAmount + "VAT Amount";
      UNTIL NEXT = 0;
    EXIT(VATAmount);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CALCSUMS("VAT Amount");
    EXIT("VAT Amount");
    */
    //end;


    //Unsupported feature: Code Modification on "GetTotalInvDiscAmount(PROCEDURE 9)".

    //procedure GetTotalInvDiscAmount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InvDiscAmount := 0;
    IF FIND('-') THEN
      REPEAT
        InvDiscAmount := InvDiscAmount + "Invoice Discount Amount";
      UNTIL NEXT = 0;
    EXIT(InvDiscAmount);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CALCSUMS("Invoice Discount Amount");
    EXIT("Invoice Discount Amount");
    */
    //end;


    //Unsupported feature: Code Modification on "GetTotalVATBase(PROCEDURE 14)".

    //procedure GetTotalVATBase();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    VATBase := 0;

    IF FIND('-') THEN
      REPEAT
        VATBase := VATBase + "VAT Base";
      UNTIL NEXT = 0;
    EXIT(VATBase);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CALCSUMS("VAT Base");
    EXIT("VAT Base");
    */
    //end;


    //Unsupported feature: Code Modification on "GetTotalAmountInclVAT(PROCEDURE 17)".

    //procedure GetTotalAmountInclVAT();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    AmountInclVAT := 0;

    IF FIND('-') THEN
      REPEAT
        AmountInclVAT := AmountInclVAT + "Amount Including VAT";
      UNTIL NEXT = 0;
    EXIT(AmountInclVAT);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CALCSUMS("Amount Including VAT");
    EXIT("Amount Including VAT");
    */
    //end;


    //Unsupported feature: Code Modification on "SetInvoiceDiscountAmount(PROCEDURE 13)".

    //procedure SetInvoiceDiscountAmount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InitGlobals(NewCurrencyCode,FALSE,NewPricesIncludingVAT);
    TotalInvDiscBaseAmount := GetTotalInvDiscBaseAmount(FALSE,Currency.Code);
    IF TotalInvDiscBaseAmount = 0 THEN
      EXIT;
    #5..19
        NewRemainder := NewRemainder - "Invoice Discount Amount";
      END;
    UNTIL NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    InitGlobals(NewCurrencyCode,FALSE);
    #2..22
    */
    //end;


    //Unsupported feature: Code Modification on "SetInvoiceDiscountPercent(PROCEDURE 16)".

    //procedure SetInvoiceDiscountPercent();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InitGlobals(NewCurrencyCode,FALSE,NewPricesIncludingVAT);
    IF FIND('-') THEN
      REPEAT
        IF "Inv. Disc. Base Amount" <> 0 THEN BEGIN
    #5..17
            NewRemainder := NewRemainder - "Invoice Discount Amount";
        END;
      UNTIL NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    InitGlobals(NewCurrencyCode,FALSE);
    #2..20
    */
    //end;


    //Unsupported feature: Code Modification on "GetCalculatedVAT(PROCEDURE 12)".

    //procedure GetCalculatedVAT();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT GlobalsInitialized THEN
      InitGlobals(NewCurrencyCode,FALSE,NewPricesIncludingVAT);

    IF NewPricesIncludingVAT THEN
      EXIT(
    #6..10
      ROUND(
        ("Line Amount" - "Invoice Discount Amount") * "VAT %" / 100 * (1 - NewVATBaseDiscPct / 100),
        Currency."Amount Rounding Precision",Currency.VATRoundingDirection));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    InitGlobals(NewCurrencyCode,FALSE);
    #3..13
    */
    //end;


    //Unsupported feature: Code Modification on "CalcVATFields(PROCEDURE 23)".

    //procedure CalcVATFields();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT GlobalsInitialized THEN
      InitGlobals(NewCurrencyCode,FALSE,NewPricesIncludingVAT);

    "VAT Amount" := GetCalculatedVAT(NewCurrencyCode,NewPricesIncludingVAT,NewVATBaseDiscPct);

    #6..20
    "Calculated VAT Amount" := "VAT Amount";
    "VAT Difference" := 0;
    Modified := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    InitGlobals(NewCurrencyCode,FALSE);
    #3..23
    */
    //end;

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
                VATDEEEAmount := VATDEEEAmount + "DEEE VAT Amount";
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
                AmountInclVATDEEE := AmountInclVATDEEE + "DEEE TTC Amount";
            UNTIL NEXT = 0;
        EXIT(AmountInclVATDEEE);
        //>>DEEE1.00
    end;

    procedure DeductVATAmountLine(var VATAmountLineDeduct: Record "290")
    begin
        IF FINDSET THEN
            REPEAT
                VATAmountLineDeduct := Rec;
                IF VATAmountLineDeduct.FIND THEN BEGIN
                    "VAT Base" -= VATAmountLineDeduct."VAT Base";
                    "VAT Amount" -= VATAmountLineDeduct."VAT Amount";
                    "Amount Including VAT" -= VATAmountLineDeduct."Amount Including VAT";
                    "Line Amount" -= VATAmountLineDeduct."Line Amount";
                    "Inv. Disc. Base Amount" -= VATAmountLineDeduct."Inv. Disc. Base Amount";
                    "Invoice Discount Amount" -= VATAmountLineDeduct."Invoice Discount Amount";
                    "Calculated VAT Amount" -= VATAmountLineDeduct."Calculated VAT Amount";
                    "VAT Difference" -= VATAmountLineDeduct."VAT Difference";
                    MODIFY;
                END;
            UNTIL NEXT = 0;
    end;

    procedure SumLine(LineAmount: Decimal; InvDiscAmount: Decimal; VATDifference: Decimal; AllowInvDisc: Boolean; Prepayment: Boolean)
    begin
        "Line Amount" += LineAmount;
        IF AllowInvDisc THEN
            "Inv. Disc. Base Amount" += LineAmount;
        "Invoice Discount Amount" += InvDiscAmount;
        "VAT Difference" += VATDifference;
        IF Prepayment THEN
            "Includes Prepayment" := TRUE;
        MODIFY;
    end;

    procedure UpdateLines(var TotalVATAmount: Decimal; Currency: Record "4"; CurrencyFactor: Decimal; PricesIncludingVAT: Boolean; VATBaseDiscountPerc: Decimal; TaxAreaCode: Code[20]; TaxLiable: Boolean; PostingDate: Date)
    var
        PrevVATAmountLine: Record "290";
        SalesTaxCalculate: Codeunit "398";
    begin
        IF FINDSET THEN
            REPEAT
                IF (PrevVATAmountLine."VAT Identifier" <> "VAT Identifier") OR
                   (PrevVATAmountLine."VAT Calculation Type" <> "VAT Calculation Type") OR
                   (PrevVATAmountLine."Tax Group Code" <> "Tax Group Code") OR
                   (PrevVATAmountLine."Use Tax" <> "Use Tax")
                THEN
                    PrevVATAmountLine.INIT;
                IF PricesIncludingVAT THEN
                    CASE "VAT Calculation Type" OF
                        "VAT Calculation Type"::"Normal VAT",
                        "VAT Calculation Type"::"Reverse Charge VAT":
                            BEGIN
                                "VAT Base" :=
                                  ROUND(
                                    ("Line Amount" - "Invoice Discount Amount") / (1 + "VAT %" / 100),
                                    Currency."Amount Rounding Precision") - "VAT Difference";
                                "VAT Amount" :=
                                  "VAT Difference" +
                                  ROUND(
                                    PrevVATAmountLine."VAT Amount" +
                                    ("Line Amount" - "Invoice Discount Amount" - "VAT Base" - "VAT Difference") *
                                    (1 - VATBaseDiscountPerc / 100),
                                    Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                                "Amount Including VAT" := "VAT Base" + "VAT Amount";
                                IF Positive THEN
                                    PrevVATAmountLine.INIT
                                ELSE BEGIN
                                    PrevVATAmountLine := Rec;
                                    PrevVATAmountLine."VAT Amount" :=
                                      ("Line Amount" - "Invoice Discount Amount" - "VAT Base" - "VAT Difference") *
                                      (1 - VATBaseDiscountPerc / 100);
                                    PrevVATAmountLine."VAT Amount" :=
                                      PrevVATAmountLine."VAT Amount" -
                                      ROUND(PrevVATAmountLine."VAT Amount", Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                                END;
                            END;
                        "VAT Calculation Type"::"Full VAT":
                            BEGIN
                                "VAT Base" := 0;
                                "VAT Amount" := "VAT Difference" + "Line Amount" - "Invoice Discount Amount";
                                "Amount Including VAT" := "VAT Amount";
                            END;
                        "VAT Calculation Type"::"Sales Tax":
                            BEGIN
                                "Amount Including VAT" := "Line Amount" - "Invoice Discount Amount";
                                IF "Use Tax" THEN
                                    "VAT Base" := "Amount Including VAT"
                                ELSE
                                    "VAT Base" :=
                                      ROUND(
                                        SalesTaxCalculate.ReverseCalculateTax(
                                          TaxAreaCode, "Tax Group Code", TaxLiable, PostingDate, "Amount Including VAT", Quantity, CurrencyFactor),
                                        Currency."Amount Rounding Precision");
                                "VAT Amount" := "VAT Difference" + "Amount Including VAT" - "VAT Base";
                                IF "VAT Base" = 0 THEN
                                    "VAT %" := 0
                                ELSE
                                    "VAT %" := ROUND(100 * "VAT Amount" / "VAT Base", 0.00001);
                            END;
                    END
                ELSE
                    CASE "VAT Calculation Type" OF
                        "VAT Calculation Type"::"Normal VAT",
                        "VAT Calculation Type"::"Reverse Charge VAT":
                            BEGIN
                                "VAT Base" := "Line Amount" - "Invoice Discount Amount";
                                "VAT Amount" :=
                                  "VAT Difference" +
                                  ROUND(
                                    PrevVATAmountLine."VAT Amount" +
                                    "VAT Base" * "VAT %" / 100 * (1 - VATBaseDiscountPerc / 100),
                                    Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                                "Amount Including VAT" := "Line Amount" - "Invoice Discount Amount" + "VAT Amount";
                                IF Positive THEN
                                    PrevVATAmountLine.INIT
                                ELSE
                                    IF NOT "Includes Prepayment" THEN BEGIN
                                        PrevVATAmountLine := Rec;
                                        PrevVATAmountLine."VAT Amount" :=
                                          "VAT Base" * "VAT %" / 100 * (1 - VATBaseDiscountPerc / 100);
                                        PrevVATAmountLine."VAT Amount" :=
                                          PrevVATAmountLine."VAT Amount" -
                                          ROUND(PrevVATAmountLine."VAT Amount", Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                                    END;
                            END;
                        "VAT Calculation Type"::"Full VAT":
                            BEGIN
                                "VAT Base" := 0;
                                "VAT Amount" := "VAT Difference" + "Line Amount" - "Invoice Discount Amount";
                                "Amount Including VAT" := "VAT Amount";
                            END;
                        "VAT Calculation Type"::"Sales Tax":
                            BEGIN
                                "VAT Base" := "Line Amount" - "Invoice Discount Amount";
                                IF "Use Tax" THEN
                                    "VAT Amount" := 0
                                ELSE
                                    "VAT Amount" :=
                                      SalesTaxCalculate.CalculateTax(
                                        TaxAreaCode, "Tax Group Code", TaxLiable, PostingDate, "VAT Base", Quantity, CurrencyFactor);
                                IF "VAT Base" = 0 THEN
                                    "VAT %" := 0
                                ELSE
                                    "VAT %" := ROUND(100 * "VAT Amount" / "VAT Base", 0.00001);
                                "VAT Amount" :=
                                  "VAT Difference" +
                                  ROUND("VAT Amount", Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                                "Amount Including VAT" := "VAT Base" + "VAT Amount";
                            END;
                    END;

                TotalVATAmount -= "VAT Amount";
                "Calculated VAT Amount" := "VAT Amount" - "VAT Difference";
                MODIFY;
            UNTIL NEXT = 0;
    end;

    procedure CopyFromPurchCrMemoLine(PurchCrMemoLine: Record "125")
    begin
        "VAT Identifier" := PurchCrMemoLine."VAT Identifier";
        "VAT Calculation Type" := PurchCrMemoLine."VAT Calculation Type";
        "Tax Group Code" := PurchCrMemoLine."Tax Group Code";
        "Use Tax" := PurchCrMemoLine."Use Tax";
        "VAT %" := PurchCrMemoLine."VAT %";
        "VAT Base" := PurchCrMemoLine.Amount;
        "VAT Amount" := PurchCrMemoLine."Amount Including VAT" - PurchCrMemoLine.Amount;
        "Amount Including VAT" := PurchCrMemoLine."Amount Including VAT";
        "Line Amount" := PurchCrMemoLine."Line Amount";
        IF PurchCrMemoLine."Allow Invoice Disc." THEN
            "Inv. Disc. Base Amount" := PurchCrMemoLine."Line Amount";
        "Invoice Discount Amount" := PurchCrMemoLine."Inv. Discount Amount";
        Quantity := PurchCrMemoLine."Quantity (Base)";
        "Calculated VAT Amount" :=
          PurchCrMemoLine."Amount Including VAT" - PurchCrMemoLine.Amount - PurchCrMemoLine."VAT Difference";
        "VAT Difference" := PurchCrMemoLine."VAT Difference";
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

