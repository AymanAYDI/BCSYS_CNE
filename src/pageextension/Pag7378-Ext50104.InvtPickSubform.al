pageextension 50104 "BC6_InvtPickSubform" extends "Invt. Pick Subform" //7378
{
    layout
    {
        modify("Source No.")
        {
            Visible = false;
        }
        addfirst(Control1)
        {
            field("BC6_Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Source Document")
        {
            field("BC6_Source No."; Rec."Source No.")
            {
                ApplicationArea = All;
                Visible = True;
            }
            field("BC6_Source Line No."; Rec."Source Line No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Qty. per Unit of Measure")
        {
            field("BC6_Qty. Picked"; Rec."BC6_Qty. Picked")
            {
                ApplicationArea = All;
            }
        }
    }
}
