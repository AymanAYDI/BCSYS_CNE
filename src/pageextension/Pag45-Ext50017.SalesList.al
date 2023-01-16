pageextension 50017 "BC6_SalesList" extends "Sales List" //45
{
    layout
    {
        addfirst(Control1)
        {
            field("BC6_Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("External Document No.")
        {
            field("BC6_Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
            field("BC6_Requested Delivery Date"; Rec."Requested Delivery Date")
            {
                ApplicationArea = All;
            }
            field("BC6_Promised Delivery Date"; Rec."Promised Delivery Date")
            {
                ApplicationArea = All;
            }
            field(BC6_Ship; Rec.Ship)
            {
                ApplicationArea = All;
                Caption = 'Ship', Comment = 'FRA="Entièrement livrée"';
            }
            field(BC6_Invoice; Rec.Invoice)
            {
                ApplicationArea = All;
                Caption = 'Invoice', Comment = 'FRA="Entièrement facturée"';
            }
            field(BC6_ID; Rec.BC6_ID)
            {
                ApplicationArea = All;
                Visible = BooGID;
            }
        }
        addafter("Location Code")
        {
            field("BC6_Bin Code"; Rec."BC6_Bin Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Salesperson Code")
        {
            field(BC6_purchcost; DecGPurchCost)
            {
                ApplicationArea = All;
                Caption = 'Purchase Cost', Comment = 'FRA="Coût d''achat"';
                Visible = BooGPurchcost;
            }
            field(BC6_profitamount; DecGProfitAmount)
            {
                ApplicationArea = All;
                Caption = 'Profit Amount', Comment = 'FRA="Montant Marge"';
                Visible = BooGProfitamount;
            }
            field(BC6_profitpct; "DecGProfit%")
            {
                ApplicationArea = All;
                Caption = 'Profit %', Comment = 'FRA="% Marge"';
                Visible = BooGProfitpct;
            }
        }
        addafter("Document Date")
        {
            field("BC6_Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
            }
        }
    }

    var
        RecGSalesSetup: Record "Sales & Receivables Setup";
        RecGSalesLine: Record "Sales Line";
        [InDataSet]
        BooGID: Boolean;
        BooGProfitamount: Boolean;
        BooGProfitpct: Boolean;
        [InDataSet]
        BooGPurchcost: Boolean;
        DecGAmountHT: Decimal;
        "DecGProfit%": Decimal;
        DecGProfitAmount: Decimal;
        DecGPurchCost: Decimal;

    trigger OnAfterGetRecord()
    begin
        hideuser();
        calcprofit();
    end;

    procedure hideuser()
    var
        RecLAccessControl: Record "Access Control";
    begin
        RecGSalesSetup.GET();
        RecGSalesSetup.TESTFIELD("BC6_allow Profit% to");
        RecLAccessControl.SETRANGE("User Security ID", USERSECURITYID());
        RecLAccessControl.SETRANGE("Role ID", RecGSalesSetup."BC6_allow Profit% to");
        IF RecLAccessControl.FINDFIRST() THEN BEGIN
            BooGID := TRUE;
            BooGPurchcost := TRUE;
            BooGProfitamount := TRUE;
            BooGProfitpct := TRUE;
        END
        ELSE BEGIN
            BooGID := FALSE;
            BooGPurchcost := FALSE;
            BooGProfitamount := FALSE;
            BooGProfitpct := FALSE;
        END;
    end;

    procedure calcprofit()
    begin
        DecGPurchCost := 0;
        DecGAmountHT := 0;

        RecGSalesLine.RESET();
        RecGSalesLine.SETFILTER("Document Type", '%1', Rec."Document Type");
        RecGSalesLine.SETFILTER("Sell-to Customer No.", Rec."Sell-to Customer No.");
        RecGSalesLine.SETFILTER("Document No.", '%1', Rec."No.");
        IF RecGSalesLine.FIND('-') THEN
            REPEAT
                DecGPurchCost += RecGSalesLine.Quantity * RecGSalesLine."BC6_Purchase cost";
                DecGAmountHT += RecGSalesLine.Quantity * RecGSalesLine."BC6_Discount unit price";
            UNTIL RecGSalesLine.NEXT() = 0;

        DecGProfitAmount := DecGAmountHT - DecGPurchCost;

        IF DecGAmountHT <> 0 THEN
            "DecGProfit%" := 100 * DecGProfitAmount / DecGAmountHT
        ELSE
            "DecGProfit%" := 0;
    end;
}
