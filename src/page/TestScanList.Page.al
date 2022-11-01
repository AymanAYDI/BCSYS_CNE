page 50077 "Test Scan List"
{
    PageType = List;
    SourceTable = Table83;

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

