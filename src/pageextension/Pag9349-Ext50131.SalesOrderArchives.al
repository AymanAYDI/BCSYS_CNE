pageextension 50131 "BC6_SalesOrderArchives" extends "Sales Order Archives" //9349
{
    layout
    {
        modify("No.")
        {
            Visible = false;
        }
        addfirst(Control1)
        {
            field(BC6_No; Rec."No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
