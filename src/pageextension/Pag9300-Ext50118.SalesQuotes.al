pageextension 50118 "BC6_SalesQuotes" extends "Sales Quotes" //9300
{
    //TODO: Unsupported feature: Property Modification (SourceTableView) on ""Sales Quotes"(Page 9300)".
    //    SourceTableView=SORTING(Document Type,Order Date,No.)
    // ORDER(Descending)
    // WHERE(Document Type=CONST(Quote));

    layout
    {
        modify("Amount")
        {
            Visible = false;
        }
        addafter("Status")
        {
            field(BC6_ID; ID)
            {
            }
            field("BC6_Your Reference"; "Your Reference")
            {
            }
            field("BC6_Affair No."; "BC6_Affair No.")
            {
            }
            field(BC6_Amount; Amount)
            {
            }
            field(BC6_Profit; DecGProfit)
            {
                Caption = 'Profit', comment = 'FRA="Montant marge"';
                Editable = false;
                Enabled = BooGVisible;
                Visible = BooGVisible;
            }
            field(BC6_ProfitPct; DecGProfitPct)
            {
                Caption = 'ProfitPct', comment = 'FRA="%age marge"';
                Editable = false;
                Enabled = BooGVisible;
                Visible = BooGVisible;
            }
        }
    }

    var
        RecGUserSeup: Record "User Setup";
        [InDataSet]
        BooGVisible: Boolean;
        DecGProfit: Decimal;
        DecGProfitPct: Decimal;

    trigger OnAfterGetRecord()
    var
    begin
        CalcProfit();
    end;

    trigger OnOpenPage()
    var
    begin
        //TODO: CHECKME when testing-----------
        rec.SetCurrentKey("Document Type", "Order Date", "No.");

        rec.Ascending(false);
        IsProfitVisible();
        IF NOT FINDFIRST() THEN
            INIT();

        IF NOT RecGUserSeup.GET(USERID) THEN
            RecGUserSeup.INIT();
        IF RecGUserSeup."BC6_Limited User" THEN BEGIN
            FILTERGROUP(2);
            SETFILTER("BC6_Salesperson Filter", '*' + RecGUserSeup."Salespers./Purch. Code" + '*');
            FILTERGROUP(0);
        END;
    end;

    procedure IsProfitVisible()
    var
        RecLAccessCtrl: Record "Access Control";
        RecLSalesSetup: Record "Sales & Receivables Setup";
    begin
        RecLSalesSetup.GET();
        RecLSalesSetup.TESTFIELD("BC6_allow Profit% to");

        RecLAccessCtrl.RESET();
        RecLAccessCtrl.SETRANGE("User Name", USERID);
        RecLAccessCtrl.SETRANGE("Role ID", RecLSalesSetup."BC6_allow Profit% to");
        IF NOT RecLAccessCtrl.ISEMPTY THEN
            BooGVisible := TRUE;
    end;

    procedure CalcProfit()
    var
        RecLSalesLine: Record "Sales Line";
        DecLAmount: Decimal;
        DecLPurchCost: Decimal;
    begin
        IF BooGVisible THEN BEGIN
            DecLPurchCost := 0;
            DecLAmount := 0;

            RecLSalesLine.RESET();
            RecLSalesLine.SETRANGE("Document Type", "Document Type");
            RecLSalesLine.SETRANGE("Document No.", "No.");
            IF RecLSalesLine.FINDSET() THEN
                REPEAT
                    DecLPurchCost += RecLSalesLine.Quantity * RecLSalesLine."BC6_Purchase cost";
                    DecLAmount += RecLSalesLine.Quantity * RecLSalesLine."BC6_Discount unit price";
                UNTIL RecLSalesLine.NEXT() = 0;

            DecGProfit := DecLAmount - DecLPurchCost;

            IF DecLAmount <> 0 THEN
                DecGProfitPct := 100 * DecGProfit / DecLAmount
            ELSE
                DecGProfitPct := 0;
        END;
    end;
}
