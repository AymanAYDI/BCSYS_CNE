page 50035 "BC6_Contact Affair Relation"
{
    Caption = 'Contact Affair Relation';
    Editable = false;
    PageType = List;
    SourceTable = "Contact Business Relation";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Business Relation Code"; "Business Relation Code")
                {
                }
                field("Business Relation Description"; "Business Relation Description")
                {
                }
            }
        }
    }

    actions
    {
    }
}

