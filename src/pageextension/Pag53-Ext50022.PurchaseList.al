pageextension 50022 "BC6_PurchaseList" extends "Purchase List" //53
{
    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field(BC6_ID; Rec.BC6_ID)
            {
                ApplicationArea = All;
                Visible = BooGID;
            }
        }
        addafter("Purchaser Code")
        {
            field(BC6_Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field("BC6_Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
            }
        }
    }

    var
        RecGsalesSetup: Record "Sales & Receivables Setup";
        [InDataSet]
        BooGID: Boolean;

    trigger OnOpenPage()
    var
    begin
        hideuser();
    end;

    procedure hideuser()
    var
        RecLAccessControl: Record "Access Control";
    begin
        RecGsalesSetup.GET();
        RecGsalesSetup.TESTFIELD("BC6_allow Profit% to");
        RecLAccessControl.SETRANGE("User Security ID", USERSECURITYID());
        RecLAccessControl.SETRANGE("Role ID", RecGsalesSetup."BC6_allow Profit% to");
        IF RecLAccessControl.FindFirst() THEN
            BooGID := TRUE
        ELSE
            BooGID := FALSE;
    end;
}
