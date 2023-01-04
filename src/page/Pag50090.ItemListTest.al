page 50090 "BC6_Item List Test"
{
    PageType = List;
    SourceTable = Item;
    UsageCategory = None;
    Caption = 'Item List Test';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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

