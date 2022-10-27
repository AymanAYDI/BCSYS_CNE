tableextension 50002 "BC6_PaymentLine" extends "Payment Line"
{
    LookupPageID = 10872;
    DrillDownPageID = 10872;
    fields
    {
        modify("Account No.")
        {
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset";
        }
        modify("Posting Group")
        {
            TableRelation = IF ("Account Type" = CONST(Customer)) "Customer Posting Group"
            ELSE
            IF ("Account Type" = CONST(Vendor)) "Vendor Posting Group"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "FA Posting Group";
        }
        modify("Acc. No. Last Entry Debit")
        {
            TableRelation = IF ("Acc. Type Last Entry Debit" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Acc. Type Last Entry Debit" = CONST(Customer)) Customer
            ELSE
            IF ("Acc. Type Last Entry Debit" = CONST(Vendor)) Vendor
            ELSE
            IF ("Acc. Type Last Entry Debit" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Acc. Type Last Entry Debit" = CONST("Fixed Asset")) "Fixed Asset";
        }
        modify("Acc. No. Last Entry Credit")
        {
            TableRelation = IF ("Acc. Type Last Entry Credit" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Acc. Type Last Entry Credit" = CONST(Customer)) Customer
            ELSE
            IF ("Acc. Type Last Entry Credit" = CONST(Vendor)) Vendor
            ELSE
            IF ("Acc. Type Last Entry Credit" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Acc. Type Last Entry Credit" = CONST("Fixed Asset")) "Fixed Asset";
        }

        modify("Bank Account Code")
        {
            TableRelation = IF ("Account Type" = CONST(Customer)) "Customer Bank Account".Code WHERE("Customer No." = FIELD("Account No."))
            ELSE
            IF ("Account Type" = CONST(Vendor)) "Vendor Bank Account".Code WHERE("Vendor No." = FIELD("Account No."));
        }
        modify("Payment Address Code")
        {
            TableRelation = "Payment Address".Code WHERE("Account Type" = FIELD("Account Type"),
                                                          "Account No." = FIELD("Account No."));
        }
        modify(IBAN)
        {
            Caption = 'IBAN', Comment = '{Locked}';
        }








        //Unsupported feature: Code Modification on ""Bank Account Code"(Field 25).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bank Account Code" <> '' THEN BEGIN
          IF "Account Type" = "Account Type"::Customer THEN BEGIN
            CustomerBank.GET("Account No.","Bank Account Code");
            "Bank Branch No." := CustomerBank."Bank Branch No.";
            "Bank Account No." := CustomerBank."Bank Account No.";
        #6..24
            END;
        END ELSE
          InitBankAccount;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "Bank Account Code" <> '' THEN BEGIN
          IF "Account Type" = "Account Type"::Customer THEN BEGIN
            IF SEPADirectDebitMandate.GET("Direct Debit Mandate ID") THEN
              IF "Bank Account Code" <> SEPADirectDebitMandate."Customer Bank Account Code" THEN
                ERROR(BankAccErr,SEPADirectDebitMandate."Customer Bank Account Code");
        #3..27
        */
        //end;

    }
    keys
    {
        key(Key6; "Due Date", "Document No.")
        {
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Statement.GET("No.");
    "Payment Class" := Statement."Payment Class";
    IF (Statement."Currency Code" <> "Currency Code") AND IsCopy THEN
      ERROR(Text000);
    #5..13
      IF "Document No." = '' THEN
        "Document No." := NoSeriesMgt.GetNextNo(PaymentClass."Line No. Series","Posting Date",FALSE);
    UpdateEntry(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    Statement.GET("No.");
    Statement.TESTFIELD("File Export Completed",FALSE);
    #2..16
    */
    //end;


    //Unsupported feature: Code Modification on "SetUpNewLine(PROCEDURE 1120007)".

    //procedure SetUpNewLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Account Type" := LastGenJnlLine."Account Type";
    IF "No." <> '' THEN BEGIN
      Statement.GET("No.");
      PaymentClass.GET(Statement."Payment Class");
      IF PaymentClass."Line No. Series" = '' THEN
        "Document No." := Statement."No."
      ELSE
        IF "Document No." = '' THEN
          IF BottomLine THEN
            "Document No." := INCSTR(LastGenJnlLine."Document No.")
          ELSE
            "Document No." := NoSeriesMgt.GetNextNo(PaymentClass."Line No. Series","Posting Date",FALSE);
    END;
    "Due Date" := Statement."Posting Date";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
          //>>MIGRATION NAV 2013
          //>>CORRECTIF_REGL STLA 01.08.2006 COR001 [3] Correctif Navision n° 8216026 sur les écarts de réglements
          {std
    #9..12
          }
          IF BottomLine AND (LastGenJnlLine."Line No." <> "Line No.") THEN
            "Document No." := INCSTR(LastGenJnlLine."Document No.")
          ELSE IF LastGenJnlLine."Document No." = '' THEN
              "Document No." := NoSeriesMgt.GetNextNo(PaymentClass."Line No. Series","Posting Date",FALSE)
            ELSE
              "Document No." := LastGenJnlLine."Document No.";
          //<<CORRECTIF_REGL STLA 01.08.2006 COR001 [3] Correctif Navision n° 8216026 sur les écarts de réglements
          //<<MIGRATION NAV 2013
    END;
    "Due Date" := Statement."Posting Date";
    */
    //end;


    //Unsupported feature: Code Modification on "GetAppliedDocNoList(PROCEDURE 1120009)".

    //procedure GetAppliedDocNoList();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CASE "Account Type" OF
      "Account Type"::Customer:
        BEGIN
    #4..32
        EXIT('');
    END;
    EXIT(List);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF ("Applies-to Doc. No." = '') AND ("Applies-to ID" = '') THEN
      EXIT('');
    #1..35
    */
    //end;


    //Unsupported feature: Code Modification on "DimensionCreate(PROCEDURE 1120001)".

    //procedure DimensionCreate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DefaultDimension.SETRANGE("No.","Account No.");
    IF DefaultDimension.FIND('-') THEN
      REPEAT
    #4..14
    IF DimSetEntry.FINDSET THEN
      REPEAT
        TempDimSetEntry := DimSetEntry;
        IF NOT TempDimSetEntry.MODIFY THEN
          TempDimSetEntry.INSERT;
      UNTIL DimSetEntry.NEXT = 0;

    "Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..17
        TempDimSetEntry."Dimension Set ID" := 0;
    #18..22
    */
    //end;


    //Unsupported feature: Code Modification on "DeletePaymentFileErrors(PROCEDURE 1120010)".

    //procedure DeletePaymentFileErrors();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GenJnlLine."Document No." := "No.";
    GenJnlLine."Line No." := "Line No.";
    GenJnlLine.DeletePaymentFileErrors;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    GenJnlLine."Journal Template Name" := '';
    GenJnlLine."Journal Batch Name" := FORMAT(DATABASE::"Payment Header");
    #1..3
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateEntry(PROCEDURE 1120006)".

    //procedure UpdateEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF (xRec."Line No." <> 0) AND ("Account Type" <> xRec."Account Type") THEN BEGIN
      IF NOT InsertRecord THEN BEGIN
        "Account No." := '';
    #4..30
          IF Customer.Blocked = Customer.Blocked::All THEN
            Customer.FIELDERROR(Blocked);
          IF "Bank Account Code" = '' THEN
            IF Customer."Preferred Bank Account" <> '' THEN
              VALIDATE("Bank Account Code",Customer."Preferred Bank Account");
          IF NOT InsertRecord THEN
            UpdateDueDate(0D);
        END;
      "Account Type"::Vendor:
        BEGIN
          Vendor.GET("Account No.");
          Vendor.TESTFIELD(Blocked,Vendor.Blocked::" ");
          IF "Bank Account Code" = '' THEN
            IF Vendor."Preferred Bank Account" <> '' THEN
              VALIDATE("Bank Account Code",Vendor."Preferred Bank Account");
          IF NOT InsertRecord THEN
            UpdateDueDate(0D);
        END;
    #49..64
      "Payment Address Code" := PaymentAddress.Code
    ELSE
      "Payment Address Code" := '';
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..33
            IF Customer."Preferred Bank Account Code" <> '' THEN
              VALIDATE("Bank Account Code",Customer."Preferred Bank Account Code");
    #36..43
            IF Vendor."Preferred Bank Account Code" <> '' THEN
              VALIDATE("Bank Account Code",Vendor."Preferred Bank Account Code");
    #46..67
    */
    //end;

    procedure GetAppliesToDocCustLedgEntry(var CustLedgEntry: Record 21)
    begin
        IF "Account Type" <> "Account Type"::Customer THEN
            EXIT;

        CustLedgEntry.SETRANGE("Customer No.", "Account No.");
        CustLedgEntry.SETRANGE(Open, TRUE);
        IF "Applies-to Doc. No." <> '' THEN BEGIN
            CustLedgEntry.SETRANGE("Document Type", "Applies-to Doc. Type");
            CustLedgEntry.SETRANGE("Document No.", "Applies-to Doc. No.");
            IF CustLedgEntry.FINDFIRST THEN;
        END ELSE
            IF "Applies-to ID" <> '' THEN BEGIN
                CustLedgEntry.SETRANGE("Applies-to ID", "Applies-to ID");
                IF CustLedgEntry.FINDSET THEN;
            END;
    end;

    //Unsupported feature: Property Modification (Length) on "AddDocumentNoToList(PROCEDURE 1120012).DocumentNo(Parameter 1120004)".


    //Unsupported feature: Property Modification (Length) on "GetAppliedDocNoList(PROCEDURE 1120009).DocumentNo(Variable 1120003)".


    var
        SEPADirectDebitMandate: Record 1230;


    //Unsupported feature: Property Modification (Id) on "RibKey(Variable 1120002)".

    //var
    //>>>> ORIGINAL VALUE:
    //RibKey : 1120002;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RibKey : 1120006;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "NoSeriesMgt(Variable 1120006)".

    //var
    //>>>> ORIGINAL VALUE:
    //NoSeriesMgt : 1120006;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NoSeriesMgt : 1120002;
    //Variable type has not been exported.

    var
        BankAccErr: Label 'You must use customer bank account, %1, which you specified in the selected direct debit mandate.';
}

