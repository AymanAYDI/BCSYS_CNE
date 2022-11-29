pageextension 50112 "BC6_PostedInvtPutawaySubform" extends "Posted Invt. Put-away Subform" //7391
{
    layout
    {
        addafter("Destination No.")
        {
            field("BC6_Source No. 2"; "BC6_Source No. 2")
            {
                ApplicationArea = All;
            }
            field("BC6_Source Line No. 2"; "BC6_Source Line No. 2")
            {
                ApplicationArea = All;
            }
            field("BC6_Source Bin Code"; "BC6_Source Bin Code")
            {
                ApplicationArea = All;
            }
        }
    }
}

