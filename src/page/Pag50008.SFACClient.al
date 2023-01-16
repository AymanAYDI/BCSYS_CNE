page 50008 "BC6_SFAC Client"
{
    Caption = 'SFAC Client';
    PageType = Card;
    SourceTable = Customer;
    UsageCategory = None;
    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Credit Limit (LCY)"; Rec."Credit Limit (LCY)")
                {
                    ApplicationArea = All;
                }
                field("SFAC Contract Date"; Rec."BC6_SFAC Contract Date")
                {
                    ApplicationArea = All;
                }
                field("SFAC Contract No."; Rec."BC6_SFAC Contract No.")
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
