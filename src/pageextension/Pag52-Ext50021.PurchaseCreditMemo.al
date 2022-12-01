pageextension 50021 "BC6_PurchaseCreditMemo" extends "Purchase Credit Memo" //52
{
    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field(BC6_ID; ID)
            {
                Caption = 'User ID', comment = 'FRA="Code Utilisateur"';
                Editable = false;
            }
            field("BC6_Buy-from Fax No."; "BC6_Buy-from Fax No.")
            {
            }
            field("BC6_Reason Code"; "Reason Code")
            {
                trigger OnValidate()
                begin
                    FnctGOnAfterValidateReasonCode();
                end;
            }
        }
    }

    procedure FnctGOnAfterValidateReasonCode()
    begin

        CurrPage.UPDATE(TRUE);
    end;
}
