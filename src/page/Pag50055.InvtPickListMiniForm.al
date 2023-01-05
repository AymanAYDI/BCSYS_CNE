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
                field(Type; Rec.Type)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ApplicationArea = All;
                }
                field("Destination No."; Rec."Destination No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Counter"; Rec."BC6_Sales Counter")
                {
                    ApplicationArea = All;
                }
                field("No. of Lines"; Rec."No. of Lines")
                {
                    ApplicationArea = All;
                }
                field("No. Printed"; Rec."No. Printed")
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

