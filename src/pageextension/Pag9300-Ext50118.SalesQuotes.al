pageextension 50118 "BC6_SalesQuotes" extends "Sales Quotes" //9300
{
    layout
    {
        modify("Amount")
        {
            Visible = false;
        }
        addafter("Status")
        {
            field(BC6_ID; Rec.BC6_ID)
            {
                ApplicationArea = All;
            }
            field("BC6_Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
            field("BC6_Affair No."; Rec."BC6_Affair No.")
            {
                ApplicationArea = All;
            }
            field(BC6_Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field(BC6_Profit; DecGProfit)
            {
                ApplicationArea = All;
                Caption = 'Profit', comment = 'FRA="Montant marge"';
                Editable = false;
                Enabled = BooGVisible;
                Visible = BooGVisible;
            }
            field(BC6_ProfitPct; DecGProfitPct)
            {
                ApplicationArea = All;
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
        rec.SetCurrentKey("Document Type", "Order Date", "No.");

        rec.Ascending(false);
        IsProfitVisible();
        IF NOT Rec.FINDFIRST() THEN
            Rec.INIT();

        IF NOT RecGUserSeup.GET(USERID) THEN
            RecGUserSeup.INIT();
        IF RecGUserSeup."BC6_Limited User" THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETFILTER("BC6_Salesperson Filter", '*' + RecGUserSeup."Salespers./Purch. Code" + '*');
            Rec.FILTERGROUP(0);
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
            RecLSalesLine.SETRANGE("Document Type", Rec."Document Type");
            RecLSalesLine.SETRANGE("Document No.", Rec."No.");
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
