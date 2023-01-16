pageextension 50020 "BC6_PurchaseInvoice" extends "Purchase Invoice" //51
{
    layout
    {
        addafter("Status")
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
                    ReasonCodeOnAfterValidate();
                end;
            }
        }
    }

    procedure ReasonCodeOnAfterValidate()
    begin
        CurrPage.UPDATE(TRUE);
    end;
}
