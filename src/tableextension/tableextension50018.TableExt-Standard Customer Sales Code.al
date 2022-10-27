tableextension 50018 tableextension50018 extends "Standard Customer Sales Code"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Text_Automatiques] Ajout du champ 50000
    // 
    // ------------------------------------------------------------------------
    Caption = 'Standard Customer Sales Code';
    fields
    {
        modify("Customer No.")
        {
            Caption = 'Customer No.';
        }
        modify("Code")
        {
            Caption = 'Code';
        }
        modify(Description)
        {
            Caption = 'Description';
        }
        modify("Direct Debit Mandate ID")
        {
            TableRelation = "SEPA Direct Debit Mandate" WHERE (Customer No.=FIELD(Customer No.),
                                                               Blocked=CONST(No),
                                                               Closed=CONST(No));
            Caption = 'Direct Debit Mandate ID';
        }

        //Unsupported feature: Deletion on "Code(Field 2).OnLookup".

        field(50000;TextautoReport;Boolean)
        {
            Caption = 'Text Auto report';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Text_Automatiques] Ajout du champ';
        }
    }


    //Unsupported feature: Code Modification on "CreateSalesInvoice(PROCEDURE 6)".

    //procedure CreateSalesInvoice();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TESTFIELD(Blocked,FALSE);
        SalesHeader.INIT;
        SalesHeader."No." := '';
        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader.INSERT(TRUE);
        SalesHeader.VALIDATE("Sell-to Customer No.","Customer No.");
        SalesHeader.VALIDATE("Order Date",OrderDate);
        SalesHeader.VALIDATE("Posting Date",PostingDate);
        IF "Payment Method Code" <> '' THEN
          SalesHeader.VALIDATE("Payment Method Code","Payment Method Code");
        IF "Payment Terms Code" <> '' THEN
          SalesHeader.VALIDATE("Payment Terms Code","Payment Terms Code");
        IF "Direct Debit Mandate ID" <> '' THEN
          SalesHeader.VALIDATE("Direct Debit Mandate ID","Direct Debit Mandate ID");
        SalesHeader.MODIFY;
        ApplyStdCodesToSalesLines(SalesHeader,Rec);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..8
        SalesHeader.VALIDATE("Document Date",OrderDate);
        #9..16
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: StdCustSalesCodes) (VariableCollection) on "InsertSalesLines(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "InsertSalesLines(PROCEDURE 1)".

    //procedure InsertSalesLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalesHeader.TESTFIELD("No.");
        SalesHeader.TESTFIELD("Sell-to Customer No.");

        StdCustSalesCode.FILTERGROUP := 2;
        StdCustSalesCode.SETRANGE("Customer No.",SalesHeader."Sell-to Customer No.");
        StdCustSalesCode.FILTERGROUP := 0;

        IF PAGE.RUNMODAL(PAGE::"Standard Customer Sales Codes",StdCustSalesCode) = ACTION::LookupOK THEN
          ApplyStdCodesToSalesLines(SalesHeader,StdCustSalesCode);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7
        StdCustSalesCodes.SETTABLEVIEW(StdCustSalesCode);
        StdCustSalesCodes.LOOKUPMODE(TRUE);
        IF StdCustSalesCodes.RUNMODAL = ACTION::LookupOK THEN BEGIN
          StdCustSalesCodes.GetSelected(StdCustSalesCode);
          IF StdCustSalesCode.FINDSET THEN
            REPEAT
              ApplyStdCodesToSalesLines(SalesHeader,StdCustSalesCode);
            UNTIL StdCustSalesCode.NEXT = 0;
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "ApplyStdCodesToSalesLines(PROCEDURE 2)".

    //procedure ApplyStdCodesToSalesLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF SalesHeader."Currency Code" = '' THEN
          Currency.InitRoundingPrecision
        ELSE
        #4..52
            IF StdSalesLine.InsertLine THEN BEGIN
              SalesLine."Line No." := GetNextLineNo(SalesLine);
              SalesLine.INSERT(TRUE);
              InsertExtendedText(SalesLine);
            END;
          UNTIL StdSalesLine.NEXT = 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..55
              SalesLine.AutoAsmToOrder;
        #56..58
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "InsertExtendedText(PROCEDURE 3)".


    //Unsupported feature: Property Insertion (Local) on "GetNextLineNo(PROCEDURE 4)".

}

