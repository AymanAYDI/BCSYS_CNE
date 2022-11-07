page 50112 "Purchase Return Order Cue"
{
    Caption = 'Purchase Activities';
    PageType = CardPart;
    SourceTable = "Purchase Cue";

    layout
    {
        area(content)
        {
            cuegroup("Purchase Returns Order")
            {
                Caption = 'Purchase Returns Order';
                field("Purchase Return - Location"; "BC6_Purchase Return - Location")
                {
                    DrillDownPageID = "LOC Purch. Return Order List";
                }
                field("Purchase Return - SAV"; "BC6_Purchase Return - SAV")
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
        RESET;
        IF NOT GET THEN BEGIN
            INIT;
            INSERT;
        END;

        SetRespCenterFilter;
    end;
}

