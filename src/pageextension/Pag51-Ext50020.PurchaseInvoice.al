pageextension 50020 "BC6_PurchaseInvoice" extends "Purchase Invoice" //51 
{
    layout
    {
        addafter("Status")
        {
            field(BC6_ID; Rec.BC6_ID)
            {
                Caption = 'User ID', comment = 'FRA="Code Utilisateur"';
                Editable = false;
            }
            field("BC6_Buy-from Fax No."; Rec."BC6_Buy-from Fax No.")
            {
            }
            field("BC6_Reason Code"; Rec."Reason Code")
            {

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

