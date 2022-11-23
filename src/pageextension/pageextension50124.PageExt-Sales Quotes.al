pageextension 50124 pageextension50124 extends "Sales Quotes"
{

    //Unsupported feature: Property Modification (SourceTableView) on ""Sales Quotes"(Page 9300)".

    layout
    {
        modify("Control 12")
        {
            Visible = false;
        }
        addafter("Control 1102601007")
        {
            field(ID; ID)
            {
            }
            field("Your Reference"; "Your Reference")
            {
            }
            field("Affair No."; "Affair No.")
            {
            }
            field(Amount; Amount)
            {
            }
            field(Profit; DecGProfit)
            {
                Caption = 'Montant marge';
                Editable = false;
                Enabled = BooGVisible;
                Visible = BooGVisible;
            }
            field(ProfitPct; DecGProfitPct)
            {
                Caption = '%age marge';
                Editable = false;
                Enabled = BooGVisible;
                Visible = BooGVisible;
            }
        }
    }

    var
        "- TDL.78 -": Integer;
        DecGProfit: Decimal;
        DecGProfitPct: Decimal;
        [InDataSet]
        BooGVisible: Boolean;
        RecGUserSeup: Record "91";


        //Unsupported feature: Code Insertion on "OnAfterGetRecord".

        //trigger OnAfterGetRecord()
        //begin
        /*
        //>>TDL.78
        CalcProfit();
        //<<TDL.78
        */
        //end;


        //Unsupported feature: Code Modification on "OnOpenPage".

        //trigger OnOpenPage()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SetSecurityFilterOnRespCenter;
        IsOfficeAddin := OfficeMgt.IsAvailable;

        CopySellToCustomerFilter;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        //>>TDL.78
        IsProfitVisible();
        //<<TDL.78

        //>>MIGRATION CNE 2013
        IF NOT FINDFIRST THEN
          INIT;
        //<<MIGRATION CNE 2013

        //>>P24233_001 SOBI APA 02/02/17
        IF NOT RecGUserSeup.GET(USERID) THEN
           RecGUserSeup.INIT;
        IF RecGUserSeup."Limited User" THEN BEGIN
          FILTERGROUP(2);
          SETFILTER("Salesperson Filter",'*'+RecGUserSeup."Salespers./Purch. Code"+'*');
          FILTERGROUP(0);
        END;
        //<<P24233_001 SOBI APA 02/02/17
        */
        //end;

    procedure "--- TDL.78 ---"()
    begin
    end;

    procedure IsProfitVisible()
    var
        RecLSalesSetup: Record "311";
        RecLAccessCtrl: Record "2000000053";
    begin
        RecLSalesSetup.GET;
        RecLSalesSetup.TESTFIELD("allow Profit% to");

        RecLAccessCtrl.RESET;
        RecLAccessCtrl.SETRANGE("User Name", USERID);
        RecLAccessCtrl.SETRANGE("Role ID", RecLSalesSetup."allow Profit% to");
        IF NOT RecLAccessCtrl.ISEMPTY THEN
            BooGVisible := TRUE;
    end;

    procedure CalcProfit()
    var
        RecLSalesLine: Record "37";
        DecLPurchCost: Decimal;
        DecLAmount: Decimal;
    begin
        IF BooGVisible THEN BEGIN
            DecLPurchCost := 0;
            DecLAmount := 0;

            RecLSalesLine.RESET;
            RecLSalesLine.SETRANGE("Document Type", "Document Type");
            RecLSalesLine.SETRANGE("Document No.", "No.");
            IF RecLSalesLine.FINDSET THEN
                REPEAT
                    DecLPurchCost += RecLSalesLine.Quantity * RecLSalesLine."Purchase cost";
                    DecLAmount += RecLSalesLine.Quantity * RecLSalesLine."Discount unit price";
                UNTIL RecLSalesLine.NEXT = 0;

            DecGProfit := DecLAmount - DecLPurchCost;

            IF DecLAmount <> 0 THEN
                DecGProfitPct := 100 * DecGProfit / DecLAmount
            ELSE
                DecGProfitPct := 0;
        END;
    end;
}

