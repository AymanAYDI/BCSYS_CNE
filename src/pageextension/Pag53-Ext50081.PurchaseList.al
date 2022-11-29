pageextension 50081 "BC6_PurchaseList" extends "Purchase List" //53
{
    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field(BC6_ID; ID)
            {
                Visible = BooGID;
            }
        }
        addafter("Purchaser Code")
        {
            field(BC6_Amount; Amount)
            {
            }
            field("BC6_Amount Including VAT"; "Amount Including VAT")
            {
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
        IF RecLAccessControl.FINDFIRST() THEN
            BooGID := TRUE
        ELSE
            BooGID := FALSE;

    end;
}

