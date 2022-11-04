page 50090 "BC6_Item List Test"
{
    PageType = List;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field(Description; Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

