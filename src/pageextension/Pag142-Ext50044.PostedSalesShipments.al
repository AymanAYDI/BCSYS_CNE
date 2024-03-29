pageextension 50044 "BC6_PostedSalesShipments" extends "Posted Sales Shipments" //142
{
    layout
    {
        modify("Posting Date")
        {
            Visible = false;
        }
        modify("Shipping Agent Code")
        {
            Visible = false;
        }
        modify("Package Tracking No.")
        {
            Visible = false;
        }

        addfirst(Control1)
        {
            field("BC6_Affair No."; Rec."BC6_Affair No.")
            {
                ApplicationArea = All;
            }
            field(BC6_GRespAffair; GRespAffair)
            {
                ApplicationArea = All;
                Caption = 'Chargé d''affaire';
            }
            field("BC6_Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("No.")
        {
            field("BC6_Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Sell-to Customer Name")
        {
            field("BC6_Shipping Agent Code"; Rec."Shipping Agent Code")
            {
                ApplicationArea = All;
            }
            field("BC6_Package Tracking No."; Rec."Package Tracking No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
        }
        addafter("Sell-to Contact")
        {
            field("BC6_User ID"; Rec."User ID")
            {
                ApplicationArea = All;
                Visible = BooGID;
            }
            field("BC6_Assigned User ID"; Rec."BC6_Assigned User ID")
            {
                ApplicationArea = All;
                Visible = BooGID;
            }
        }
        addafter("Bill-to Customer No.")
        {
            field("BC6_External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Location Code")
        {
            field(BC6_amount; DecGAmount)
            {
                ApplicationArea = All;
                Caption = 'Amount', comment = 'FRA="Montant"';
            }
            field(BC6_profitamount; DecGProfitAmount)
            {
                ApplicationArea = All;
                Caption = 'Profit Amount', comment = 'FRA="Montant Marge"';
                Visible = BooGProfitamount;
            }
            field(BC6_purchcost; DecGPurchCost)
            {
                ApplicationArea = All;
                Caption = 'Purchase Cost', comment = 'FRA="Coût d''achat"';
                Editable = BooGPurchcost;
            }
            field("BC6_DecGProfit%"; "DecGProfit%")
            {
                ApplicationArea = All;
                Caption = 'profit %', comment = 'FRA="% Marge"';
                Visible = BooGProfitpct;
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        IF NOT RecGUserSeup.GET(USERID) THEN
            RecGUserSeup.INIT();
        IF RecGUserSeup."BC6_Limited User" THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETFILTER("BC6_Salesperson Filter", '*' + RecGUserSeup."Salespers./Purch. Code" + '*');
            Rec.FILTERGROUP(0);
        END;
    END;

    trigger OnAfterGetRecord()
    begin
        IF RecAffair.GET(Rec."BC6_Affair No.") THEN
            GRespAffair := RecAffair."BC6_Affair Responsible";
        hideuser();
        calcprofit();
    end;

    var
        RecAffair: Record Job;
        RecGSalesSetup: Record "Sales & Receivables Setup";
        RecGShipline: Record "Sales Shipment Line";
        RecGUserSeup: Record "User Setup";
        [InDataSet]
        BooGID: Boolean;
        BooGProfitamount: Boolean;
        BooGProfitpct: Boolean;
        [InDataSet]
        BooGPurchcost: Boolean;
        GRespAffair: Code[20];
        DecGAmount: Decimal;
        "DecGProfit%": Decimal;
        DecGProfitAmount: Decimal;

        DecGPurchCost: Decimal;

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
        DecGAmount := 0;

        RecGShipline.RESET();
        RecGShipline.SETRANGE("Document No.", Rec."No.");
        IF RecGShipline.FIND('-') THEN
            REPEAT
                DecGPurchCost += RecGShipline.Quantity * RecGShipline."BC6_Purchase Cost";
                DecGAmount += RecGShipline.Quantity * RecGShipline."BC6_Discount Unit Price";
            UNTIL RecGShipline.NEXT() = 0;

        DecGProfitAmount := DecGAmount - DecGPurchCost;
        IF DecGAmount <> 0 THEN
            "DecGProfit%" := 100 * DecGProfitAmount / DecGAmount
        ELSE
            "DecGProfit%" := 0;
    end;
}
