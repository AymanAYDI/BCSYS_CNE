page 50090 "BC6_Item List Test"
{
    Caption = 'Item List Test';
    PageType = List;
    SourceTable = Item;
    UsageCategory = None;
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
