page 50008 "BC6_SFAC Client"
{
    PageType = Card;
    SourceTable = Customer;
    UsageCategory = None;
    Caption = 'SFAC Client';
    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;

                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                }
                field("Credit Limit (LCY)"; Rec."Credit Limit (LCY)")
                {
                }
                field("SFAC Contract Date"; Rec."BC6_SFAC Contract Date")
                {
                }
                field("SFAC Contract No."; Rec."BC6_SFAC Contract No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

