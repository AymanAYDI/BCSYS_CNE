pageextension 50033 "BC6_GeneralLedgerSetup" extends "General Ledger Setup" //118
{
    layout
    {
        addafter("Gen. Journal Templates")
        {
            group(BC6_DEEE)
            {
                Caption = 'DEEE', Comment = 'FRA="DEEE"';
                field("BC6_DEEE Management"; "BC6_DEEE Management")
                {
                    ApplicationArea = All;
                }
                field("BC6_DEEE Sales line prefix"; "BC6_DEEE Sales line prefix")
                {
                    ApplicationArea = All;
                }
                field("BC6_DEEE Purchases line prefix"; "BC6_DEEE Purchases line prefix")
                {
                    ApplicationArea = All;
                }
                field("BC6_DEEE Business Group ID"; "BC6_DEEE Business Group ID")
                {
                    ApplicationArea = All;
                }
                field("BC6_Defaut Eco partner DEEE"; "BC6_Defaut Eco partner DEEE")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

