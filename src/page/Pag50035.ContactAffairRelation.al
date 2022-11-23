page 50035 "BC6_Contact Affair Relation"
{
    Caption = 'Contact Affair Relation', Comment = 'FRA="Contact Affaire Relation"';
    Editable = false;
    PageType = List;
    SourceTable = "Contact Business Relation";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Business Relation Code"; "Business Relation Code")
                {
                    ApplicationArea = All;
                }
                field("Business Relation Description"; "Business Relation Description")
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

