page 50113 "BC6_Return Solutions"
{
    Caption = 'Return Solutions';
    Description = 'BCSYS';
    PageType = List;
    SourceTable = "BC6_Return Solution";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                }
                field(Description; Description)
                {
                }
                field(Type; Type)
                {
                }
            }
        }
    }

    actions
    {
    }
}

