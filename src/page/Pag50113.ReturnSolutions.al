page 50113 "BC6_Return Solutions"
{
    Caption = 'Return Solutions', comment = 'FRA="Solutions retour"';
    PageType = List;
    SourceTable = "BC6_Return Solution";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
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
