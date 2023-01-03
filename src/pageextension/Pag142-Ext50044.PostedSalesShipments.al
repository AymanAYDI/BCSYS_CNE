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
            field("BC6_Affair No."; "BC6_Affair No.")
            {

            }
            field(BC6_GRespAffair; "GRespAffair")
            {
                Caption = 'Chargé d''affaire';
            }
            field("BC6_Posting Date"; "Posting Date")
            {
            }
        }
        addafter("No.")
        {
            field("BC6_Order No."; "Order No.")
            {
            }
        }
        addafter("Sell-to Customer Name")
        {
            field("BC6_Shipping Agent Code"; "Shipping Agent Code")
            {
            }
            field("BC6_Package Tracking No."; "Package Tracking No.")
            {
            }
            field("BC6_Your Reference"; "Your Reference")
            {
            }
        }
        addafter("Sell-to Contact")
        {
            field("BC6_User ID"; "User ID")
            {
                Visible = BooGID;
            }
            field("BC6_Assigned User ID"; "BC6_Assigned User ID")
            {
                Visible = BooGID;
            }
        }
        addafter("Bill-to Customer No.")
        {
            field("BC6_External Document No."; "External Document No.")
            {
            }
        }
        addafter("Location Code")
        {
            field(BC6_amount; DecGAmount)
            {
                Caption = 'Amount', comment = 'FRA="Montant"';
            }
            field(BC6_profitamount; DecGProfitAmount)
            {
                Caption = 'Profit Amount', comment = 'FRA="Montant Marge"';
                Visible = BooGProfitamount;
            }
            field(BC6_purchcost; DecGPurchCost)
            {
                Caption = 'Purchase Cost', comment = 'FRA="Coût d''achat"';
                Editable = BooGPurchcost;
            }
            field("BC6_DecGProfit%"; "DecGProfit%")
            {
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
            FILTERGROUP(2);
            SETFILTER("BC6_Salesperson Filter", '*' + RecGUserSeup."Salespers./Purch. Code" + '*');
            FILTERGROUP(0);
        END;
    END;

    trigger OnAfterGetRecord()
    begin
#pragma warning disable AA0206
        GRespAffair := '';
        IF RecAffair.GET("BC6_Affair No.") THEN
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
        BooGAmount: Boolean;
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
            BooGAmount := TRUE;
            BooGPurchcost := TRUE;
            BooGProfitamount := TRUE;
            BooGProfitpct := TRUE;
        END
        ELSE BEGIN
            BooGID := FALSE;
            BooGAmount := FALSE;
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
        RecGShipline.SETRANGE("Document No.", "No.");
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
