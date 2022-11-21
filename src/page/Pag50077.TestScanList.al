page 50077 "BC6_Test Scan List"
{
    PageType = List;
    SourceTable = "Item Journal Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
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

                trigger OnAction()
                begin
                    MESSAGE('OK');
                end;
            }
        }
    }
}

