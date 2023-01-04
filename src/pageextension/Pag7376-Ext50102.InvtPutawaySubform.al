pageextension 50102 "BC6_InvtPutawaySubform" extends "Invt. Put-away Subform" //7376
{
    layout
    {
        addafter("Destination No.")
        {
            field("BC6_Source No. 2"; Rec."BC6_Source No. 2")
            {
                ApplicationArea = All;
            }
            field("BC6_Source Line No. 2"; Rec."BC6_Source Line No. 2")
            {
                ApplicationArea = All;
            }
            field("BC6_Source Bin Code"; Rec."BC6_Source Bin Code")
            {
                ApplicationArea = All;
            }
            field("BC6_Warehouse Comment"; Rec."BC6_Warehouse Comment")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
}

