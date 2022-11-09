pageextension 50080 pageextension50080 extends "Purchase Credit Memo"
{
    layout
    {
        addafter("Control 6")
        {
            field(ID; ID)
            {
                Caption = 'User ID';
                Editable = false;
            }
            field("Buy-from Fax No."; "Buy-from Fax No.")
            {
            }
            field("Reason Code"; "Reason Code")
            {

                trigger OnValidate()
                begin
                    FnctGOnAfterValidateReasonCode();
                end;
            }
        }
    }

    procedure "---MIGNAV2013---"()
    begin
    end;

    procedure FnctGOnAfterValidateReasonCode()
    begin

        //<<DEEE1.00
        CurrPage.UPDATE(TRUE);
        //>>DEEE1.00
    end;
}

