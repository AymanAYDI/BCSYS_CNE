page 50077 "BC6_Test Scan List"
{
    PageType = List;
    SourceTable = "Item Journal Line";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
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

