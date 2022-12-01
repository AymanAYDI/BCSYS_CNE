pageextension 50020 "BC6_PurchaseInvoice" extends "Purchase Invoice" //51 
{
    layout
    {
        addafter("Status")
        {
            field(BC6_ID; Rec.ID)
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

