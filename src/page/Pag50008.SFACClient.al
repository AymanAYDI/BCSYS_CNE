page 50008 "BC6_SFAC Client"
{
    PageType = Card;
    SourceTable = Customer;
    Caption = 'SFAC Client';
    layout
    {
        area(content)
        {
            group(Control1)
            {
                field("No."; "No.")
                {
                    Editable = false;
                }
                field(Name; Name)
                {
                    Editable = false;
                }
                field("Credit Limit (LCY)"; "Credit Limit (LCY)")
                {
                }
                field("SFAC Contract Date"; "BC6_SFAC Contract Date")
                {
                }
                field("SFAC Contract No."; "BC6_SFAC Contract No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

