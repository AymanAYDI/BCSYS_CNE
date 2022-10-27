tableextension 50051 tableextension50051 extends "Invoice Post. Buffer"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ 50003
    // //>>DEEE1.00
    // DEEE:JNPA 01/01/2007 : eco taxe
    //           - Add fields 80800, 80802, 80804, 80805..80807
    // ------------------------------------------------------------------------
    fields
    {
        field(1700; "Deferral Code"; Code[10])
        {
            Caption = 'Deferral Code';
            TableRelation = "Deferral Template"."Deferral Code";
        }
        field(1701; "Deferral Line No."; Integer)
        {
            Caption = 'Deferral Line No.';
        }
        field(50003; "Pay-to No."; Code[20])
        {
            Caption = 'Pay-to No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
        }
        field(80800; "DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code';
            Description = 'DEEE1.00';
            TableRelation = "Categories of item".Category;
        }
        field(80802; "DEEE HT Amount"; Decimal)
        {
            Caption = 'Montant HT DEEE';
            Description = 'DEEE1.00';
        }
        field(80804; "DEEE VAT Amount"; Decimal)
        {
            Caption = 'Montant TVA DEEE';
            Description = 'DEEE1.00';
        }
        field(80805; "DEEE TTC Amount"; Decimal)
        {
            Description = 'DEEE1.00';
        }
        field(80806; "DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80807; "Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE';
            Description = 'DEEE1.00';
            Editable = false;
            TableRelation = Vendor;
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Type,G/L Account,Gen. Bus. Posting Group,Gen. Prod. Posting Group,VAT Bus. Posting Group,VAT Prod. Posting Group,Tax Area Code,Tax Group Code,Tax Liable,Use Tax,Dimension Set ID,Job No.,Fixed Asset Line No."(Key)".

        key(Key1; Type, "G/L Account", "Gen. Bus. Posting Group", "Gen. Prod. Posting Group", "VAT Bus. Posting Group", "VAT Prod. Posting Group", "Tax Area Code", "Tax Group Code", "Tax Liable", "Use Tax", "Dimension Set ID", "Job No.", "Fixed Asset Line No.", "Deferral Code")
        {
            Clustered = true;
        }
    }


    //Unsupported feature: Code Modification on "PrepareSales(PROCEDURE 1)".

    //procedure PrepareSales();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CLEAR(Rec);
    Type := SalesLine.Type;
    "System-Created Entry" := TRUE;
    #4..19
      "Use Duplication List" := SalesLine."Use Duplication List";
    END;

    IF "VAT Calculation Type" = "VAT Calculation Type"::"Sales Tax" THEN BEGIN
      "Tax Area Code" := SalesLine."Tax Area Code";
      "Tax Group Code" := SalesLine."Tax Group Code";
      "Tax Liable" := SalesLine."Tax Liable";
      "Use Tax" := FALSE;
      Quantity := SalesLine."Qty. to Invoice (Base)";
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..22
    IF "VAT Calculation Type" = "VAT Calculation Type"::"Sales Tax" THEN
      SetSalesTaxForSalesLine(SalesLine);

    DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Global Dimension 1 Code","Global Dimension 2 Code");

    IF SalesLine."Line Discount %" = 100 THEN BEGIN
      "VAT Base Amount" := 0;
      "VAT Base Amount (ACY)" := 0;
      "VAT Amount" := 0;
      "VAT Amount (ACY)" := 0;
    END;
    */
    //end;


    //Unsupported feature: Code Modification on "CalcVATAmount(PROCEDURE 3)".

    //procedure CalcVATAmount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "VAT%" = 0 THEN
      EXIT(0);
    IF ValueInclVAT THEN
      EXIT(Value / (1 + ("VAT%" / 100)) * ("VAT%" / 100));

    EXIT(Value * ("VAT%" / 100));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF VATPercent = 0 THEN
      EXIT(0);
    IF ValueInclVAT THEN
      EXIT(Value / (1 + (VATPercent / 100)) * (VATPercent / 100));

    EXIT(Value * (VATPercent / 100));
    */
    //end;


    //Unsupported feature: Code Modification on "SetAccount(PROCEDURE 4)".

    //procedure SetAccount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TotalVAT := TotalVAT - "VAT Amount";
    TotalVATACY := TotalVATACY - "VAT Amount (ACY)";
    TotalAmount := TotalAmount - Amount;
    TotalAmountACY := TotalAmountACY - "Amount (ACY)";
    "G/L Account" := Account;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    "G/L Account" := AccountNo;
    */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: TotalVATBase) (ParameterCollection) on "SetAmounts(PROCEDURE 5)".


    //Unsupported feature: Parameter Insertion (Parameter: TotalVATBaseACY) (ParameterCollection) on "SetAmounts(PROCEDURE 5)".



    //Unsupported feature: Code Modification on "SetAmounts(PROCEDURE 5)".

    //procedure SetAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Amount := TotalAmount;
    "VAT Base Amount" := TotalAmount;
    "VAT Amount" := TotalVAT;
    "Amount (ACY)" := TotalAmountACY;
    "VAT Base Amount (ACY)" := TotalAmountACY;
    "VAT Amount (ACY)" := TotalVATACY;
    "VAT Difference" := "VAT Difference";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    Amount := TotalAmount;
    "VAT Base Amount" := TotalVATBase;
    "VAT Amount" := TotalVAT;
    "Amount (ACY)" := TotalAmountACY;
    "VAT Base Amount (ACY)" := TotalVATBaseACY;
    "VAT Amount (ACY)" := TotalVATACY;
    "VAT Difference" := VATDifference;
    */
    //end;


    //Unsupported feature: Code Modification on "PreparePurchase(PROCEDURE 6)".

    //procedure PreparePurchase();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CLEAR(Rec);
    Type := PurchLine.Type;
    "System-Created Entry" := TRUE;
    #4..26
      "Budgeted FA No." := PurchLine."Budgeted FA No.";
    END;

    IF "VAT Calculation Type" = "VAT Calculation Type"::"Sales Tax" THEN BEGIN
      "Tax Area Code" := PurchLine."Tax Area Code";
      "Tax Group Code" := PurchLine."Tax Group Code";
      "Tax Liable" := PurchLine."Tax Liable";
      "Use Tax" := FALSE;
      Quantity := PurchLine."Qty. to Invoice (Base)";
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..29
    IF "VAT Calculation Type" = "VAT Calculation Type"::"Sales Tax" THEN
      SetSalesTaxForPurchLine(PurchLine);

    DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Global Dimension 1 Code","Global Dimension 2 Code");

    IF PurchLine."Line Discount %" = 100 THEN BEGIN
      "VAT Base Amount" := 0;
      "VAT Base Amount (ACY)" := 0;
      "VAT Amount" := 0;
      "VAT Amount (ACY)" := 0;
    END;
    */
    //end;

    //Unsupported feature: Property Modification (Name) on "SetSalesTax(PROCEDURE 8)".



    //Unsupported feature: Code Modification on "SetAmountsNoVAT(PROCEDURE 10)".

    //procedure SetAmountsNoVAT();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Amount := TotalAmount;
    "VAT Base Amount" := TotalAmount;
    "VAT Amount" := 0;
    "Amount (ACY)" := TotalAmountACY;
    "VAT Base Amount (ACY)" := TotalAmountACY;
    "VAT Amount (ACY)" := 0;
    "VAT Difference" := "VAT Difference";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    "VAT Difference" := VATDifference;
    */
    //end;

    procedure SetSalesTaxForSalesLine(SalesLine: Record "37")
    begin
        "Tax Area Code" := SalesLine."Tax Area Code";
        "Tax Liable" := SalesLine."Tax Liable";
        "Tax Group Code" := SalesLine."Tax Group Code";
        "Use Tax" := FALSE;
        Quantity := SalesLine."Qty. to Invoice (Base)";
    end;

    procedure FillPrepmtAdjBuffer(var TempInvoicePostBuffer: Record "49" temporary; InvoicePostBuffer: Record "49"; GLAccountNo: Code[20]; AdjAmount: Decimal; RoundingEntry: Boolean)
    var
        PrepmtAdjInvPostBuffer: Record "49";
    begin
        WITH PrepmtAdjInvPostBuffer DO BEGIN
            INIT;
            Type := Type::"Prepmt. Exch. Rate Difference";
            "G/L Account" := GLAccountNo;
            Amount := AdjAmount;
            IF RoundingEntry THEN
                "Amount (ACY)" := AdjAmount
            ELSE
                "Amount (ACY)" := 0;
            "Dimension Set ID" := InvoicePostBuffer."Dimension Set ID";
            "Global Dimension 1 Code" := InvoicePostBuffer."Global Dimension 1 Code";
            "Global Dimension 2 Code" := InvoicePostBuffer."Global Dimension 2 Code";
            "System-Created Entry" := TRUE;
            InvoicePostBuffer := PrepmtAdjInvPostBuffer;

            TempInvoicePostBuffer := InvoicePostBuffer;
            IF TempInvoicePostBuffer.FIND THEN BEGIN
                TempInvoicePostBuffer.Amount += InvoicePostBuffer.Amount;
                TempInvoicePostBuffer."Amount (ACY)" += InvoicePostBuffer."Amount (ACY)";
                TempInvoicePostBuffer.MODIFY;
            END ELSE BEGIN
                TempInvoicePostBuffer := InvoicePostBuffer;
                TempInvoicePostBuffer.INSERT;
            END;
        END;
    end;

    procedure Update(InvoicePostBuffer: Record "49"; var InvDefLineNo: Integer; var DeferralLineNo: Integer)
    begin
        Rec := InvoicePostBuffer;
        IF FIND THEN BEGIN
            Amount += InvoicePostBuffer.Amount;
            "VAT Amount" += InvoicePostBuffer."VAT Amount";
            "VAT Base Amount" += InvoicePostBuffer."VAT Base Amount";
            "Amount (ACY)" += InvoicePostBuffer."Amount (ACY)";
            "VAT Amount (ACY)" += InvoicePostBuffer."VAT Amount (ACY)";
            "VAT Difference" += InvoicePostBuffer."VAT Difference";
            "VAT Base Amount (ACY)" += InvoicePostBuffer."VAT Base Amount (ACY)";
            Quantity += InvoicePostBuffer.Quantity;
            IF NOT InvoicePostBuffer."System-Created Entry" THEN
                "System-Created Entry" := FALSE;
            MODIFY;
            InvDefLineNo := "Deferral Line No.";
        END ELSE BEGIN
            IF "Deferral Code" <> '' THEN BEGIN
                DeferralLineNo := DeferralLineNo + 1;
                "Deferral Line No." := DeferralLineNo;
                InvDefLineNo := "Deferral Line No.";
            END;
            INSERT;
        END;
    end;

    //Unsupported feature: Property Modification (Name) on "CalcVATAmount(PROCEDURE 3)."VAT%"(Parameter 1002)".


    //Unsupported feature: Property Modification (Name) on "SetAccount(PROCEDURE 4).Account(Parameter 1000)".


    var
        DimMgt: Codeunit "408";
}

