pageextension 50029 "BC6_InvtPickSubform" extends "Invt. Pick Subform" //7378
{
    layout
    {
        modify("Source No.")
        {
            Visible = false;

        }
        addfirst(Control1)
        {
            field("BC6_Line No."; "Line No.") { }
        }
        addafter("Source Document")
        {
            field("BC6_Source No."; "Source No.")
            {
                Visible = True;
            }
            field("BC6_Source Line No."; "Source Line No.") { }

        }
        addafter("Qty. per Unit of Measure")
        {
            field("BC6_Qty. Picked"; "BC6_Qty. Picked") { }
        }
    }
}
