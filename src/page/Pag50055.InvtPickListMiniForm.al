page 50055 "BC6_Invt Pick List MiniForm"
{
    Caption = 'Invt Pick List', Comment = 'FRA="Liste prélèvements"';
    Editable = false;
    PageType = List;
    SourceTable = "Warehouse Activity Header";
    SourceTableView = SORTING(Type, "No.")
                      ORDER(Ascending)
                      WHERE(Type = CONST("Invt. Pick"));
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Type; Type)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Source No."; "Source No.")
                {
                    ApplicationArea = All;
                }
                field("Destination Type"; "Destination Type")
                {
                    ApplicationArea = All;
                }
                field("Destination No."; "Destination No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Counter"; "BC6_Sales Counter")
                {
                    ApplicationArea = All;
                }
                field("No. of Lines"; "No. of Lines")
                {
                    ApplicationArea = All;
                }
                field("No. Printed"; "No. Printed")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

