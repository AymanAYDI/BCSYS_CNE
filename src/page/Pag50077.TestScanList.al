page 50077 "BC6_Test Scan List"
{
    Caption = 'Test Scan List';
    PageType = List;
    SourceTable = "Item Journal Line";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No.', Comment = 'FRA="N° ligne"';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Test)
            {
                ApplicationArea = All;
                Gesture = LeftSwipe;
                Promoted = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    MESSAGE('OK');
                end;
            }
        }
    }
}
