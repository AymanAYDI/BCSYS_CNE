page 50055 "Invt Pick List MiniForm"
{
    Caption = 'Invt Pick List';
    Editable = false;
    PageType = List;
    SourceTable = "Warehouse Activity Header";
    SourceTableView = SORTING(Type, "No.")
                      ORDER(Ascending)
                      WHERE(Type = CONST("Invt. Pick"));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Type; Type)
                {
                    Visible = false;
                }
                field("No."; "No.")
                {
                }
                field("Source No."; "Source No.")
                {
                }
                field("Destination Type"; "Destination Type")
                {
                }
                field("Destination No."; "Destination No.")
                {
                }
                field("Sales Counter"; "BC6_Sales Counter")
                {
                }
                field("No. of Lines"; "No. of Lines")
                {
                }
                field("No. Printed"; "No. Printed")
                {
                }
            }
        }
    }

    actions
    {
    }
}

