pageextension 50021 "BC6_PurchaseCreditMemo" extends "Purchase Credit Memo" //52
{
    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field(BC6_ID; Rec.BC6_ID)
            {
                ApplicationArea = All;
                Caption = 'User ID', comment = 'FRA="Code Utilisateur"';
                Editable = false;
            }
            field("BC6_Buy-from Fax No."; Rec."BC6_Buy-from Fax No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Reason Code"; Rec."Reason Code")
            {
                ApplicationArea = All;
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
