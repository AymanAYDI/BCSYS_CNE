page 50024 "BC6_Item Category List"
{
    Caption = 'Item Category List', Comment = 'FRA="Liste des catégories d''articles"';
    PageType = List;
    SourceTable = "BC6_Categories of item";
    UsageCategory = Tasks;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Eco Partner"; Rec."Eco Partner")
                {
                    ApplicationArea = All;
                }
                field("Weight Min"; Rec."Weight Min")
                {
                    ApplicationArea = All;
                }
                field("Weight Max"; Rec."Weight Max")
                {
                    ApplicationArea = All;
                }
                field("Eco-partner"; Rec."Eco-partner")
                {
                    ApplicationArea = All;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                }
                field("DEEE Product Group ID"; Rec."DEEE Product Group ID")
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
            action("&Tariffs")
            {
                Caption = '&Tariffs', Comment = 'FRA="&Tarifs"';
                Promoted = true;
                Image = Discount;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunPageLink = "DEEE Code" = FIELD(Category),
                              "Eco Partner" = FIELD("Eco Partner");
                RunObject = Page "BC6_DEEE Tariffs List";
                ApplicationArea = All;
            }
        }
    }
}

