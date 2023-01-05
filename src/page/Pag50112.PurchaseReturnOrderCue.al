page 50112 "BC6_Purchase Return Order Cue"
{
    Caption = 'Purchase Activities', comment = 'FRA="Activités achat"';
    PageType = CardPart;
    SourceTable = "Purchase Cue";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            cuegroup("Purchase Returns Order")
            {
                Caption = 'Purchase Returns Order', comment = 'FRA="Retours achat"';
                field("Purchase Return - Location"; Rec."BC6_Purchase Return - Location")
                {
                    DrillDownPageID = "LOC Purch. Return Order List";
                }
                field("Purchase Return - SAV"; Rec."BC6_Purchase Return - SAV")
                {
                    DrillDownPageID = "BC6_SAV Purch. Ret. Order List";
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.RESET();
        IF NOT Rec.GET() THEN BEGIN
            Rec.INIT();
            Rec.INSERT();
        END;

        Rec.SetRespCenterFilter();
    end;
}

