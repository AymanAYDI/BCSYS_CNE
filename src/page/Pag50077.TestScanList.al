page 50077 "BC6_Test Scan List"
{
    PageType = List;
    SourceTable = "Item Journal Line";
    UsageCategory = None;
    Caption = 'Test Scan List';
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
                Gesture = LeftSwipe;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    MESSAGE('OK');
                end;
            }
        }
    }
}

