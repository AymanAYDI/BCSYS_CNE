pageextension 50007 pageextension50007 extends "General Ledger Setup"
{
    layout
    {
        addafter("Control 1904409301")
        {
            group(DEEE)
            {
                Caption = 'DEEE';
                field("DEEE Management"; "DEEE Management")
                {
                }
                field("DEEE Sales line prefix"; "DEEE Sales line prefix")
                {
                }
                field("DEEE Purchases line prefix"; "DEEE Purchases line prefix")
                {
                }
                field("DEEE Business Group ID"; "DEEE Business Group ID")
                {
                }
                field("Defaut Eco partner DEEE"; "Defaut Eco partner DEEE")
                {
                }
            }
        }
    }
}

