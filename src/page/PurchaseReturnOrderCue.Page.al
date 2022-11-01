page 50112 "Purchase Return Order Cue"
{
    Caption = 'Purchase Activities';
    PageType = CardPart;
    SourceTable = Table9055;

    layout
    {
        area(content)
        {
            cuegroup("Purchase Returns Order")
            {
                Caption = 'Purchase Returns Order';
                field("Purchase Return - Location"; "Purchase Return - Location")
                {
                    DrillDownPageID = "LOC Purch. Return Order List";
                }
                field("Purchase Return - SAV"; "Purchase Return - SAV")
                {
                    DrillDownPageID = "SAV Purch. Return Order List";
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

