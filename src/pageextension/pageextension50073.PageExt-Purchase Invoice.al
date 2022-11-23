pageextension 50073 pageextension50073 extends "Purchase Invoice"
{
    layout
    {
        addafter("Control 118")
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
                    //>>MIGRATION NAV 2013
                    ReasonCodeOnAfterValidate;
                    //<<MIGRATION NAV 2013
                end;
            }
        }
    }

    procedure "---MIGNAV2013---"()
    begin
    end;

    procedure ReasonCodeOnAfterValidate()
    begin
        //<<MIGRATION NAV 2013
        //<<DEEE1.00
        CurrPage.UPDATE(TRUE);
        //>>DEEE1.00
        //>>MIGRATION NAV 2013
    end;
}

