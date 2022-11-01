page 50113 "Return Solutions"
{
    Caption = 'Return Solutions';
    Description = 'BCSYS';
    PageType = List;
    SourceTable = Table50018;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
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

