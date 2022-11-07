pageextension 50108 pageextension50108 extends "Small Business Owner RC"
{
    layout
    {
        modify("Control 24")
        {
            Visible = false;
        }
        addafter("Control 78")
        {
            part("Company Picture"; 50099)
            {
                Caption = 'Company Picture';
            }
        }
        addafter("Control 2")
        {
            part(; 681)
            {
            }
        }
    }
    actions
    {
        modify("Action 43")
        {
            Visible = false;
        }
        modify("Action 12")
        {
            Visible = false;
        }
        addafter("Action 11")
        {
            action("Sales &Order")
            {
                Caption = 'Sales &Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 42;
                RunPageMode = Create;
            }
        }
        addafter("Action 4")
        {
            action("&Purchase Order")
            {
                Caption = '&Purchase Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 50;
                RunPageMode = Create;
            }
        }
    }
}

